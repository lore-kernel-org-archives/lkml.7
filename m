Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8294D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H+JRTDUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDCQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:36:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCQgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:36:06 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B00C81EC01B6;
        Wed,  3 Apr 2019 18:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554309364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nPk71CFAKB6t6PDRfCfBvJ7rxBk+M9xBUVJJ8/e3plw=;
        b=H+JRTDUFpFfB2A8McqQ97Av7aCk74b9FoVG0XeC7+SUTGVNt1Jhnx91ir6r4gwNthr+jIE
        CF8c0fZ7RhI5qc2oao0koXReaLjchbY34LuqnkgA5OlmnBSMeoR0PYN2z7/R2R1n3jzu6P
        rNPqujF3Hkz0jxgdi5BADYj91TQB4Hc=
Date:   Wed, 3 Apr 2019 18:35:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 04/14] x86/exceptions: Make IST index zero based
Message-ID: <20190403163556.GE6970@zn.tnic>
References: <20190331214020.836098943@linutronix.de>
 <20190331215135.133741719@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190331215135.133741719@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:24PM +0200, Thomas Gleixner wrote:
> The defines for the exception stack (IST) array in the TSS are using the
> SDM convention IST1 - IST7. That causes all sorts of code to subtract 1 for
> array indices related to IST. That's confusing at best and does not provide
> any value.
> 
> Make the indices zero based and fixup the usage sites. The only code which
> needs to adjust the 0 based index is the interrupt descriptor setup which
> needs to add 1 now.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/x86/kernel-stacks      |    8 ++++----
>  arch/x86/entry/entry_64.S            |    4 ++--
>  arch/x86/include/asm/page_64_types.h |   13 ++++++++-----
>  arch/x86/kernel/cpu/common.c         |    4 ++--
>  arch/x86/kernel/dumpstack_64.c       |   14 +++++++-------
>  arch/x86/kernel/idt.c                |   15 +++++++++------
>  6 files changed, 32 insertions(+), 26 deletions(-)

With the below hunk added:

Reviewed-by: Borislav Petkov <bp@suse.de>

---
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..1e340adf65e8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -793,7 +793,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
        if (is_vmalloc_addr((void *)address) &&
            (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
             address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
-               unsigned long stack = this_cpu_read(orig_ist.ist[DOUBLEFAULT_STACK]) - sizeof(void *);
+               unsigned long stack = this_cpu_read(orig_ist.ist[DOUBLEFAULT_IST]) - sizeof(void *);
                /*
                 * We're likely to be running with very little stack space
                 * left.  It's plausible that we'd hit this condition but


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

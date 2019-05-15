Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9930C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD562089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="U8qBrTd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEOHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:37:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfEOHhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:37:23 -0400
Received: from zn.tnic (p200300EC2F0A7C00C5AEE5FDCF635866.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:7c00:c5ae:e5fd:cf63:5866])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FDCD1EC050B;
        Wed, 15 May 2019 09:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557905841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q+jQ7LRBrR4DiRw8jrw+SJJLRHdv1HmQmbSvhXSEgFw=;
        b=U8qBrTd50D3YFy21SDLZfmsKPERosfB595SMymT6ph8MRstvguZBURaoNnlRYk4bOFWN2E
        j4qWLFpP/vrUNb2toRQBXifQII5XsK+EZAPx57vY29tQbFGSvORHHr7jS7WXxen8lOsW+L
        lrWsK0eaUpknXHTe3SPijzeOF7zncrU=
Date:   Wed, 15 May 2019 09:37:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [PATCH v6 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190515073715.GC24212@zn.tnic>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:45:26AM +0800, Zhao Yakui wrote:
> When the ACRN hypervisor is detected, the hypercall is needed so that the
> ACRN guest can query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for guest operating system.
> 
> Add the hypercall so that the ACRN guest can communicate with the
> low-level ACRN hypervisor. On x86 it is implemented with the VMCALL
> instruction.
> 
> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
> v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
> v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H.
>         Use the "VMCALL" mnemonic in comment/commit log.
>         Uppercase r8/rdi/rsi/rax for hypercall parameter register in comment.
> v5->v6: Remove explicit local register variable for inline assembly
> ---
>  arch/x86/include/asm/acrn_hypercall.h | 84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 arch/x86/include/asm/acrn_hypercall.h
> 
> diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
> new file mode 100644
> index 0000000..5cb438e
> --- /dev/null
> +++ b/arch/x86/include/asm/acrn_hypercall.h

Questions:

* why isn't this in acrn.h and needs to be a separate header?

* why aren't those functions used anywhere?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

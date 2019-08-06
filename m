Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F9B2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BJcQZHKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfHFPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:35:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34060 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:35:37 -0400
Received: from zn.tnic (p200300EC2F0DA00008E04FA4C58F7CE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a000:8e0:4fa4:c58f:7ce4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 348861EC0260;
        Tue,  6 Aug 2019 17:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565105735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=97K8pZ7S8v0HHICvQPuZRuC2rxMxs5QigvHbJw+cxYE=;
        b=BJcQZHKO3xWhrfbjqKM3DL1VP0CePTCbJZQ/vJlQfP01WRLt6dZNtkiQwxTtpb8t/BtsKf
        XgDrjO0vcmTkHcoszzEt1+W+Hxeffv1senq6tyLTVtacGzaBElvDFCqvSj9OBdKF8fJVro
        kycmyh2qzfKVp3Z3sfTt0LpS2nL/Iug=
Date:   Tue, 6 Aug 2019 17:35:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/11] x86/entry/64: Adapt assembly for PIE support
Message-ID: <20190806153530.GC25897@zn.tnic>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-5-thgarnie@chromium.org>
 <20190805172854.GF18785@zn.tnic>
 <20190806135942.xnuovr4vbanbxneb@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806135942.xnuovr4vbanbxneb@home.goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:59:42AM -0400, Steven Rostedt wrote:
> As Peter stated later in this thread, we only have the IRQ stack frame saved
> here, because we just took an NMI, and this is the logic to determine if it
> was a nested NMI or not (where we have to be *very* careful about touching the
> stack!)
> 
> That said, the code modified here is to test the NMI nesting logic (only
> enabled with CONFIG_DEBUG_ENTRY), and what it is doing is re-enabling NMIs
> before calling the first NMI handler, to help trigger nested NMIs without the
> need of a break point or page fault (iret enables NMIs again).
> 
> This code is in the path of the "first nmi" (we confirmed that this is not
> nested), which means that it should be safe to push onto the stack.

Thanks for the explanation!

> Yes, we need to save and restore whatever reg we used. The only comment I
> would make is to use %rdx instead of %rax as that has been our "scratch"
> register used before saving pt_regs. Just to be consistent.

Yap, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

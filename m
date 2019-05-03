Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73CCC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88722206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LWBqwcXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfECGEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:04:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECGEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:04:42 -0400
Received: from zn.tnic (p200300EC2F0CA900008324B911E5A0D4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:a900:83:24b9:11e5:a0d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44C2D1EC021C;
        Fri,  3 May 2019 08:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556863480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inhuVd3vZjvhqHNbAjisK/y3DxblsA0AtAJfAQHL6wY=;
        b=LWBqwcXv9TxeGVJfuHnoYJt4sqkTr7VVVhHNMyx5iK2Pp0b4fFwnSb2ta85AKFQS+CGV4P
        sGY3VwB4eYteovGIFxohQFOjjiRgY+EHapLAbgfpfypBhBTbAnlSq1GV5+E4IpuBDovpYP
        F0grqmko7eCr2FvytGsB4zlH7gVYyBA=
Date:   Fri, 3 May 2019 08:04:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@intel.com, tglx@linutronix.de,
        x86@kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@amacapital.net, hpa@zytor.com, mingo@kernel.org
Subject: Re: [PATCH v2] x86/fpu: Fault-in user stack if
 copy_fpstate_to_sigframe() fails
Message-ID: <20190503060434.GA5020@zn.tnic>
References: <1556657902.6132.13.camel@lca.pw>
 <20190501082312.GA3908@zn.tnic>
 <20190502171139.mqtegctsg35cir2e@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502171139.mqtegctsg35cir2e@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:11:39PM +0200, Sebastian Andrzej Siewior wrote:
> In the compacted form, XSAVES may save only the XMM+SSE state but skip
> FP (x87 state).
> 
> This is denoted by header->xfeatures = 6. The fastpath
> (copy_fpregs_to_sigframe()) does that but _also_ initialises the FP
> state (cwd to 0x37f, mxcsr as we do, remaining fields to 0).
> 
> The slowpath (copy_xstate_to_user()) leaves most of the FP
> state untouched. Only mxcsr and mxcsr_flags are set due to
> xfeatures_mxcsr_quirk(). Now that XFEATURE_MASK_FP is set
> unconditionally, see
> 
>   04944b793e18 ("x86: xsave: set FP, SSE bits in the xsave header in the user sigcontext"),
> 
> on return from the signal, random garbage is loaded as the FP state.
> 
> Instead of utilizing copy_xstate_to_user(), fault-in the user memory
> and retry the fast path. Ideally, the fast path succeeds on the second
> attempt but may be retried again if the memory is swapped out due
> to memory pressure. If the user memory can not be faulted-in then
> get_user_pages() returns an error so we don't loop forever.
> 
> Fault in memory via get_user_pages_unlocked() so
> copy_fpregs_to_sigframe() succeeds without a fault.
> 
> Fixes: 69277c98f5eef ("x86/fpu: Always store the registers in copy_fpstate_to_sigframe()")
> Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>    - s/get_user_pages()/get_user_pages_unlocked()/
>    - merge cleanups
> 
> I'm posting this all-in-one fix up replacing the original patch so we
> don't have a merge window with known bugs (that is the one that the
> patch was going the fix and the KASAN fallout that it introduced).
> 
>  arch/x86/kernel/fpu/signal.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)

Queued to tip:WIP.x86/fpu for some hammering ontop ...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjDJQely"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:50:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vftNCW2KR+i5s0Bw7t4HeIZsPq3GFvzfFQczyldYbNk=; b=OjDJQely6WUdJX0lrhYPjcOfl
        yVxys0ehphl6B7Rr7XRAA5tQv4mk0mMXvotoi9e0wwBmwj5LzgsQaaW1V540s5eV/6OwIvMnCN59F
        SaXOcs8wmuVAKaG4rNO8hwsScC7zy2gD/MzO1j0SqjADpjJQrMhmhaue/FCbqpNX8xnXlnoS+GH1/
        mHr1CMRG8FMyT/3iQ6URxPw5NxfD024mnz3hRiJsJ8lQuqaUNCQi44ZCQRhiC8RstF9HhSPdEw0vD
        dEUct/g6tVbHedMKaah+oiAZMkh8sZ0SQU8jLNtGWekaqZ+AYK3Mb2GQB8iLo4UMrK0JgoJ8dhIvy
        bBfAKi+QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1tPU-00062q-B2; Thu, 07 Mar 2019 13:50:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0813202A2A1F; Thu,  7 Mar 2019 14:50:06 +0100 (CET)
Date:   Thu, 7 Mar 2019 14:50:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org
Subject: Re: [PATCH 07/20] x86/uaccess: Always inline force_valid_ss()
Message-ID: <20190307135006.GG32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.708180729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307115159.708180729@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:18PM +0100, Peter Zijlstra wrote:
> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x3cc: call to force_valid_ss.isra.5() with UACCESS enabled
> 
> XXX: move the callsite out of te AC=1 region instead?
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/signal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -71,7 +71,7 @@
>   * alone.  Using this generally makes no sense unless
>   * user_64bit_mode(regs) would return true.
>   */
> -static void force_valid_ss(struct pt_regs *regs)
> +static __always_inline void force_valid_ss(struct pt_regs *regs)
>  {
>  	u32 ar;
>  	asm volatile ("lar %[old_ss], %[ar]\n\t"

arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x384: call to frame_uc_flags.isra.0() with UACCESS enabled

@@ -441,7 +441,7 @@ static int __setup_rt_frame(int sig, str
 	return 0;
 }
 #else /* !CONFIG_X86_32 */
-static unsigned long frame_uc_flags(struct pt_regs *regs)
+static __always_inline unsigned long frame_uc_flags(struct pt_regs *regs)
 {
 	unsigned long flags;
 

Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D18C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ECE20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kpeVHztU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCGTAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:00:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfCGS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gGmYOEezlYoLoO0joDUV5GhkDVpNGHdbcg3KKJ8/zgw=; b=kpeVHztUq/iGy8hyqLOKVFMM/
        cTiKPOslBkaiGhUXH3WpScswCI9mxDbf7Y9sUtg7wJKfcQM3cS38XfvOdFedCJnhTUK1cD1PlglOJ
        g38mAhLx6wfFS9UWTDvRhZilHcSrJQyoMo8C24us5clpy2i5fin/4hAD8iDZsK9baj/YT2abrVUiO
        dxDy4k+MPgxaaAlKUAkGtzaGohOOjg/d2j7yL5b2lJlUvxJDyGyz/mH/j+yN8sOR135tVEasCuX09
        hpU4I/uoTwuZbrvoL7kz7xvMmDQTPEALZWfDa3TrlMH7IPilY2ayrQAW9qwN1WmQqzrzjHVoTYYTn
        0kCe9Sdyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1yEo-0000g7-Bh; Thu, 07 Mar 2019 18:59:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5152C9837F2; Thu,  7 Mar 2019 19:59:22 +0100 (CET)
Date:   Thu, 7 Mar 2019 19:59:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 07/20] x86/uaccess: Always inline force_valid_ss()
Message-ID: <20190307185922.GA2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.708180729@infradead.org>
 <CALCETrX8ZAQpqxA+aRA7gdT3or33wj2Lmj40khmHp59JO=AVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX8ZAQpqxA+aRA7gdT3or33wj2Lmj40khmHp59JO=AVVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:05:43AM -0800, Andy Lutomirski wrote:
> On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x3cc: call to force_valid_ss.isra.5() with UACCESS enabled
> >
> > XXX: move the callsite out of te AC=1 region instead?
> 
> Let's move it instead.  I looked at the code and it should be fine.

Something like so; or did I miss something subtle?

--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -132,16 +132,6 @@ static int restore_sigcontext(struct pt_
 		COPY_SEG_CPL3(cs);
 		COPY_SEG_CPL3(ss);
 
-#ifdef CONFIG_X86_64
-		/*
-		 * Fix up SS if needed for the benefit of old DOSEMU and
-		 * CRIU.
-		 */
-		if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) &&
-			     user_64bit_mode(regs)))
-			force_valid_ss(regs);
-#endif
-
 		get_user_ex(tmpflags, &sc->flags);
 		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
 		regs->orig_ax = -1;		/* disable syscall checks */
@@ -150,6 +140,15 @@ static int restore_sigcontext(struct pt_
 		buf = (void __user *)buf_val;
 	} get_user_catch(err);
 
+#ifdef CONFIG_X86_64
+	/*
+	 * Fix up SS if needed for the benefit of old DOSEMU and
+	 * CRIU.
+	 */
+	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
+		force_valid_ss(regs);
+#endif
+
 	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
 
 	force_iret();
@@ -441,7 +440,7 @@ static int __setup_rt_frame(int sig, str
 	return 0;
 }
 #else /* !CONFIG_X86_32 */
-static unsigned long frame_uc_flags(struct pt_regs *regs)
+static __always_inline unsigned long frame_uc_flags(struct pt_regs *regs)
 {
 	unsigned long flags;
 
@@ -461,6 +460,7 @@ static int __setup_rt_frame(int sig, str
 {
 	struct rt_sigframe __user *frame;
 	void __user *fp = NULL;
+	unsigned long uc_flags;
 	int err = 0;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
@@ -473,9 +473,11 @@ static int __setup_rt_frame(int sig, str
 			return -EFAULT;
 	}
 
+	uc_flags = frame_uc_flags(regs);
+
 	put_user_try {
 		/* Create the ucontext.  */
-		put_user_ex(frame_uc_flags(regs), &frame->uc.uc_flags);
+		put_user_ex(uc_flags, &frame->uc.uc_flags);
 		put_user_ex(0, &frame->uc.uc_link);
 		save_altstack_ex(&frame->uc.uc_stack, regs->sp);
 


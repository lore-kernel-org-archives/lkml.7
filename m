Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2A20896
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCWQOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:14:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42648 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCWQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:14:41 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7jHu-0004rJ-J5; Sat, 23 Mar 2019 17:14:26 +0100
Date:   Sat, 23 Mar 2019 17:14:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
In-Reply-To: <20190228192746.GA13021@embeddedor>
Message-ID: <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
References: <20190228192746.GA13021@embeddedor>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Gustavo A. R. Silva wrote:

>  arch/x86/include/asm/syscall.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Second thoughts. So this adds 28 /* fall through */ comments. Now I
appreciate the effort, but can we pretty please look at the code in
question and figure out whether the implementation makes sense in the first
place before adding falltrough comments blindly?

The whole exercise can be simplified. Untested patch below.

Looking at that stuff makes me wonder about two things:

 1) The third argument of get/set(), i.e. the argument offset, is 0 on all
    call sites. Do we need it at all?

 2) syscall_set_arguments() has been introduced in 2008 and we still have
    no caller. Instead of polishing it, can it be removed completely or are
    there plans to actually use it?

Thanks,

	tglx

8<----------------

arch/x86/include/asm/syscall.h |  174 +++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 110 deletions(-)

--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -114,126 +114,80 @@ static inline int syscall_get_arch(void)
 
 #else	 /* CONFIG_X86_64 */
 
+static inline unsigned long syscall_get_argreg(struct pt_regs *regs,
+					       unsigned int idx)
+{
+	switch (idx) {
+	case  0: return regs->di;
+	case  1: return regs->si;
+	case  2: return regs->dx;
+	case  3: return regs->r10;
+	case  4: return regs->r8;
+	case  5: return regs->r9;
+#ifdef CONFIG_IA32_EMULATION
+	case  6: return regs->bx;
+	case  7: return regs->cx;
+	case  8: return regs->dx;
+	case  9: return regs->si;
+	case 10: return regs->di;
+	case 11: return regs->bp;
+#endif
+	}
+	return 0;
+}
+
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
+					 unsigned int idx, unsigned int cnt,
 					 unsigned long *args)
 {
-# ifdef CONFIG_IA32_EMULATION
-	if (task->thread_info.status & TS_COMPAT)
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			*args++ = regs->bx;
-		case 1:
-			if (!n--) break;
-			*args++ = regs->cx;
-		case 2:
-			if (!n--) break;
-			*args++ = regs->dx;
-		case 3:
-			if (!n--) break;
-			*args++ = regs->si;
-		case 4:
-			if (!n--) break;
-			*args++ = regs->di;
-		case 5:
-			if (!n--) break;
-			*args++ = regs->bp;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
-	else
-# endif
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			*args++ = regs->di;
-		case 1:
-			if (!n--) break;
-			*args++ = regs->si;
-		case 2:
-			if (!n--) break;
-			*args++ = regs->dx;
-		case 3:
-			if (!n--) break;
-			*args++ = regs->r10;
-		case 4:
-			if (!n--) break;
-			*args++ = regs->r8;
-		case 5:
-			if (!n--) break;
-			*args++ = regs->r9;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
+	if (WARN_ON((idx + cnt) > 6))
+		return;
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
+	    task->thread_info.status & TS_COMPAT)
+		idx += 6;
+
+	for (; cnt > 0; cnt--)
+		*args++ = syscall_get_argreg(regs, idx++);
+}
+
+static inline void syscall_set_argreg(struct pt_regs *regs,
+				      unsigned int idx,
+				      unsigned long val)
+{
+	switch (idx) {
+	case  0: regs->di  = val; break;
+	case  1: regs->si  = val; break;
+	case  2: regs->dx  = val; break;
+	case  3: regs->r10 = val; break;
+	case  4: regs->r8  = val; break;
+	case  5: regs->r9  = val; break;
+#ifdef CONFIG_IA32_EMULATION
+	case  6: regs->bx  = val; break;
+	case  7: regs->cx  = val; break;
+	case  8: regs->dx  = val; break;
+	case  9: regs->si  = val; break;
+	case 10: regs->di  = val; break;
+	case 11: regs->bp  = val; break;
+#endif
+	}
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
+					 unsigned int idx, unsigned int cnt,
 					 const unsigned long *args)
 {
-# ifdef CONFIG_IA32_EMULATION
-	if (task->thread_info.status & TS_COMPAT)
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			regs->bx = *args++;
-		case 1:
-			if (!n--) break;
-			regs->cx = *args++;
-		case 2:
-			if (!n--) break;
-			regs->dx = *args++;
-		case 3:
-			if (!n--) break;
-			regs->si = *args++;
-		case 4:
-			if (!n--) break;
-			regs->di = *args++;
-		case 5:
-			if (!n--) break;
-			regs->bp = *args++;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
-	else
-# endif
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			regs->di = *args++;
-		case 1:
-			if (!n--) break;
-			regs->si = *args++;
-		case 2:
-			if (!n--) break;
-			regs->dx = *args++;
-		case 3:
-			if (!n--) break;
-			regs->r10 = *args++;
-		case 4:
-			if (!n--) break;
-			regs->r8 = *args++;
-		case 5:
-			if (!n--) break;
-			regs->r9 = *args++;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
+	if (WARN_ON((idx + cnt) > 6))
+		return;
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
+	    task->thread_info.status & TS_COMPAT)
+		idx += 6;
+
+	for (; cnt > 0; cnt--)
+		syscall_set_argreg(regs, idx++, *args++);
 }
 
 static inline int syscall_get_arch(void)

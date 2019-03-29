Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4D218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iursBBaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfC2VrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:47:15 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44853 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbfC2VrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:47:13 -0400
Received: by mail-qt1-f201.google.com with SMTP id b1so3655126qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pAK9mB0rR5eLJqKVQEdBShN9qY/HYUOEXs4mGavWn+E=;
        b=iursBBaLgBcxmTAiM/uaUtNclPrrEoqFb39Rh/nthzsextgL0Zr5gj+GqbaxSj5uxh
         hjJUVB4xXYNNfwvi2zlThEO7pAQcqhHuKjLfJVTaxfq5cLVO7ppCFgJo6JAhLCJHHQpR
         OshmfU1QkYq+/IKfhTT9uXhmRggz9W4hZo+NNFPFwKgTQmMNfPPoj6gb8clOHuwVWa2a
         TrryZH1THBnHYdZSr7cC3rPlRZASb6jMrv4U9AGY/GE8HrMGCJ9gzwTZ/81wWFekjCm+
         5pI/0Jtq2Xo5sBasc0FcgMV9LXJ3yeH7iKRrCUFg2bEc6nfwb5em0awHIRxpH710B/f9
         BX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pAK9mB0rR5eLJqKVQEdBShN9qY/HYUOEXs4mGavWn+E=;
        b=Zyfq2ePEXhXd4KmhoQng6r1krfvkkN8AzE1i2bBGvgK1du8LeHwvP3ouiW7mkazZac
         WkanzWDZaMB4AxVhUezMzyrf2B3OKrRsOrOZ3o5JdlqstrF8OtplvhL86x4gBQFvBAwo
         HC0l7zpizIowcsnNIpAKGWaGZ2PuAMJ1cEeLOjjKqWiZ46Ne9M1tfLxhvoQq9q6g5tGC
         oD0IxemiTMVvx/zXvZ1CvwWqKXWXu8ijeOTfu+jkSZkjqve2nHyUWIFnygk2KexOYmWD
         GQJcHPrDlGZLuewc4c/aTixDi0Igz8dOaC6ApQsiDw26jEyHZmu3RgNaXSR3tXTBmFca
         I5yw==
X-Gm-Message-State: APjAAAUqj1JPH/RWIqxyiN9XuyoViA8b5sXKOT9Z/6naaegVpd75cDT6
        H5GZVWOoBCH/RHOskukKdVTStJpTQw==
X-Google-Smtp-Source: APXvYqzaEYW+EYHzwhs7G8i4QHDmJrx3SLEB5iU1Ub+VndqbVobaFjkskBq/ByoQRGfGoXspSGMNDfainQ==
X-Received: by 2002:ac8:2363:: with SMTP id b32mr4692042qtb.48.1553896032339;
 Fri, 29 Mar 2019 14:47:12 -0700 (PDT)
Date:   Fri, 29 Mar 2019 22:46:51 +0100
In-Reply-To: <20190329214652.258477-1-jannh@google.com>
Message-Id: <20190329214652.258477-3-jannh@google.com>
Mime-Version: 1.0
References: <20190329214652.258477-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 3/4] x86/fpu: Fix __user annotations
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In save_xstate_epilog(), use __user when type-casting userspace pointers.

In setup_sigcontext() and x32_setup_rt_frame(), cast the userspace
pointers to 'unsigned long __user *' before writing into them.
These pointers are originally '__u32 __user *' or '__u64 __user *',
causing sparse to complain when a userspace pointer is written into
them. The casts are okay because the pointers always point to
pointer-sized values.
Thanks to Luc Van Oostenryck and Al Viro for explaining this to me.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/fpu/signal.c | 6 +++---
 arch/x86/kernel/signal.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f6a1d299627c..55b80de13ea5 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -92,13 +92,13 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 		return err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 *)(buf + fpu_user_xstate_size));
+			  (__u32 __user *)(buf + fpu_user_xstate_size));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
 	 * from the state in task struct) to the user buffers.
 	 */
-	err |= __get_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
@@ -113,7 +113,7 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	 */
 	xfeatures |= XFEATURE_MASK_FPSSE;
 
-	err |= __put_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	return err;
 }
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 08dfd4c1a4f9..b419e1a1a0ce 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		put_user_ex(regs->ss, &sc->ss);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, &sc->fpstate);
+		put_user_ex(fpstate, (unsigned long __user *)&sc->fpstate);
 
 		/* non-iBCS2 extensions.. */
 		put_user_ex(mask, &sc->oldmask);
@@ -569,7 +569,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 			restorer = NULL;
 			err |= -EFAULT;
 		}
-		put_user_ex(restorer, &frame->pretcode);
+		put_user_ex(restorer, (unsigned long __user *)&frame->pretcode);
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-- 
2.21.0.392.gf8f6787159e-goog


Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91300C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6080B218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUzmGO+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfC2QbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:31:03 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50782 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2QbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:31:01 -0400
Received: by mail-qt1-f201.google.com with SMTP id g17so2721504qte.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W0llCKzJRT/maqYxf3VxveLknpG8fuRPHcqL2onuco4=;
        b=bUzmGO+xA1rfe/72XqOQOlpr9kuIitPJjKSUjiAHIe2pNIbpTGQKsa8RxWouup4Q+a
         StWkfDlV7FHZHnEqnqW+/vabz085oe9AU/7VaYMQTdSc//0ZGum/kqtMHyE0xVuFfexZ
         zgFqZptSeKGxFqL7nZu5/XfNj7EgGpwbZhcpO9byxUd02nPuaQGnsqxbv06EgeomTl6h
         IbxxKqHSXBcQv6AO11ziT7Jg2hoqBF9HC0y+lBDu3Acvd84dd0GCUdXd/wTLAEeOB9Gd
         rr2JVzxVIIqU4PcwJ5EFAvHCOR3evXcml4gnC9FjU1PJ9MBDMNWkx0oAH0/6LR+QJdSj
         j09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W0llCKzJRT/maqYxf3VxveLknpG8fuRPHcqL2onuco4=;
        b=bEi8RYKZKfE4NOYG8COf0uf0rvaw5iQnmENN4Tn5c4r1t8hpgtnLYxyg305f/snFST
         JUbMD6nlVX+AGqOl3peUKrKCvhlqENY8NMpMwOKmvvcAEwpYUrb512/mtU/Tn321Xct/
         tMHgb49qH/1ETzboiOTzq43CguZArxM4CXFv77ilqa3pizN885osH6fk2TSSZY1uE9s/
         4+S51Fym3M3clXxSLj0yHuuRjz9eLCYBLh2E1PIS8M5yxeBeuK/AhTRrfN3mjwk0pLnF
         dbG3nx0pYcsPGApKg984LpmERajCo1lOCfQlTsBwhRImRJjfVAViY6QMVcANShpZqKqg
         314w==
X-Gm-Message-State: APjAAAUrWsIsst3590leBP4kSAENZdVMaOUZgHcEv7FQjgON16tFohsJ
        1CN5wvIOGerdnem6XHIgjmlkDm47eQ==
X-Google-Smtp-Source: APXvYqwVsqrp1nkrNnPb561mlCkXo1MAWw53F+B+qWqTW+z29xQ88gjQvqh0k35pi39ZxqqJdbtaI2pUJQ==
X-Received: by 2002:a05:620a:1376:: with SMTP id d22mr3167332qkl.53.1553877060582;
 Fri, 29 Mar 2019 09:31:00 -0700 (PDT)
Date:   Fri, 29 Mar 2019 17:30:46 +0100
In-Reply-To: <20190329163047.223508-1-jannh@google.com>
Message-Id: <20190329163047.223508-3-jannh@google.com>
Mime-Version: 1.0
References: <20190329163047.223508-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 3/4] x86/fpu: Fix __user annotations
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In save_xstate_epilog(), use __user when type-casting userspace pointers.

In setup_sigcontext() and x32_setup_rt_frame(), perform explicit __force
casts for converting userspace pointers to unsigned long; put_user_ex()
already performs a cast, but without __force, which is required by sparse
for conversions from userspace pointers to numbers.

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
index 08dfd4c1a4f9..e13cd972f9af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		put_user_ex(regs->ss, &sc->ss);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, &sc->fpstate);
+		put_user_ex((unsigned long __force)fpstate, &sc->fpstate);
 
 		/* non-iBCS2 extensions.. */
 		put_user_ex(mask, &sc->oldmask);
@@ -569,7 +569,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 			restorer = NULL;
 			err |= -EFAULT;
 		}
-		put_user_ex(restorer, &frame->pretcode);
+		put_user_ex((unsigned long __force)restorer, &frame->pretcode);
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-- 
2.21.0.392.gf8f6787159e-goog


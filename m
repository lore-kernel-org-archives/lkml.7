Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4027BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE38205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439668AbfIYP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:29:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:20433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439623AbfIYP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032288"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 08:28:58 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 6/6] x86/fpu/xstate: Rename validate_xstate_header() to validate_xstate_header_from_user()
Date:   Wed, 25 Sep 2019 08:10:22 -0700
Message-Id: <20190925151022.21688-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925151022.21688-1-yu-cheng.yu@intel.com>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The function validate_xstate_header() validates an xstate header coming
from userspace (PTRACE or sigreturn).  To make it clear, rename it to
validate_xstate_header_from_user().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/xstate.h | 2 +-
 arch/x86/kernel/fpu/regset.c      | 2 +-
 arch/x86/kernel/fpu/signal.c      | 2 +-
 arch/x86/kernel/fpu/xstate.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 5954bd97da16..45df38043600 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -72,6 +72,6 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-extern int validate_xstate_header(const struct xstate_header *hdr);
+int validate_xstate_header_from_user(const struct xstate_header *hdr);
 
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index d652b939ccfb..9789f95cfb66 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -139,7 +139,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	} else {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
 		if (!ret)
-			ret = validate_xstate_header(&xsave->header);
+			ret = validate_xstate_header_from_user(&xsave->header);
 	}
 
 	/*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 25e7dddbc6fd..728b43c34536 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -368,7 +368,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
 
 			if (!ret && state_size > offsetof(struct xregs_state, header))
-				ret = validate_xstate_header(&fpu->state.xsave.header);
+				ret = validate_xstate_header_from_user(&fpu->state.xsave.header);
 		}
 		if (ret)
 			goto err_out;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a183c319d808..3df2e55e860d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -480,7 +480,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_xstate_header(const struct xstate_header *hdr)
+int validate_xstate_header_from_user(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & ~xfeatures_mask_user())
@@ -1165,7 +1165,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 
 	memcpy(&hdr, kbuf + offset, size);
 
-	if (validate_xstate_header(&hdr))
+	if (validate_xstate_header_from_user(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
@@ -1219,7 +1219,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	if (__copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
-	if (validate_xstate_header(&hdr))
+	if (validate_xstate_header_from_user(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
-- 
2.17.1


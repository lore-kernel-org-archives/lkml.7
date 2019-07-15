Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADABC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EE720896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200523;
	bh=8aMhZObp+OV6R+0Pf2IC4tAtq3tomyGvUrXruWhPUoI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iv5tQZqPfwR6uZISLQEq7h5Hs+IGFs2PTmjCuL8r3N9Ms6aByZVgNsaf3+tKC7fn6
	 n4fyGZrnA8fkAAIu5n6+flvF4ayVhaDxSiGHuGxHD8jj0JL5OOA1Nq4vfFWNNN+5nS
	 OnMzyNcgY2Yp66+nvspZMQZxdcYLTd0qEGFoD9dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390127AbfGOOV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390004AbfGOOVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:51 -0400
Received: from localhost (d192-24-91-215.try.wideopenwest.com [24.192.215.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D342184C;
        Mon, 15 Jul 2019 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200510;
        bh=8aMhZObp+OV6R+0Pf2IC4tAtq3tomyGvUrXruWhPUoI=;
        h=From:To:Cc:Subject:Date:From;
        b=CHG6tDR6ScJFj8bAHpOx7eMShmwPYizVnXpdP8cPQMLJgnbg+mW0KuTbNiAWfnT4D
         ypqe+rM31ZHkrPTu5UGXO42Ag5E2swcKWLFQ4/gguFge9pwJ8TGdHCEfZ40jFmPore
         8RXk3um9of4WsBsU6mrxx7af7igpveBwmmqRQaag=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] Revert "x86/ptrace: Prevent ptrace from clearing the FS/GS selector" and fix the test
Date:   Mon, 15 Jul 2019 07:21:44 -0700
Message-Id: <fca39c478ea7fb15bc76fe8a36bd180810a067f6.1563200250.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 48f5e52e916b55fb73754833efbacc7f8081a159.

The ptrace ABI change was a prerequisite to the proposed design for
FSGSBASE.  Since FSGSBASE support has been reverted, and since I'm
not convinced that the ABI was ever adequately tested, revert the
ABI change as well.

This also modifies the test case so that it tests the preexisting
behavior.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ptrace.c               | 14 ++++++++++++--
 tools/testing/selftests/x86/fsgsbase.c | 22 ++++------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 3108cdc00b29..a166c960bc9e 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,12 +397,22 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_fsbase_write_task(child, value);
+		/*
+		 * When changing the FS base, use do_arch_prctl_64()
+		 * to set the index to zero and to set the base
+		 * as requested.
+		 */
+		if (child->thread.fsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
+		/*
+		 * Exactly the same here as the %fs handling above.
+		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_gsbase_write_task(child, value);
+		if (child->thread.gsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 5ab4c60c100e..15a329da59fa 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -489,25 +489,11 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs != *shared_scratch) {
-			nerrs++;
-			printf("[FAIL]\tGS changed to %lx\n", gs);
-
-			/*
-			 * On older kernels, poking a nonzero value into the
-			 * base would zero the selector.  On newer kernels,
-			 * this behavior has changed -- poking the base
-			 * changes only the base and, if FSGSBASE is not
-			 * available, this may have no effect.
-			 */
-			if (gs == 0)
-				printf("\tNote: this is expected behavior on older kernels.\n");
-		} else if (have_fsgsbase && (base != 0xFF)) {
-			nerrs++;
-			printf("[FAIL]\tGSBASE changed to %lx\n", base);
+		if (gs == 0 && base == 0xFF) {
+			printf("[OK]\tGS was reset as expected\n");
 		} else {
-			printf("[OK]\tGS remained 0x%hx%s", *shared_scratch, have_fsgsbase ? " and GSBASE changed to 0xFF" : "");
-			printf("\n");
+			nerrs++;
+			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
 		}
 	}
 
-- 
2.21.0


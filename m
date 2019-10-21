Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EC420640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfJUOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:23:15 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:52712 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:23:15 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id GEPA2100Z05gfCL01EPAGy; Mon, 21 Oct 2019 16:23:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMYaU-0007oE-Ju; Mon, 21 Oct 2019 16:23:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMYaU-0007K2-Gm; Mon, 21 Oct 2019 16:23:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] powerpc/security: Fix debugfs data leak on 32-bit
Date:   Mon, 21 Oct 2019 16:23:09 +0200
Message-Id: <20191021142309.28105-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"powerpc_security_features" is "unsigned long", i.e. 32-bit or 64-bit,
depending on the platform (PPC_FSL_BOOK3E or PPC_BOOK3S_64).  Hence
casting its address to "u64 *", and calling debugfs_create_x64() is
wrong, and leaks 32-bit of nearby data to userspace on 32-bit platforms.

While all currently defined SEC_FTR_* security feature flags fit in
32-bit, they all have "ULL" suffixes to make them 64-bit constants.
Hence fix the leak by changing the type of "powerpc_security_features"
(and the parameter types of its accessors) to "u64".  This also allows
to drop the cast.

Fixes: 398af571128fe75f ("powerpc/security: Show powerpc_security_features in debugfs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Alternatively, powerpc_security_features could be changed to u32.
However, that would require using debugfs_create_x32() instead of
debugfs_create_x64(), which would change the debugfs file formatting
from "0x%016llx" to "0x%08llx".
---
 arch/powerpc/include/asm/security_features.h | 8 ++++----
 arch/powerpc/kernel/security.c               | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 759597bf0fd867bd..a3e8ecd48dc7ffa0 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -9,7 +9,7 @@
 #define _ASM_POWERPC_SECURITY_FEATURES_H
 
 
-extern unsigned long powerpc_security_features;
+extern u64 powerpc_security_features;
 extern bool rfi_flush;
 
 /* These are bit flags */
@@ -24,17 +24,17 @@ void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
 void setup_count_cache_flush(void);
 
-static inline void security_ftr_set(unsigned long feature)
+static inline void security_ftr_set(u64 feature)
 {
 	powerpc_security_features |= feature;
 }
 
-static inline void security_ftr_clear(unsigned long feature)
+static inline void security_ftr_clear(u64 feature)
 {
 	powerpc_security_features &= ~feature;
 }
 
-static inline bool security_ftr_enabled(unsigned long feature)
+static inline bool security_ftr_enabled(u64 feature)
 {
 	return !!(powerpc_security_features & feature);
 }
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7cfcb294b11ca7be..2e9a7e20d05c5f79 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -16,7 +16,7 @@
 #include <asm/setup.h>
 
 
-unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
+u64 powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 enum count_cache_flush_type {
 	COUNT_CACHE_FLUSH_NONE	= 0x1,
@@ -108,7 +108,7 @@ device_initcall(barrier_nospec_debugfs_init);
 static __init int security_feature_debugfs_init(void)
 {
 	debugfs_create_x64("security_features", 0400, powerpc_debugfs_root,
-			   (u64 *)&powerpc_security_features);
+			   &powerpc_security_features);
 	return 0;
 }
 device_initcall(security_feature_debugfs_init);
-- 
2.17.1


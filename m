Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD2C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AF1218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbfGWNWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:54750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGWNWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B355628;
        Tue, 23 Jul 2019 06:22:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B5B63F71F;
        Tue, 23 Jul 2019 06:22:07 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/features/locking: update lists
Date:   Tue, 23 Jul 2019 14:22:03 +0100
Message-Id: <20190723132203.51814-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking feature lists don't match reality as of v5.3-rc1:

* arm64 moved to queued spinlocks in commit:

  c11090474d70590170cf5fa6afe85864ab494b37

  ("arm64: locking: Replace ticket lock implementation with qspinlock")

* xtensa moved to queued spinlocks and rwlocks in commit:

  579afe866f52adcd921272a224ab36733051059c

  ("xtensa: use generic spinlock/rwlock implementation")

* architecture-specific rwsem support was removed in commit:

  46ad0840b1584b92b5ff2cc3ed0b011dd6b8e0f1

  ("locking/rwsem: Remove arch specific rwsem files")

So update the feature lists accordingly, and remove the now redundant
rwsem-optimized list.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 .../locking/queued-rwlocks/arch-support.txt        |  2 +-
 .../locking/queued-spinlocks/arch-support.txt      |  4 +--
 .../locking/rwsem-optimized/arch-support.txt       | 34 ----------------------
 3 files changed, 3 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/features/locking/rwsem-optimized/arch-support.txt

diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index c683da198f31..ee922746a64c 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index e3080b82aefd..c52116c1a049 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
deleted file mode 100644
index 7521d7500fbe..000000000000
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Feature name:          rwsem-optimized
-#         Kconfig:       !RWSEM_GENERIC_SPINLOCK
-#         description:   arch provides optimized rwsem APIs
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: |  ok  |
-    |         arc: | TODO |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |        csky: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: |  ok  |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: | TODO |
-    |       riscv: | TODO |
-    |        s390: |  ok  |
-    |          sh: |  ok  |
-    |       sparc: |  ok  |
-    |          um: |  ok  |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: |  ok  |
-    -----------------------
-- 
2.11.0


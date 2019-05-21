Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1013DC072AD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937D2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfEUExG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:06 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58412 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUExF (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:05 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:04 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:52:57 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 01/14] interval-tree: build unconditionally
Date:   Mon, 20 May 2019 21:52:29 -0700
Message-Id: <20190521045242.24378-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for range locking, this patch gets rid of
CONFIG_INTERVAL_TREE option as we will unconditionally
build it.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/Kconfig      |  2 --
 drivers/gpu/drm/i915/Kconfig |  1 -
 drivers/iommu/Kconfig        |  1 -
 lib/Kconfig                  | 14 --------------
 lib/Kconfig.debug            |  1 -
 lib/Makefile                 |  3 +--
 6 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e360a4a131e1..3405336175ed 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -200,7 +200,6 @@ config DRM_RADEON
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
-	select INTERVAL_TREE
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
@@ -220,7 +219,6 @@ config DRM_AMDGPU
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
-	select INTERVAL_TREE
 	select CHASH
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 3d5f1cb6a76c..54d4bc8d141f 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,7 +3,6 @@ config DRM_I915
 	depends on DRM
 	depends on X86 && PCI
 	select INTEL_GTT
-	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a2ed2b51a0f7..d21e6dc2adae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -477,7 +477,6 @@ config VIRTIO_IOMMU
 	depends on VIRTIO=y
 	depends on ARM64
 	select IOMMU_API
-	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 8d9239a4156c..e089ac40c062 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -409,20 +409,6 @@ config TEXTSEARCH_FSM
 config BTREE
 	bool
 
-config INTERVAL_TREE
-	bool
-	help
-	  Simple, embeddable, interval-tree. Can find the start of an
-	  overlapping range in log(n) time and then iterate over all
-	  overlapping nodes. The algorithm is implemented as an
-	  augmented rbtree.
-
-	  See:
-
-		Documentation/rbtree.txt
-
-	  for more information.
-
 config XARRAY_MULTI
 	bool
 	help
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4c35e52c5a2e..54bafed8ba70 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1759,7 +1759,6 @@ config RBTREE_TEST
 config INTERVAL_TREE_TEST
 	tristate "Interval tree test"
 	depends on DEBUG_KERNEL
-	select INTERVAL_TREE
 	help
 	  A benchmark measuring the performance of the interval tree library
 
diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..39fd34156692 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -50,7 +50,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o
+	 generic-radix-tree.o interval_tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
@@ -115,7 +115,6 @@ obj-y += logic_pio.o
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
-obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
 obj-$(CONFIG_ASSOCIATIVE_ARRAY) += assoc_array.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
-- 
2.16.4


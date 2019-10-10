Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A110C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94020640
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfJJKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:41:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:49352 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732923AbfJJKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 03:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="187917759"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2019 03:41:13 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] samples: mei: use hostprogs kbuild constructs
Date:   Thu, 10 Oct 2019 16:27:10 +0300
Message-Id: <20191010132710.4075-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hostprogs kbuild constructs to compile
mei sample program mei-amt-version

Add CONFIG_SAMPLE_INTEL_MEI option to enable/disable
the feature.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 samples/Kconfig      |  7 +++++++
 samples/Makefile     |  1 +
 samples/mei/Makefile | 12 ++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index c8dacb4dda80..b663d9d24114 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -169,4 +169,11 @@ config SAMPLE_VFS
 	  as mount API and statx().  Note that this is restricted to the x86
 	  arch whilst it accesses system calls that aren't yet in all arches.
 
+config SAMPLE_INTEL_MEI
+	bool "Build example program working with intel mei driver"
+	depends on INTEL_MEI
+	help
+	  Build a sample program to work with mei device.
+
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 7d6e4ca28d69..d6062ab25347 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
+obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
diff --git a/samples/mei/Makefile b/samples/mei/Makefile
index c7e52e9e92ca..27f37efdadb4 100644
--- a/samples/mei/Makefile
+++ b/samples/mei/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-CC := $(CROSS_COMPILE)gcc
-CFLAGS := -I../../usr/include
+# Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
 
-PROGS := mei-amt-version
+hostprogs-y := mei-amt-version
 
-all: $(PROGS)
+HOSTCFLAGS_mei-amt-version.o += -I$(objtree)/usr/include
 
-clean:
-	rm -fr $(PROGS)
+always := $(hostprogs-y)
+
+all: mei-amt-version
-- 
2.21.0


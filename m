Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DA720811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NZDTpt77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCSXcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:32:08 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:23329 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCSXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4393; q=dns/txt; s=iport;
  t=1553038324; x=1554247924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebaKlHsU+JLkUig1mk8UCew4GuPPPQqZTb0b5yOHuM0=;
  b=NZDTpt77wq2/RzgX3e79HaQoHTAPo2gSow29DFRSP06mGcOpYF4UIYm9
   uQR/mjroXYX6skoO8piapdCTEiQ0YzEg5rBXvjBRmUtZAu0D+zt6OX6D9
   rQzvDfnJ2ynHuCwj8l8FxiwyMQ8xzfv9finpucaa5nCbqVm9f6rLwtBIN
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAAA8eZFc/4cNJK1jGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCEIFrJ4wnpWuBew2EbIRtIjQJDQEBAwEBCQE?=
 =?us-ascii?q?DAm0ohgMBRimBFQESgyKBdQGsD4o1FIEbAYZphEgXgUA/jmMiA5Ickk0Jgku?=
 =?us-ascii?q?QVQwZk16LDJMrgUc4gVYzGggbFYMnkGsfM49rAQE?=
X-IronPort-AV: E=Sophos;i="5.60,246,1549929600"; 
   d="scan'208";a="247548013"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 19 Mar 2019 23:24:58 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id x2JNOrtY019667;
        Tue, 19 Mar 2019 23:24:57 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] powerpc: convert config files to generic cmdline
Date:   Tue, 19 Mar 2019 16:24:48 -0700
Message-Id: <20190319232448.45964-5-danielwa@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a mass convert of the config files to use the new
generic cmdline.

The command used to convert is as follows,

sed -i 's/CONFIG_CMDLINE=/CONFIG_CMDLINE_PREPEND=/g' <config>

Cc: xe-linux-external@cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>

Change-Id: Idf7cae45ef5f8afebcb1ee7e025aafcb6541ad35
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/configs/44x/fsp2_defconfig       | 2 +-
 arch/powerpc/configs/44x/iss476-smp_defconfig | 2 +-
 arch/powerpc/configs/44x/warp_defconfig       | 2 +-
 arch/powerpc/configs/holly_defconfig          | 2 +-
 arch/powerpc/configs/mvme5100_defconfig       | 2 +-
 arch/powerpc/configs/skiroot_defconfig        | 2 +-
 arch/powerpc/configs/storcenter_defconfig     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index bae6b26bcfba..1e9b1e7e281f 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -29,7 +29,7 @@ CONFIG_SWIOTLB=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ip=on rw"
+CONFIG_CMDLINE_PREPEND="ip=on rw"
 # CONFIG_SUSPEND is not set
 # CONFIG_PCI is not set
 CONFIG_NET=y
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index d24bfa6ecd62..ed234c2b1956 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -18,7 +18,7 @@ CONFIG_HZ_100=y
 CONFIG_MATH_EMULATION=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="root=/dev/issblk0"
+CONFIG_CMDLINE_PREPEND="root=/dev/issblk0"
 # CONFIG_PCI is not set
 CONFIG_ADVANCED_OPTIONS=y
 CONFIG_DYNAMIC_MEMSTART=y
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 6c02f53271cd..ddb395840bb9 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -15,7 +15,7 @@ CONFIG_WARP=y
 CONFIG_PPC4xx_GPIO=y
 CONFIG_HZ_1000=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ip=on"
+CONFIG_CMDLINE_PREPEND="ip=on"
 # CONFIG_PCI is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index 71d8d2430b6c..14945562d193 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -14,7 +14,7 @@ CONFIG_PPC_HOLLY=y
 CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 63e38c7220f1..07a68ebb3713 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -23,7 +23,7 @@ CONFIG_HZ_100=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
+CONFIG_CMDLINE_PREPEND="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index cfdd08897a06..a79984208224 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -53,7 +53,7 @@ CONFIG_NUMA=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
+CONFIG_CMDLINE_PREPEND="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
 # CONFIG_SECCOMP is not set
 # CONFIG_PPC_MEM_KEYS is not set
 CONFIG_NET=y
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 74bca2eccd0f..83b3b92176a0 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -13,7 +13,7 @@ CONFIG_STORCENTER=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=m
-- 
2.19.1


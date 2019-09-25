Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD955C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D94321D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbfIYG3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:29:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390491AbfIYG3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:29:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31D1BA6A5DDE99DB5B69;
        Wed, 25 Sep 2019 14:28:51 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 14:28:42 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <david.oberhollenzer@sigma-star.at>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH xfstests v3] overlay: Enable character device to be the base fs partition
Date:   Wed, 25 Sep 2019 14:35:33 +0800
Message-ID: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running overlay tests using character devices as base fs partitions,
all overlay usecase results become 'notrun'. Function
'_overay_config_override' (common/config) detects that the current base
fs partition is not a block device and will set FSTYP to base fs. The
overlay usecase will check the current FSTYP, and if it is not 'overlay'
or 'generic', it will skip the execution.

For example, using UBIFS as base fs skips all overlay usecases:

  FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
  MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
  MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch

  overlay/001	[not run] not suitable for this filesystem type: ubifs
  overlay/002	[not run] not suitable for this filesystem type: ubifs
  overlay/003	[not run] not suitable for this filesystem type: ubifs

When checking that the base fs partition is a block/character device,
FSTYP is overwritten as 'overlay'. This patch allows the base fs
partition to be a character device that can also execute overlay
usecases (such as ubifs).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/config | 6 +++---
 common/rc     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/config b/common/config
index 4c86a49..4eda36c 100644
--- a/common/config
+++ b/common/config
@@ -532,7 +532,7 @@ _canonicalize_mountpoint()
 # When SCRATCH/TEST_* vars are defined in evironment and not
 # in config file, this function is called after vars have already
 # been overriden in the previous test.
-# In that case, TEST_DEV is a directory and not a blockdev and
+# In that case, TEST_DEV is a directory and not a blockdev/chardev and
 # the function will return without overriding the SCRATCH/TEST_* vars.
 _overlay_config_override()
 {
@@ -550,7 +550,7 @@ _overlay_config_override()
 	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
 	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
 	#    overlayfs base and mount dirs inside base fs mount.
-	[ -b "$TEST_DEV" ] || return 0
+	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
 
 	# Config file may specify base fs type, but we obay -overlay flag
 	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
@@ -570,7 +570,7 @@ _overlay_config_override()
 	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
 	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
 
-	[ -b "$SCRATCH_DEV" ] || return 0
+	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
 
 	# Store original base fs vars
 	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
diff --git a/common/rc b/common/rc
index 66c7fd4..8d57c37 100644
--- a/common/rc
+++ b/common/rc
@@ -3100,7 +3100,7 @@ _require_scratch_shutdown()
 			# SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
 			# will be null, so check OVL_BASE_SCRATCH_DEV before
 			# running shutdown to avoid shutting down base fs accidently.
-			_notrun "$SCRATCH_DEV is not a block device"
+			_notrun "This test requires a valid $OVL_BASE_SCRATCH_DEV as ovl base fs"
 		else
 			src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
 			|| _notrun "Underlying filesystem does not support shutdown"
-- 
2.7.4


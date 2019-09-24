Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B09C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5761E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504249AbfIXJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:33:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405224AbfIXJdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:33:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C6155CFB229BD2C1AE5;
        Tue, 24 Sep 2019 17:33:41 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Sep 2019
 17:33:34 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <david.oberhollenzer@sigma-star.at>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH xfstests] overlay: Enable character device to be the base fs partition
Date:   Tue, 24 Sep 2019 17:40:25 +0800
Message-ID: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
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
  ...

When checking that the base fs partition is a block/character device,
FSTYP is overwritten as 'overlay'. This patch allows the base fs
partition to be a character device that can also execute overlay
usecases (such as ubifs).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 common/config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/config b/common/config
index 4c86a49..a22acdb 100644
--- a/common/config
+++ b/common/config
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
-- 
2.7.4


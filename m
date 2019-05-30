Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E50C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD90246F2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186953;
	bh=WSxZ+l1zBLcw8xp+9tZaF07YU4YOYkgUrHg+LBoNN3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhHNBOYLH+/fvd/nBMsqPzcWLhxZjTDHZ3kx7V1/WXYkyud16rHqqTyzhotXXtNU7
	 NX/le51lDNx9uv0qz+KqlPK7qvmf1gLkM7rrhnmS8icgZuahckTgSjk/46Z0dtG3Et
	 mtPaiZqtwZCVjHuGBaOxvKCXOU8ETb3BrF6vDiuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfE3D3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfE3DUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:31 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CCA2493A;
        Thu, 30 May 2019 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186430;
        bh=WSxZ+l1zBLcw8xp+9tZaF07YU4YOYkgUrHg+LBoNN3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVmNO/UijO9E+3FXlabeEEndPck3SBpHT+2/fR5hWH8jgHAvWbYXxbpGGBGgtXP4t
         Npu17+Dmu2ja58SVJ6u52yX/ZwzSiaGnC3hzkSTGiN9jenSHH2gRor3AfJRsatxPsv
         mPa6u0qQUsqrk2l7LtPAgSPQBxqU25xFEznjZ7+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 022/128] Revert "btrfs: Honour FITRIM range constraints during free space trim"
Date:   Wed, 29 May 2019 20:05:54 -0700
Message-Id: <20190530030438.866703877@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

This reverts commit 038ec2c13e0d1f7b9d45a081786f18f75b65f11b.

There is currently no corresponding patch in master due to additional
changes that would be significantly different from plain revert in the
respective stable branch.

The range argument was not handled correctly and could cause trim to
overlap allocated areas or reach beyond the end of the device. The
address space that fitrim normally operates on is in logical
coordinates, while the discards are done on the physical device extents.
This distinction cannot be made with the current ioctl interface and
caused the confusion.

The bug depends on the layout of block groups and does not always
happen. The whole-fs trim (run by default by the fstrim tool) is not
affected.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11150,9 +11150,9 @@ int btrfs_error_unpin_extent_range(struc
  * transaction.
  */
 static int btrfs_trim_free_extents(struct btrfs_device *device,
-				   struct fstrim_range *range, u64 *trimmed)
+				   u64 minlen, u64 *trimmed)
 {
-	u64 start = range->start, len = 0;
+	u64 start = 0, len = 0;
 	int ret;
 
 	*trimmed = 0;
@@ -11188,8 +11188,8 @@ static int btrfs_trim_free_extents(struc
 			atomic_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ret = find_free_dev_extent_start(trans, device, range->minlen,
-						 start, &start, &len);
+		ret = find_free_dev_extent_start(trans, device, minlen, start,
+						 &start, &len);
 		if (trans)
 			btrfs_put_transaction(trans);
 
@@ -11201,16 +11201,6 @@ static int btrfs_trim_free_extents(struc
 			break;
 		}
 
-		/* If we are out of the passed range break */
-		if (start > range->start + range->len - 1) {
-			mutex_unlock(&fs_info->chunk_mutex);
-			ret = 0;
-			break;
-		}
-
-		start = max(range->start, start);
-		len = min(range->len, len);
-
 		ret = btrfs_issue_discard(device->bdev, start, len, &bytes);
 		up_read(&fs_info->commit_root_sem);
 		mutex_unlock(&fs_info->chunk_mutex);
@@ -11221,10 +11211,6 @@ static int btrfs_trim_free_extents(struc
 		start += len;
 		*trimmed += bytes;
 
-		/* We've trimmed enough */
-		if (*trimmed >= range->len)
-			break;
-
 		if (fatal_signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			break;
@@ -11309,7 +11295,8 @@ int btrfs_trim_fs(struct btrfs_root *roo
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	devices = &fs_info->fs_devices->devices;
 	list_for_each_entry(device, devices, dev_list) {
-		ret = btrfs_trim_free_extents(device, range, &group_trimmed);
+		ret = btrfs_trim_free_extents(device, range->minlen,
+					      &group_trimmed);
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;



Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BD2214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431258;
	bh=aOZ5Zd1lbSAteEr5LJ2AOgThOLfNS16FyuGXJpkXz6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJPSq7SoknDPk9NHSTbvc1aGZhnTPeg0m+emKk2tJHEGivj9gVOnBjptRI8DAMjc5
	 o9KnOP2YkIIHOlaiV4mLbyzA3471nt/4jx2qtnFIWpviwRotxNPm7L8sWm9VBQNpXW
	 wBEqKypwGCJvUNhj44Sp8TJt4I/uGb5BAhDlrIf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgAGVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgAGVHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D68D208C4;
        Tue,  7 Jan 2020 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431250;
        bh=aOZ5Zd1lbSAteEr5LJ2AOgThOLfNS16FyuGXJpkXz6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=md+26HfRvq8CsbtDpz3HbhjlcXho2JxisgRsefTKBMm2GQtugInZkrtjTnvOFF6JJ
         /8QQrvXLl+6KtmuW81V5QbAxkVn7eFtgfe6s/gE2+YGdbp0DXemuFL0YEqgG6LibSu
         Od9539C3/4HSf6LQuE8+bHR024SIZPuNlriVbAns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 096/115] bdev: Factor out bdev revalidation into a common helper
Date:   Tue,  7 Jan 2020 21:55:06 +0100
Message-Id: <20200107205307.270373105@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 731dc4868311ee097757b8746eaa1b4f8b2b4f1c upstream.

Factor out code handling revalidation of bdev on disk change into a
common helper.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/block_dev.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1430,6 +1430,14 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
+static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
+{
+	if (invalidate)
+		invalidate_partitions(bdev->bd_disk, bdev);
+	else
+		rescan_partitions(bdev->bd_disk, bdev);
+}
+
 /*
  * bd_mutex locking:
  *
@@ -1512,12 +1520,9 @@ static int __blkdev_get(struct block_dev
 			 * The latter is necessary to prevent ghost
 			 * partitions on a removed medium.
 			 */
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(disk, bdev);
-			}
+			if (bdev->bd_invalidated &&
+			    (!ret || ret == -ENOMEDIUM))
+				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
 			if (ret)
 				goto out_clear;
@@ -1550,12 +1555,9 @@ static int __blkdev_get(struct block_dev
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 			/* the same as first opener case, read comment there */
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(bdev->bd_disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(bdev->bd_disk, bdev);
-			}
+			if (bdev->bd_invalidated &&
+			    (!ret || ret == -ENOMEDIUM))
+				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 			if (ret)
 				goto out_unlock_bdev;
 		}



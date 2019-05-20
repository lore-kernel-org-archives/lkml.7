Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714020815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355709;
	bh=piwKhTcHj4VZCfXF8EKFK2myXkUn0IB9W2vW67NcuNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rF4KOM6+bAO5nUHWI9B2F6OuXNGtAQ4+LDI9BwYl4S3Hv05Pl9Qb87Zu8DcMDoAP
	 GMc2WIdCLmo2swMwbiLTkGquiTv58m1imMUez9nze0rE8/Iel6gUwdUga32/Cgt+lQ
	 MhD35nCw4QIwWkz3+62EmZCDKpC3Ev7qGa6JC9QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbfETMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390429AbfETMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:35:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D50621479;
        Mon, 20 May 2019 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355701;
        bh=piwKhTcHj4VZCfXF8EKFK2myXkUn0IB9W2vW67NcuNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcxdenNrew9Dd9LvvF78Leofw1leYmTg3nLWmZM0kaFiRea6SOgIjuKlQ6rGJuUHF
         7LXY7IBkWmdCtT8eNNN/YsYiLdeLjaYZq7JMlohbN8d119jT6tDSJNKxzJKTAkZsJo
         lcF2pZsfEm71p5tszjDGp44rMp2KhgauHgs220SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.1 094/128] btrfs: Honour FITRIM range constraints during free space trim
Date:   Mon, 20 May 2019 14:14:41 +0200
Message-Id: <20190520115255.652676201@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

commit c2d1b3aae33605a61cbab445d8ae1c708ccd2698 upstream.

Up until now trimming the freespace was done irrespective of what the
arguments of the FITRIM ioctl were. For example fstrim's -o/-l arguments
will be entirely ignored. Fix it by correctly handling those paramter.
This requires breaking if the found freespace extent is after the end of
the passed range as well as completing trim after trimming
fstrim_range::len bytes.

Fixes: 499f377f49f0 ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11315,9 +11315,9 @@ int btrfs_error_unpin_extent_range(struc
  * held back allocations.
  */
 static int btrfs_trim_free_extents(struct btrfs_device *device,
-				   u64 minlen, u64 *trimmed)
+				   struct fstrim_range *range, u64 *trimmed)
 {
-	u64 start = 0, len = 0;
+	u64 start = range->start, len = 0;
 	int ret;
 
 	*trimmed = 0;
@@ -11360,8 +11360,8 @@ static int btrfs_trim_free_extents(struc
 		if (!trans)
 			up_read(&fs_info->commit_root_sem);
 
-		ret = find_free_dev_extent_start(trans, device, minlen, start,
-						 &start, &len);
+		ret = find_free_dev_extent_start(trans, device, range->minlen,
+						 start, &start, &len);
 		if (trans) {
 			up_read(&fs_info->commit_root_sem);
 			btrfs_put_transaction(trans);
@@ -11374,6 +11374,16 @@ static int btrfs_trim_free_extents(struc
 			break;
 		}
 
+		/* If we are out of the passed range break */
+		if (start > range->start + range->len - 1) {
+			mutex_unlock(&fs_info->chunk_mutex);
+			ret = 0;
+			break;
+		}
+
+		start = max(range->start, start);
+		len = min(range->len, len);
+
 		ret = btrfs_issue_discard(device->bdev, start, len, &bytes);
 		mutex_unlock(&fs_info->chunk_mutex);
 
@@ -11383,6 +11393,10 @@ static int btrfs_trim_free_extents(struc
 		start += len;
 		*trimmed += bytes;
 
+		/* We've trimmed enough */
+		if (*trimmed >= range->len)
+			break;
+
 		if (fatal_signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			break;
@@ -11466,8 +11480,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	devices = &fs_info->fs_devices->devices;
 	list_for_each_entry(device, devices, dev_list) {
-		ret = btrfs_trim_free_extents(device, range->minlen,
-					      &group_trimmed);
+		ret = btrfs_trim_free_extents(device, range, &group_trimmed);
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;



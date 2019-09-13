Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D20C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A920206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380552;
	bh=KPBt0vTCOmRrJNhkIgQw67qoTqslgfitXdMMk7LF4lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vs7JD7Ute7+noX0D3M0TMIkYfrkq7TNk68LRfnL0JeBbIly72ZFEgJU1CEcwpk2MA
	 U2qC+YHUSI3lKAH+IE9IM5FVuJKcsuxWSNhq2//+YksoTxJD84EhfrX+kImGdL50gw
	 U2zaFDkeYrHlE0cZFyOSDTNOdCg5Yn2KF5JStE/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbfIMNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389740AbfIMNPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:49 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7448214AE;
        Fri, 13 Sep 2019 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380548;
        bh=KPBt0vTCOmRrJNhkIgQw67qoTqslgfitXdMMk7LF4lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1JeNS9C26JB4u9AfwBe4dOq4mMLsnt3v8y+po9qcRwFnbVsx3MIMg+uP12V1P1Fu
         1oEi+SmfAOaFEs+806S3zGwU+o1GLmo3jn+ALFcvJl+ppv/zq44/O4458NS8HWHrdd
         b9CxfAp8vEaE4u7TDQEt4oh7LIXyj3VhuL9xONmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/190] btrfs: scrub: move scrub_setup_ctx allocation out of device_list_mutex
Date:   Fri, 13 Sep 2019 14:05:55 +0100
Message-Id: <20190913130607.587164373@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0e94c4f45d14cf89d1f40c91b0a8517e791672a7 ]

The scrub context is allocated with GFP_KERNEL and called from
btrfs_scrub_dev under the fs_info::device_list_mutex. This is not safe
regarding reclaim that could try to flush filesystem data in order to
get the memory. And the device_list_mutex is held during superblock
commit, so this would cause a lockup.

Move the alocation and initialization before any changes that require
the mutex.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index efaad3e1b295a..56c4d2236484f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3837,13 +3837,18 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		return -EINVAL;
 	}
 
+	/* Allocate outside of device_list_mutex */
+	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
+	if (IS_ERR(sctx))
+		return PTR_ERR(sctx);
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	dev = btrfs_find_device(fs_info, devid, NULL, NULL);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_free_ctx;
 	}
 
 	if (!is_dev_replace && !readonly &&
@@ -3851,7 +3856,8 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		btrfs_err_in_rcu(fs_info, "scrub: device %s is not writable",
 				rcu_str_deref(dev->name));
-		return -EROFS;
+		ret = -EROFS;
+		goto out_free_ctx;
 	}
 
 	mutex_lock(&fs_info->scrub_lock);
@@ -3859,7 +3865,8 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &dev->dev_state)) {
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		return -EIO;
+		ret = -EIO;
+		goto out_free_ctx;
 	}
 
 	btrfs_dev_replace_read_lock(&fs_info->dev_replace);
@@ -3869,7 +3876,8 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		return -EINPROGRESS;
+		ret = -EINPROGRESS;
+		goto out_free_ctx;
 	}
 	btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 
@@ -3877,16 +3885,9 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (ret) {
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		return ret;
+		goto out_free_ctx;
 	}
 
-	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
-	if (IS_ERR(sctx)) {
-		mutex_unlock(&fs_info->scrub_lock);
-		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		scrub_workers_put(fs_info);
-		return PTR_ERR(sctx);
-	}
 	sctx->readonly = readonly;
 	dev->scrub_ctx = sctx;
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -3939,6 +3940,11 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 
 	scrub_put_ctx(sctx);
 
+	return ret;
+
+out_free_ctx:
+	scrub_free_ctx(sctx);
+
 	return ret;
 }
 
-- 
2.20.1




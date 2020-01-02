Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C2C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2131220863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004921;
	bh=TrO/k8D3SWblGwhilHgaV+gXgyn2/xwQq4SJqBiDUd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0bm8KDg80h2KFr+jWcAm9sO4TL12loDiWyDVke4lqbmAik6LuxX7x50owsu7zhI2
	 gw3lIk6Q7GKf/aV6d2p9LThViMrkr0YRKJX2d5skyLD7c1j7rmoSCdyCwvOenNeE8Y
	 j1MyBSv+qXg7Yh2TTyqedlj2n19qVjUxYkG34nfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgABWgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgABWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:36:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD57A22B48;
        Thu,  2 Jan 2020 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004588;
        bh=TrO/k8D3SWblGwhilHgaV+gXgyn2/xwQq4SJqBiDUd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sh1KyxVRUE9dRGt2jOslYOEorxnRixETp7kZZyYnalHMeby5boxJvX6jolQnfnomj
         hL6yK2kOcXcgJ0HrMoPVdVwRSMLmF7gssvZxd711sp975+Pv/SNEWj/zx1lU5o8cD3
         zgsyLV2h0nySkysDSwIIKYCUiAt9+zpZuHvOfw4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 070/137] btrfs: abort transaction after failed inode updates in create_subvol
Date:   Thu,  2 Jan 2020 23:07:23 +0100
Message-Id: <20200102220555.988675827@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit c7e54b5102bf3614cadb9ca32d7be73bad6cecf0 ]

We can just abort the transaction here, and in fact do that for every
other failure in this function except these two cases.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3379490ce54d..119b1c5c279b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -594,12 +594,18 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_i_size_write(dir, dir->i_size + namelen * 2);
 	ret = btrfs_update_inode(trans, root, dir);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, root, ret);
+		goto fail;
+	}
 
 	ret = btrfs_add_root_ref(trans, root->fs_info->tree_root,
 				 objectid, root->root_key.objectid,
 				 btrfs_ino(dir), index, name, namelen);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, root, ret);
+		goto fail;
+	}
 
 	ret = btrfs_uuid_tree_add(trans, root->fs_info->uuid_root,
 				  root_item.uuid, BTRFS_UUID_KEY_SUBVOL,
-- 
2.20.1




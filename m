Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE34C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28862086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124144;
	bh=iHfGe84i5leyeF01WVOTO5FmmkKoYIY5JVD9wh7lneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBLnM+vCLqq3Ji3dyt3RySvgBkiKONsohe9l+/+uEsZmyFwoxxXg/zZOudQ7GNTky
	 vU5rBt4cb9LIrNxBvhMMpkPYF7K7c62j9d7UQYKZux22ea+nx3iqOivZUrr82kXSIl
	 nQy0p1JWCrn7rqd7KryIv7yRlVlYCNCTU+03IkK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfJCRfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732642AbfJCQF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:05:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582242054F;
        Thu,  3 Oct 2019 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118755;
        bh=iHfGe84i5leyeF01WVOTO5FmmkKoYIY5JVD9wh7lneU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mz/R1FZLKVv1PDTdAb3LEO1nTWL33LV4mFrhHSoJMWTiBKhMs3n3A0h4fJMvP1T7C
         556ykui1UYKPcmSvwIJLbfkl5SS0bI2RP0HVWGqq0cHay3HhtC6oZ6lNH4B0bY8BaP
         MYDcA2/5mc9dL7EHMyIh8CqhYMLN41UihmEN0r1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 128/129] btrfs: qgroup: Drop quota_root and fs_info parameters from update_qgroup_status_item
Date:   Thu,  3 Oct 2019 17:54:11 +0200
Message-Id: <20191003154417.400121911@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

[ Upstream commit 2e980acdd829742966c6a7e565ef3382c0717295 ]

They can be fetched from the transaction handle.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f25233093d68c..088dc7d38c136 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -759,10 +759,10 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int update_qgroup_status_item(struct btrfs_trans_handle *trans,
-				     struct btrfs_fs_info *fs_info,
-				    struct btrfs_root *root)
+static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *quota_root = fs_info->quota_root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *l;
@@ -778,7 +778,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	ret = btrfs_search_slot(trans, quota_root, &key, path, 0, 1);
 	if (ret > 0)
 		ret = -ENOENT;
 
@@ -1863,7 +1863,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans,
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
 	spin_unlock(&fs_info->qgroup_lock);
 
-	ret = update_qgroup_status_item(trans, fs_info, quota_root);
+	ret = update_qgroup_status_item(trans);
 	if (ret)
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 
@@ -2403,7 +2403,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 			  err);
 		goto done;
 	}
-	ret = update_qgroup_status_item(trans, fs_info, fs_info->quota_root);
+	ret = update_qgroup_status_item(trans);
 	if (ret < 0) {
 		err = ret;
 		btrfs_err(fs_info, "fail to update qgroup status: %d", err);
-- 
2.20.1




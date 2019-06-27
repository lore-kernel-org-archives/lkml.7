Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9229C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7790E21851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595726;
	bh=SQ9IR5Fk2JhjIsoB4sJRIflWq9VbQg4x2q3LL2zkuz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qtEQdtqzxMUTg6g+wDHhvQqGUnLeD5rhrSe8ANHS1n49gAPgdThdAoRyCcibd6fLO
	 dDYaIq0Oo6W10NVthr/LzWmh2SvXEsPlMIeInbWe8aaSKs2HY7/Sfj6oNccj2L0EEc
	 i+oDQNX9LpHekCMWJjyI/RTxSFrSgUMjxAIc7cJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfF0AfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfF0AfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:35:18 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4699F217F4;
        Thu, 27 Jun 2019 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595717;
        bh=SQ9IR5Fk2JhjIsoB4sJRIflWq9VbQg4x2q3LL2zkuz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iESBHwIW0DxR6Zo80ZGJSeNlDWA64tZDF+7nga3Hv+NbMD4Vi++zy3jqmw8dkmObe
         Ml9VcSoqAXPSoz/O1kPu/45xhUoEwwvX65urYNssDBFG0WBwu5lc/AJmpQLVpbEN5E
         AEuDgW9TNV3sB4MJUZmRKPhsDGbuAlk/iqnRKdYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yangerkun <yangerkun@huawei.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 90/95] quota: fix a problem about transfer quota
Date:   Wed, 26 Jun 2019 20:30:15 -0400
Message-Id: <20190627003021.19867-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit c6d9c35d16f1bafd3fec64b865e569e48cbcb514 ]

Run below script as root, dquot_add_space will return -EDQUOT since
__dquot_transfer call dquot_add_space with flags=0, and dquot_add_space
think it's a preallocation. Fix it by set flags as DQUOT_SPACE_WARN.

mkfs.ext4 -O quota,project /dev/vdb
mount -o prjquota /dev/vdb /mnt
setquota -P 23 1 1 0 0 /dev/vdb
dd if=/dev/zero of=/mnt/test-file bs=4K count=1
chattr -p 23 test-file

Fixes: 7b9ca4c61bc2 ("quota: Reduce contention on dq_data_lock")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..dd1783ea7003 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1993,8 +1993,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 				       &warn_to[cnt]);
 		if (ret)
 			goto over_quota;
-		ret = dquot_add_space(transfer_to[cnt], cur_space, rsv_space, 0,
-				      &warn_to[cnt]);
+		ret = dquot_add_space(transfer_to[cnt], cur_space, rsv_space,
+				      DQUOT_SPACE_WARN, &warn_to[cnt]);
 		if (ret) {
 			spin_lock(&transfer_to[cnt]->dq_dqb_lock);
 			dquot_decr_inodes(transfer_to[cnt], inode_usage);
-- 
2.20.1


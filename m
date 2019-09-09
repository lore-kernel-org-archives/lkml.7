Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F08AC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FCD21D79
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067453;
	bh=MxqU5SPmj5mtY7IY3nIDrBdvk0zA/H/zTaOVX7PF5Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkleSlpUEbKO1GRW1wPOOzBcHAvxCvXjcR/JiH8xXmE3tFuwL0U2RzLORxsGX7w65
	 lPmZWO0+j6WEe9S9hPALwovmfeCoTl2d29waNku9ZIrn5+Yf1medtmNCWk1JPVzT7x
	 2fmppU4z7Ugx74UxhdfWgXWOboZBYND/IsoFGmqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406343AbfIIWR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392302AbfIIWRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:17:25 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE1A21A4C;
        Mon,  9 Sep 2019 22:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067444;
        bh=MxqU5SPmj5mtY7IY3nIDrBdvk0zA/H/zTaOVX7PF5Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUr0ENbT6KM0FdQq3QMyVlITBKuQ5L5XgxYo9oNRoErTuaHL93uTgm7oAkIrOH4J2
         a0XkIV6LqEEXPFKtBTlZCw1ixZfbnXYpIDSHk3c5Qv8xnwqKeZU35vyyZrLx9/1dTj
         mAPcoFJuJ3d2uED4Voa9UnKmj7hKo4NWLce1U4Cg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 4/6] configfs_register_group() shouldn't be (and isn't) called in rmdirable parts
Date:   Mon,  9 Sep 2019 11:42:03 -0400
Message-Id: <20190909154205.31376-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154205.31376-1-sashal@kernel.org>
References: <20190909154205.31376-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit f19e4ed1e1edbfa3c9ccb9fed17759b7d6db24c6 ]

revert cc57c07343bd "configfs: fix registered group removal"
It was an attempt to handle something that fundamentally doesn't
work - configfs_register_group() should never be done in a part
of tree that can be rmdir'ed.  And in mainline it never had been,
so let's not borrow trouble; the fix was racy anyway, it would take
a lot more to make that work and desired semantics is not clear.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/dir.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index a1985a9ad2d64..64fdb12e6ad61 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1782,16 +1782,6 @@ void configfs_unregister_group(struct config_group *group)
 	struct dentry *dentry = group->cg_item.ci_dentry;
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 
-	mutex_lock(&subsys->su_mutex);
-	if (!group->cg_item.ci_parent->ci_group) {
-		/*
-		 * The parent has already been unlinked and detached
-		 * due to a rmdir.
-		 */
-		goto unlink_group;
-	}
-	mutex_unlock(&subsys->su_mutex);
-
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	spin_lock(&configfs_dirent_lock);
 	configfs_detach_prep(dentry, NULL);
@@ -1806,7 +1796,6 @@ void configfs_unregister_group(struct config_group *group)
 	dput(dentry);
 
 	mutex_lock(&subsys->su_mutex);
-unlink_group:
 	unlink_group(group);
 	mutex_unlock(&subsys->su_mutex);
 }
-- 
2.20.1


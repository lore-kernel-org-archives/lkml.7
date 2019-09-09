Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E135F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067383;
	bh=S9RqiWZFY7XocjRzZvzE/0TlahC45WZWnkU4RKt+pKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmPj3PXzX/z9Xu+0Cuz6k28XJb6CGJB/pIGtyQLfiS9AvhvqBpdQVPpBj2nsz0aK2
	 Tu5ei3T8CassgApThIBEKHVsL6hvnqcXHxp/jZajcdin5RH/jwosfVVIZHyjz0UHob
	 uHWC2pv8uW3CzJgXcxcAs7XRHKv53tDtTslUzZik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392077AbfIIWQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392036AbfIIWQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:16:16 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E4721A4C;
        Mon,  9 Sep 2019 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067375;
        bh=S9RqiWZFY7XocjRzZvzE/0TlahC45WZWnkU4RKt+pKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgZ84+YhmAfBW0CWVS9fAudg8S8P2RXnWz3HB01pK0K6WekEp7Q/aObkpmvLyrRqL
         uQwG+X+sv+OQNoQ3raHMH6CzX4pI0LcDknHCBsoPn4qjv76wkfuqD+H8wIM6G/OIaw
         AWZh5Fn83a0SlVQB4VrNlOh52IE59GPI4faiaL7s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 06/12] configfs_register_group() shouldn't be (and isn't) called in rmdirable parts
Date:   Mon,  9 Sep 2019 11:40:46 -0400
Message-Id: <20190909154052.30941-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154052.30941-1-sashal@kernel.org>
References: <20190909154052.30941-1-sashal@kernel.org>
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
index d2ca5287762d8..7d8d16da40314 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1770,16 +1770,6 @@ void configfs_unregister_group(struct config_group *group)
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
@@ -1794,7 +1784,6 @@ void configfs_unregister_group(struct config_group *group)
 	dput(dentry);
 
 	mutex_lock(&subsys->su_mutex);
-unlink_group:
 	unlink_group(group);
 	mutex_unlock(&subsys->su_mutex);
 }
-- 
2.20.1


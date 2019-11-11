Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD998204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497775;
	bh=ZK/ZBjuL36PlHFysUhKmPHj4iSBscDJgj7PWaoy0ufo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qF955BgkwF9RimtlgfEP8ifyadGDEcMb+bFlxkl4sUDS1kSkKgO1v/jm1KH9e2pRy
	 znR/PVHpk3qGpD0xKliRqzEH97wdSqbu8wv+C6owSZx6vX0FpUa+1TQSQov7yKM50V
	 doP2LsglzJRSEpVGczm8bQV7CoXSy7qNCyGU/4Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfKKSmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfKKSmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:42:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E6A21925;
        Mon, 11 Nov 2019 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497770;
        bh=ZK/ZBjuL36PlHFysUhKmPHj4iSBscDJgj7PWaoy0ufo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsLbtlPZleMfPY1ys/ebRQ2UyWrWeSkro0+Qad1Ozm/ihKpQF4F76itXAKmpFuzWK
         5jMWe4Gjh19Bff29hBu8BkLdhsH8w+imlsxG7qws4ITaGCIXOaMky6tfPff3RMfff4
         vusf+MbfQC2KrsRWHVdRtnc49KyKUDZJSg8jymRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.19 053/125] configfs_register_group() shouldnt be (and isnt) called in rmdirable parts
Date:   Mon, 11 Nov 2019 19:28:12 +0100
Message-Id: <20191111181447.430082052@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit f19e4ed1e1edbfa3c9ccb9fed17759b7d6db24c6 upstream.

revert cc57c07343bd "configfs: fix registered group removal"
It was an attempt to handle something that fundamentally doesn't
work - configfs_register_group() should never be done in a part
of tree that can be rmdir'ed.  And in mainline it never had been,
so let's not borrow trouble; the fix was racy anyway, it would take
a lot more to make that work and desired semantics is not clear.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/configfs/dir.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1782,16 +1782,6 @@ void configfs_unregister_group(struct co
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
@@ -1806,7 +1796,6 @@ void configfs_unregister_group(struct co
 	dput(dentry);
 
 	mutex_lock(&subsys->su_mutex);
-unlink_group:
 	unlink_group(group);
 	mutex_unlock(&subsys->su_mutex);
 }



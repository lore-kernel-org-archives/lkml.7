Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC2DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D282173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080613;
	bh=4k5lCqv1h3YYH4AA9kIguuzaH3ELRVcCQ2qK2QzcEjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L3tCDiciRVlcqmBbK0AE6fkQX4p/L3ZXCqEwgbb6YrIZ5+vuC9mjNYpb7IxHb6IQB
	 PxamuESxkvweFhnkFyXa9jgxr2UdWFMrTqjZ4GPPyJnuyqzW2xadaRdJKj8rZuFSGS
	 9JINRdNMcOdZDYXRHArsZQ0FMcyYD42lMSOC3cO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfLKPMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbfLKPLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:11:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD7B24656;
        Wed, 11 Dec 2019 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077113;
        bh=4k5lCqv1h3YYH4AA9kIguuzaH3ELRVcCQ2qK2QzcEjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uljg34GtFlAKrQtXkCJzEls34IpKrsQx3ke8+zsWDv+vHIZjQT9mUXYFprqEyaMQ2
         dBLhLw2AW5AcIFn74F6Bjs6AOkID46kY6F7Vdb/c7KwBh1s4YRhOZGPaXfNe7bSjR3
         JoEMgTXXPVZ88CNr8+jKNBWFiUQfe+2hFwRQMooc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 022/105] audit_get_nd(): dont unlock parent too early
Date:   Wed, 11 Dec 2019 16:05:11 +0100
Message-Id: <20191211150227.393353419@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 69924b89687a2923e88cc42144aea27868913d0e ]

if the child has been negative and just went positive
under us, we want coherent d_is_positive() and ->d_inode.
Don't unlock the parent until we'd done that work...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 1f31c2f1e6fc1..4508d5e0cf696 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -351,12 +351,12 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	struct dentry *d = kern_path_locked(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	inode_unlock(d_backing_inode(parent->dentry));
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
+	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.20.1




Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44293C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB42227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782499;
	bh=KBWdRp1C0diqcB72JfhHtC2PPDRx4lRZjSBB2xMIzcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIlhmUw/y7fY/b4+c+qEXDnsHIYso8GDoMJwMy6FBTSwedj0F/w9kBTROrNXaUM8E
	 mnNoPC4pLFTsOYj3rNcBbaXCti3HpBUDxAhLP92GZReZlrtMAy3O+Bwt+sdK6GJHob
	 S0oOIKnuptS7SSh1QAZOZu4pNPESVsGqrMBWghaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfLSSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfLSSmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4E2206D7;
        Thu, 19 Dec 2019 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780921;
        bh=KBWdRp1C0diqcB72JfhHtC2PPDRx4lRZjSBB2xMIzcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSxhnRjqBFUZypjHa2LnstYMGIwOT3iBpauyyTJoNaGExgJXD2+MVPQEBIYhSCE1A
         c0h6csqP56jpg/jDt9JiOlARM5eR8IHGvKz7nnSxjDSTqFpVwvFgP2MuWLuV0sAC6q
         B+KWvx41cKm4kSEyqDMNRVHBqOXLvsBSf3mS7iHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 010/199] exportfs_decode_fh(): negative pinned may become positive without the parent locked
Date:   Thu, 19 Dec 2019 19:31:32 +0100
Message-Id: <20191219183215.271141184@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit a2ece088882666e1dc7113744ac912eb161e3f87 ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exportfs/expfs.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 7a7bba7c23284..3706939e5dd5e 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -506,26 +506,33 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 		 * inode is actually connected to the parent.
 		 */
 		err = exportfs_get_name(mnt, target_dir, nbuf, result);
-		if (!err) {
-			inode_lock(target_dir->d_inode);
-			nresult = lookup_one_len(nbuf, target_dir,
-						 strlen(nbuf));
-			inode_unlock(target_dir->d_inode);
-			if (!IS_ERR(nresult)) {
-				if (nresult->d_inode) {
-					dput(result);
-					result = nresult;
-				} else
-					dput(nresult);
-			}
+		if (err) {
+			dput(target_dir);
+			goto err_result;
 		}
 
+		inode_lock(target_dir->d_inode);
+		nresult = lookup_one_len(nbuf, target_dir, strlen(nbuf));
+		if (!IS_ERR(nresult)) {
+			if (unlikely(nresult->d_inode != result->d_inode)) {
+				dput(nresult);
+				nresult = ERR_PTR(-ESTALE);
+			}
+		}
+		inode_unlock(target_dir->d_inode);
 		/*
 		 * At this point we are done with the parent, but it's pinned
 		 * by the child dentry anyway.
 		 */
 		dput(target_dir);
 
+		if (IS_ERR(nresult)) {
+			err = PTR_ERR(nresult);
+			goto err_result;
+		}
+		dput(result);
+		result = nresult;
+
 		/*
 		 * And finally make sure the dentry is actually acceptable
 		 * to NFSD.
-- 
2.20.1




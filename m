Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD19C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5793420726
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452207;
	bh=KBWdRp1C0diqcB72JfhHtC2PPDRx4lRZjSBB2xMIzcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQxyLh6hIwLf8BU1apUSUuWyjCpX0z0dVXCG93T0s3468lQGQR3fSXnL5yxsv6umk
	 zutVDHiLucmu1nrsBRAZSxZ5YlZfL2RZZ8921KWbG26Ptcv5Xxiuv7Wp/UA/KK145z
	 zbXT4/g08iBCFsL0+FOYLwTBhZVNvcGI+ipcdo64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKVTuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfKVTuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6F32075B;
        Fri, 22 Nov 2019 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452202;
        bh=KBWdRp1C0diqcB72JfhHtC2PPDRx4lRZjSBB2xMIzcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEgFOJ6jncme/aVhsiDTtx638FHRzn7w+Rytn/6F31R1MHVYqLfSZl8fxwR9xCDDP
         xf+hqkeqLaWSCxxLOb/KCnUtKXIxEv4hhYk8N6ehPzTIumSVI1MTcjricyb9aSFm1W
         FHpgHo5+mSvQhPs9XfNlFd0ifblMF6aVGkm3NhWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/13] exportfs_decode_fh(): negative pinned may become positive without the parent locked
Date:   Fri, 22 Nov 2019 14:49:48 -0500
Message-Id: <20191122194958.24926-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194958.24926-1-sashal@kernel.org>
References: <20191122194958.24926-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


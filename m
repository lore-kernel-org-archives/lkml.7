Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1278C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA76822CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149289;
	bh=IKwThzWP3q85VpQOjjn0zA5IoiUfv4uAcXFpVtqVYB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TE7rYFCEKLrs53FfxbiTtkU0fXSSDy8xDRbzcBgMip6XeB2ml2myHB32DOqCTmAOZ
	 USTpOUuHmhfOFSx/dIgHL8FuIo1MAvb5jl5snThjsetW5Xj3ZvSKdoENqMhSXX+Wwf
	 6yZJQulY/ZIluS9JqFIAv6mG+/UYWp8twQ827ENg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGZNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388016AbfGZNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1BE22CBD;
        Fri, 26 Jul 2019 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148561;
        bh=IKwThzWP3q85VpQOjjn0zA5IoiUfv4uAcXFpVtqVYB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szqzX7ty9W/iW6S4AVbFbx0EgT7MPQjYxVReVSsNW7zYR36Kj2Q129dLY8PO+CWEX
         estOpQh+e68dcjOO8xbLyECDpCZCALp6yOBbGvxX1VJUr2Q3tbnD9BZFoGAjM4B44p
         cfvjnQY5NX4s63rgVIw5KCz+eCRd2k7x8rDNPjh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/47] ceph: fix listxattr vxattr buffer length calculation
Date:   Fri, 26 Jul 2019 09:41:41 -0400
Message-Id: <20190726134210.12156-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit 2b2abcac8c251d1c77a4cc9d9f248daefae0fb4e ]

ceph_listxattr() incorrectly returns a length based on the static
ceph_vxattrs_name_size() value, which only takes into account whether
vxattrs are hidden, ignoring vxattr.exists_cb().

When filling the xattr buffer ceph_listxattr() checks VXATTR_FLAG_HIDDEN
and vxattr.exists_cb(). If both are false, we return an incorrect
(oversize) length.

Fix this behaviour by always calculating the vxattrs length at runtime,
taking both vxattr.hidden and vxattr.exists_cb() into account.

This bug is only exposed with the new "ceph.snap.btime" vxattr, as all
other vxattrs with a non-null exists_cb also carry VXATTR_FLAG_HIDDEN.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/xattr.c | 54 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5cc8b94f8206..996ee87b1eaf 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -879,10 +879,9 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
-	u32 vir_namelen = 0;
+	bool len_only = (size == 0);
 	u32 namelen;
 	int err;
-	u32 len;
 	int i;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -901,38 +900,45 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = __build_xattrs(inode);
 	if (err < 0)
 		goto out;
-	/*
-	 * Start with virtual dir xattr names (if any) (including
-	 * terminating '\0' characters for each).
-	 */
-	vir_namelen = ceph_vxattrs_name_size(vxattrs);
 
-	/* adding 1 byte per each variable due to the null termination */
+	/* add 1 byte for each xattr due to the null termination */
 	namelen = ci->i_xattrs.names_size + ci->i_xattrs.count;
-	err = -ERANGE;
-	if (size && vir_namelen + namelen > size)
-		goto out;
-
-	err = namelen + vir_namelen;
-	if (size == 0)
-		goto out;
+	if (!len_only) {
+		if (namelen > size) {
+			err = -ERANGE;
+			goto out;
+		}
+		names = __copy_xattr_names(ci, names);
+		size -= namelen;
+	}
 
-	names = __copy_xattr_names(ci, names);
 
 	/* virtual xattr names, too */
-	err = namelen;
 	if (vxattrs) {
 		for (i = 0; vxattrs[i].name; i++) {
-			if (!(vxattrs[i].flags & VXATTR_FLAG_HIDDEN) &&
-			    !(vxattrs[i].exists_cb &&
-			      !vxattrs[i].exists_cb(ci))) {
-				len = sprintf(names, "%s", vxattrs[i].name);
-				names += len + 1;
-				err += len + 1;
+			size_t this_len;
+
+			if (vxattrs[i].flags & VXATTR_FLAG_HIDDEN)
+				continue;
+			if (vxattrs[i].exists_cb && !vxattrs[i].exists_cb(ci))
+				continue;
+
+			this_len = strlen(vxattrs[i].name) + 1;
+			namelen += this_len;
+			if (len_only)
+				continue;
+
+			if (this_len > size) {
+				err = -ERANGE;
+				goto out;
 			}
+
+			memcpy(names, vxattrs[i].name, this_len);
+			names += this_len;
+			size -= this_len;
 		}
 	}
-
+	err = namelen;
 out:
 	spin_unlock(&ci->i_ceph_lock);
 	return err;
-- 
2.20.1


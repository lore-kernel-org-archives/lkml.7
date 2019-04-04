Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA622184E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368339;
	bh=k3HLpjcx1svCi9DVnesXdCBIkkgfOk18PBLFBB1+yI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnZd9Ls6HywFPMoJwcYS2i6yidRxA4w+mdky+pKFK59sEOceM4lCFaj9arjnplIZf
	 89Z50LNjQtywm0MZhaHq8+wwM4J4ab3UPujFCnDb1fG5qiWzs7KB7/x2zWzDprmf94
	 VvBG+JWVGn+IRbSYRo/Ve3PErbkj0+8MtdKxxNRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfDDI65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730933AbfDDI6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB4F21855;
        Thu,  4 Apr 2019 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368332;
        bh=k3HLpjcx1svCi9DVnesXdCBIkkgfOk18PBLFBB1+yI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCCwawHRb2hV8+RweirjvF5QytwxAvSjqNkWNYcJEsz/podn2fZRJMRDYd/Kpn2fL
         ee17WGv9NOneqo4dRYNFYrj8EacofOYBx5mrQGAGOYi4b3UzPnlzenyYgGxv/qNraw
         tA3/UZjDqJbdS/H80wGO2mZ67nPnkIVnJR5ytXMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 115/121] selinux: do not override context on context mounts
Date:   Thu,  4 Apr 2019 10:48:23 +0200
Message-Id: <20190404084551.480634980@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 53e0c2aa9a59a48e3798ef193d573ade85aa80f5 ]

Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
flag unset. This is achived by returning -EOPNOTSUPP for this case in
selinux_inode_setsecurtity() (because that function should not be called
in such case anyway) and translating this error to 0 in
selinux_inode_notifysecctx().

This fixes behavior of kernfs-based filesystems when mounted with the
'context=' option. Before this patch, if a node's context had been
explicitly set to a non-default value and later the filesystem has been
remounted with the 'context=' option, then this node would show up as
having the manually-set context and not the mount-specified one.

Steps to reproduce:
    # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
    # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
    # umount /sys/fs/cgroup/unified
    # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified

Result before:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads

Result after:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a5d9c0146ac3..b72aa48f6478 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3339,12 +3339,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 	u32 newsid;
 	int rc;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	if (!(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	if (!value || !size)
 		return -EACCES;
 
@@ -6103,7 +6107,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
+					   ctx, ctxlen, 0);
+	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
+	return rc == -EOPNOTSUPP ? 0 : rc;
 }
 
 /*
-- 
2.19.1




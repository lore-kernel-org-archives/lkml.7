Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD612C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC821A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256206;
	bh=UJ2ahH+WU3dxFLgJ1mQZA3nDylyzrYmxPX5KT0Apu3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjO7VxUPQuzmISOTQESMJBEdxdmRgtxrYRzHjABR8K3T5KEDU1xZ8qzHtM6mfpll3
	 CWQJf74lOB2ad6XyzR1lbTE4PmbQAhjbFw1WZL2o+lDGie+ZrTb+RwUvUMrokQOhI8
	 kHHScVpAfRJOM7fJj8W25Gx7DZGXo3NhDHGfigCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfCVMDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388043AbfCVMDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13D5204FD;
        Fri, 22 Mar 2019 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256202;
        bh=UJ2ahH+WU3dxFLgJ1mQZA3nDylyzrYmxPX5KT0Apu3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBPJ/JZhvxIg5upGSbIOWu0Tcf20v6zORYjJlizq57n17exl5Uzuaz6RBN/SYeNbG
         l/o2Rl8xgbXZzhj147XouKV/bAhPZjybNkDNrSBcEvNXfxYnEMPz6lvjnorBAhV0ap
         mEVmrFYeyfApj7v/AnQwR1rH1+lEC+ZPeoF9wr5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.19 121/280] fix cgroup_do_mount() handling of failure exits
Date:   Fri, 22 Mar 2019 12:14:34 +0100
Message-Id: <20190322111315.074443430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 399504e21a10be16dd1408ba0147367d9d82a10c upstream.

same story as with last May fixes in sysfs (7b745a4e4051
"unfuck sysfs_mount()"); new_sb is left uninitialized
in case of early errors in kernfs_mount_ns() and papering
over it by treating any error from kernfs_mount_ns() as
equivalent to !new_ns ends up conflating the cases when
objects had never been transferred to a superblock with
ones when that has happened and resulting new superblock
had been dropped.  Easily fixed (same way as in sysfs
case).  Additionally, there's a superblock leak on
kernfs_node_dentry() failure *and* a dentry leak inside
kernfs_node_dentry() itself - the latter on probably
impossible errors, but the former not impossible to trigger
(as the matter of fact, injecting allocation failures
at that point *does* trigger it).

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/mount.c      |    8 ++++++--
 kernel/cgroup/cgroup.c |    9 ++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -196,8 +196,10 @@ struct dentry *kernfs_node_dentry(struct
 		return dentry;
 
 	knparent = find_next_ancestor(kn, NULL);
-	if (WARN_ON(!knparent))
+	if (WARN_ON(!knparent)) {
+		dput(dentry);
 		return ERR_PTR(-EINVAL);
+	}
 
 	do {
 		struct dentry *dtmp;
@@ -206,8 +208,10 @@ struct dentry *kernfs_node_dentry(struct
 		if (kn == knparent)
 			return dentry;
 		kntmp = find_next_ancestor(kn, knparent);
-		if (WARN_ON(!kntmp))
+		if (WARN_ON(!kntmp)) {
+			dput(dentry);
 			return ERR_PTR(-EINVAL);
+		}
 		dtmp = lookup_one_len_unlocked(kntmp->name, dentry,
 					       strlen(kntmp->name));
 		dput(dentry);
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1998,7 +1998,7 @@ struct dentry *cgroup_do_mount(struct fi
 			       struct cgroup_namespace *ns)
 {
 	struct dentry *dentry;
-	bool new_sb;
+	bool new_sb = false;
 
 	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
 
@@ -2008,6 +2008,7 @@ struct dentry *cgroup_do_mount(struct fi
 	 */
 	if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
 		struct dentry *nsdentry;
+		struct super_block *sb = dentry->d_sb;
 		struct cgroup *cgrp;
 
 		mutex_lock(&cgroup_mutex);
@@ -2018,12 +2019,14 @@ struct dentry *cgroup_do_mount(struct fi
 		spin_unlock_irq(&css_set_lock);
 		mutex_unlock(&cgroup_mutex);
 
-		nsdentry = kernfs_node_dentry(cgrp->kn, dentry->d_sb);
+		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(dentry);
+		if (IS_ERR(nsdentry))
+			deactivate_locked_super(sb);
 		dentry = nsdentry;
 	}
 
-	if (IS_ERR(dentry) || !new_sb)
+	if (!new_sb)
 		cgroup_put(&root->cgrp);
 
 	return dentry;



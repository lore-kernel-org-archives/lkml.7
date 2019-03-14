Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2021852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCNQJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBAA5305FCDF;
        Thu, 14 Mar 2019 16:09:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59E91001DEA;
        Thu, 14 Mar 2019 16:09:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/38] vfs: Convert nsfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:09:45 +0000
Message-ID: <155257978587.13720.10763193306699997914.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 14 Mar 2019 16:09:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric W. Biederman <ebiederm@xmission.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/nsfs.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 60702d677bd4..1a86ab9abaf7 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/proc_ns.h>
@@ -262,15 +263,17 @@ static const struct super_operations nsfs_ops = {
 	.evict_inode = nsfs_evict,
 	.show_path = nsfs_show_path,
 };
-static struct dentry *nsfs_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+
+static int nsfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type, "nsfs:", &nsfs_ops,
-			&ns_dentry_operations, NSFS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "nsfs:",
+					  &nsfs_ops, NULL,
+					  &ns_dentry_operations, NSFS_MAGIC);
 }
+
 static struct file_system_type nsfs = {
 	.name = "nsfs",
-	.mount = nsfs_mount,
+	.init_fs_context = nsfs_init_fs_context,
 	.kill_sb = kill_anon_super,
 };
 


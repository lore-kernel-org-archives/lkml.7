Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B908C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430882075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfC0XmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0XmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BB7D301989C;
        Wed, 27 Mar 2019 23:42:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48D945C28D;
        Wed, 27 Mar 2019 23:42:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 12/68] vfs: Convert sockfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:42:03 +0000
Message-ID: <155373012351.7602.2163765503529319964.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:42:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sockfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netdev@vger.kernel.org
---

 net/socket.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 3c176a12fe48..40d0ed85d61a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -79,6 +79,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
@@ -351,19 +352,20 @@ static const struct xattr_handler *sockfs_xattr_handlers[] = {
 	NULL
 };
 
-static struct dentry *sockfs_mount(struct file_system_type *fs_type,
-			 int flags, const char *dev_name, void *data)
+static int sockfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo_xattr(fs_type, "socket:", &sockfs_ops,
-				  sockfs_xattr_handlers,
-				  &sockfs_dentry_operations, SOCKFS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "socket:",
+					  &sockfs_ops,
+					  sockfs_xattr_handlers,
+					  &sockfs_dentry_operations,
+					  SOCKFS_MAGIC);
 }
 
 static struct vfsmount *sock_mnt __read_mostly;
 
 static struct file_system_type sock_fs_type = {
 	.name =		"sockfs",
-	.mount =	sockfs_mount,
+	.init_fs_context = sockfs_init_fs_context,
 	.kill_sb =	kill_anon_super,
 };
 


Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD609C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF0621852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCNQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfCNQKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2F4A308FEE0;
        Thu, 14 Mar 2019 16:10:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 967185D75E;
        Thu, 14 Mar 2019 16:10:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/38] vfs: Convert sockfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     netdev@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:10:07 +0000
Message-ID: <155257980736.13720.744503081451179415.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 14 Mar 2019 16:10:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 


Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0989C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A940D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfC0XmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbfC0XmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C805A308FC20;
        Wed, 27 Mar 2019 23:42:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7481B1001944;
        Wed, 27 Mar 2019 23:42:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 14/68] vfs: Convert drm to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:42:18 +0000
Message-ID: <155373013865.7602.4323790421889477990.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Mar 2019 23:42:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the drm filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Airlie <airlied@linux.ie>
cc: Daniel Vetter <daniel@ffwll.ch>
cc: dri-devel@lists.freedesktop.org
---

 drivers/gpu/drm/drm_drv.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 381581b01d48..9eead5a478de 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
 
@@ -413,20 +414,17 @@ static const struct super_operations drm_fs_sops = {
 	.statfs		= simple_statfs,
 };
 
-static struct dentry *drm_fs_mount(struct file_system_type *fs_type, int flags,
-				   const char *dev_name, void *data)
+static int drm_fs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type,
-			    "drm:",
-			    &drm_fs_sops,
-			    &drm_fs_dops,
-			    0x010203ff);
+	return vfs_init_pseudo_fs_context(fc, "drm:",
+					  &drm_fs_sops, NULL,
+					  &drm_fs_dops, 0x010203ff);
 }
 
 static struct file_system_type drm_fs_type = {
 	.name		= "drm",
 	.owner		= THIS_MODULE,
-	.mount		= drm_fs_mount,
+	.init_fs_context = drm_fs_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 


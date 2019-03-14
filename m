Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C06C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7527B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfCNQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCNQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97BD159460;
        Thu, 14 Mar 2019 16:10:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7AC17CEB;
        Thu, 14 Mar 2019 16:10:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/38] vfs: Convert virtio_balloon to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:10:55 +0000
Message-ID: <155257985551.13720.4140347473578124492.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 14 Mar 2019 16:10:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Michael S. Tsirkin" <mst@redhat.com>
cc: Jason Wang <jasowang@redhat.com>
cc: virtualization@lists.linux-foundation.org
---

 drivers/virtio/virtio_balloon.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f19061b585a4..89d67c8aa719 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -757,21 +757,22 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 
 	return MIGRATEPAGE_SUCCESS;
 }
+#include <linux/fs_context.h>
 
-static struct dentry *balloon_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
-{
-	static const struct dentry_operations ops = {
-		.d_dname = simple_dname,
-	};
+static const struct dentry_operations balloon_dops = {
+	.d_dname = simple_dname,
+};
 
-	return mount_pseudo(fs_type, "balloon-kvm:", NULL, &ops,
-				BALLOON_KVM_MAGIC);
+static int balloon_init_fs_context(struct fs_context *fc)
+{
+	return vfs_init_pseudo_fs_context(fc, "balloon-kvm:",
+					  NULL, NULL,
+					  &balloon_dops, BALLOON_KVM_MAGIC);
 }
 
 static struct file_system_type balloon_fs = {
 	.name           = "balloon-kvm",
-	.mount          = balloon_mount,
+	.init_fs_context = balloon_init_fs_context,
 	.kill_sb        = kill_anon_super,
 };
 


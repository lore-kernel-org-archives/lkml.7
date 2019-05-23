Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB2C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F2020881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640368;
	bh=Izkbe190T4j/Rt5mfXWuYGBWKYq4g4dZ4r2nz9ulMrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTdlQO3JKXqhJOIE4krXFvo6zzacZudNghSsKwd7CRsNCcUFUi+zjDIuwrnNKfm07
	 vhJj/LH4+jOZMvGFdQ5z206yOmhue9ZEP4xmzA2ftNXYSwwYVM5kvfJnFtLo3MyaZa
	 NLhjkUGAdnIdYlB8sYuZ1YM4ZcJ3C5qMDGRvV8LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbfEWTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388660AbfEWTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0735C205ED;
        Thu, 23 May 2019 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639325;
        bh=Izkbe190T4j/Rt5mfXWuYGBWKYq4g4dZ4r2nz9ulMrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXUWfeQfZFNHdG2I5L4gxqvSAJbVfcnQIQPF9HavR24j0n6wos+cRyop0ZqH4jPRY
         Gcs00zkIapPkrT6OBqn4IGGF7bqI8WX6TCeFEHu36IQNCOh+57o65swWHgAZQuOv1J
         ZVBvW78N+j1Mz/qjHlhR1D2nGFWwp8NoueIGDfrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.0 063/139] ceph: flush dirty inodes before proceeding with remount
Date:   Thu, 23 May 2019 21:05:51 +0200
Message-Id: <20190523181728.957143804@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 00abf69dd24f4444d185982379c5cc3bb7b6d1fc upstream.

xfstest generic/452 was triggering a "Busy inodes after umount" warning.
ceph was allowing the mount to go read-only without first flushing out
dirty inodes in the cache. Ensure we sync out the filesystem before
allowing a remount to proceed.

Cc: stable@vger.kernel.org
Link: http://tracker.ceph.com/issues/39571
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/super.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -832,6 +832,12 @@ static void ceph_umount_begin(struct sup
 	return;
 }
 
+static int ceph_remount(struct super_block *sb, int *flags, char *data)
+{
+	sync_filesystem(sb);
+	return 0;
+}
+
 static const struct super_operations ceph_super_ops = {
 	.alloc_inode	= ceph_alloc_inode,
 	.destroy_inode	= ceph_destroy_inode,
@@ -839,6 +845,7 @@ static const struct super_operations cep
 	.drop_inode	= ceph_drop_inode,
 	.sync_fs        = ceph_sync_fs,
 	.put_super	= ceph_put_super,
+	.remount_fs	= ceph_remount,
 	.show_options   = ceph_show_options,
 	.statfs		= ceph_statfs,
 	.umount_begin   = ceph_umount_begin,



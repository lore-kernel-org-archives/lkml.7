Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0403FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FE52178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfKFXnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:43:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKFXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:43:04 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iSUx4-0002vl-3u; Wed, 06 Nov 2019 23:43:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: create UUIDs for file systems that do not set the superblock UUID
Date:   Wed,  6 Nov 2019 23:43:01 +0000
Message-Id: <20191106234301.283006-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Some file systems such as squashfs do not set the UUID in the
superblock resulting in a zero'd UUID.  In cases were two or more
of these file systems are overlayed on the lower layer we can hit
overlay corruption issues because identical zero'd overlayfs UUIDs
are impossible to differentiate between.  This can be fixed by
creating an overlayfs UUID based on the file system from the
superblock s_magic and s_dev fields.  (This currently seems like
enough information to be able create a UUID, but the could be
scope to use other super block fields such as the pointer s_fs_info
but may need some obfuscation).

This issue can be reproduced with the following commands:

mkdir -p /cdrom
mount -t iso9660 -o ro,noatime /dev/sr0 /cdrom
sleep 1
mkdir -p /cow
mount -t tmpfs -o 'rw,noatime,mode=755' tmpfs /cow
mkdir -p /cow/upper
mkdir -p /cow/work
modprobe -q -b overlay
modprobe -q -b loop
dev=$(losetup -f)
mkdir -p /filesystem.squashfs
losetup $dev /cdrom/casper/filesystem.squashfs
mount -t squashfs -o ro,noatime $dev /filesystem.squashfs
dev=$(losetup -f)
mkdir -p /installer.squashfs
losetup $dev /cdrom/casper/installer.squashfs
mount -t squashfs -o ro,noatime $dev /installer.squashfs
mkdir -p /root-tmp
mount -t overlay -o 'upperdir=/cow/upper,lowerdir=/installer.squashfs:/filesystem.squashfs,workdir=/cow/work' /cow /root-tmp

FILE=/root-tmp/etc/.pwd.lock

echo foo > $FILE
cat $FILE
sync
echo 3 > /proc/sys/vm/drop_caches
cat $FILE

The output from cat $FILE:
cat: /root-tmp/etc/.pwd.lock: Input/output error

dmesg reports:
[ 42.415432] overlayfs: invalid origin (etc/.pwd.lock, ftype=8000, origin ftype=4000).

BugLink: https://bugs.launchpad.net/bugs/1824407
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/overlayfs/copy_up.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..a578db87936b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -231,6 +231,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	void *buf;
 	int buflen = MAX_HANDLE_SZ;
 	uuid_t *uuid = &real->d_sb->s_uuid;
+	static const uuid_t z_uuid;
 
 	buf = kmalloc(buflen, GFP_KERNEL);
 	if (!buf)
@@ -272,7 +273,20 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	if (is_upper)
 		fh->flags |= OVL_FH_FLAG_PATH_UPPER;
 	fh->len = fh_len;
-	fh->uuid = *uuid;
+
+	if (uuid_equal(uuid, &z_uuid)) {
+		/*
+		 * An zero'd uuid indicates the uuid in the super block was
+		 * not set by the file system, so fake one instead
+		 */
+		struct super_block *sb = real->d_sb;
+
+		memcpy(&fh->uuid.b[0], &sb->s_magic, 8);
+		memcpy(&fh->uuid.b[8], &sb->s_dev, 8);
+	} else {
+		fh->uuid = *uuid;
+	}
+
 	memcpy(fh->fid, buf, buflen);
 
 out:
-- 
2.20.1


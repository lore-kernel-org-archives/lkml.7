Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DC420679
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKMUGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:06:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfKMUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:06:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iUyuh-0007CI-O4; Wed, 13 Nov 2019 20:06:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
Date:   Wed, 13 Nov 2019 20:06:51 +0000
Message-Id: <20191113200651.114606-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

In the past, overlayfs required that lower fs have non null
uuid in order to support nfs export and decode copy up origin file handles.

Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
lower fs") relaxed this requirement for nfs export support, as long
as uuid (even if null) is unique among all lower fs.

However, said commit unintentionally also relaxed the non null uuid
requirement for decoding copy up origin file handles, regardless of
the unique uuid requirement.

Amend this mistake by disabling decoding of copy up origin file handle
from lower fs with a conflicting uuid.

We still encode copy up origin file handles from those fs, because
file handles like those already exist in the wild and because they
might provide useful information in the future.

[Colin Ian King] fixed the case of index=off,nfs_export=off

Reported-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/lkml/20191106234301.283006-1-colin.king@canonical.com/
Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid ...")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>`
---

V3: fix the following check:
  -       if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
  +       if (!ofs->config.nfs_export && !ofs->upper_mnt)

V4: remove bogus ofs->upper_mnt check

---
 fs/overlayfs/namei.c     |  8 ++++++++
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/super.c     | 13 ++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..f47c591402d7 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -325,6 +325,14 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 	int i;
 
 	for (i = 0; i < ofs->numlower; i++) {
+		/*
+		 * If lower fs uuid is not unique among lower fs we cannot match
+		 * fh->uuid to layer.
+		 */
+		if (ofs->lower_layers[i].fsid &&
+		    ofs->lower_layers[i].fs->bad_uuid)
+			continue;
+
 		origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
 					    connected);
 		if (origin)
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index a8279280e88d..28348c44ea5b 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -22,6 +22,8 @@ struct ovl_config {
 struct ovl_sb {
 	struct super_block *sb;
 	dev_t pseudo_dev;
+	/* Unusable (conflicting) uuid */
+	bool bad_uuid;
 };
 
 struct ovl_layer {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index afbcb116a7f1..8001bbad8705 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1255,7 +1255,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 {
 	unsigned int i;
 
-	if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
+	if (!ofs->config.nfs_export && !ofs->upper_mnt)
 		return true;
 
 	for (i = 0; i < ofs->numlowerfs; i++) {
@@ -1263,9 +1263,13 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 		 * We use uuid to associate an overlay lower file handle with a
 		 * lower layer, so we can accept lower fs with null uuid as long
 		 * as all lower layers with null uuid are on the same fs.
+		 * if we detect multiple lower fs with the same uuid, we
+		 * disable lower file handle decoding on all of them.
 		 */
-		if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid))
+		if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid)) {
+			ofs->lower_fs[i].bad_uuid = true;
 			return false;
+		}
 	}
 	return true;
 }
@@ -1277,6 +1281,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 	unsigned int i;
 	dev_t dev;
 	int err;
+	bool bad_uuid = false;
 
 	/* fsid 0 is reserved for upper fs even with non upper overlay */
 	if (ofs->upper_mnt && ofs->upper_mnt->mnt_sb == sb)
@@ -1288,9 +1293,10 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 	}
 
 	if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
+		bad_uuid = true;
 		ofs->config.index = false;
 		ofs->config.nfs_export = false;
-		pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
+		pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', enforcing index=off,nfs_export=off.\n",
 			uuid_is_null(&sb->s_uuid) ? "null" : "conflicting",
 			path->dentry);
 	}
@@ -1303,6 +1309,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 
 	ofs->lower_fs[ofs->numlowerfs].sb = sb;
 	ofs->lower_fs[ofs->numlowerfs].pseudo_dev = dev;
+	ofs->lower_fs[ofs->numlowerfs].bad_uuid = bad_uuid;
 	ofs->numlowerfs++;
 
 	return ofs->numlowerfs;
-- 
2.20.1


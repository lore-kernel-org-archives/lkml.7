Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2013C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DBA216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564411503;
	bh=ZJaCH6/EG+GnwaN6bqP7F/RqkgpTASOAGcigZFAnIpA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Psh8KhjdGl3KUn3Kw0IB2t2w3fgxpst6YszVR+tcxVbP3CwGhcCRneZ1XJnDtvb+m
	 od1raeR3a3l7zuQ0HN43RrM2fK6BP/bBSOjJYkyYwAs54HjIYtOPlTvHv1gcSnGRdO
	 FNzG+ocay1kmp4AtiwmcR29FM5miI011p2LkBOoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfG2OpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfG2OpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:45:02 -0400
Received: from localhost.localdomain (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA22206BA;
        Mon, 29 Jul 2019 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564411500;
        bh=ZJaCH6/EG+GnwaN6bqP7F/RqkgpTASOAGcigZFAnIpA=;
        h=From:To:Cc:Subject:Date:From;
        b=TmvZSnG9lh5mWO+cGUplu/CmjSJvwa2qTah96YjGVYfbj9ierPPBmN9AieTmH7SRJ
         AYCDXgiyWmdeT3MzmJ2zd5kkoAg5OHeQXQBCE5L28CUqt+mLFfjiTSsAhpkPWZF3Y7
         f97y+zozRZJ/mGj4OJcR/r2n/uRUKi0xGdpYwuLc=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: introduce sb.required_features to store incompatible features
Date:   Sun, 28 Jul 2019 23:15:26 +0800
Message-Id: <20190728151526.11845-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Later after this patch was merged, all new incompatible feature's
bit should be added into sb.required_features field, and define new
feature function with F2FS_INCOMPAT_FEATURE_FUNCS() macro.

Then during mount, we will do sanity check with enabled features in
image, if there are features in sb.required_features that kernel can
not recognize, just fail the mount.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- change commit title.
- fix wrong macro name.
 fs/f2fs/f2fs.h          | 15 +++++++++++++++
 fs/f2fs/super.c         | 10 ++++++++++
 include/linux/f2fs_fs.h |  3 ++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a6eb828af57f..b8e17d4ddb8d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -163,6 +163,15 @@ struct f2fs_mount_info {
 #define F2FS_CLEAR_FEATURE(sbi, mask)					\
 	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
 
+#define F2FS_INCOMPAT_FEATURES		0
+
+#define F2FS_HAS_INCOMPAT_FEATURE(sbi, mask)				\
+	((sbi->raw_super->required_features & cpu_to_le32(mask)) != 0)
+#define F2FS_SET_INCOMPAT_FEATURE(sbi, mask)				\
+	(sbi->raw_super->required_features |= cpu_to_le32(mask))
+#define F2FS_CLEAR_INCOMPAT_FEATURE(sbi, mask)				\
+	(sbi->raw_super->required_features &= ~cpu_to_le32(mask))
+
 /*
  * Default values for user and/or group using reserved blocks
  */
@@ -3585,6 +3594,12 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
 F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
 F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 
+#define F2FS_INCOMPAT_FEATURE_FUNCS(name, flagname) \
+static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
+{ \
+	return F2FS_HAS_INCOMPAT_FEATURE(sbi, F2FS_FEATURE_##flagname); \
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 				    block_t blkaddr)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5540fee0fe3f..3701dcce90e6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2513,6 +2513,16 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EINVAL;
 	}
 
+	/* check whether current kernel supports all features on image */
+	if (le32_to_cpu(raw_super->required_features) &
+			~F2FS_INCOMPAT_FEATURES) {
+		f2fs_info(sbi, "Unsupported feature: %x: supported: %x",
+			  le32_to_cpu(raw_super->required_features) ^
+			  F2FS_INCOMPAT_FEATURES,
+			  F2FS_INCOMPAT_FEATURES);
+		return -EINVAL;
+	}
+
 	/* Check checksum_offset and crc in superblock */
 	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
 		crc_offset = le32_to_cpu(raw_super->checksum_offset);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a2b36b2e286f..4141be3f219c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -117,7 +117,8 @@ struct f2fs_super_block {
 	__u8 hot_ext_count;		/* # of hot file extension */
 	__le16	s_encoding;		/* Filename charset encoding */
 	__le16	s_encoding_flags;	/* Filename charset encoding flags */
-	__u8 reserved[306];		/* valid reserved region */
+	__le32 required_features;       /* incompatible features to old kernel */
+	__u8 reserved[302];		/* valid reserved region */
 	__le32 crc;			/* checksum of superblock */
 } __packed;
 
-- 
2.22.0


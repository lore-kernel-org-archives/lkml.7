Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D8320663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142079;
	bh=HvQFAdWCiaTLrjN4db2Usy+T6gnJgRUADKiUxMGDsPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkQzb6iNoAtahG9OTOSaEd7euAuqXRhHIR9PxpWiBfNVffrqdrQhUhR/eKrmijqn4
	 fdSDtkkegSe2jUwPyeR04717tombw0XHA67yR1vlyD9oFrFQRb8Pi0dMMmgFzygafL
	 QcJOpBbN5FzHtGyB2oB69urglbNKDoAh0Ri1ZxOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfDARKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfDARKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2AF21924;
        Mon,  1 Apr 2019 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138650;
        bh=HvQFAdWCiaTLrjN4db2Usy+T6gnJgRUADKiUxMGDsPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1eJomXcvX6IbNO9t2Uwm3GVkKFO9shBHq3waeL1E/wqU3FBqPG/fmMHMt45jxzUy
         BNjr4oHGLOVw4Yqe+0YXTIbFjhD745lHbUHGBa/puuCR9RM/Gdkk/VlhYaqzdT6GmP
         5YIi2VBPcRizNCjPd6Pxe0MSXUP4l1GG30yqse/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.0 089/146] staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()
Date:   Mon,  1 Apr 2019 19:01:41 +0200
Message-Id: <20190401170056.345948930@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 33bac912840fe64dbc15556302537dc6a17cac63 upstream.

After commit 419d6efc50e9, kernel cannot be crashed in the namei
path. However, corrupted nameoff can do harm in the process of
readdir for scenerios without dm-verity as well. Fix it now.

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/dir.c |   45 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -23,6 +23,21 @@ static const unsigned char erofs_filetyp
 	[EROFS_FT_SYMLINK]	= DT_LNK,
 };
 
+static void debug_one_dentry(unsigned char d_type, const char *de_name,
+			     unsigned int de_namelen)
+{
+#ifdef CONFIG_EROFS_FS_DEBUG
+	/* since the on-disk name could not have the trailing '\0' */
+	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
+
+	memcpy(dbg_namebuf, de_name, de_namelen);
+	dbg_namebuf[de_namelen] = '\0';
+
+	debugln("found dirent %s de_len %u d_type %d", dbg_namebuf,
+		de_namelen, d_type);
+#endif
+}
+
 static int erofs_fill_dentries(struct dir_context *ctx,
 	void *dentry_blk, unsigned int *ofs,
 	unsigned int nameoff, unsigned int maxsize)
@@ -33,14 +48,10 @@ static int erofs_fill_dentries(struct di
 	de = dentry_blk + *ofs;
 	while (de < end) {
 		const char *de_name;
-		int de_namelen;
+		unsigned int de_namelen;
 		unsigned char d_type;
-#ifdef CONFIG_EROFS_FS_DEBUG
-		unsigned int dbg_namelen;
-		unsigned char dbg_namebuf[EROFS_NAME_LEN];
-#endif
 
-		if (unlikely(de->file_type < EROFS_FT_MAX))
+		if (de->file_type < EROFS_FT_MAX)
 			d_type = erofs_filetype_table[de->file_type];
 		else
 			d_type = DT_UNKNOWN;
@@ -48,26 +59,20 @@ static int erofs_fill_dentries(struct di
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
 
-		de_namelen = unlikely(de + 1 >= end) ?
-			/* last directory entry */
-			strnlen(de_name, maxsize - nameoff) :
-			le16_to_cpu(de[1].nameoff) - nameoff;
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
 
 		/* a corrupted entry is found */
-		if (unlikely(de_namelen < 0)) {
+		if (unlikely(nameoff + de_namelen > maxsize ||
+			     de_namelen > EROFS_NAME_LEN)) {
 			DBG_BUGON(1);
 			return -EIO;
 		}
 
-#ifdef CONFIG_EROFS_FS_DEBUG
-		dbg_namelen = min(EROFS_NAME_LEN - 1, de_namelen);
-		memcpy(dbg_namebuf, de_name, dbg_namelen);
-		dbg_namebuf[dbg_namelen] = '\0';
-
-		debugln("%s, found de_name %s de_len %d d_type %d", __func__,
-			dbg_namebuf, de_namelen, d_type);
-#endif
-
+		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      le64_to_cpu(de->nid), d_type))
 			/* stopped by some reason */



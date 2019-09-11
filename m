Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25047C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A1206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfIKRxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:53:09 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:39365 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbfIKRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:53:08 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i86nd-000GOr-W3; Wed, 11 Sep 2019 19:53:02 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=volery)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i86nd-0006xP-SW; Wed, 11 Sep 2019 19:53:01 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Wed, 11 Sep 2019 21:53:03 +0200
From:   Sandro Volery <sandro@volery.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, linux@rasmusvillemoes.dk
Subject: [PATCH v4] Staging: exfat: avoid use of strcpy
Message-ID: <20190911195303.GA27966@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing strcpy with strscpy and moving the length check to the
same function.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Sandro Volery <sandro@volery.com>
---

Took a couple attempts to finaly get this right :P

v4: Replaced strlen check
v3: Failed to replace check
v2: Forgot to replace strlen check
v1: original patch
 drivers/staging/exfat/exfat_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index da8c58149c35..4336fee444ce 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2960,18 +2960,15 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
-
-	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
+	
+	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
 		return FFS_INVALIDPATH;
 
-	strcpy(name_buf, path);
-
 	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
 	if (lossy)
 		return FFS_INVALIDPATH;
 
-	fid->size = i_size_read(inode);
-
+fid->size = i_size_read(inode);
 	p_dir->dir = fid->start_clu;
 	p_dir->size = (s32)(fid->size >> p_fs->cluster_size_bits);
 	p_dir->flags = fid->flags;
-- 
2.23.0


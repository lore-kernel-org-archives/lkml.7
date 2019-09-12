Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1614EC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D8520650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfILI0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:26:09 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:59193 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfILI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:26:08 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i8KQT-0008vL-Kc; Thu, 12 Sep 2019 10:26:01 +0200
Received: from [83.150.61.156] (helo=volery)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i8KQT-000DZC-Fp; Thu, 12 Sep 2019 10:26:01 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Thu, 12 Sep 2019 10:25:59 +0200
From:   Sandro Volery <sandro@volery.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5] Staging: exfat: Avoid use of strcpy
Message-ID: <20190912082559.GA5043@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strscpy instead of strcpy in exfat_core.c, and add a check
for length that will return already known FFS_INVALIDPATH.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Sandro Volery <sandro@volery.com>
---
v5: Fixed some whitespaces
v4: Replaced strlen check
v3: Failed to replace check
v2: Forgot to replace strlen check
v1: original patch
 drivers/staging/exfat/exfat_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index da8c58149c35..ee474ae3bd98 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2961,11 +2961,9 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
 
-	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
+	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
 		return FFS_INVALIDPATH;
 
-	strcpy(name_buf, path);
-
 	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
 	if (lossy)
 		return FFS_INVALIDPATH;
-- 
2.23.0


Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF09217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610485;
	bh=+udT0kFDJdycTpaw1Ab2NsHIYtH5Im/geoaaCnI2xwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FeFlt2bdw+Fg6txD16Zya9dtponB27OgRwwRwfnF4A1Q2VQR5gPhxUcWyDPoDxS6D
	 fDMzoAc/I+S8btd9TGpwJ+pa3SAyOMPis3n4Hw/Shyp6LARuacCH94igxtnMOfcV3i
	 CNS0blCGXQmAqV4DggdY/ScqeJSquDFpZTW38diQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbfDRSBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390095AbfDRSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA13206B6;
        Thu, 18 Apr 2019 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610480;
        bh=+udT0kFDJdycTpaw1Ab2NsHIYtH5Im/geoaaCnI2xwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8IYd+J9kzax3GgG9NgxUq0AWfeLn1yVvDsoNt/weqIHvOl6ZzoEPOXMY6KeuTw++
         FBEHmgEY2NGvG490y7S30g8W76D0i+8upPiPKtXG69+o1YKC54an8P5UqFp8K0Tva3
         3gM7AueMQvx+eFBfUplQR2e/FBlxHlzUtLUwvUbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/110] cifs: fallback to older infolevels on findfirst queryinfo retry
Date:   Thu, 18 Apr 2019 19:57:06 +0200
Message-Id: <20190418160445.478785952@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3b7960caceafdfc2cdfe2850487f8d091eb41144 ]

In cases where queryinfo fails, we have cases in cifs (vers=1.0)
where with backupuid mounts we retry the query info with findfirst.
This doesn't work to some NetApp servers which don't support
WindowsXP (and later) infolevel 261 (SMB_FIND_FILE_ID_FULL_DIR_INFO)
so in this case use other info levels (in this case it will usually
be level 257, SMB_FIND_FILE_DIRECTORY_INFO).

(Also fixes some indentation)

See kernel bugzilla 201435

Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 020f49c15b30..b59ebed4f615 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -780,43 +780,50 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
 	} else if ((rc == -EACCES) && backup_cred(cifs_sb) &&
 		   (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
 		      == 0)) {
-			/*
-			 * For SMB2 and later the backup intent flag is already
-			 * sent if needed on open and there is no path based
-			 * FindFirst operation to use to retry with
-			 */
+		/*
+		 * For SMB2 and later the backup intent flag is already
+		 * sent if needed on open and there is no path based
+		 * FindFirst operation to use to retry with
+		 */
 
-			srchinf = kzalloc(sizeof(struct cifs_search_info),
-						GFP_KERNEL);
-			if (srchinf == NULL) {
-				rc = -ENOMEM;
-				goto cgii_exit;
-			}
+		srchinf = kzalloc(sizeof(struct cifs_search_info),
+					GFP_KERNEL);
+		if (srchinf == NULL) {
+			rc = -ENOMEM;
+			goto cgii_exit;
+		}
 
-			srchinf->endOfSearch = false;
+		srchinf->endOfSearch = false;
+		if (tcon->unix_ext)
+			srchinf->info_level = SMB_FIND_FILE_UNIX;
+		else if ((tcon->ses->capabilities &
+			 tcon->ses->server->vals->cap_nt_find) == 0)
+			srchinf->info_level = SMB_FIND_FILE_INFO_STANDARD;
+		else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)
 			srchinf->info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
+		else /* no srvino useful for fallback to some netapp */
+			srchinf->info_level = SMB_FIND_FILE_DIRECTORY_INFO;
 
-			srchflgs = CIFS_SEARCH_CLOSE_ALWAYS |
-					CIFS_SEARCH_CLOSE_AT_END |
-					CIFS_SEARCH_BACKUP_SEARCH;
+		srchflgs = CIFS_SEARCH_CLOSE_ALWAYS |
+				CIFS_SEARCH_CLOSE_AT_END |
+				CIFS_SEARCH_BACKUP_SEARCH;
 
-			rc = CIFSFindFirst(xid, tcon, full_path,
-				cifs_sb, NULL, srchflgs, srchinf, false);
-			if (!rc) {
-				data =
-				(FILE_ALL_INFO *)srchinf->srch_entries_start;
+		rc = CIFSFindFirst(xid, tcon, full_path,
+			cifs_sb, NULL, srchflgs, srchinf, false);
+		if (!rc) {
+			data = (FILE_ALL_INFO *)srchinf->srch_entries_start;
 
-				cifs_dir_info_to_fattr(&fattr,
-				(FILE_DIRECTORY_INFO *)data, cifs_sb);
-				fattr.cf_uniqueid = le64_to_cpu(
-				((SEARCH_ID_FULL_DIR_INFO *)data)->UniqueId);
-				validinum = true;
+			cifs_dir_info_to_fattr(&fattr,
+			(FILE_DIRECTORY_INFO *)data, cifs_sb);
+			fattr.cf_uniqueid = le64_to_cpu(
+			((SEARCH_ID_FULL_DIR_INFO *)data)->UniqueId);
+			validinum = true;
 
-				cifs_buf_release(srchinf->ntwrk_buf_start);
-			}
-			kfree(srchinf);
-			if (rc)
-				goto cgii_exit;
+			cifs_buf_release(srchinf->ntwrk_buf_start);
+		}
+		kfree(srchinf);
+		if (rc)
+			goto cgii_exit;
 	} else
 		goto cgii_exit;
 
-- 
2.19.1




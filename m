Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCBC214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611934;
	bh=xMXkTQqI2leSNgIK0Npj2Q2ofB1Viwr8xPHazsDBQtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDWibyeoBEHKXH2XZ17p6G7j9mEoaPsiVTA44tj0rxOM4TgFee3QniqpUvEJt1/dn
	 s/mmwHPA0Rc4RGmhm9k4DvvM4V4SlNtX+os3Y3kLq85BF4oqXpwpwlcJ3zemp3f/6+
	 WLYd/MD7QurcbxQwWTcpEZD70xql2snPkCbRhiUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbfDRSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390411AbfDRSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AD42186A;
        Thu, 18 Apr 2019 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610704;
        bh=xMXkTQqI2leSNgIK0Npj2Q2ofB1Viwr8xPHazsDBQtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTqjhI26pdPvVfu3+7M5sLTkNa4xbsMMCkg6gHQz824QPRGy3PokDEcrUD0hXA90x
         PHNClbBLp5etfg7o9/Y3CLvdCOnuLhcbi9syVOtveGdbKGv6+jmcGJmLGBXpEO3S4j
         fZiDABnS7qzq8U12QFFaJw3w8I3B3H4oLrIRUDBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 53/92] cifs: fallback to older infolevels on findfirst queryinfo retry
Date:   Thu, 18 Apr 2019 19:57:11 +0200
Message-Id: <20190418160434.803128481@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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
index a90a637ae79a..6fd4a6a75234 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -779,43 +779,50 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
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




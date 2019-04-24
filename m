Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD17C282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B6620652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128922;
	bh=SZpf9VjrGuNPYbm/5p0PTRoSFW7LuNFcSU2T55vMh9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNvjTKqc20SNkljU8iXyxzZxPWtDoqEBFNt5NrR0GkFhIEVzt9doK+/4CfXdUr0y5
	 Un0ASjZvfKnZ5bpi1YYEea0B2XYQWIK0D8kkIWtpOISM1JikFzcXsZdS5xfDbn0bqx
	 VGd6xQOh0yAq44T8VY90dBWp+PHsA2OvsHFg/duE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfDXRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389351AbfDXRVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:30 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B636205ED;
        Wed, 24 Apr 2019 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126489;
        bh=SZpf9VjrGuNPYbm/5p0PTRoSFW7LuNFcSU2T55vMh9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UEvVC8+h/s7dWjdVf9WtZBKSAYCalaHkF9PTZkf5HKnkntVdsAjsnEi/I4pMlv9x
         mkCUMhxlmjcRsuygNKLdZxeqFMeOjZwQTiOR+uKeALTGJPaSNMohjhBXVAy+U/N7s/
         fOay4b2ZK6EWn1Q74i6wunXTAF2WX1rglnJkbG4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 126/168] cifs: fallback to older infolevels on findfirst queryinfo retry
Date:   Wed, 24 Apr 2019 19:09:30 +0200
Message-Id: <20190424170930.798773750@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
 fs/cifs/inode.c | 69 +++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 5c3187df9ab9..d8bd8dd36211 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -759,43 +759,50 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
 	} else if ((rc == -EACCES) && backup_cred(cifs_sb) &&
 		   (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
 		      == 0)) {
-			/*
-			 * For SMB2 and later the backup intent flag is already
-			 * sent if needed on open and there is no path based
-			 * FindFirst operation to use to retry with
-			 */
-
-			srchinf = kzalloc(sizeof(struct cifs_search_info),
-						GFP_KERNEL);
-			if (srchinf == NULL) {
-				rc = -ENOMEM;
-				goto cgii_exit;
-			}
+		/*
+		 * For SMB2 and later the backup intent flag is already
+		 * sent if needed on open and there is no path based
+		 * FindFirst operation to use to retry with
+		 */
+
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




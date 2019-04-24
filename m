Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37933C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED96D2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127020;
	bh=9Hr+vbr3MYJUocQqbkui8bZAihin5517wLa+64ztmbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bX6p4Y+xCaCkZaYH/rE6Hy8quKlUtcCXLmY/z4iyttszbz2UaA6slh9H3DfEwv9H+
	 iq03RHG9v5wLBa5BFdlqlnec/sW3+PrV7bP+Y+ssAP2dg9W6MqBHw2oDfb2idboa4z
	 +06eoj8DeoOWws2qFJvM9GPa9WnNUe/itfQBhfBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfDXRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390923AbfDXRaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:13 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C4D2054F;
        Wed, 24 Apr 2019 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127012;
        bh=9Hr+vbr3MYJUocQqbkui8bZAihin5517wLa+64ztmbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAIlaSAziEiH7fxzX+PeyRFteOktpON2fe8ov2QyVc7GENZu4Ute/MLWv0zobDYlM
         95kDtQT4KztFSfbzALCgetGnEoAh3tnQQlw7qbpxgINw7HUeTEdRZtwSLyekIcoNuP
         MPncGlejq8/eoePUDNYjo+S2U2q5xOzfaI7cN3Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.19 28/96] CIFS: keep FileInfo handle live during oplock break
Date:   Wed, 24 Apr 2019 19:09:33 +0200
Message-Id: <20190424170921.753222908@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

commit b98749cac4a695f084a5ff076f4510b23e353ecd upstream.

In the oplock break handler, writing pending changes from pages puts
the FileInfo handle. If the refcount reaches zero it closes the handle
and waits for any oplock break handler to return, thus causing a deadlock.

To prevent this situation:

* We add a wait flag to cifsFileInfo_put() to decide whether we should
  wait for running/pending oplock break handlers

* We keep an additionnal reference of the SMB FileInfo handle so that
  for the rest of the handler putting the handle won't close it.
  - The ref is bumped everytime we queue the handler via the
    cifs_queue_oplock_break() helper.
  - The ref is decremented at the end of the handler

This bug was triggered by xfstest 464.

Also important fix to address the various reports of
oops in smb2_push_mandatory_locks

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h |    2 ++
 fs/cifs/file.c     |   30 +++++++++++++++++++++++++-----
 fs/cifs/misc.c     |   25 +++++++++++++++++++++++--
 fs/cifs/smb2misc.c |    6 +++---
 4 files changed, 53 insertions(+), 10 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1263,6 +1263,7 @@ cifsFileInfo_get_locked(struct cifsFileI
 }
 
 struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file);
+void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_hdlr);
 void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
 
 #define CIFS_CACHE_READ_FLG	1
@@ -1763,6 +1764,7 @@ GLOBAL_EXTERN spinlock_t gidsidlock;
 #endif /* CONFIG_CIFS_ACL */
 
 void cifs_oplock_break(struct work_struct *work);
+void cifs_queue_oplock_break(struct cifsFileInfo *cfile);
 
 extern const struct slow_work_ops cifs_oplock_break_ops;
 extern struct workqueue_struct *cifsiod_wq;
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -358,13 +358,31 @@ cifsFileInfo_get(struct cifsFileInfo *ci
 	return cifs_file;
 }
 
-/*
- * Release a reference on the file private data. This may involve closing
- * the filehandle out on the server. Must be called without holding
- * tcon->open_file_lock and cifs_file->file_info_lock.
+/**
+ * cifsFileInfo_put - release a reference of file priv data
+ *
+ * Always potentially wait for oplock handler. See _cifsFileInfo_put().
  */
 void cifsFileInfo_put(struct cifsFileInfo *cifs_file)
 {
+	_cifsFileInfo_put(cifs_file, true);
+}
+
+/**
+ * _cifsFileInfo_put - release a reference of file priv data
+ *
+ * This may involve closing the filehandle @cifs_file out on the
+ * server. Must be called without holding tcon->open_file_lock and
+ * cifs_file->file_info_lock.
+ *
+ * If @wait_for_oplock_handler is true and we are releasing the last
+ * reference, wait for any running oplock break handler of the file
+ * and cancel any pending one. If calling this function from the
+ * oplock break handler, you need to pass false.
+ *
+ */
+void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_handler)
+{
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifs_tcon *tcon = tlink_tcon(cifs_file->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
@@ -411,7 +429,8 @@ void cifsFileInfo_put(struct cifsFileInf
 
 	spin_unlock(&tcon->open_file_lock);
 
-	oplock_break_cancelled = cancel_work_sync(&cifs_file->oplock_break);
+	oplock_break_cancelled = wait_oplock_handler ?
+		cancel_work_sync(&cifs_file->oplock_break) : false;
 
 	if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
 		struct TCP_Server_Info *server = tcon->ses->server;
@@ -4170,6 +4189,7 @@ void cifs_oplock_break(struct work_struc
 							     cinode);
 		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
 	}
+	_cifsFileInfo_put(cfile, false /* do not wait for ourself */);
 	cifs_done_oplock_break(cinode);
 }
 
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -490,8 +490,7 @@ is_valid_oplock_break(char *buffer, stru
 					   CIFS_INODE_DOWNGRADE_OPLOCK_TO_L2,
 					   &pCifsInode->flags);
 
-				queue_work(cifsoplockd_wq,
-					   &netfile->oplock_break);
+				cifs_queue_oplock_break(netfile);
 				netfile->oplock_break_cancelled = false;
 
 				spin_unlock(&tcon->open_file_lock);
@@ -588,6 +587,28 @@ void cifs_put_writer(struct cifsInodeInf
 	spin_unlock(&cinode->writers_lock);
 }
 
+/**
+ * cifs_queue_oplock_break - queue the oplock break handler for cfile
+ *
+ * This function is called from the demultiplex thread when it
+ * receives an oplock break for @cfile.
+ *
+ * Assumes the tcon->open_file_lock is held.
+ * Assumes cfile->file_info_lock is NOT held.
+ */
+void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
+{
+	/*
+	 * Bump the handle refcount now while we hold the
+	 * open_file_lock to enforce the validity of it for the oplock
+	 * break handler. The matching put is done at the end of the
+	 * handler.
+	 */
+	cifsFileInfo_get(cfile);
+
+	queue_work(cifsoplockd_wq, &cfile->oplock_break);
+}
+
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)
 {
 	clear_bit(CIFS_INODE_PENDING_OPLOCK_BREAK, &cinode->flags);
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -555,7 +555,7 @@ smb2_tcon_has_lease(struct cifs_tcon *tc
 			clear_bit(CIFS_INODE_DOWNGRADE_OPLOCK_TO_L2,
 				  &cinode->flags);
 
-		queue_work(cifsoplockd_wq, &cfile->oplock_break);
+		cifs_queue_oplock_break(cfile);
 		kfree(lw);
 		return true;
 	}
@@ -719,8 +719,8 @@ smb2_is_valid_oplock_break(char *buffer,
 					   CIFS_INODE_DOWNGRADE_OPLOCK_TO_L2,
 					   &cinode->flags);
 				spin_unlock(&cfile->file_info_lock);
-				queue_work(cifsoplockd_wq,
-					   &cfile->oplock_break);
+
+				cifs_queue_oplock_break(cfile);
 
 				spin_unlock(&tcon->open_file_lock);
 				spin_unlock(&cifs_tcp_ses_lock);



Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70257C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F3924682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781748;
	bh=evkCinW7sZmVDT71TB5X7RzDelWavbVQam8KagxZbK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgrJ+yXD/j7wl6MkYYDzTCITF2dilQ5zgkM9PchnvqsqqOcIQWFD6Pltpwe3TyA8t
	 Hj345sFXSwCe8l3OZkTLXGbFPN+TOrj3gjBXLYMH7i9PGM7wJHtTKRBs4d/hJolFBG
	 2x99MfakMZ/qLz/QCvTYh5X4ryF6FZ6ToRi2G1fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfLSSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730702AbfLSSzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:55:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8592C24676;
        Thu, 19 Dec 2019 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781743;
        bh=evkCinW7sZmVDT71TB5X7RzDelWavbVQam8KagxZbK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1eYSz1YqU4pOzlFlHVhBE4KtokpaQQo+mnyovn0AZYdF4EJiE2nhKSji0AbaQFwFK
         5o1eo/0TW4nSMtWEc0IrzOTG+dBL3MOK7f7xszyqYhmCJO+gko5p5/1UP/L8ElaKBF
         OtruoJcJsq+lSpCWAVVnns2lD5RhAYVrDk4lMVWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Sorenson <sorenson@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 35/80] CIFS: Close open handle after interrupted close
Date:   Thu, 19 Dec 2019 19:34:27 +0100
Message-Id: <20191219183106.903932675@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 9150c3adbf24d77cfba37f03639d4a908ca4ac25 upstream.

If Close command is interrupted before sending a request
to the server the client ends up leaking an open file
handle. This wastes server resources and can potentially
block applications that try to remove the file or any
directory containing this file.

Fix this by putting the close command into a worker queue,
so another thread retries it later.

Cc: Stable <stable@vger.kernel.org>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2misc.c  |   59 +++++++++++++++++++++++++++++++++++++++-------------
 fs/cifs/smb2pdu.c   |   16 +++++++++++++-
 fs/cifs/smb2proto.h |    3 ++
 3 files changed, 63 insertions(+), 15 deletions(-)

--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -743,36 +743,67 @@ smb2_cancelled_close_fid(struct work_str
 	kfree(cancelled);
 }
 
+/* Caller should already has an extra reference to @tcon */
+static int
+__smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
+			      __u64 volatile_fid)
+{
+	struct close_cancelled_open *cancelled;
+
+	cancelled = kzalloc(sizeof(*cancelled), GFP_KERNEL);
+	if (!cancelled)
+		return -ENOMEM;
+
+	cancelled->fid.persistent_fid = persistent_fid;
+	cancelled->fid.volatile_fid = volatile_fid;
+	cancelled->tcon = tcon;
+	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
+	WARN_ON(queue_work(cifsiod_wq, &cancelled->work) == false);
+
+	return 0;
+}
+
+int
+smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
+			    __u64 volatile_fid)
+{
+	int rc;
+
+	cifs_dbg(FYI, "%s: tc_count=%d\n", __func__, tcon->tc_count);
+	spin_lock(&cifs_tcp_ses_lock);
+	tcon->tc_count++;
+	spin_unlock(&cifs_tcp_ses_lock);
+
+	rc = __smb2_handle_cancelled_close(tcon, persistent_fid, volatile_fid);
+	if (rc)
+		cifs_put_tcon(tcon);
+
+	return rc;
+}
+
 int
 smb2_handle_cancelled_mid(char *buffer, struct TCP_Server_Info *server)
 {
 	struct smb2_sync_hdr *sync_hdr = (struct smb2_sync_hdr *)buffer;
 	struct smb2_create_rsp *rsp = (struct smb2_create_rsp *)buffer;
 	struct cifs_tcon *tcon;
-	struct close_cancelled_open *cancelled;
+	int rc;
 
 	if (sync_hdr->Command != SMB2_CREATE ||
 	    sync_hdr->Status != STATUS_SUCCESS)
 		return 0;
 
-	cancelled = kzalloc(sizeof(*cancelled), GFP_KERNEL);
-	if (!cancelled)
-		return -ENOMEM;
-
 	tcon = smb2_find_smb_tcon(server, sync_hdr->SessionId,
 				  sync_hdr->TreeId);
-	if (!tcon) {
-		kfree(cancelled);
+	if (!tcon)
 		return -ENOENT;
-	}
 
-	cancelled->fid.persistent_fid = rsp->PersistentFileId;
-	cancelled->fid.volatile_fid = rsp->VolatileFileId;
-	cancelled->tcon = tcon;
-	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
-	queue_work(cifsiod_wq, &cancelled->work);
+	rc = __smb2_handle_cancelled_close(tcon, rsp->PersistentFileId,
+					   rsp->VolatileFileId);
+	if (rc)
+		cifs_put_tcon(tcon);
 
-	return 0;
+	return rc;
 }
 
 /**
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2972,7 +2972,21 @@ int
 SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	   u64 persistent_fid, u64 volatile_fid)
 {
-	return SMB2_close_flags(xid, tcon, persistent_fid, volatile_fid, 0);
+	int rc;
+	int tmp_rc;
+
+	rc = SMB2_close_flags(xid, tcon, persistent_fid, volatile_fid, 0);
+
+	/* retry close in a worker thread if this one is interrupted */
+	if (rc == -EINTR) {
+		tmp_rc = smb2_handle_cancelled_close(tcon, persistent_fid,
+						     volatile_fid);
+		if (tmp_rc)
+			cifs_dbg(VFS, "handle cancelled close fid 0x%llx returned error %d\n",
+				 persistent_fid, tmp_rc);
+	}
+
+	return rc;
 }
 
 int
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -212,6 +212,9 @@ extern int SMB2_set_compression(const un
 extern int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 			     const u64 persistent_fid, const u64 volatile_fid,
 			     const __u8 oplock_level);
+extern int smb2_handle_cancelled_close(struct cifs_tcon *tcon,
+				       __u64 persistent_fid,
+				       __u64 volatile_fid);
 extern int smb2_handle_cancelled_mid(char *buffer,
 					struct TCP_Server_Info *server);
 void smb2_cancelled_close_fid(struct work_struct *work);



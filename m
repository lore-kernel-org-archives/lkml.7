Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0672070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258593;
	bh=/hgtlxIL7Tjm2kkcAyezXCdQMPGcN9xd8Q1WmaQzXcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7FD89aP0koqnUi8izcUZFhnfB5hu6mXDGXmH/BMHgSIZqK18wctLiPwRYk9vxYLc
	 U6l3tLAa+qt7luwtciuQHl6Onek5li6k943UwVY05PLxpr3LR9+00z5TF5Wmm54YF7
	 SDqyAUan//UOZebWq5SHqcY/fFz595VSUMNsgJRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfCVMDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732400AbfCVMDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C53204FD;
        Fri, 22 Mar 2019 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256195;
        bh=/hgtlxIL7Tjm2kkcAyezXCdQMPGcN9xd8Q1WmaQzXcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIjxdS3vixIye7jM65RHEcGVnWBX+bcIlXVZeFnrmxVQJtbHzrcaiXyytlaP3VSiZ
         xMpBjV3cM6JAW1/hK1xo7yELoHs5kBOf9mWM3Zb16ziuYvIptpVg5Rbyp0FsobiEX+
         FSpP8CPGjFiQmsrpW8BP/aGR6DwPb2XQZPwzgfVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 137/280] CIFS: Do not reset lease state to NONE on lease break
Date:   Fri, 22 Mar 2019 12:14:50 +0100
Message-Id: <20190322111317.645510503@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <piastryyy@gmail.com>

commit 7b9b9edb49ad377b1e06abf14354c227e9ac4b06 upstream.

Currently on lease break the client sets a caching level twice:
when oplock is detected and when oplock is processed. While the
1st attempt sets the level to the value provided by the server,
the 2nd one resets the level to None unconditionally.
This happens because the oplock/lease processing code was changed
to avoid races between page cache flushes and oplock breaks.
The commit c11f1df5003d534 ("cifs: Wait for writebacks to complete
before attempting write.") fixed the races for oplocks but didn't
apply the same changes for leases resulting in overwriting the
server granted value to None. Fix this by properly processing
lease breaks.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2misc.c |   17 ++++++++++++++---
 fs/cifs/smb2ops.c  |   15 ++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -517,7 +517,6 @@ smb2_tcon_has_lease(struct cifs_tcon *tc
 	__u8 lease_state;
 	struct list_head *tmp;
 	struct cifsFileInfo *cfile;
-	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_pending_open *open;
 	struct cifsInodeInfo *cinode;
 	int ack_req = le32_to_cpu(rsp->Flags &
@@ -537,13 +536,25 @@ smb2_tcon_has_lease(struct cifs_tcon *tc
 		cifs_dbg(FYI, "lease key match, lease break 0x%x\n",
 			 le32_to_cpu(rsp->NewLeaseState));
 
-		server->ops->set_oplock_level(cinode, lease_state, 0, NULL);
-
 		if (ack_req)
 			cfile->oplock_break_cancelled = false;
 		else
 			cfile->oplock_break_cancelled = true;
 
+		set_bit(CIFS_INODE_PENDING_OPLOCK_BREAK, &cinode->flags);
+
+		/*
+		 * Set or clear flags depending on the lease state being READ.
+		 * HANDLE caching flag should be added when the client starts
+		 * to defer closing remote file handles with HANDLE leases.
+		 */
+		if (lease_state & SMB2_LEASE_READ_CACHING_HE)
+			set_bit(CIFS_INODE_DOWNGRADE_OPLOCK_TO_L2,
+				&cinode->flags);
+		else
+			clear_bit(CIFS_INODE_DOWNGRADE_OPLOCK_TO_L2,
+				  &cinode->flags);
+
 		queue_work(cifsoplockd_wq, &cfile->oplock_break);
 		kfree(lw);
 		return true;
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2301,6 +2301,15 @@ smb2_downgrade_oplock(struct TCP_Server_
 }
 
 static void
+smb21_downgrade_oplock(struct TCP_Server_Info *server,
+		       struct cifsInodeInfo *cinode, bool set_level2)
+{
+	server->ops->set_oplock_level(cinode,
+				      set_level2 ? SMB2_LEASE_READ_CACHING_HE :
+				      0, 0, NULL);
+}
+
+static void
 smb2_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 		      unsigned int epoch, bool *purge_cache)
 {
@@ -3351,7 +3360,7 @@ struct smb_version_operations smb21_oper
 	.print_stats = smb2_print_stats,
 	.is_oplock_break = smb2_is_valid_oplock_break,
 	.handle_cancelled_mid = smb2_handle_cancelled_mid,
-	.downgrade_oplock = smb2_downgrade_oplock,
+	.downgrade_oplock = smb21_downgrade_oplock,
 	.need_neg = smb2_need_neg,
 	.negotiate = smb2_negotiate,
 	.negotiate_wsize = smb2_negotiate_wsize,
@@ -3447,7 +3456,7 @@ struct smb_version_operations smb30_oper
 	.dump_share_caps = smb2_dump_share_caps,
 	.is_oplock_break = smb2_is_valid_oplock_break,
 	.handle_cancelled_mid = smb2_handle_cancelled_mid,
-	.downgrade_oplock = smb2_downgrade_oplock,
+	.downgrade_oplock = smb21_downgrade_oplock,
 	.need_neg = smb2_need_neg,
 	.negotiate = smb2_negotiate,
 	.negotiate_wsize = smb2_negotiate_wsize,
@@ -3551,7 +3560,7 @@ struct smb_version_operations smb311_ope
 	.dump_share_caps = smb2_dump_share_caps,
 	.is_oplock_break = smb2_is_valid_oplock_break,
 	.handle_cancelled_mid = smb2_handle_cancelled_mid,
-	.downgrade_oplock = smb2_downgrade_oplock,
+	.downgrade_oplock = smb21_downgrade_oplock,
 	.need_neg = smb2_need_neg,
 	.negotiate = smb2_negotiate,
 	.negotiate_wsize = smb2_negotiate_wsize,



Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9542CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB75221744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904738;
	bh=d1+D2WbtCi048YV1rKTlYg7OIfGww8vt5fBXO1vSNng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UE4uK5KRlfH4BohjPwfcVnsMR6w2WOlhvU2igxsbdUbo7Pb/TKozG25DiHHU2Yyms
	 vnqbauSZpVplgEXA1GOPIeHXpaYZH6uLf7Ju4trgubmg71A84BkfpfFFyT/9qIq5F+
	 B8MF3GxYlnmOJB7B2r86tlRY7JjR03STtb5FgCUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfKDV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730739AbfKDV6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:58:47 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE8720650;
        Mon,  4 Nov 2019 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904727;
        bh=d1+D2WbtCi048YV1rKTlYg7OIfGww8vt5fBXO1vSNng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiEloVjFsrfcI7R6Mb91S/n16QO3XRqvf2AzRyHiZ2oC+eu0qp2l6nZAUaqBAThp8
         KvCocJjT7shUMZqtN4bQkVPZeIaVe1fijhzmamm+awfggxxb5LCFOedMDzdQmR9S6D
         Qi61tIvkg15dLtE4Naqs1S2ckJi2uK1xZSE1sKxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/149] cifs: add credits from unmatched responses/messages
Date:   Mon,  4 Nov 2019 22:44:02 +0100
Message-Id: <20191104212139.553840698@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit eca004523811f816bcfca3046ab54e1278e0973b ]

We should add any credits granted to us from unmatched server responses.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c  | 22 ++++++++++++++++++++++
 fs/cifs/smb2misc.c |  7 -------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 966e493c82e57..7e85070d010f4 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -930,6 +930,26 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	return 0;
 }
 
+static void
+smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
+{
+	struct smb2_sync_hdr *shdr = (struct smb2_sync_hdr *)buffer;
+
+	/*
+	 * SMB1 does not use credits.
+	 */
+	if (server->vals->header_preamble_size)
+		return;
+
+	if (shdr->CreditRequest) {
+		spin_lock(&server->req_lock);
+		server->credits += le16_to_cpu(shdr->CreditRequest);
+		spin_unlock(&server->req_lock);
+		wake_up(&server->request_q);
+	}
+}
+
+
 static int
 cifs_demultiplex_thread(void *p)
 {
@@ -1059,6 +1079,7 @@ next_pdu:
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
+				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dbg(FYI, "Received oplock break\n");
 			} else {
 				cifs_dbg(VFS, "No task to wake, unknown frame "
@@ -1070,6 +1091,7 @@ next_pdu:
 				if (server->ops->dump_detail)
 					server->ops->dump_detail(bufs[i],
 								 server);
+				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dump_mids(server);
 #endif /* CIFS_DEBUG2 */
 			}
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 0a7ed2e3ad4f2..e311f58dc1c82 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -659,13 +659,6 @@ smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server)
 	if (rsp->sync_hdr.Command != SMB2_OPLOCK_BREAK)
 		return false;
 
-	if (rsp->sync_hdr.CreditRequest) {
-		spin_lock(&server->req_lock);
-		server->credits += le16_to_cpu(rsp->sync_hdr.CreditRequest);
-		spin_unlock(&server->req_lock);
-		wake_up(&server->request_q);
-	}
-
 	if (rsp->StructureSize !=
 				smb2_rsp_struct_sizes[SMB2_OPLOCK_BREAK_HE]) {
 		if (le16_to_cpu(rsp->StructureSize) == 44)
-- 
2.20.1




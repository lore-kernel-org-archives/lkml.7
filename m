Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2C92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258038;
	bh=Cjt2P+RKYApyJAcZpAJGGIcXkYCZcwD+g7mFV/WrLqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IoR+cznJNSJdw48hJw4GpEjy9aXGpCUvulu9VjcxPMIAwpgi0QLMJZm1TynUxc6Yi
	 y1XQLfvd7SC7CCIbmdGwfESsKzsr3YYZqF3YHQFWElFZQ9Y8LEewtfK/e0uwUS4S6W
	 dR8WvKXjzAHnMfSqOUVoRAv1NH9UKbXzRzovzKEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfCVMOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbfCVMOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE27B20811;
        Fri, 22 Mar 2019 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256845;
        bh=Cjt2P+RKYApyJAcZpAJGGIcXkYCZcwD+g7mFV/WrLqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyZwYpKbaPyxgQ72WxRU133Z5HKvxK94bTjAoxr60/FwSmZ3ZsEwZ7tDFkjYnOppt
         RcCHl+pOv3K9ah8nlj0USUWJQcpEY3cpIBCaXZe9fDDcDIpM4locLpW0CWv0desIL2
         vKSpopBVCbkYOEOuTzhtikGgXiyhHG93Lh/nIKG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.0 053/238] CIFS: Do not skip SMB2 message IDs on send failures
Date:   Fri, 22 Mar 2019 12:14:32 +0100
Message-Id: <20190322111301.573119740@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Pavel Shilovsky <piastryyy@gmail.com>

commit c781af7e0c1fed9f1d0e0ec31b86f5b21a8dca17 upstream.

When we hit failures during constructing MIDs or sending PDUs
through the network, we end up not using message IDs assigned
to the packet. The next SMB packet will skip those message IDs
and continue with the next one. This behavior may lead to a server
not granting us credits until we use the skipped IDs. Fix this by
reverting the current ID to the original value if any errors occur
before we push the packet through the network stack.

This patch fixes the generic/310 test from the xfs-tests.

Cc: <stable@vger.kernel.org> # 4.19.x
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h      |   19 +++++++++++++++++++
 fs/cifs/smb2ops.c       |   13 +++++++++++++
 fs/cifs/smb2transport.c |   14 ++++++++++++--
 fs/cifs/transport.c     |    6 +++++-
 4 files changed, 49 insertions(+), 3 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -236,6 +236,8 @@ struct smb_version_operations {
 	int * (*get_credits_field)(struct TCP_Server_Info *, const int);
 	unsigned int (*get_credits)(struct mid_q_entry *);
 	__u64 (*get_next_mid)(struct TCP_Server_Info *);
+	void (*revert_current_mid)(struct TCP_Server_Info *server,
+				   const unsigned int val);
 	/* data offset from read response message */
 	unsigned int (*read_data_offset)(char *);
 	/*
@@ -770,6 +772,22 @@ get_next_mid(struct TCP_Server_Info *ser
 	return cpu_to_le16(mid);
 }
 
+static inline void
+revert_current_mid(struct TCP_Server_Info *server, const unsigned int val)
+{
+	if (server->ops->revert_current_mid)
+		server->ops->revert_current_mid(server, val);
+}
+
+static inline void
+revert_current_mid_from_hdr(struct TCP_Server_Info *server,
+			    const struct smb2_sync_hdr *shdr)
+{
+	unsigned int num = le16_to_cpu(shdr->CreditCharge);
+
+	return revert_current_mid(server, num > 0 ? num : 1);
+}
+
 static inline __u16
 get_mid(const struct smb_hdr *smb)
 {
@@ -1422,6 +1440,7 @@ struct mid_q_entry {
 	struct kref refcount;
 	struct TCP_Server_Info *server;	/* server corresponding to this mid */
 	__u64 mid;		/* multiplex id */
+	__u16 credits;		/* number of credits consumed by this mid */
 	__u32 pid;		/* process id */
 	__u32 sequence_number;  /* for CIFS signing */
 	unsigned long when_alloc;  /* when mid was created */
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -219,6 +219,15 @@ smb2_get_next_mid(struct TCP_Server_Info
 	return mid;
 }
 
+static void
+smb2_revert_current_mid(struct TCP_Server_Info *server, const unsigned int val)
+{
+	spin_lock(&GlobalMid_Lock);
+	if (server->CurrentMid >= val)
+		server->CurrentMid -= val;
+	spin_unlock(&GlobalMid_Lock);
+}
+
 static struct mid_q_entry *
 smb2_find_mid(struct TCP_Server_Info *server, char *buf)
 {
@@ -3550,6 +3559,7 @@ struct smb_version_operations smb20_oper
 	.get_credits = smb2_get_credits,
 	.wait_mtu_credits = cifs_wait_mtu_credits,
 	.get_next_mid = smb2_get_next_mid,
+	.revert_current_mid = smb2_revert_current_mid,
 	.read_data_offset = smb2_read_data_offset,
 	.read_data_length = smb2_read_data_length,
 	.map_error = map_smb2_to_linux_error,
@@ -3645,6 +3655,7 @@ struct smb_version_operations smb21_oper
 	.get_credits = smb2_get_credits,
 	.wait_mtu_credits = smb2_wait_mtu_credits,
 	.get_next_mid = smb2_get_next_mid,
+	.revert_current_mid = smb2_revert_current_mid,
 	.read_data_offset = smb2_read_data_offset,
 	.read_data_length = smb2_read_data_length,
 	.map_error = map_smb2_to_linux_error,
@@ -3741,6 +3752,7 @@ struct smb_version_operations smb30_oper
 	.get_credits = smb2_get_credits,
 	.wait_mtu_credits = smb2_wait_mtu_credits,
 	.get_next_mid = smb2_get_next_mid,
+	.revert_current_mid = smb2_revert_current_mid,
 	.read_data_offset = smb2_read_data_offset,
 	.read_data_length = smb2_read_data_length,
 	.map_error = map_smb2_to_linux_error,
@@ -3846,6 +3858,7 @@ struct smb_version_operations smb311_ope
 	.get_credits = smb2_get_credits,
 	.wait_mtu_credits = smb2_wait_mtu_credits,
 	.get_next_mid = smb2_get_next_mid,
+	.revert_current_mid = smb2_revert_current_mid,
 	.read_data_offset = smb2_read_data_offset,
 	.read_data_length = smb2_read_data_length,
 	.map_error = map_smb2_to_linux_error,
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -576,6 +576,7 @@ smb2_mid_entry_alloc(const struct smb2_s
 		     struct TCP_Server_Info *server)
 {
 	struct mid_q_entry *temp;
+	unsigned int credits = le16_to_cpu(shdr->CreditCharge);
 
 	if (server == NULL) {
 		cifs_dbg(VFS, "Null TCP session in smb2_mid_entry_alloc\n");
@@ -586,6 +587,7 @@ smb2_mid_entry_alloc(const struct smb2_s
 	memset(temp, 0, sizeof(struct mid_q_entry));
 	kref_init(&temp->refcount);
 	temp->mid = le64_to_cpu(shdr->MessageId);
+	temp->credits = credits > 0 ? credits : 1;
 	temp->pid = current->pid;
 	temp->command = shdr->Command; /* Always LE */
 	temp->when_alloc = jiffies;
@@ -674,13 +676,18 @@ smb2_setup_request(struct cifs_ses *ses,
 	smb2_seq_num_into_buf(ses->server, shdr);
 
 	rc = smb2_get_mid_entry(ses, shdr, &mid);
-	if (rc)
+	if (rc) {
+		revert_current_mid_from_hdr(ses->server, shdr);
 		return ERR_PTR(rc);
+	}
+
 	rc = smb2_sign_rqst(rqst, ses->server);
 	if (rc) {
+		revert_current_mid_from_hdr(ses->server, shdr);
 		cifs_delete_mid(mid);
 		return ERR_PTR(rc);
 	}
+
 	return mid;
 }
 
@@ -695,11 +702,14 @@ smb2_setup_async_request(struct TCP_Serv
 	smb2_seq_num_into_buf(server, shdr);
 
 	mid = smb2_mid_entry_alloc(shdr, server);
-	if (mid == NULL)
+	if (mid == NULL) {
+		revert_current_mid_from_hdr(server, shdr);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
+		revert_current_mid_from_hdr(server, shdr);
 		DeleteMidQEntry(mid);
 		return ERR_PTR(rc);
 	}
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -647,6 +647,7 @@ cifs_call_async(struct TCP_Server_Info *
 	cifs_in_send_dec(server);
 
 	if (rc < 0) {
+		revert_current_mid(server, mid->credits);
 		server->sequence_number -= 2;
 		cifs_delete_mid(mid);
 	}
@@ -868,6 +869,7 @@ compound_send_recv(const unsigned int xi
 	for (i = 0; i < num_rqst; i++) {
 		midQ[i] = ses->server->ops->setup_request(ses, &rqst[i]);
 		if (IS_ERR(midQ[i])) {
+			revert_current_mid(ses->server, i);
 			for (j = 0; j < i; j++)
 				cifs_delete_mid(midQ[j]);
 			mutex_unlock(&ses->server->srv_mutex);
@@ -897,8 +899,10 @@ compound_send_recv(const unsigned int xi
 	for (i = 0; i < num_rqst; i++)
 		cifs_save_when_sent(midQ[i]);
 
-	if (rc < 0)
+	if (rc < 0) {
+		revert_current_mid(ses->server, num_rqst);
 		ses->server->sequence_number -= 2;
+	}
 
 	mutex_unlock(&ses->server->srv_mutex);
 



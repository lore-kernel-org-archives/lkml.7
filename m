Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E82C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0442173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412364;
	bh=s86Jh0s/SfejSfI6FfxGZlRqputgUZQPuS1LZ1e0VNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfY+CLxs7kxihYfnqJollGeuPbAZcOrrPMqcFWFVuMQN57zh39EDrnHvhTQtHrr6U
	 rxxIRw21ZBZk4PF9dqnR3yjtNqxFRQR/EBLD7HyoJi9GFSsLfwvrirKhYITDl7RnCP
	 1ymhjeuF8kvMJI5vl5Xr978qNVIR8wOLVPhKBU9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfCLRQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbfCLRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:24 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8733F217D4;
        Tue, 12 Mar 2019 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410923;
        bh=s86Jh0s/SfejSfI6FfxGZlRqputgUZQPuS1LZ1e0VNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJ+K4d1FRY4RyNLQ7EkOF+7Lo274CAQGLzlO6XWg+/+s/qykVJEEpO+T/cKZ0117n
         hF+oR17CV0OdbNieUgxkQhJjOjXANJJFqrkWpEHwwbAKuCysaNHHMF36dh+MmkrF4I
         ZWWR3l4ZHvmmYk2trlbCHvUgnQzTokr94tKcVg28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.19 143/149] cifs: allow calling SMB2_xxx_free(NULL)
Date:   Tue, 12 Mar 2019 10:09:21 -0700
Message-Id: <20190312170401.279894701@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 32a1fb36f6e50183871c2c1fcf5493c633e84732 upstream.

Change these free functions to allow passing NULL as the argument and
treat it as a no-op just like free(NULL) would.
Or, if rqst->rq_iov is NULL.

The second scenario could happen for smb2_queryfs() if the call
to SMB2_query_info_init() fails and we go to qfs_exit to clean up
and free all resources.
In that case we have not yet assigned rqst[2].rq_iov and thus
the rq_iov dereference in SMB2_close_free() will cause a NULL pointer
dereference.

[ bp: upstream patch also fixes SMB2_set_info_free which was introduced in 4.20 ]

Fixes:  1eb9fb52040f ("cifs: create SMB2_open_init()/SMB2_open_free() helpers")

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2243,10 +2243,12 @@ SMB2_open_free(struct smb_rqst *rqst)
 {
 	int i;
 
-	cifs_small_buf_release(rqst->rq_iov[0].iov_base);
-	for (i = 1; i < rqst->rq_nvec; i++)
-		if (rqst->rq_iov[i].iov_base != smb2_padding)
-			kfree(rqst->rq_iov[i].iov_base);
+	if (rqst && rqst->rq_iov) {
+		cifs_small_buf_release(rqst->rq_iov[0].iov_base);
+		for (i = 1; i < rqst->rq_nvec; i++)
+			if (rqst->rq_iov[i].iov_base != smb2_padding)
+				kfree(rqst->rq_iov[i].iov_base);
+	}
 }
 
 int
@@ -2535,7 +2537,8 @@ SMB2_close_init(struct cifs_tcon *tcon,
 void
 SMB2_close_free(struct smb_rqst *rqst)
 {
-	cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
+	if (rqst && rqst->rq_iov)
+		cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
 }
 
 int
@@ -2685,7 +2688,8 @@ SMB2_query_info_init(struct cifs_tcon *t
 void
 SMB2_query_info_free(struct smb_rqst *rqst)
 {
-	cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
+	if (rqst && rqst->rq_iov)
+		cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
 }
 
 static int



Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3229C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B962075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370956;
	bh=XcFrHLG3c2mR/DNZwpCrOvZNlQ5NA+MgCR6kU81BqPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCqeLOpvTYPQ3mnMBis4Vyq/PLQCErjWDvP5KH72YLTWjnD3Jpgnrvwoz/2qBDji5
	 PEu+m9XEN359UWSRKoxckrHUDQkGavMmsoY7nMsuXFp2Y64Ywf9T2Bpo/f5IzJQJ1a
	 1V4L2n9LLnyV9lwVINAF/wpHkcZW4+Ay0vBNWRUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfDDJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbfDDJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:01:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB81721741;
        Thu,  4 Apr 2019 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368480;
        bh=XcFrHLG3c2mR/DNZwpCrOvZNlQ5NA+MgCR6kU81BqPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUiE4CaCv3HgJtpH+QKVIlbWxmo1sVmhUl2t2VhjHNflfv9v0uuk7CY27EvBCJ/Gk
         YgPPVFxoER3yTl47zOe8katsi1rBaa+Mc++sfmyhgAe6n2f2InMgN5hiZD11PRUOv9
         djLDQnU7EMn3b+C1+iCaUOKok0LGaPXYtleG48sA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/187] cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPORTED
Date:   Thu,  4 Apr 2019 10:46:16 +0200
Message-Id: <20190404084604.918847946@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

[ Upstream commit 969ae8e8d4ee54c99134d3895f2adf96047f5bee ]

Old windows version or Netapp SMB server will return
NT_STATUS_NOT_SUPPORTED since they do not allow or implement
FSCTL_VALIDATE_NEGOTIATE_INFO. The client should accept the response
provided it's properly signed.

See
https://blogs.msdn.microsoft.com/openspecification/2012/06/28/smb3-secure-dialect-negotiation/

and

MS-SMB2 validate negotiate response processing:
https://msdn.microsoft.com/en-us/library/hh880630.aspx

Samba client had already handled it.
https://bugzilla.samba.org/attachment.cgi?id=13285&action=edit

Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 3d0db37d64ad..71f32d983384 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -881,8 +881,14 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
 		(char *)pneg_inbuf, inbuflen, (char **)&pneg_rsp, &rsplen);
-
-	if (rc != 0) {
+	if (rc == -EOPNOTSUPP) {
+		/*
+		 * Old Windows versions or Netapp SMB server can return
+		 * not supported error. Client should accept it.
+		 */
+		cifs_dbg(VFS, "Server does not support validate negotiate\n");
+		return 0;
+	} else if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
 		rc = -EIO;
 		goto out_free_inbuf;
-- 
2.19.1




Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE31C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E48520840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922684;
	bh=dzU4Naa1BU9a6lDIQVkvDeJjFIH9R7FRWsW9clpnOqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hiYSUL+Yo1e/5oqTFijitFs2BpzQsFsANWWTI1XOBFKw6Fuk02HGrtdY9sz6c9uqO
	 HzTIoUdKHwadLSBoxYTy3AivuhjyrQxBY4XtX7PhyONJWDfDCVKi1Prd3KrifJ3qqv
	 dA/qp+oITUWq0fRrSXM8Wlj/k/4ketAZUynvXGUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfFGPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732203AbfFGPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7DE820657;
        Fri,  7 Jun 2019 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922646;
        bh=dzU4Naa1BU9a6lDIQVkvDeJjFIH9R7FRWsW9clpnOqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPhce/0kCqSCDoxBQXa0lVe0gMeN4xyDC+bmFhbFlJPi16mLu+xh5zqaW1FuH3xlm
         8h0OyABJy0QPOa6u4FaA/dQSX2SV+zlEr7b3GS9+ACGiLsZEq9s/aEoGes8LzdMkSu
         w3aWeRZ5f97kIJN29NfvbHtLOTJs1o1yH92GxWCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.1 67/85] cifs: fix memory leak of pneg_inbuf on -EOPNOTSUPP ioctl case
Date:   Fri,  7 Jun 2019 17:39:52 +0200
Message-Id: <20190607153856.681728320@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 210782038b54ec8e9059a3c12d6f6ae173efa3a9 upstream.

Currently in the case where SMB2_ioctl returns the -EOPNOTSUPP error
there is a memory leak of pneg_inbuf. Fix this by returning via
the out_free_inbuf exit path that will perform the relevant kfree.

Addresses-Coverity: ("Resource leak")
Fixes: 969ae8e8d4ee ("cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPORTED")
CC: Stable <stable@vger.kernel.org> # v5.1+
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1013,7 +1013,8 @@ int smb3_validate_negotiate(const unsign
 		 * not supported error. Client should accept it.
 		 */
 		cifs_dbg(VFS, "Server does not support validate negotiate\n");
-		return 0;
+		rc = 0;
+		goto out_free_inbuf;
 	} else if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
 		rc = -EIO;



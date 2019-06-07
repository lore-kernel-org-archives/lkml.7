Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E8FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B1A214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922344;
	bh=JyX84JqCTKs45PfWeKpnmGa2HeJsO7bMDBIhYz7qQaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0PuBTCU72Rn1xgc8r93cunKKL7tVrps/xCx2csF6i2BKq9yBB9J2Si/AkoRxLCBk
	 WMkJgoeQtoAX5wpYvK9izeoyMignESnVHDn1gEbM6DseN0p+cXpd4gtaudixz2Y90h
	 SKR96rk0SGjRs3JMzvS0+bzqEk4lW6oSWreH0LYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfFGPpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfFGPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:45:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A9D2146E;
        Fri,  7 Jun 2019 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922338;
        bh=JyX84JqCTKs45PfWeKpnmGa2HeJsO7bMDBIhYz7qQaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMxjctYjJtoD0qQBoygY7v1vbRhUt9VeMhe488+xQgYGTJCtiVd5XboDaU8WKBE0M
         CKzSvZyjajnVqCECAjymyRuG5Sb1X95NMBIqsQxJuLEbIjhDWRA/kD3LqzXYJniBO1
         o5FP3h8z5cCn1ooZ4mIrd7evfVCRHR8st3QSkbTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 52/73] cifs: fix memory leak of pneg_inbuf on -EOPNOTSUPP ioctl case
Date:   Fri,  7 Jun 2019 17:39:39 +0200
Message-Id: <20190607153854.878421027@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
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
@@ -887,7 +887,8 @@ int smb3_validate_negotiate(const unsign
 		 * not supported error. Client should accept it.
 		 */
 		cifs_dbg(VFS, "Server does not support validate negotiate\n");
-		return 0;
+		rc = 0;
+		goto out_free_inbuf;
 	} else if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
 		rc = -EIO;



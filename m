Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2206C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659572077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127031;
	bh=BJpjWrulrbJR5wn8zEMd2Fgf4wYFCG/auu6n56H0ARw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHIqmQ3rlvBdL24J6bMr584gNQxuWdIKWoNwULb4f7dEaV7KkwJY3+/CGEl52R9Np
	 M/QnUcIu9vmiMvOQvo6fLHzcs0e4b+jp73fExy2gYAs/GHO9TDCZYosNytJOC+qNWs
	 24mwnsExlDFBK0VR9nFtYrwmPTw1Yk8sHBZnkMfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfDXRaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390982AbfDXRaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16FF2077C;
        Wed, 24 Apr 2019 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127023;
        bh=BJpjWrulrbJR5wn8zEMd2Fgf4wYFCG/auu6n56H0ARw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dANn7qymhjaAiOtdlHJly9s6uZieZEV0eP674yDj7nYiEu+S4LjJNc8rnQKQ6+Egk
         l4JSs5jQQg+5id5az9tE0pV12Bp0poRoPIaA1wyhLs63pR75JflP/Nti+C0MVo8qJN
         RT+1H9gz52iy/DlJPB2IIHHW0/ZyH4sI2GD3aWOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.19 31/96] cifs: fix handle leak in smb2_query_symlink()
Date:   Wed, 24 Apr 2019 19:09:36 +0200
Message-Id: <20190424170921.979543686@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit e6d0fb7b34f264f72c33053558a360a6a734905e upstream.

If we enter smb2_query_symlink() for something that is not a symlink
and where the SMB2_open() would succeed we would never end up
closing this handle and would thus leak a handle on the server.

Fix this by immediately calling SMB2_close() on successfull open.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1906,6 +1906,8 @@ smb2_query_symlink(const unsigned int xi
 
 	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, &err_iov,
 		       &resp_buftype);
+	if (!rc)
+		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	if (!rc || !err_iov.iov_base) {
 		rc = -ENOENT;
 		goto free_path;



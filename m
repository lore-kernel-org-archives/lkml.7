Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A854C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0749E206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780910;
	bh=0Uheibo8gkEs+/r+hVQolFVWe7Lgcf4cjKOOPLOcS0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P1ZLb5VoqkDFySpP6hAh6sv3UBTGFORCISxLGVUrakZytCiYv/57QDQQKIUveJbaa
	 kI/kSR0nYBhtT3mUx+flM7n9fYQzYhdQDtWtME/t4thEV2ce5z7M1dWh0SmiflqP0J
	 K4s/3AQk6WV5lR4s+r0YdiCHolEzHrv/L7fLLNjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfLSSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLSSlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:41:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C7424672;
        Thu, 19 Dec 2019 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780899;
        bh=0Uheibo8gkEs+/r+hVQolFVWe7Lgcf4cjKOOPLOcS0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkmZ+auCI/qqKdq0Y8F9AxqoHjaL/JP/9yFf8W3Kn1BGRaWcdjnlxi8/pEDsGNwqE
         4RPQu6GNeMMmQxMYeni+z91kDqnJEUbWBdtDfupZfzvBwkj2k0G4mU70d5k4h3Uvw6
         vOJjkqmIDiSdj2qAR4994tZlt5vjlOhJDWyGaA4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 154/162] CIFS: Respect O_SYNC and O_DIRECT flags during reconnect
Date:   Thu, 19 Dec 2019 19:34:22 +0100
Message-Id: <20191219183217.149492388@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 44805b0e62f15e90d233485420e1847133716bdc upstream.

Currently the client translates O_SYNC and O_DIRECT flags
into corresponding SMB create options when openning a file.
The problem is that on reconnect when the file is being
re-opened the client doesn't set those flags and it causes
a server to reject re-open requests because create options
don't match. The latter means that any subsequent system
call against that open file fail until a share is re-mounted.

Fix this by properly setting SMB create options when
re-openning files after reconnects.

Fixes: 1013e760d10e6: ("SMB3: Don't ignore O_SYNC/O_DSYNC and O_DIRECT flags")
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -703,6 +703,13 @@ cifs_reopen_file(struct cifsFileInfo *cf
 	if (backup_cred(cifs_sb))
 		create_options |= CREATE_OPEN_BACKUP_INTENT;
 
+	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
+	if (cfile->f_flags & O_SYNC)
+		create_options |= CREATE_WRITE_THROUGH;
+
+	if (cfile->f_flags & O_DIRECT)
+		create_options |= CREATE_NO_BUFFER;
+
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 



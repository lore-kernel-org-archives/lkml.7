Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E383E206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfD0P0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34934 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728267AbfD0P0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3D-0000z6-SF; Sat, 27 Apr 2019 16:15:39 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Q3-RF; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Steve French" <stfrench@microsoft.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.590234419@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 031/202] CIFS: Do not hide EINTR after sending
 network packets
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit ee13919c2e8d1f904e035ad4b4239029a8994131 upstream.

Currently we hide EINTR code returned from sock_sendmsg()
and return 0 instead. This makes a caller think that we
successfully completed the network operation which is not
true. Fix this by properly returning EINTR to callers.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -376,7 +376,7 @@ uncork:
 	if (rc < 0 && rc != -EINTR)
 		cifs_dbg(VFS, "Error %d sending data on socket to server\n",
 			 rc);
-	else
+	else if (rc > 0)
 		rc = 0;
 
 	return rc;


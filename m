Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A9820870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496115;
	bh=9lz0j7Dg9kHYcPRsVc6Xu+Ax0xEBjstIGrwUByaMt1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N3sXq9jyubzXp6eaOy8THkBamtiIBshSrJe9Hmu+MJHq8L2jZ0BxENA0ov/IjeJ+t
	 vwoM7NlgabbSWJIT8pUFNy5tW0kdzTF8koizxvye/Lh/pvRlylStJOYgba3YBWQa3o
	 uv86LwEsoE6u6iBgJD3kqBSuXIo7cBj94/rtWXTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfHVRse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391317AbfHVRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:27 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CF823400;
        Thu, 22 Aug 2019 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494547;
        bh=9lz0j7Dg9kHYcPRsVc6Xu+Ax0xEBjstIGrwUByaMt1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkwaVH8GlH7Fj541EgreIqKGGRw9BCtmUtJwNrkHNT1ljJ2zOhVNADaZCpOZQVeJY
         3rnd4mRFdIe4e3ID3NUwvadwTsbxGGSwkovZ3t8uKsN3ZFQ4yEdcFAEEw0IagfZwmx
         I7WoAqP1bE0e4JN3Xg1Sj6tV+zbpQTqotGrKVfWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.4 29/78] SMB3: Fix deadlock in validate negotiate hits reconnect
Date:   Thu, 22 Aug 2019 10:18:33 -0700
Message-Id: <20190822171832.888396613@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit e99c63e4d86d3a94818693147b469fa70de6f945 upstream.

Currently we skip SMB2_TREE_CONNECT command when checking during
reconnect because Tree Connect happens when establishing
an SMB session. For SMB 3.0 protocol version the code also calls
validate negotiate which results in SMB2_IOCL command being sent
over the wire. This may deadlock on trying to acquire a mutex when
checking for reconnect. Fix this by skipping SMB2_IOCL command
when doing the reconnect check.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -171,7 +171,7 @@ smb2_reconnect(__le16 smb2_command, stru
 	if (tcon == NULL)
 		return 0;
 
-	if (smb2_command == SMB2_TREE_CONNECT)
+	if (smb2_command == SMB2_TREE_CONNECT || smb2_command == SMB2_IOCTL)
 		return 0;
 
 	if (tcon->tidStatus == CifsExiting) {



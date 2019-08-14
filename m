Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98833C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802703;
	bh=WRLxgu5pjGZz8vXoOs3/zQIOrHQH6Ij/EdXN46H2njE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKIeBDxYDHr9JjS945tgbxsNsRka+ooP43UbHqDE0btjGRtEVa3bBnz83wzzNK3A2
	 Q6F7nyzyRenWe0hpLr19FjfpbHMSgrDmUksYw4JYxHnhbBzcskuqNqkB9S6mUFoM/P
	 4Zlsr5M0TDwDog7bWao35k3vXoCHy3GCbDkJz4NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfHNRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbfHNRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:11:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A162063F;
        Wed, 14 Aug 2019 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802700;
        bh=WRLxgu5pjGZz8vXoOs3/zQIOrHQH6Ij/EdXN46H2njE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP1TvyCMzkyfH21YwX8bXu/5pDHZZR6OlWlE4sDcUiRPO8fIAnRdBuZ5QSddf948+
         CYIFBDxBUkSdIgJSx511lsMS99vPc8FktWG7Cx0NQfvCh5kVflY+I2hyw1a1qlDolY
         9Hw/+E5FwEpvZRRpssJOwxLplGHCRybREe3X8yYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.19 83/91] SMB3: Fix deadlock in validate negotiate hits reconnect
Date:   Wed, 14 Aug 2019 19:01:46 +0200
Message-Id: <20190814165753.556737990@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
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
@@ -168,7 +168,7 @@ smb2_reconnect(__le16 smb2_command, stru
 	if (tcon == NULL)
 		return 0;
 
-	if (smb2_command == SMB2_TREE_CONNECT)
+	if (smb2_command == SMB2_TREE_CONNECT || smb2_command == SMB2_IOCTL)
 		return 0;
 
 	if (tcon->tidStatus == CifsExiting) {



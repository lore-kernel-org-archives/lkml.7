Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A20C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F340E208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802707;
	bh=QDR3h7FfOBFrr7zGv7KqXDw32Werc2p/sPczydszZDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tOEPQARZF+d7FPsRE3bu93EQSxeqE4JqhW8gZFg3fK+xJVNcZdbzTusYgUpG/pOCB
	 KeS6zmoW46dZ6o9jaOAI1j8cRdlDLYq6nCeKHu8Qvm6+QoLbQTgsv5QiONfunjfuzH
	 VftCov5vZIm9GGSoFzz0Bd0743AJxma3cAK/aIE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfHNRLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbfHNRLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:11:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F8E72063F;
        Wed, 14 Aug 2019 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802702;
        bh=QDR3h7FfOBFrr7zGv7KqXDw32Werc2p/sPczydszZDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdO8G9RW80mchy/JGXqAHayTyYp1UkvbJ+KEpEhJLLNjuHp3cPlcmin582aemLBri
         GT/LaEPPR6iLeBKT8oQ+CPfRPizsLNc5ywm3gCJx2ayj0GpwSBSEIXJKnDMdn8tOKj
         qzuFDcsUVI2SOmzGqkIzPL3W/YbWDihiUnR0LIc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.19 84/91] smb3: send CAP_DFS capability during session setup
Date:   Wed, 14 Aug 2019 19:01:47 +0200
Message-Id: <20190814165753.592414915@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 8d33096a460d5b9bd13300f01615df5bb454db10 upstream.

We had a report of a server which did not do a DFS referral
because the session setup Capabilities field was set to 0
(unlike negotiate protocol where we set CAP_DFS).  Better to
send it session setup in the capabilities as well (this also
more closely matches Windows client behavior).

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1006,7 +1006,12 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_
 	else
 		req->SecurityMode = 0;
 
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	req->Capabilities = cpu_to_le32(SMB2_GLOBAL_CAP_DFS);
+#else
 	req->Capabilities = 0;
+#endif /* DFS_UPCALL */
+
 	req->Channel = 0; /* MBZ */
 
 	sess_data->iov[0].iov_base = (char *)req;



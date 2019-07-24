Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7769C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033688;
	bh=mpHAlu1g6ATP9dASfPwGMVpV6BfbTPl75zysN1qbgMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGOQyXmDz1TXPpyA7poif+474AcscZCVHiCqabQL3AoSer53pA0udTSMIUMrufxKs
	 1+2RJB+h8IMrmxzVVwux+8mjLn9cFQELHqt1sSgjYLS9exwW51DlEkLEYzn1dUgjEW
	 N02eSieIWXEpmXshcqCMYsG7DZMnO9J5uP2IM/tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfGYFsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388125AbfGYFqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4C322C7D;
        Thu, 25 Jul 2019 05:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033598;
        bh=mpHAlu1g6ATP9dASfPwGMVpV6BfbTPl75zysN1qbgMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ujx9FsbXDx7yYKSBDq6D1qsuKEvRoJlptkFX2bHyn4cqDbxGpxh3L6HsuSBdXn4Hr
         /yyQMYRUBGB2ZKRfLgXddwBjnzh+9WG8Dzmrl9TLbe2tIHfWw/dCOnm+s0kQa7VCe+
         Rf55DZ4t037VTbTioA13vJT+jsvIzNTfTSbW8498=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Szymon Janc <szymon.janc@codecoup.pl>,
        Maarten Fonville <maarten.fonville@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 264/271] Bluetooth: Add SMP workaround Microsoft Surface Precision Mouse bug
Date:   Wed, 24 Jul 2019 21:22:13 +0200
Message-Id: <20190724191717.836063480@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szymon Janc <szymon.janc@codecoup.pl>

commit 1d87b88ba26eabd4745e158ecfd87c93a9b51dc2 upstream.

Microsoft Surface Precision Mouse provides bogus identity address when
pairing. It connects with Static Random address but provides Public
Address in SMP Identity Address Information PDU. Address has same
value but type is different. Workaround this by dropping IRK if ID
address discrepancy is detected.

> HCI Event: LE Meta Event (0x3e) plen 19
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 75
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E0:52:33:93:3B:21 (Static)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00

....

> ACL Data RX: Handle 75 flags 0x02 dlen 12
      SMP: Identity Address Information (0x09) len 7
        Address type: Public (0x00)
        Address: E0:52:33:93:3B:21

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Tested-by: Maarten Fonville <maarten.fonville@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199461
Cc: stable@vger.kernel.org
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/smp.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2580,6 +2580,19 @@ static int smp_cmd_ident_addr_info(struc
 		goto distribute;
 	}
 
+	/* Drop IRK if peer is using identity address during pairing but is
+	 * providing different address as identity information.
+	 *
+	 * Microsoft Surface Precision Mouse is known to have this bug.
+	 */
+	if (hci_is_identity_address(&hcon->dst, hcon->dst_type) &&
+	    (bacmp(&info->bdaddr, &hcon->dst) ||
+	     info->addr_type != hcon->dst_type)) {
+		bt_dev_err(hcon->hdev,
+			   "ignoring IRK with invalid identity address");
+		goto distribute;
+	}
+
 	bacpy(&smp->id_addr, &info->bdaddr);
 	smp->id_addr_type = info->addr_type;
 



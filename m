Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C38C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D123217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997337;
	bh=w5AmyS/nU/vxMXYmZ5E6sBsYQq1ZQJ10Hd9VtUp33kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddJ/PHoS23We3sw7tHWxX5qA8/qWhBR80clf245WQvOIMSRprFD7H7phCgCXUKhbX
	 j+p0qL0eVn6TnYv+OV6cXga1mubB9ILxYhMDQBFAYYnQiBXBV60I0GQoNteJhMsHpl
	 3G036HYXx+9/Qen+92kuD5xoAXH2fXdQTMEvUw7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbfGXTmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390326AbfGXTmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BA2217D4;
        Wed, 24 Jul 2019 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997333;
        bh=w5AmyS/nU/vxMXYmZ5E6sBsYQq1ZQJ10Hd9VtUp33kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVWZFbw+P5M6VtUkA8pbZ/loSK14dHP1XqREfn3kQDG1HHJwjmVNlU+XZvkBxINle
         ZOI5mVR0/qD9ASC8OItrDGvsz+vjmMiOFNrFxOy6n0n4u7jtT3jgtwQCeZETWV4oVU
         6jIihmNflqeB0fzs7L5RUACwBcuXYRL6WHpb/DPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Szymon Janc <szymon.janc@codecoup.pl>,
        Maarten Fonville <maarten.fonville@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.2 401/413] Bluetooth: Add SMP workaround Microsoft Surface Precision Mouse bug
Date:   Wed, 24 Jul 2019 21:21:32 +0200
Message-Id: <20190724191803.496577151@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
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
@@ -2579,6 +2579,19 @@ static int smp_cmd_ident_addr_info(struc
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
 



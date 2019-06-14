Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B202921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFNHX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:23:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59537 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfFNHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:23:56 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0000qV-R7; Fri, 14 Jun 2019 09:23:53 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0006Nl-3b; Fri, 14 Jun 2019 09:23:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/3] Bluetooth: hci_mrvl: Wait for final ack before switching baudrate
Date:   Fri, 14 Jun 2019 09:23:50 +0200
Message-Id: <20190614072351.17390-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614072351.17390-1-s.hauer@pengutronix.de>
References: <20190614072351.17390-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the Marvell HCI UART we have to upload two firmware files. The first
one is only for switching the baudrate of the device to a higher
baudrate. After the baudrate switching firmware has been uploaded the
device waits for a final ack (0x5a) before actually switching the
baudrate. To send this final ack with the old baudrate give the hci
ldisc workqueue a chance to run before switching the baudrate. Without
this the final ack will never be received by the device and firmware
upload fails.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/bluetooth/hci_mrvl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 50212ac629e3..a0a74362455e 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -339,6 +339,9 @@ static int mrvl_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
+	/* Let the final ack go out before switching the baudrate */
+	hci_uart_wait_until_sent(hu);
+
 	hci_uart_set_baudrate(hu, 3000000);
 	hci_uart_set_flow_control(hu, false);
 
-- 
2.20.1


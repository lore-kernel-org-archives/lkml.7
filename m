Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF16C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4090920665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Olxy8Ly/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGAU5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:57:48 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:46639 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbfGAU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:57:47 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45d07Y0TpWzPn4l;
        Mon,  1 Jul 2019 22:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1562014665; bh=0aD6zQiUuWWJu/DwB7y6TA5PeGr13/8BX82O+w/LOEE=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=Olxy8Ly/PUTpRCPrZiWFNpL1yJMJk1u02kSR0KZVPTXTyngDCzsSs11X2ywj6LxSe
         pV58gqI8lFAsAA+ubBM4Upn2BQVq3SnMvVnwVuj2WnEw+j5K7e2F8FP8Y2XzzaxJcq
         VKl43THuBzVNKqbStTsLVM5jMg3C7kzKJgQIGYYAIoNvxHZkPJPRQPrBYhz8udIWPY
         6VdeN5iV7NFrH4zLFC03O7RRjixqYQ2YSxNZCOxPp1XptgypAi3dp4+GxodSm+t1Oi
         b4MDyix/Lu+1FRJg2QLZUqLELT5Pcdc+HbY8fv0avZvUdL0fIhs0kjms6cVSzzcFQR
         eIKmvmUQkW/Zg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:702:6a00:4887:de4e:78a6:9b9c
Received: from laptop.fritz.box (p200300D507026A004887DE4E78A69B9C.dip0.t-ipconnect.de [IPv6:2003:d5:702:6a00:4887:de4e:78a6:9b9c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+aFOVk90gDIw0Br56ViaI5l8WyNKHpAw0=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45d07R0DPqzPkSM;
        Mon,  1 Jul 2019 22:57:38 +0200 (CEST)
From:   Fabian Schindlatz <fabian.schindlatz@fau.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        =?UTF-8?q?Thomas=20R=C3=B6thenbacher?= 
        <thomas.roethenbacher@fau.de>
Subject: [PATCH] bluetooth: hci_ll: Refactor download_firmware
Date:   Mon,  1 Jul 2019 22:57:13 +0200
Message-Id: <20190701205713.2833-1-fabian.schindlatz@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the new function send_command_from_firmware from
download_firmware, which helps with the readability of the switch
statement. This way the code is less deeply nested and also no longer
exceeds the 80 character limit.

Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
---
 drivers/bluetooth/hci_ll.c | 45 ++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c04f5f9e1ed0..12bc16edd043 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -474,6 +474,32 @@ static int read_local_version(struct hci_dev *hdev)
 	return err ? err : version;
 }
 
+static int send_command_from_firmware(struct ll_device *lldev,
+				      struct hci_command *cmd)
+{
+	struct sk_buff *skb;
+
+	if (cmd->opcode == HCI_VS_UPDATE_UART_HCI_BAUDRATE) {
+		/* ignore remote change
+		 * baud rate HCI VS command
+		 */
+		bt_dev_warn(lldev->hu.hdev,
+			    "change remote baud rate command in firmware");
+		return 0;
+	}
+	if (cmd->prefix != 1)
+		bt_dev_dbg(lldev->hu.hdev, "command type %d", cmd->prefix);
+
+	skb = __hci_cmd_sync(lldev->hu.hdev, cmd->opcode, cmd->plen,
+			     &cmd->speed, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(lldev->hu.hdev, "send command failed");
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+	return 0;
+}
+
 /**
  * download_firmware -
  *	internal function which parses through the .bts firmware
@@ -486,7 +512,6 @@ static int download_firmware(struct ll_device *lldev)
 	unsigned char *ptr, *action_ptr;
 	unsigned char bts_scr_name[40];	/* 40 char long bts scr name? */
 	const struct firmware *fw;
-	struct sk_buff *skb;
 	struct hci_command *cmd;
 
 	version = read_local_version(lldev->hu.hdev);
@@ -528,23 +553,9 @@ static int download_firmware(struct ll_device *lldev)
 		case ACTION_SEND_COMMAND:	/* action send */
 			bt_dev_dbg(lldev->hu.hdev, "S");
 			cmd = (struct hci_command *)action_ptr;
-			if (cmd->opcode == HCI_VS_UPDATE_UART_HCI_BAUDRATE) {
-				/* ignore remote change
-				 * baud rate HCI VS command
-				 */
-				bt_dev_warn(lldev->hu.hdev, "change remote baud rate command in firmware");
-				break;
-			}
-			if (cmd->prefix != 1)
-				bt_dev_dbg(lldev->hu.hdev, "command type %d", cmd->prefix);
-
-			skb = __hci_cmd_sync(lldev->hu.hdev, cmd->opcode, cmd->plen, &cmd->speed, HCI_INIT_TIMEOUT);
-			if (IS_ERR(skb)) {
-				bt_dev_err(lldev->hu.hdev, "send command failed");
-				err = PTR_ERR(skb);
+			err = send_command_from_firmware(lldev, cmd);
+			if (err)
 				goto out_rel_fw;
-			}
-			kfree_skb(skb);
 			break;
 		case ACTION_WAIT_EVENT:  /* wait */
 			/* no need to wait as command was synchronous */
-- 
2.19.1


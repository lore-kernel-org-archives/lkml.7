Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBCDC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D060F20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="KOKBO4yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFWVXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 17:23:30 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:42631 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbfFWVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 17:23:29 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 17:23:28 EDT
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45X4wX4BFdz8sbC;
        Sun, 23 Jun 2019 23:16:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561324572; bh=TvAWv5mAdSTHTCUznqhA0MpkCk410TmUpI3jPeG6N0s=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=KOKBO4ygoenPycEQ6wCeF+RTs9vjl8HgB6oVeU/S03a3itTQr3WgXngHlJoRH604L
         W5uUTS6/UJW3SW5aY1OH1mKYZUKEdlLB/y3s0MpyfyateFGovxQqSg4icvxntn3Ws7
         x20jpVtRcjr5gC1Sbu8wGvRy9nWy02SqZEQLy0VipDJED5nGCgONaQXFkZKwH7RNRR
         znbLC3NA/0yxnViuFp4YRvC4zuQSU1Ya4sZwdprV6JJS0uBLpMTagwjn4FjsmW8hsk
         sDtLiA1nPTHypDcLK4nC3xD5h41NTESS3P3FeisEYofN8ymXojPkr1VsaEJuRSaess
         P9sZbFjCa9A3w==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:702:6a00:f4f6:d397:1904:c079
Received: from laptop.fritz.box (p200300D507026A00F4F6D3971904C079.dip0.t-ipconnect.de [IPv6:2003:d5:702:6a00:f4f6:d397:1904:c079])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18QX5maE9gIFkEd6Z1+JPmLBSYaIwGxR+s=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45X4wV0X0rz8snq;
        Sun, 23 Jun 2019 23:16:10 +0200 (CEST)
From:   Fabian Schindlatz <fabian.schindlatz@fau.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        =?UTF-8?q?Thomas=20R=C3=B6thenbacher?= 
        <thomas.roethenbacher@fau.de>, linux-kernel@i4.cs.fau.de
Subject: [PATCH] bluetooth: Cleanup formatting and coding style
Date:   Sun, 23 Jun 2019 23:15:48 +0200
Message-Id: <20190623211548.1966-1-fabian.schindlatz@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some warnings and one error reported by checkpatch.pl:
- lines longer than 80 characters are wrapped
- empty lines inserted to separate variable declarations from the actual
  code
- line break inserted after if (...)

Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/bluetooth/bpa10x.c |  3 ++-
 drivers/bluetooth/hci_ll.c | 25 ++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index a346ccb5450d..a0e84538cec8 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -359,7 +359,8 @@ static int bpa10x_set_diag(struct hci_dev *hdev, bool enable)
 	return 0;
 }
 
-static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static int bpa10x_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)
 {
 	struct bpa10x_data *data;
 	struct hci_dev *hdev;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 3e767f245ed5..5ee221d06d65 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -141,6 +141,7 @@ static int ll_open(struct hci_uart *hu)
 
 	if (hu->serdev) {
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
+
 		if (!IS_ERR(lldev->ext_clk))
 			clk_prepare_enable(lldev->ext_clk);
 	}
@@ -175,6 +176,7 @@ static int ll_close(struct hci_uart *hu)
 
 	if (hu->serdev) {
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
+
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 
 		clk_disable_unprepare(lldev->ext_clk);
@@ -240,7 +242,8 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
 		break;
 	default:
 		/* any other state is illegal */
-		BT_ERR("received HCILL_WAKE_UP_IND in state %ld", ll->hcill_state);
+		BT_ERR("received HCILL_WAKE_UP_IND in state %ld",
+		       ll->hcill_state);
 		break;
 	}
 
@@ -269,7 +272,8 @@ static void ll_device_want_to_sleep(struct hci_uart *hu)
 
 	/* sanity check */
 	if (ll->hcill_state != HCILL_AWAKE)
-		BT_ERR("ERR: HCILL_GO_TO_SLEEP_IND in state %ld", ll->hcill_state);
+		BT_ERR("ERR: HCILL_GO_TO_SLEEP_IND in state %ld",
+		       ll->hcill_state);
 
 	/* acknowledge device sleep */
 	if (send_hcill_cmd(HCILL_GO_TO_SLEEP_ACK, hu) < 0) {
@@ -302,7 +306,8 @@ static void ll_device_woke_up(struct hci_uart *hu)
 
 	/* sanity check */
 	if (ll->hcill_state != HCILL_ASLEEP_TO_AWAKE)
-		BT_ERR("received HCILL_WAKE_UP_ACK in state %ld", ll->hcill_state);
+		BT_ERR("received HCILL_WAKE_UP_ACK in state %ld",
+		       ll->hcill_state);
 
 	/* send pending packets and change state to HCILL_AWAKE */
 	__ll_do_awake(ll);
@@ -351,7 +356,8 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		skb_queue_tail(&ll->tx_wait_q, skb);
 		break;
 	default:
-		BT_ERR("illegal hcill state: %ld (losing packet)", ll->hcill_state);
+		BT_ERR("illegal hcill state: %ld (losing packet)",
+		       ll->hcill_state);
 		kfree_skb(skb);
 		break;
 	}
@@ -451,6 +457,7 @@ static int ll_recv(struct hci_uart *hu, const void *data, int count)
 static struct sk_buff *ll_dequeue(struct hci_uart *hu)
 {
 	struct ll_struct *ll = hu->priv;
+
 	return skb_dequeue(&ll->txq);
 }
 
@@ -462,7 +469,8 @@ static int read_local_version(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading TI version information failed (%ld)",
 			   PTR_ERR(skb));
@@ -482,7 +490,8 @@ static int read_local_version(struct hci_dev *hdev)
 	version = le16_to_cpu(ver->lmp_subver);
 
 out:
-	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
+	if (err)
+		bt_dev_err(hdev, "Failed to read TI version info: %d", err);
 	kfree_skb(skb);
 	return err ? err : version;
 }
@@ -689,7 +698,9 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	serdev_device_set_drvdata(serdev, lldev);
 	lldev->serdev = hu->serdev = serdev;
 
-	lldev->enable_gpio = devm_gpiod_get_optional(&serdev->dev, "enable", GPIOD_OUT_LOW);
+	lldev->enable_gpio = devm_gpiod_get_optional(&serdev->dev,
+						     "enable",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(lldev->enable_gpio))
 		return PTR_ERR(lldev->enable_gpio);
 
-- 
2.20.1


Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133C02342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfH3WO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:14:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48559 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfH3WO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:14:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7UMEF4I012637, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (rsn1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7UMEF4I012637
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 31 Aug 2019 06:14:16 +0800
Received: from laptop-alex (59.63.203.251) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 06:14:15 +0800
Date:   Sat, 31 Aug 2019 06:13:56 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH v2 2/2] Bluetooth: btrtl: Add firmware version print
Message-ID: <20190830221356.GA9697@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [59.63.203.251]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

This patch is used to print fw version for debug convenience

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
Changes in v2
  - Re-order the code so that no forward declaration is needed

 drivers/bluetooth/btrtl.c | 56 ++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index b7487ab99eed..e32ef7c60a22 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -178,6 +178,27 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 	return &ic_id_table[i];
 }
 
+static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION failed (%ld)\n",
+			    PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION event length mismatch\n");
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
 static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 {
 	struct rtl_rom_version_evt *rom_version;
@@ -368,6 +389,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	int frag_len = RTL_FRAG_LEN;
 	int ret = 0;
 	int i;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *rp;
 
 	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
 	if (!dl_cmd)
@@ -406,6 +429,18 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		data += RTL_FRAG_LEN;
 	}
 
+	skb = btrtl_read_local_version(hdev);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		rtl_dev_err(hdev, "read local version failed");
+		goto out;
+	}
+
+	rp = (struct hci_rp_read_local_version *)skb->data;
+	rtl_dev_info(hdev, "rtl: fw version 0x%04x%04x",
+		     __le16_to_cpu(rp->hci_rev), __le16_to_cpu(rp->lmp_subver));
+	kfree_skb(skb);
+
 out:
 	kfree(dl_cmd);
 	return ret;
@@ -484,27 +519,6 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	return ret;
 }
 
-static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION failed (%ld)\n",
-			    PTR_ERR(skb));
-		return skb;
-	}
-
-	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
-		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION event length mismatch\n");
-		kfree_skb(skb);
-		return ERR_PTR(-EIO);
-	}
-
-	return skb;
-}
-
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	kfree(btrtl_dev->fw_data);
-- 
2.21.0


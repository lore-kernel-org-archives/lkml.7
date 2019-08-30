Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA35C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8721874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3MZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:25:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55690 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3MZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:25:22 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7UCPFGC027683, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7UCPFGC027683
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 30 Aug 2019 20:25:15 +0800
Received: from laptop-alex (172.29.36.155) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 20:05:45 +0800
Date:   Fri, 30 Aug 2019 20:05:30 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH 2/2] Bluetooth: btrtl: Add firmware version print
Message-ID: <20190830120530.GA3299@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.29.36.155]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

This patch is used to print fw version for debug convenience

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btrtl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index b7487ab99eed..7219eb98d02d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -151,6 +151,8 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8822b_config" },
 	};
 
+static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev);
+
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 					     u8 hci_ver, u8 hci_bus)
 {
@@ -368,6 +370,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	int frag_len = RTL_FRAG_LEN;
 	int ret = 0;
 	int i;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *rp;
 
 	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
 	if (!dl_cmd)
@@ -406,6 +410,18 @@ static int rtl_download_firmware(struct hci_dev *hdev,
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
-- 
2.21.0


Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F003C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103587;
	bh=E7EHSvLSZJd4GlOj41JTabPK+yrB+jUT8faqfwhNk9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ttJ7fN1dTl3pMC0/LxK5NyPx9QYq0/fHScyASM24m+WkcGnkSMMV6rLc6/fR7opJj
	 V7AbEgiDS6OoB6Ln7UR5Gnhs6LlVRLlkhRdjmqzPH3d6qnivNh7BD471elSc/D99DH
	 6tWeS1kUHJJlb44gKdY3WTQhMWhV3s4egzVuZuxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfH2SNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfH2SNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190FF23428;
        Thu, 29 Aug 2019 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102428;
        bh=E7EHSvLSZJd4GlOj41JTabPK+yrB+jUT8faqfwhNk9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DmZWkYkLy4Y4WnclpxLJz3C+adDj7wfkocSASRHun+cV/+3p159PEBdnrsMS+HOM
         Q2FEUwmPcWhE66U0JG3f5AW/DXoekPaPFJO9iqkHp6JnSIZcRcB/3KvZDrq3odELuB
         b41Yk+wgqLj1ztU0sqIHudkKhbbiFO0y4b8H3rUA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harish Bandi <c-hbandi@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 19/76] Bluetooth: hci_qca: Send VS pre shutdown command.
Date:   Thu, 29 Aug 2019 14:12:14 -0400
Message-Id: <20190829181311.7562-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harish Bandi <c-hbandi@codeaurora.org>

[ Upstream commit a2780889e247561744dd8efbd3478a1999b72ae3 ]

WCN399x chips are coex chips, it needs a VS pre shutdown
command while turning off the BT. So that chip can inform
BT is OFF to other active clients.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqca.c   | 21 +++++++++++++++++++++
 drivers/bluetooth/btqca.h   |  7 +++++++
 drivers/bluetooth/hci_qca.c |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 0ee5acb685a10..ee25e6ae1a098 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -99,6 +99,27 @@ static int qca_send_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err;
+
+	bt_dev_dbg(hdev, "QCA pre shutdown cmd");
+
+	skb = __hci_cmd_sync(hdev, QCA_PRE_SHUTDOWN_CMD, 0,
+				NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "QCA preshutdown_cmd failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
+
 static void qca_tlv_check_data(struct rome_config *config,
 				const struct firmware *fw)
 {
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index e9c9999596035..f2a9e576a86ce 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -13,6 +13,7 @@
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
+#define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
 
 #define EDL_CMD_REQ_RES_EVT		(0x00)
 #define EDL_PATCH_VER_RES_EVT		(0x19)
@@ -130,6 +131,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, u32 soc_ver);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+int qca_send_pre_shutdown_cmd(struct hci_dev *hdev);
 static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
 {
 	return soc_type == QCA_WCN3990 || soc_type == QCA_WCN3998;
@@ -161,4 +163,9 @@ static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
 {
 	return false;
 }
+
+static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f41fb2c02e4fd..d88b024eaf566 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1319,6 +1319,9 @@ static int qca_power_off(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 
+	/* Perform pre shutdown command */
+	qca_send_pre_shutdown_cmd(hdev);
+
 	qca_power_shutdown(hu);
 	return 0;
 }
-- 
2.20.1


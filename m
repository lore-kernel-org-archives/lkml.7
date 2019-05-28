Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F9EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DD208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKn0m+Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfE1Vn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:43:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34731 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfE1Vn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:43:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so137012pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VF/qoO5e2HVpIlhn/mmGk7lZp4pfCGkV4Ihi5vvSYDo=;
        b=IKn0m+Tk1bSnkFM9KxvqyXEuO7j86eRr9dYnyvU71UsJ/A0l6xAyLFmwwxvkDmQHke
         CmG0MqJz6jUo6PQ0hryGNd05youGUlz/4uc3Xd7LlY2+HQ2Hou40eDGwXvIf2pnCK2JN
         TTvbLgOnLPf0NnwQwZ89fEtw3aqy2cCd5vOac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VF/qoO5e2HVpIlhn/mmGk7lZp4pfCGkV4Ihi5vvSYDo=;
        b=Rr/SW1323S7GdhjOWMGfQyVYuwe43zjB1n8ERvgOrDz2IcM5OItfqAswaE8B0Ng3lE
         8TFtL0vzV4UyXV/D82P4zfzHJ5kaU3BZ9SOnoM2MekRTuFRBSQN4nm9aoLanQPXo4oWu
         r7hZ1X0pwGLdk+iSJsndPQx50iV8kPA+3UOKO2BmgNMxn9D1w0KpAD4WDFR1571w+Cvb
         fVR0KgMNyW223N1Q3nTOXOJTKFPSebM7HKc1+Gn7errh68IFcRyggGUE+w2dY5hmHipH
         QeM8ebRg5q8Rq/yieaaczW96P9DbRlQH/cNEHPnKQHCW3mHw9v7FKjvNm/3JupS5R4Ad
         3W+w==
X-Gm-Message-State: APjAAAVonO2vyRHgdV6eRLtR+xvrErmquYcV0HBzK9BIMbCP6EueiByB
        B2p9zRqvWx8S5DV8FuztEHAgGw==
X-Google-Smtp-Source: APXvYqzNnwHUdmFzAV7cj1qhRtUlHOZ7yJt8VDOR+MHPaHygtEyir13Kcuiz619o961D3hVZTbNCVw==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr40840014pgm.87.1559079808326;
        Tue, 28 May 2019 14:43:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h7sm9223657pfo.108.2019.05.28.14.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 14:43:27 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v9] Bluetooth: btqca: inject command complete event during fw download
Date:   Tue, 28 May 2019 14:43:22 -0700
Message-Id: <20190528214322.171922-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Latest qualcomm chips are not sending an command complete event for
every firmware packet sent to chip. They only respond with a vendor
specific event for the last firmware packet. This optimization will
decrease the BT ON time. Due to this we are seeing a timeout error
message logs on the console during firmware download. Now we are
injecting a command complete event once we receive an vendor specific
event for the last RAM firmware packet.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v9:
- define QCA_HCI_CC_SUCCESS (again)
- use QCA_HCI_CC_OPCODE instead of HCI_OP_NOP

Changes in v8:
- renamed QCA_HCI_CC_SUCCESS to QCA_HCI_CC_OPCODE
- use 0xFC00 as opcode of the injected event instead of 0
- added Matthias' tags from the v7 review
---
 drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h |  4 ++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cc12eecd9e4d..711ce526e03c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
 		 * In case VSE is skipped, only the last segment is acked.
 		 */
 		config->dnld_mode = tlv_patch->download_mode;
+		config->dnld_type = config->dnld_mode;
 
 		BT_DBG("Total Length           : %d bytes",
 		       le32_to_cpu(tlv_patch->total_size));
@@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
+static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
+{
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *evt;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->evt = HCI_EV_CMD_COMPLETE;
+	hdr->plen = sizeof(*evt) + 1;
+
+	evt = skb_put(skb, sizeof(*evt));
+	evt->ncmd = 1;
+	evt->opcode = QCA_HCI_CC_OPCODE;
+
+	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
+
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+
 static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
@@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
 		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
-			break;
+			goto out;
 
 		segment += segsize;
 	}
 
+	/* Latest qualcomm chipsets are not sending a command complete event
+	 * for every fw packet sent. They only respond with a vendor specific
+	 * event for the last packet. This optimization in the chip will
+	 * decrease the BT in initialization time. Here we will inject a command
+	 * complete event to avoid a command timeout error message.
+	 */
+	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
+	    config->dnld_type == ROME_SKIP_EVT_VSE))
+		return qca_inject_cmd_complete_event(hdev);
+
+out:
 	release_firmware(fw);
 
 	return ret;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 4c4fe2b5b7b7..718de9608ff1 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -41,6 +41,9 @@
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0
 
+#define QCA_HCI_CC_OPCODE		0xFC00
+#define QCA_HCI_CC_SUCCESS		0x00
+
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
@@ -82,6 +85,7 @@ struct rome_config {
 	char fwname[64];
 	uint8_t user_baud_rate;
 	enum rome_tlv_dnld_mode dnld_mode;
+	enum rome_tlv_dnld_mode dnld_type;
 };
 
 struct edl_event_hdr {
-- 
2.22.0.rc1.257.g3120a18244-goog


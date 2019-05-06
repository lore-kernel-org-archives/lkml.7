Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B13DC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F92054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qCkWo8H5";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qCkWo8H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEFOIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:08:51 -0400
Received: from node.akkea.ca ([192.155.83.177]:37944 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfEFOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:08:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id CD4D04E2056;
        Mon,  6 May 2019 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557151723; bh=RAeCpmhA4P7ycHXDF1WROtdWMKsl/rnfxBaRR1sAt80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qCkWo8H5NajrrfbeYj+gCGJYumhZ9B4QyqSrkX/AmZ3hxg56nAKtfxDGKxWx5lD3e
         P7R+8Nqkmb2TkMcYWfPjIA3t9dOVH2tfS77Z4nAyvK3dILo29KSW/I+4p7qumOIEaZ
         axjskErkVKsD26d1W8gleN7azKge/5vm7ZuZtuwY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PAci3R7UHMmz; Mon,  6 May 2019 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 0F2044E204B;
        Mon,  6 May 2019 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557151723; bh=RAeCpmhA4P7ycHXDF1WROtdWMKsl/rnfxBaRR1sAt80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qCkWo8H5NajrrfbeYj+gCGJYumhZ9B4QyqSrkX/AmZ3hxg56nAKtfxDGKxWx5lD3e
         P7R+8Nqkmb2TkMcYWfPjIA3t9dOVH2tfS77Z4nAyvK3dILo29KSW/I+4p7qumOIEaZ
         axjskErkVKsD26d1W8gleN7azKge/5vm7ZuZtuwY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 2/3] usb: typec: tcpm: Add functions to read the VBUS voltage
Date:   Mon,  6 May 2019 08:08:29 -0600
Message-Id: <20190506140830.25376-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506140830.25376-1-angus@akkea.ca>
References: <20190506140830.25376-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put some diagnostics in the tcpm log when there's an over
or under voltage situation.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/typec/tcpm/tcpci.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index c1f7073a56de..c6e0e48b9a2a 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -261,6 +261,39 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
 	return 0;
 }
 
+static int tcpci_get_vbus_voltage(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	u16 vbus_reg;
+	unsigned int vbus_voltage;
+	int ret, scale;
+
+	ret = tcpci_read16(tcpci, TCPC_VBUS_VOLTAGE, &vbus_reg);
+	if (ret < 0)
+		return ret;
+
+	vbus_voltage = vbus_reg & 0x3f;
+	switch ((ret >> 10) & 3) {
+	case 0:
+		scale = 1;
+		break;
+	case 1:
+		scale = 2;
+		break;
+	case 2:
+		scale = 4;
+		break;
+	case 3:
+		tcpm_log(tcpci->port, "invalid VBUS scale");
+		return -1;
+	}
+
+	if (scale != 1)
+		vbus_voltage *= scale;
+
+	return vbus_voltage;
+}
+
 static int tcpci_get_vbus(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -463,6 +496,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 	else if (status & TCPC_ALERT_TX_FAILED)
 		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
 
+	if (status & (TCPC_ALERT_V_ALARM_LO | TCPC_ALERT_V_ALARM_HI)) {
+		int ret;
+
+		ret = tcpci_get_vbus_voltage(&tcpci->tcpc);
+
+		if (IS_ERR(ret))
+			tcpm_log(tcpci->port, "Can't read VBUS voltage");
+		else
+			tcpm_log(tcpci->port, "Invalid VBUS voltage %d", ret);
+	}
+
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(tcpci_irq);
-- 
2.17.1


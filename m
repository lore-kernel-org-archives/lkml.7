Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8265C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832520C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8LO9ZO3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="LeWSofyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEHAkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:40:49 -0400
Received: from node.akkea.ca ([192.155.83.177]:43474 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfEHAks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:40:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0A16C4E2050;
        Wed,  8 May 2019 00:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557276048; bh=FgMbez4kMW0wjlFdZNKQ9TjLWgAyTOJ4vTmDZ70BusA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b8LO9ZO3BxdZwfMc4iyvuUDJSiR/CuuvhDm/DjCmADlr8peaqzk7QiSy6icxDSXeM
         x4T0DK+nRL/rEs84ZDTP/QfiZE5n/SC+Rp9gYna816JDkEoytZTdAaPIQTjLiWKLf4
         1iS2PEH5pHFWEXh9Xdh5Jr7FTjHjhi3oWN46dCw4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hTtW_R1dT7LI; Wed,  8 May 2019 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 012F04E204B;
        Wed,  8 May 2019 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557276047; bh=FgMbez4kMW0wjlFdZNKQ9TjLWgAyTOJ4vTmDZ70BusA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LeWSofyQZEzFkWf0+L0eN1obt5zQkeAYJCJ1RN0fWPpLGvUrtceOR4hBjma433FZK
         bkY6UQdArZXUpGp47RaSjrYV+iZZhZC3UOvc9H+dmpmpFn5F0UCP5n44mmUm1QsgCW
         vobaakV7bz3kjYfvJyQ2ERSd5BYjfb2duumaAKJw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 1/1] usb: typec: tcpci: add functions to read the VBUS voltage
Date:   Tue,  7 May 2019 18:40:27 -0600
Message-Id: <20190508004027.16558-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508004027.16558-1-angus@akkea.ca>
References: <20190508004027.16558-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show an error when the VBUS voltage is out of range.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/typec/tcpm/tcpci.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index a5746657b190..223941e11ef3 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -261,6 +261,26 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
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
+
+	scale = (vbus_reg >> 10) & 3;
+	if (scale == 3)
+		return -EIO;
+
+	return (vbus_voltage << scale) * 25;
+}
+
 static int tcpci_get_vbus(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -401,6 +421,7 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 irqreturn_t tcpci_irq(struct tcpci *tcpci)
 {
 	u16 status;
+	int ret;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
 
@@ -474,6 +495,20 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
 	}
 
+	if (status & (TCPC_ALERT_V_ALARM_LO | TCPC_ALERT_V_ALARM_HI)) {
+		ret = tcpci_get_vbus_voltage(&tcpci->tcpc);
+
+		if (ret >= 0) {
+			if (status & TCPC_ALERT_V_ALARM_LO)
+				dev_err(tcpci->dev, "Low VBUS voltage %d mV\n",
+						ret);
+
+			if (status & TCPC_ALERT_V_ALARM_HI)
+				dev_err(tcpci->dev, "High VBUS voltage %d mV\n",
+						ret);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(tcpci_irq);
-- 
2.17.1


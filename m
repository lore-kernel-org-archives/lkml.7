Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448BC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A8A205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZZcLaBmD";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZZcLaBmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEHAaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:30:04 -0400
Received: from node.akkea.ca ([192.155.83.177]:43178 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfEHAaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B32784E2050;
        Wed,  8 May 2019 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557275402; bh=kKw3PXSebbu1jSJsDkQQCAb+XJjRIcsDdg852RVfVgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZZcLaBmD7n10nCdaT2FpM/LbP0NwzibIHz0dFG/OyNX2tu+Q3ZDUqpDHaPMsFJBfk
         MtG0xKkb/L3GcPsFkWcTTpCRmPVV36S/J0ICpSaNQFLGWNWlarH3Erz+LAcxnsac7Q
         dHlsKhmUEglC8YIBC4TbdWZkvyqkBlkAbEyTS6BY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rm2Sfk5cR1u3; Wed,  8 May 2019 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 2C5E64E204B;
        Wed,  8 May 2019 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557275402; bh=kKw3PXSebbu1jSJsDkQQCAb+XJjRIcsDdg852RVfVgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZZcLaBmD7n10nCdaT2FpM/LbP0NwzibIHz0dFG/OyNX2tu+Q3ZDUqpDHaPMsFJBfk
         MtG0xKkb/L3GcPsFkWcTTpCRmPVV36S/J0ICpSaNQFLGWNWlarH3Erz+LAcxnsac7Q
         dHlsKhmUEglC8YIBC4TbdWZkvyqkBlkAbEyTS6BY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
Date:   Tue,  7 May 2019 18:27:49 -0600
Message-Id: <20190508002749.14816-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508002749.14816-1-angus@akkea.ca>
References: <20190508002749.14816-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the fault status register doesn't get cleared then
the ptn5110 interrupt gets stuck on. As the fault register gets
set everytime the ptn5110 powers on the interrupt is always stuck.

Fixes: fault status register stuck
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index c1f7073a56de..a5746657b190 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -463,6 +463,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 	else if (status & TCPC_ALERT_TX_FAILED)
 		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
 
+	if (status & TCPC_ALERT_FAULT) {
+		u16 fault_status;
+
+		tcpci_read16(tcpci, TCPC_FAULT_STATUS, &fault_status);
+
+		dev_warn(tcpci->dev, "FAULT ALERT status 0x%x\n", fault_status);
+
+		/* clear the fault status */
+		tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
+	}
+
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(tcpci_irq);
-- 
2.17.1


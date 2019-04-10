Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9509C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A99620874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsNCqSR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDJA6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:58:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38627 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfDJA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so659535wmc.3;
        Tue, 09 Apr 2019 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdjwEC5UZ5nLwnsGRtDKPuSdGfH49FK0iMI1xBTTo2k=;
        b=SsNCqSR3zpIzrZ/IQ15gOo42eyrXeOohizgKiGbjBLcymufUnaBhLXnZbNppWzDClk
         ErbEzKxGWOtSA8TsYQRwU+lQq5t8R1EDl89as0pFR1AnZHA1wbdSDEelr6sOivssTnxA
         Jdf+LAZB68Wd3CoTPeAVYryduj8qH52/2d5FQOQpSidH+I/ZkJo2qVGzVAzlDg/5pDZh
         GHbXlUFu9EylZLhuYVKlht/aAhsLE2eDAnTmHxTo31IJJWvnMbI3FaNDlC1N1LoTgl//
         OWH4QiPUwEF+o8sf0sw8KztvkWsSSYvjMdcliRxnhzqo0NkC96R7ipOWWtEYiw1LnuVu
         dFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdjwEC5UZ5nLwnsGRtDKPuSdGfH49FK0iMI1xBTTo2k=;
        b=VpfAVlwVg2/28r9fRlUTrkz8dnA0K/J4Ei+w7XZQICvZypOEV6sD2lr2Y5eu0j9NbT
         4/YwoU8TiOLSOnfxaZAHBMnWOIxWRp7TCTaVo6JADl8Xj/DPBH/g5CB1EwH3AQbHaoh7
         z1bxx/uldj4Wk3DDu00oCNTc3zVKvcqATO78GJssfrBCk+mp9MkHSaMQ7FPMrhsFyVE1
         VAZY68LvsOx97H1O1KRfU3WayvWW44b5Xn3tjO8ITp/+R8uWXQp/DPcf220syYFaKu6Y
         XSx2f9EnT8beX3LHK95ciDxb3MdT4lftslADzgUcFtSXk5+uZb2gKRQYEzudWB3TdT7c
         Bsyg==
X-Gm-Message-State: APjAAAVbgw033wPK367XV8yVjMi2YLt3NUG9CMIVbJcR1lNY2p/tBcst
        kmL1aZUfY3uP1fs+KLthp70=
X-Google-Smtp-Source: APXvYqxhJdkhD37qebbRd0CQl3qkl2+Cqztp9KSAPzd+AwIcrMsOUGpfVNLT3sUYKex+yyQDE9uYdQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr736454wmc.76.1554857862958;
        Tue, 09 Apr 2019 17:57:42 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:42 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 19/22] net: dsa: sja1105: Prevent PHY jabbering during switch reset
Date:   Wed, 10 Apr 2019 03:56:57 +0300
Message-Id: <20190410005700.31582-20-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resetting the switch at runtime is currently done while changing the
vlan_filtering setting (due to the required TPID change).

But reset is asynchronous with packet egress, and the switch core will
not wait for egress to finish before carrying on with the reset
operation.

As a result, a connected PHY such as the BCM5464 would see an
unterminated Ethernet frame and start to jabber (repeat the last seen
Ethernet symbols - jabber is by definition an oversized Ethernet frame
with bad FCS). This behavior is strange in itself, but it also causes
the MACs of some link partners (such as the FRDM-LS1012A) to completely
lock up.

So as a remedy for this situation, when switch reset is required, simply
inhibit Tx on all ports, and wait for the necessary time for the
eventual one frame left in the egress queue (not even the Tx inhibit
command is instantaneous) to be flushed.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
Patch is new.

 drivers/net/dsa/sja1105/sja1105.h     |  1 +
 drivers/net/dsa/sja1105/sja1105_spi.c | 37 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 3c16b991032c..9cea23ba2806 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -33,6 +33,7 @@ struct sja1105_regs {
 	u64 device_id;
 	u64 prod_id;
 	u64 status;
+	u64 port_control;
 	u64 rgu;
 	u64 config;
 	u64 rmii_pll1;
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index e4ef4d8048b2..aada5eeb4f49 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -10,6 +10,7 @@
 #define SIZE_SPI_MSG_HEADER	4
 #define SIZE_SPI_MSG_MAXLEN	(64 * 4)
 #define SPI_TRANSFER_SIZE_MAX	(SIZE_SPI_MSG_HEADER + SIZE_SPI_MSG_MAXLEN)
+#define SIZE_PORT_CTRL		4
 
 static int sja1105_spi_transfer(const struct sja1105_private *priv,
 				const void *tx, void *rx, int size)
@@ -278,6 +279,25 @@ static int sja1105_cold_reset(const struct sja1105_private *priv)
 	return priv->info->reset_cmd(priv, &reset);
 }
 
+static int sja1105_inhibit_tx(const struct sja1105_private *priv,
+			      const unsigned long *port_bitmap)
+{
+	const struct sja1105_regs *regs = priv->info->regs;
+	u64 inhibit_cmd;
+	int port, rc;
+
+	rc = sja1105_spi_send_int(priv, SPI_READ, regs->port_control,
+				  &inhibit_cmd, SIZE_PORT_CTRL);
+	if (rc < 0)
+		return rc;
+
+	for_each_set_bit(port, port_bitmap, SJA1105_NUM_PORTS)
+		inhibit_cmd |= BIT(port);
+
+	return sja1105_spi_send_int(priv, SPI_WRITE, regs->port_control,
+				    &inhibit_cmd, SIZE_PORT_CTRL);
+}
+
 struct sja1105_status {
 	u64 configs;
 	u64 crcchkl;
@@ -366,6 +386,7 @@ static_config_buf_prepare_for_upload(struct sja1105_private *priv,
 int sja1105_static_config_upload(struct sja1105_private *priv)
 {
 #define RETRIES 10
+	unsigned long port_bitmap = GENMASK_ULL(SJA1105_NUM_PORTS - 1, 0);
 	struct sja1105_static_config *config = &priv->static_config;
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct device *dev = &priv->spidev->dev;
@@ -384,6 +405,20 @@ int sja1105_static_config_upload(struct sja1105_private *priv)
 		dev_err(dev, "Invalid config, cannot upload\n");
 		return -EINVAL;
 	}
+	/* Prevent PHY jabbering during switch reset by inhibiting
+	 * Tx on all ports and waiting for current packet to drain.
+	 * Otherwise, the PHY will see an unterminated Ethernet packet.
+	 */
+	rc = sja1105_inhibit_tx(priv, &port_bitmap);
+	if (rc < 0) {
+		dev_err(dev, "Failed to inhibit Tx on ports\n");
+		return -ENXIO;
+	}
+	/* Wait for an eventual egress packet to finish transmission
+	 * (reach IFG). It is guaranteed that a second one will not
+	 * follow, and that switch cold reset is thus safe
+	 */
+	udelay(1000);
 	do {
 		/* Put the SJA1105 in programming mode */
 		rc = sja1105_cold_reset(priv);
@@ -449,6 +484,7 @@ struct sja1105_regs sja1105et_regs = {
 	.device_id = 0x0,
 	.prod_id = 0x100BC3,
 	.status = 0x1,
+	.port_control = 0x11,
 	.config = 0x020000,
 	.rgu = 0x100440,
 	.pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
@@ -473,6 +509,7 @@ struct sja1105_regs sja1105pqrs_regs = {
 	.device_id = 0x0,
 	.prod_id = 0x100BC3,
 	.status = 0x1,
+	.port_control = 0x12,
 	.config = 0x020000,
 	.rgu = 0x100440,
 	.pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
-- 
2.17.1


Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A9D20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWFkHuq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfDMB3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:29:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37592 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfDMB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so14161517wrm.4;
        Fri, 12 Apr 2019 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xzAaKljt2+1RJ377xnCnJnjqCMwvnQQGWu/E7UOhFA=;
        b=qWFkHuq47V99UWGlE8Z1NfunyYD2Ev1OUMeoLqrtb2uByfqTMGh0Lyhm65kBpFXdFS
         P7aldDBPktewlujIFonR/lx+CDSu0h0edvFZVbenYg++rmrOqepVM5ShghVRpCkpSgDk
         Yc1kaKpwj4O/9wuIaCLWBhc5JWjXHi5Jx60V3ohB2+hjXrJvbtRiVEgRQoUdsO954MHH
         rXS3XBIn4XpSmTSRQ18AVnqFRQZaKZaS24fxqQ5eoK0y7M6hklXa49j5p/6DkYJLQt4x
         yXPtt7GfaDLXsIRV4dkBcVoAzWFgEkGlTxOfy3Lv2TjK7eHRL5EYj4EbAjcCNaxn8g6k
         ifdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xzAaKljt2+1RJ377xnCnJnjqCMwvnQQGWu/E7UOhFA=;
        b=gbZl8zneMLrIbAn6U3VMphhx8DKN6mto5VY7uAKTTpR8yPTVOqnWDigGzzM4ZMMfEL
         Bz8u2Y0/NSq+b/A9sWfqq5NHx9tcJG0t1LcdKT/GuWiN3ngMOMGz0cXLZL0/yWVmZ0mF
         L+8igMJAsMEQ/V5FMFap/UYsuUn5M6turCRzTGNyDGouxJVxT6rfy/7CZz9ynqy7pr5+
         K5GKINzlsSTlg8kna/Yp7oOnn17AFj4HACw9n1H1LmdoqhLoKGgMS/9Z3o2/xLE3BzaE
         /ZBynshqoqSHWkvCcQneEBESzepwNg9jMFdXRMrl9L4LaJu0jdPAloiWWXXd+gYpd4Ka
         /HZg==
X-Gm-Message-State: APjAAAVBeYzTlmkrr1qtRJ2xw8Fqpw///BkaCEmdKAv0+0FV9QGJfGNC
        dlV2uPqZYJHA2DJrJ78yD3c=
X-Google-Smtp-Source: APXvYqz0NjfdAGQAXnmESM3rbkbVcyd44ROPpCg6KAIQz59IfKvi0CxXtfed2WzfSHcS4yNBqMplWg==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr7019866wrs.166.1555118935642;
        Fri, 12 Apr 2019 18:28:55 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:55 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 21/24] net: dsa: sja1105: Prevent PHY jabbering during switch reset
Date:   Sat, 13 Apr 2019 04:28:19 +0300
Message-Id: <20190413012822.30931-22-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
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
Changes in v3:
None.

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
index e4ef4d8048b2..622f7afcbf43 100644
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
+	usleep_range(500, 1000);
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


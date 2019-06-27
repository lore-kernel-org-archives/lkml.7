Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB99CC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B356A21852
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596022;
	bh=JW85fRvpHjlZwe3Bm/8XTkupFrwCYFNvP8zqp4uiOLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=voYyuhEs1uUlbKWAwdksEYDSMmCXoZd4x5xUtZIiNJDe7r4umBODHRm3NMNs7emHd
	 cjjB14qjBU8sPAFHee02mSN4teBIeEBdZEDk9dc/r+7+PzdwRVHHKEnUp4rVncoswR
	 DMas6BwT4P05bgZztskNWh8Cg93yGRkGQO/7yJAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfF0AkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfF0AkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:40:19 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F7621855;
        Thu, 27 Jun 2019 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596018;
        bh=JW85fRvpHjlZwe3Bm/8XTkupFrwCYFNvP8zqp4uiOLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLCfnpw2x/NgUVDNcyu16a99/apQCLOxdXdLnbP3rHz/kB1dPg6RZ/+nmjXKaRYxO
         76SiBGAXUwhucLlHiS5ilk9FnIENj9o/ZV8UD93a49xtU3bJypdFoFvpKeGCekXnZ4
         o/rd+iZ8o12m4H7958IALAkbAsX8y9i3D/Y0cLz4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/35] can: m_can: implement errata "Needless activation of MRAF irq"
Date:   Wed, 26 Jun 2019 20:39:03 -0400
Message-Id: <20190627003925.21330-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003925.21330-1-sashal@kernel.org>
References: <20190627003925.21330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 3e82f2f34c930a2a0a9e69fdc2de2f2f1388b442 ]

During frame reception while the MCAN is in Error Passive state and the
Receive Error Counter has thevalue MCAN_ECR.REC = 127, it may happen
that MCAN_IR.MRAF is set although there was no Message RAM access
failure. If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is
generated.

Work around:
The Message RAM Access Failure interrupt routine needs to check whether

    MCAN_ECR.RP = '1' and MCAN_ECR.REC = '127'.

In this case, reset MCAN_IR.MRAF. No further action is required.
This affects versions older than 3.2.0

Errata explained on Sama5d2 SoC which includes this hardware block:
http://ww1.microchip.com/downloads/en/DeviceDoc/SAMA5D2-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000803B.pdf
chapter 6.2

Reproducibility: If 2 devices with m_can are connected back to back,
configuring different bitrate on them will lead to interrupt storm on
the receiving side, with error "Message RAM access failure occurred".
Another way is to have a bad hardware connection. Bad wire connection
can lead to this issue as well.

This patch fixes the issue according to provided workaround.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/m_can/m_can.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d3ce904e929e..ebad93ac8f11 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -818,6 +818,27 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	if (!irqstatus)
 		goto end;
 
+	/* Errata workaround for issue "Needless activation of MRAF irq"
+	 * During frame reception while the MCAN is in Error Passive state
+	 * and the Receive Error Counter has the value MCAN_ECR.REC = 127,
+	 * it may happen that MCAN_IR.MRAF is set although there was no
+	 * Message RAM access failure.
+	 * If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated
+	 * The Message RAM Access Failure interrupt routine needs to check
+	 * whether MCAN_ECR.RP = ’1’ and MCAN_ECR.REC = 127.
+	 * In this case, reset MCAN_IR.MRAF. No further action is required.
+	 */
+	if ((priv->version <= 31) && (irqstatus & IR_MRAF) &&
+	    (m_can_read(priv, M_CAN_ECR) & ECR_RP)) {
+		struct can_berr_counter bec;
+
+		__m_can_get_berr_counter(dev, &bec);
+		if (bec.rxerr == 127) {
+			m_can_write(priv, M_CAN_IR, IR_MRAF);
+			irqstatus &= ~IR_MRAF;
+		}
+	}
+
 	psr = m_can_read(priv, M_CAN_PSR);
 	if (irqstatus & IR_ERR_STATE)
 		work_done += m_can_handle_state_errors(dev, psr);
-- 
2.20.1


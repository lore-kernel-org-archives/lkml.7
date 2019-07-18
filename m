Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A1C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EC20818
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419375;
	bh=S/h8bMj9dYlzLDIQkq5FX3kIwrthWQmwTA+B6FKzt/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G7qnV8XO+t/8kWrAMouQS2ao/6c9jvUN7EtyW0OERPmOXzBVGTAedrKcY7GKHV+dl
	 wB0lnj+2gOIfZK9txZHOv9NVXlSj/gCumTl+qsi4AuUx8xGwuCq8OwcYZnKDLL6RJs
	 p5eRRkPAFPxVVKn8uuEmTwWzGOxdXKWuLP3gfgJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfGRDJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390999AbfGRDJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:32 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AAB20818;
        Thu, 18 Jul 2019 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419371;
        bh=S/h8bMj9dYlzLDIQkq5FX3kIwrthWQmwTA+B6FKzt/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+d/x0jaAtvS+E/PMEG2c24YeOU7XlKAvJrgc5+JOMs44nUwoJVgKVH3b+hTSddbJ
         buBZn9ph8FvqzzVqSXIeh+yOHmqK1AAmi6uK0AHuUia0HHxb+Fd3mxJFwOkCLzppxf
         1V0tWsPxVcAVkZThahKzCMIZOpPbbnDQ4cRdcKik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/80] can: m_can: implement errata "Needless activation of MRAF irq"
Date:   Thu, 18 Jul 2019 12:01:10 +0900
Message-Id: <20190718030100.325995106@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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




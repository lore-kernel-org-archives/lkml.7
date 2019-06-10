Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA5C064EB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6147B207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403753AbfFJOOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:14:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40284 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390516AbfFJOOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:14:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 320542007DA;
        Mon, 10 Jun 2019 16:14:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48C0E2007D5;
        Mon, 10 Jun 2019 16:14:28 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F1B6A402FB;
        Mon, 10 Jun 2019 22:14:21 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 2/2] imx: mailbox: Introduce TX doorbell with ACK
Date:   Mon, 10 Jun 2019 22:16:09 +0800
Message-Id: <20190610141609.17559-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610141609.17559-1-daniel.baluta@nxp.com>
References: <20190610141609.17559-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

TX doorbell with ACK will allow us to push the doorbell ring button
(trigger GIR) and also will allow us to handle the response from DSP.

DSP firmware found on i.MX8 boards implements a duplex
communication protocol over MU channels.

On the host side (Linux) we need to plugin into Sound Open Firmware IPC
communication infrastructure which handles all the details (e.g message
queuing, tx/rx logic) [1] and the users are only required to provide the
following callbacks:

  - send_msg (for Tx)
  - irq_handler (Ack of Tx, request from DSP)

In order to implement send_msg and irq_handler we will use two MU
channels:
	* channel #0, TX doorbell with ACK
	* channel #1, RX doorbell

Sending a request Host -> DSP (channel #0)
  - send_msg callback
	- write data into SHMEM
	- push doorbell ring button (trigger GIR)
 - irq handler
	- handle DSP request (channel #1)
	  - read SHMEM and trigger SOF IPC state machine
	  - send ACK (push doorbell ring button for channel #1)
	- handle DSP response (ACK) (channel #0)
	  - read SHMEM and trigger IPC state machine

The easisest way to implement this is to directly access the MU
registers but since the MU is abstracted using the mailbox interface
we need to use that instead.

[1] https://elixir.bootlin.com/linux/v5.2-rc4/source/sound/soc/sof/ipc.c

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9f74dee1a58c..3a91611e17d2 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -42,6 +42,7 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_RX,		/* Rx */
 	IMX_MU_TYPE_TXDB,	/* Tx doorbell */
 	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
+	IMX_MU_TYPE_TXDB_ACK	/* Tx doorbell with Ack */
 };
 
 struct imx_mu_con_priv {
@@ -124,6 +125,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 			(ctrl & IMX_MU_xCR_RIEn(cp->idx));
 		break;
 	case IMX_MU_TYPE_RXDB:
+	case IMX_MU_TYPE_TXDB_ACK:
 		val &= IMX_MU_xSR_GIPn(cp->idx) &
 			(ctrl & IMX_MU_xCR_GIEn(cp->idx));
 		break;
@@ -200,6 +202,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_RXDB:
+	case IMX_MU_TYPE_TXDB_ACK:
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIEn(cp->idx), 0);
 		break;
 	default:
-- 
2.17.1


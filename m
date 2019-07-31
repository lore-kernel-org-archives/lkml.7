Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B42067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfGaUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:55:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfGaUzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:55:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE40B200AD1;
        Wed, 31 Jul 2019 22:55:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1020200065;
        Wed, 31 Jul 2019 22:55:41 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 60B13205F3;
        Wed, 31 Jul 2019 22:55:41 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, o.rempel@pengutronix.de,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] mailbox: imx: Fix Tx doorbell shutdown path
Date:   Wed, 31 Jul 2019 23:55:39 +0300
Message-Id: <20190731205539.13997-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tx doorbell is handled by txdb_tasklet and doesn't
have an associated IRQ.

Anyhow, imx_mu_shutdown ignores this and tries to
free an IRQ that wasn't requested for Tx DB resulting
in the following warning:

[    1.967644] Trying to free already-free IRQ 26
[    1.972108] WARNING: CPU: 2 PID: 157 at kernel/irq/manage.c:1708 __free_irq+0xc0/0x358
[    1.980024] Modules linked in:
[    1.983088] CPU: 2 PID: 157 Comm: kworker/2:1 Tainted: G
[    1.993524] Hardware name: Freescale i.MX8QXP MEK (DT)
[    1.998668] Workqueue: events deferred_probe_work_func
[    2.003812] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    2.008607] pc : __free_irq+0xc0/0x358
[    2.012364] lr : __free_irq+0xc0/0x358
[    2.016111] sp : ffff00001179b7e0
[    2.019422] x29: ffff00001179b7e0 x28: 0000000000000018
[    2.024736] x27: ffff000011233000 x26: 0000000000000004
[    2.030053] x25: 000000000000001a x24: ffff80083bec74d4
[    2.035369] x23: 0000000000000000 x22: ffff80083bec7588
[    2.040686] x21: ffff80083b1fe8d8 x20: ffff80083bec7400
[    2.046003] x19: 0000000000000000 x18: ffffffffffffffff
[    2.051320] x17: 0000000000000000 x16: 0000000000000000
[    2.056637] x15: ffff0000111296c8 x14: ffff00009179b517
[    2.061953] x13: ffff00001179b525 x12: ffff000011142000
[    2.067270] x11: ffff000011129f20 x10: ffff0000105da970
[    2.072587] x9 : 00000000ffffffd0 x8 : 0000000000000194
[    2.077903] x7 : 612065657266206f x6 : ffff0000111e7b09
[    2.083220] x5 : 0000000000000003 x4 : 0000000000000000
[    2.088537] x3 : 0000000000000000 x2 : 00000000ffffffff
[    2.093854] x1 : 28b70f0a2b60a500 x0 : 0000000000000000
[    2.099173] Call trace:
[    2.101618]  __free_irq+0xc0/0x358
[    2.105021]  free_irq+0x38/0x98
[    2.108170]  imx_mu_shutdown+0x90/0xb0
[    2.111921]  mbox_free_channel.part.2+0x24/0xb8
[    2.116453]  mbox_free_channel+0x18/0x28

This bug is present from the beginning of times.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes:  2bb7005696e2246 ("mailbox: Add support for i.MX messaging unit")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9f74dee1a58c..957c10c4e674 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -214,8 +214,10 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
 
-	if (cp->type == IMX_MU_TYPE_TXDB)
+	if (cp->type == IMX_MU_TYPE_TXDB) {
 		tasklet_kill(&cp->txdb_tasklet);
+		return;
+	}
 
 	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx) |
 		       IMX_MU_xCR_RIEn(cp->idx) | IMX_MU_xCR_GIEn(cp->idx));
-- 
2.17.1


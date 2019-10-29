Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4557CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E3F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbfJ2Onz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:43:55 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:57808 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfJ2Ony (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:43:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 2E88B23F3A5;
        Tue, 29 Oct 2019 15:43:52 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fHeggOj3nSBy; Tue, 29 Oct 2019 15:43:51 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 129D123F648;
        Tue, 29 Oct 2019 15:43:51 +0100 (CET)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Lars Poeschel <poeschel@lemonage.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Steve Winslow <swinslow@gmail.com>,
        netdev@vger.kernel.org (open list:NFC SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Johan Hovold <johan@kernel.org>, Simon Horman <horms@verge.net.au>
Subject: [PATCH v11 1/7] nfc: pn533: i2c: "pn532" as dt compatible string
Date:   Tue, 29 Oct 2019 15:43:14 +0100
Message-Id: <20191029144320.17718-2-poeschel@lemonage.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029144320.17718-1-poeschel@lemonage.de>
References: <20191029144320.17718-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is favourable to have one unified compatible string for devices that
have multiple interfaces. So this adds simply "pn532" as the devicetree
binding compatible string and makes a note that the old ones are
deprecated.

Cc: Johan Hovold <johan@kernel.org>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v10:
- Rebased the patch series on net-next 'Commit 503a64635d5e ("Merge
  branch 'DPAA-Ethernet-changes'")'

Changes in v9:
- Rebased the patch series on v5.4-rc2

Changes in v6:
- Rebased the patch series on v5.3-rc5

Changes in v3:
- This patch is new in v3

 drivers/nfc/pn533/i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 1832cd921ea7..1abd40398a5a 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -245,6 +245,11 @@ static int pn533_i2c_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id of_pn533_i2c_match[] = {
+	{ .compatible = "nxp,pn532", },
+	/*
+	 * NOTE: The use of the compatibles with the trailing "...-i2c" is
+	 * deprecated and will be removed.
+	 */
 	{ .compatible = "nxp,pn533-i2c", },
 	{ .compatible = "nxp,pn532-i2c", },
 	{},
-- 
2.23.0


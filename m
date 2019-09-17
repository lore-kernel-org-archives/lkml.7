Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37429C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0830B20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbfIQIN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:13:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46280 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfIQIN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:13:28 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8c0-0005RU-95; Tue, 17 Sep 2019 10:13:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, d.schultz@phytec.de,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com, tony.xie@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/4] mfd: rk808: fix rk817 powerkey integration
Date:   Tue, 17 Sep 2019 10:12:54 +0200
Message-Id: <20190917081256.24919-2-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081256.24919-1-heiko@sntech.de>
References: <20190917081256.24919-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwrkey integration seems to stem from the vendor kernel, as the
compatible is wrong and also the order of key-irqs is swapped.

So fix these issues to make the pwrkey on rk817 actually work.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/rk808.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 050478cabc95..966841744ee6 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -121,16 +121,8 @@ static struct resource rk817_rtc_resources[] = {
 };
 
 static struct resource rk805_key_resources[] = {
-	{
-		.start  = RK805_IRQ_PWRON_FALL,
-		.end    = RK805_IRQ_PWRON_FALL,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = RK805_IRQ_PWRON_RISE,
-		.end    = RK805_IRQ_PWRON_RISE,
-		.flags  = IORESOURCE_IRQ,
-	}
+	DEFINE_RES_IRQ(RK805_IRQ_PWRON_RISE),
+	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
 };
 
 static struct resource rk817_pwrkey_resources[] = {
@@ -167,7 +159,7 @@ static const struct mfd_cell rk817s[] = {
 	{ .name = "rk808-clkout",},
 	{ .name = "rk808-regulator",},
 	{
-		.name = "rk8xx-pwrkey",
+		.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
 		.resources = &rk817_pwrkey_resources[0],
 	},
-- 
2.20.1


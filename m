Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BC1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35152146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCTQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:57:23 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.164]:38624 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfCTQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:57:23 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id A2D8ACDD38
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:57:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6eWnhcPoviQer6eWnhQ5jn; Wed, 20 Mar 2019 11:57:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=54032 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6eWB-001qrp-Rd; Wed, 20 Mar 2019 11:57:20 -0500
Date:   Wed, 20 Mar 2019 11:56:43 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] regulator: axp20x: Mark expected switch fall-throughs
Message-ID: <20190320165643.GA3886@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6eWB-001qrp-Rd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:54032
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/regulator/axp20x-regulator.c: In function ‘axp20x_set_dcdc_freq’:
drivers/regulator/axp20x-regulator.c:1023:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   reg = AXP803_DCDC_FREQ_CTRL;
drivers/regulator/axp20x-regulator.c:1025:2: note: here
  case AXP806_ID:
  ^~~~
drivers/regulator/axp20x-regulator.c: In function ‘axp20x_set_dcdc_workmode’:
drivers/regulator/axp20x-regulator.c:1115:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   reg = AXP806_DCDC_MODE_CTRL2;
drivers/regulator/axp20x-regulator.c:1121:2: note: here
  case AXP221_ID:
  ^~~~

Notice that in this particular case, I moved the whole comment
"Fall through to the check below.", which contains the "Fall through"
comment, at the bottom of the case, which is what GCC is expecting
to find.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 07e10c8b0a22..152053361862 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1021,7 +1021,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		 * (See include/linux/mfd/axp20x.h)
 		 */
 		reg = AXP803_DCDC_FREQ_CTRL;
-		/* Fall through to the check below.*/
+		/* Fall through - to the check below.*/
 	case AXP806_ID:
 		/*
 		 * AXP806 also have DCDC work frequency setting register at a
@@ -1112,12 +1112,12 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		break;
 
 	case AXP806_ID:
-		reg = AXP806_DCDC_MODE_CTRL2;
 		/*
 		 * AXP806 DCDC regulator IDs have the same range as AXP22X.
-		 * Fall through to the check below.
 		 * (See include/linux/mfd/axp20x.h)
 		 */
+		reg = AXP806_DCDC_MODE_CTRL2;
+		 /* Fall through - to the check below. */
 	case AXP221_ID:
 	case AXP223_ID:
 	case AXP809_ID:
-- 
2.21.0


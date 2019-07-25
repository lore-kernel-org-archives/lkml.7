Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A711C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31B4218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfGYUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:34:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:64560 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfGYUeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:34:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 13:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="172821940"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2019 13:34:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E415C76; Thu, 25 Jul 2019 23:34:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] extcon: axp288: Use for_each_set_bit() in axp288_extcon_log_rsi()
Date:   Thu, 25 Jul 2019 23:34:05 +0300
Message-Id: <20190725203405.65523-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725203405.65523-1-andriy.shevchenko@linux.intel.com>
References: <20190725203405.65523-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies and standardizes axp288_extcon_log_rsi()
by using for_each_set_bit() library function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 4cbcc3b1aa6b..670334c362ac 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -121,7 +121,6 @@ static const char * const axp288_pwr_up_down_info[] = {
 	"Last shutdown caused by PMIC UVLO threshold",
 	"Last shutdown caused by SOC initiated cold off",
 	"Last shutdown caused by user pressing the power button",
-	NULL,
 };
 
 /*
@@ -130,20 +129,18 @@ static const char * const axp288_pwr_up_down_info[] = {
  */
 static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 {
-	const char * const *rsi;
 	unsigned int val, i, clear_mask = 0;
+	unsigned long bits;
 	int ret;
 
 	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
 	if (ret < 0)
 		return;
 
-	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
-		if (val & BIT(i)) {
-			dev_dbg(info->dev, "%s\n", *rsi);
-			clear_mask |= BIT(i);
-		}
-	}
+	bits = val & GENMASK(ARRAY_SIZE(axp288_pwr_up_down_info) - 1, 0);
+	for_each_set_bit(i, &bits, ARRAY_SIZE(axp288_pwr_up_down_info))
+		dev_dbg(info->dev, "%s\n", axp288_pwr_up_down_info[i]);
+	clear_mask = bits;
 
 	/* Clear the register value for next reboot (write 1 to clear bit) */
 	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
-- 
2.20.1


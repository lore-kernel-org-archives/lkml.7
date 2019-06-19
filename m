Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51AAC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFFC206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfFSMmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:42:16 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:34224 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727314AbfFSMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:42:15 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id BB/FA-01646-3AD2A0D5; Wed, 19 Jun 2019 12:42:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsVy8IPnUd3Fuly
  xBi2/JC2mPnzCZvFz0jQWi/tfjzJafLvSwWRxedccNgdWj52z7rJ7bFrVyeZx59oeNo9ntxex
  eHzeJBfAGsWamZeUX5HAmnFj43vWgrl2FWu6lrI3MB4y6WLk4hASWM8oMaVrBXsXIyeQUyFxv
  XMqE4jNJmAoMe/Ne0YQm0VAVWLlv/msILawQKjE08NzmEGaRQQmM0rMezWXDSTBLBArcX7eUh
  YQm1fAQWLX+ZVMELagxMmZT1ggaiQkDr54AdTMAbRMS2L5sUiQsISAvcT091fBwhIC+hKNx2I
  hwoYS32d9Y4GwzSX+fOtlnMDIPwvJ0FlIhi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKxromth
  qJdYpZukl1qqm5yaV1KUCJTUSywv1iuuzE3OSdHLSy3ZxAgM7ZRClsAdjE+OvNY7xCjJwaQky
  qv8gTNWiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSvrg5XrJBgUWp6akVaZg4wzmDSEhw8SiK82S
  Bp3uKCxNzizHSI1ClGXY6125csYhZiycvPS5US53XTBioSACnKKM2DGwGL+UuMslLCvIwMDAx
  CPAWpRbmZJajyrxjFORiVhHnvgkzhycwrgdv0CugIJqAjHi1lAzmiJBEhJdXA1Gngv1ZmU2jH
  TIsKoegVJ46wb3X1CNQ2Tdt2+mLFvy2J76va8gOuF6te8lrr0TO1PECS+VlCy3vlwlkalW9vq
  v8INC9v6I1PatD3PxsUfE55ooFU0mxtqbyTW5wuJ7n+vZ3k9JsvUerhuk+txU2H7532+O/Jd/
  ek8JP1zSU/uZQPFZezvGB9tba4NofLV+kA84UKDRmh9J/rEpdzKoXXZf/X+Wl0YVvjJf6zZRx
  sL3WXpN3v+FAu9/624bU/ifrxi4SC9ptpuTy3Zb3wMFxwpfHbDe0ch1ftTedYkPB0xScznusn
  BB39avK5Xr82KVhw0Jlhqqy7sD2n3ksR++cFJWIVK/VMnrE/KFWu7FdiKc5INNRiLipOBABfW
  RlhdAMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-6.tower-239.messagelabs.com!1560948130!480407!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25934 invoked from network); 19 Jun 2019 12:42:11 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-6.tower-239.messagelabs.com with AES128-SHA256 encrypted SMTP; 19 Jun 2019 12:42:11 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Jun 2019 13:42:09 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 BE6863FB35; Wed, 19 Jun 2019 13:42:09 +0100 (BST)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Wed, 19 Jun 2019 13:30:00 +0100
Subject: [PATCH V2] regulator: da9061/62: Adjust LDO voltage selection minimum
 value
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Felix Riemann <Felix.Riemann@sma.de>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190619124209.BE6863FB35@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 19/06/2019 10:27:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Riemann <felix.riemann@sma.de>

According to the DA9061 and DA9062 datasheets the LDO voltage selection
registers have a lower value of 0x02. This applies to voltage registers
VLDO1_A, VLDO2_A, VLDO3_A and VLDO4_A. This linear offset of 0x02 was
previously not observed by the driver, causing the LDO output voltage to
be systematically lower by two steps (= 0.1V).

This patch fixes the minimum linear selector offset by setting it to a
value of 2 and increases the n_voltages by the same amount allowing
voltages in the range 0x02 -> 0.9V to 0x38 -> 3.6V to be correctly
selected. Also fixes an incorrect calculaton for the n_voltages value in
the regulator LDO2.

These fixes effect all LDO regulators for DA9061 and DA9062.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Felix Riemann <felix.riemann@sma.de>
---

Hi Felix,

I have taken your previous patch, fixed the whitespace like we discussed
and updated the commit message to add more details. Also, I have
simplified your original patch slightly by using a single define in the
include file instead of repeating the same value for each LDO[1-4].

Finally, I added a minor typo fix which I found when calculating the
LDO2 n_voltages, there was a calculation of (3600-600)/50 instead of
(3600-900)/50.

I've finished my testing for DA9061 and DA9062 and so I've Acked your
patch and added a Tested-by tag. If you are happy with those changes to
your patch, I guess you can let the Maintainers take a look.

Regards,
Steve

 drivers/regulator/da9062-regulator.c | 40 +++++++++++++++++++++---------------
 include/linux/mfd/da9062/registers.h |  3 +++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a02e048..1cadaae 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -493,12 +493,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO1_CONT,
 		.desc.enable_mask = DA9062AA_LDO1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO1_A,
 		.desc.vsel_mask = DA9062AA_VLDO1_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO1_A,
 			__builtin_ffs((int)DA9062AA_LDO1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -525,12 +526,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (600))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO2_CONT,
 		.desc.enable_mask = DA9062AA_LDO2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO2_A,
 		.desc.vsel_mask = DA9062AA_VLDO2_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO2_A,
 			__builtin_ffs((int)DA9062AA_LDO2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -557,12 +559,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO3_CONT,
 		.desc.enable_mask = DA9062AA_LDO3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO3_A,
 		.desc.vsel_mask = DA9062AA_VLDO3_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO3_A,
 			__builtin_ffs((int)DA9062AA_LDO3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -589,12 +592,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO4_CONT,
 		.desc.enable_mask = DA9062AA_LDO4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO4_A,
 		.desc.vsel_mask = DA9062AA_VLDO4_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO4_A,
 			__builtin_ffs((int)DA9062AA_LDO4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -769,12 +773,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+							+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO1_CONT,
 		.desc.enable_mask = DA9062AA_LDO1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO1_A,
 		.desc.vsel_mask = DA9062AA_VLDO1_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO1_A,
 			__builtin_ffs((int)DA9062AA_LDO1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -801,12 +806,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (600))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+							+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO2_CONT,
 		.desc.enable_mask = DA9062AA_LDO2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO2_A,
 		.desc.vsel_mask = DA9062AA_VLDO2_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO2_A,
 			__builtin_ffs((int)DA9062AA_LDO2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -833,12 +839,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+							+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO3_CONT,
 		.desc.enable_mask = DA9062AA_LDO3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO3_A,
 		.desc.vsel_mask = DA9062AA_VLDO3_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO3_A,
 			__builtin_ffs((int)DA9062AA_LDO3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -865,12 +872,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+							+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO4_CONT,
 		.desc.enable_mask = DA9062AA_LDO4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO4_A,
 		.desc.vsel_mask = DA9062AA_VLDO4_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO4_A,
 			__builtin_ffs((int)DA9062AA_LDO4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/da9062/registers.h
index fe04b70..090213a 100644
--- a/include/linux/mfd/da9062/registers.h
+++ b/include/linux/mfd/da9062/registers.h
@@ -797,6 +797,9 @@
 #define DA9062AA_BUCK3_SL_A_SHIFT	7
 #define DA9062AA_BUCK3_SL_A_MASK	BIT(7)
 
+/* DA9062AA_VLDO[1-4]_A common */
+#define DA9062AA_VLDO_A_MIN_SEL		2
+
 /* DA9062AA_VLDO1_A = 0x0A9 */
 #define DA9062AA_VLDO1_A_SHIFT		0
 #define DA9062AA_VLDO1_A_MASK		0x3f
-- 
1.9.3


Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DCC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA3F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFSQfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:35:05 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:18958 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfFSQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:35:05 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 19/BA-04517-4346A0D5; Wed, 19 Jun 2019 16:35:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsVy8IPnUV2TFK5
  YgxtzlCymPnzCZvFz0jQWi/tfjzJafLvSwWRxedccNgdWj52z7rJ7bFrVyeZx59oeNo9ntxex
  eHzeJBfAGsWamZeUX5HAmrGn5yhLQbtVxc/Ok2wNjDMNuxg5OYQE1jNKdM+X72LkALIrJH4fS
  AEJswkYSsx7854RJMwioCqx61YZSFhYIFRi0vrZbF2MXBwiApMZJea9mssGkmAWiJU4P28pC4
  jNK+AgMfH/TiYIW1Di5MwnLBA1EhIHX7xghlilJbH8WCRIWELAXmL6+6tgYQkBfYnGY7EQYUO
  J77O+sUDY5hIfjnewTGDkn4Vk6CwkQxcwMq1itEgqykzPKMlNzMzRNTQw0DU0NNI1tLTQNTQz
  0Eus0k3SSy3VLU8tLtE11EssL9YrrsxNzknRy0st2cQIDOqUgmMLdjCuPfJa7xCjJAeTkiiv8
  gfOWCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvJHJXLFCgkWp6akVaZk5wAiDSUtw8CiJ8PYlAa
  V5iwsSc4sz0yFSpxh1OdZuX7KIWYglLz8vVUqcdzJIkQBIUUZpHtwIWLRfYpSVEuZlZGBgEOI
  pSC3KzSxBlX/FKM7BqCTMawlyCU9mXgncpldARzABHfFoKRvIESWJCCmpBqbdLzsyF61P4FOx
  yc2LLdx1rULbvH1OfeG+1RfqV7Bms3nVyO20dP53OPBn+KyD8TbWq4MW/T4R+7P88rWIin6/b
  7/4Nn5W827cbzIv0cfGb35MfQB3y3ExvQ4nDgZWdrG7Ln0SfzrLP9zdPDe69V3C5Koveb8STL
  JTEucXBbvEa7bfPvd/jS2v+t7Yzm/K5zYmKx9aqfH3vYX+coOKu6+Wrpc4oZm+VeHERvlN243
  fLrD+veaJk/eq1yd87qtMvFoRtvrOl2zNNba6dSHFx6tebmpkUD5p0zX59LcOlUM2Nxt3/Lun
  7PbpkfX+yW5rF2l9WaXU9z59zaMgxml3Z24J/L+0Nm75syM/rok3LEpQYinOSDTUYi4qTgQAf
  OFEgXEDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-17.tower-282.messagelabs.com!1560962100!1308001!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14632 invoked from network); 19 Jun 2019 16:35:00 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-17.tower-282.messagelabs.com with AES128-SHA256 encrypted SMTP; 19 Jun 2019 16:35:00 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Jun 2019 17:34:57 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 A35B73FB46; Wed, 19 Jun 2019 17:34:57 +0100 (BST)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Wed, 19 Jun 2019 17:35:00 +0100
Subject: [PATCH V3] regulator: da9061/62: Adjust LDO voltage selection minimum
 value
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Felix Riemann <Felix.Riemann@sma.de>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190619163457.A35B73FB46@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 19/06/2019 15:11:00
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
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Felix Riemann <felix.riemann@sma.de>
---

Hi Mark,

I've added my signed-off tag to the commit patch of V3.

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
@@ -801,12 +806,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -833,12 +839,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -865,12 +872,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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


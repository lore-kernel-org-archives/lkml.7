Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA06AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2920830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="QK9H5c43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfDJQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:15:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34139 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbfDJQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:15:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1856312pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Roy+djpL2n+HgFTlIySMAzSc4JBNM6+oEC9810Y0BXI=;
        b=QK9H5c43obw39onu0ixLHkok+2qGFJ/3v7Rm8fK72stecC2D4PPZ1KNHer42X3NxXM
         FcujZBZSLOlAbYY9Wy2swfsNNVSki8cVsryJ1NTR4ReKz8XTpdgTPKxd6YQ7MZitCiAs
         DMbvsSJEvDM/riWzyb5LmHR7aiL7n6B1lu5DdKsKfF+pjm0kAGvcmrPGq1L6qKfVFehN
         k7C1Gd2xtEozh9MkuS3Fb4k8DCUtbfdT4ZFoTwzS0qB+0nGuO1HloaQ3rNRzbgfHFHxg
         V2hB9J9O84hKBU3LPFo60kg1R23KKqccHfSLdEF/l/xSA3STrrQm6f3RFpI8g9xLCEuq
         nt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Roy+djpL2n+HgFTlIySMAzSc4JBNM6+oEC9810Y0BXI=;
        b=lRiFe2wu8NAZtdAY0wBFs+2PRmvDK5v1K2HR3CVyqt/ztnICr19ZBOy9YWjUqOGwTC
         HJyh20LAhebWMgDSdL6cHQ9JShoD9NZdjuaVhXPIDKMu1gAqIoWl45FHYX+FrpEyPPT+
         sibuQ4V09KMHD5K2SqxWBYaE72fhvTX+Ctb3LkUkVdVKpwZegJTKcbK5dyiujv33tLfD
         K6iqfgAACo/Y+TV3dEQRbM9k8HtMnodcuN5Yqgtghu766Nv2GzQ8jSA0iwA6WIFQ6Mf9
         RUH25ePDu11oGnWAxrh1jx96jByJwJzZI0Q0qal1TW7yzd4XfB4FWfeJtPxhm78iLYjs
         08Vw==
X-Gm-Message-State: APjAAAVecPgSpLB+60X5DBGLhwniRKYQYE8NQw2o62OrbKZYlywa78gY
        YFQugIXcb29WMqPYu06gu9goeA==
X-Google-Smtp-Source: APXvYqwn69oYk4WqMOTv+rQv9rlTU/4QoRsI1P7/+Aw7TE2YVQn0GeUxaLjyuBeVTq4KdIoKxk7QeA==
X-Received: by 2002:a63:e402:: with SMTP id a2mr42508951pgi.268.1554912901558;
        Wed, 10 Apr 2019 09:15:01 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id j5sm32310831pfe.15.2019.04.10.09.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:15:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421: Convert to use simplified DT parsing
Date:   Thu, 11 Apr 2019 00:14:27 +0800
Message-Id: <20190410161427.3394-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421-regulator.c | 208 ++++++++++-----------------
 1 file changed, 78 insertions(+), 130 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 259c3a865ac6..6c7ea4eb4bb0 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -78,43 +78,6 @@ enum hi6421_regulator_id {
 	HI6421_NUM_REGULATORS,
 };
 
-#define HI6421_REGULATOR_OF_MATCH(_name, id)				\
-{									\
-	.name = #_name,							\
-	.driver_data = (void *) HI6421_##id,				\
-}
-
-static struct of_regulator_match hi6421_regulator_match[] = {
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout0, LDO0),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout1, LDO1),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout2, LDO2),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout3, LDO3),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout4, LDO4),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout5, LDO5),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout6, LDO6),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout7, LDO7),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout8, LDO8),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout9, LDO9),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout10, LDO10),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout11, LDO11),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout12, LDO12),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout13, LDO13),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout14, LDO14),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout15, LDO15),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout16, LDO16),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout17, LDO17),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout18, LDO18),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout19, LDO19),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout20, LDO20),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout_audio, LDOAUDIO),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck0, BUCK0),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck1, BUCK1),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck2, BUCK2),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck3, BUCK3),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck4, BUCK4),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck5, BUCK5),
-};
-
 /* LDO 0, 4~7, 9~14, 16~20 have same voltage table. */
 static const unsigned int ldo_0_voltages[] = {
 	1500000, 1800000, 2400000, 2500000,
@@ -157,6 +120,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 #define HI6421_LDO_ENABLE_TIME (350)
 /*
  * _id - LDO id name string
+ * _match - of match name string
  * v_table - voltage table
  * vreg - voltage select register
  * vmask - voltage select mask
@@ -166,11 +130,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO(_id, v_table, vreg, vmask, ereg, emask,		\
+#define HI6421_LDO(_id, _match, v_table, vreg, vmask, ereg, emask,	\
 		   odelay, ecomask, ecoamp)				\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -191,6 +157,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 LDO1~3 are linear voltage regulators at fixed uV_step
  *
  * _id - LDO id name string
+ * _match - of match name string
  * _min_uV - minimum voltage supported in uV
  * n_volt - number of votages available
  * vstep - voltage increase in each linear step in uV
@@ -202,11 +169,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO_LINEAR(_id, _min_uV, n_volt, vstep, vreg, vmask,	\
+#define HI6421_LDO_LINEAR(_id, _match, _min_uV, n_volt, vstep, vreg, vmask,\
 			  ereg, emask, odelay, ecomask, ecoamp)		\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_linear_ops,	\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -228,6 +197,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 LDOAUDIO is a linear voltage regulator with two 4-step ranges
  *
  * _id - LDO id name string
+ * _match - of match name string
  * n_volt - number of votages available
  * volt_ranges - array of regulator_linear_range
  * vstep - voltage increase in each linear step in uV
@@ -239,11 +209,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO_LINEAR_RANGE(_id, n_volt, volt_ranges, vreg, vmask,	\
+#define HI6421_LDO_LINEAR_RANGE(_id, _match, n_volt, volt_ranges, vreg, vmask,\
 				ereg, emask, odelay, ecomask, ecoamp)	\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_linear_range_ops,	\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -265,6 +237,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 BUCK0/1/2 are linear voltage regulators at fixed uV_step
  *
  * _id - BUCK0/1/2 id name string
+ * _match - of match name string
  * vreg - voltage select register
  * vmask - voltage select mask
  * ereg - enable register
@@ -273,11 +246,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * etime - enable time
  * odelay - off/on delay time in uS
  */
-#define HI6421_BUCK012(_id, vreg, vmask, ereg, emask, sleepmask,	\
+#define HI6421_BUCK012(_id, _match, vreg, vmask, ereg, emask, sleepmask,\
 			etime, odelay)					\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_buck012_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -299,6 +274,7 @@ static const struct regulator_ops hi6421_buck345_ops;
  *  that it supports SLEEP mode, so has different .ops.
  *
  * _id - LDO id name string
+ * _match - of match name string
  * v_table - voltage table
  * vreg - voltage select register
  * vmask - voltage select mask
@@ -307,11 +283,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * odelay - off/on delay time in uS
  * sleepmask - mask of sleep mode
  */
-#define HI6421_BUCK345(_id, v_table, vreg, vmask, ereg, emask,		\
+#define HI6421_BUCK345(_id, _match, v_table, vreg, vmask, ereg, emask,	\
 			odelay, sleepmask)				\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_buck345_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -331,59 +309,63 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 regulator information */
 static struct hi6421_regulator_info
 		hi6421_regulator_info[HI6421_NUM_REGULATORS] = {
-	HI6421_LDO(LDO0, ldo_0_voltages, 0x20, 0x07, 0x20, 0x10,
+	HI6421_LDO(LDO0, hi6421_vout0, ldo_0_voltages, 0x20, 0x07, 0x20, 0x10,
 		   10000, 0x20, 8000),
-	HI6421_LDO_LINEAR(LDO1, 1700000, 4, 100000, 0x21, 0x03, 0x21, 0x10,
-			  10000, 0x20, 5000),
-	HI6421_LDO_LINEAR(LDO2, 1050000, 8, 50000, 0x22, 0x07, 0x22, 0x10,
-			  20000, 0x20, 8000),
-	HI6421_LDO_LINEAR(LDO3, 1050000, 8, 50000, 0x23, 0x07, 0x23, 0x10,
-			  20000, 0x20, 8000),
-	HI6421_LDO(LDO4, ldo_0_voltages, 0x24, 0x07, 0x24, 0x10,
+	HI6421_LDO_LINEAR(LDO1, hi6421_vout1, 1700000, 4, 100000, 0x21, 0x03,
+			  0x21, 0x10, 10000, 0x20, 5000),
+	HI6421_LDO_LINEAR(LDO2, hi6421_vout2, 1050000, 8, 50000, 0x22, 0x07,
+			  0x22, 0x10, 20000, 0x20, 8000),
+	HI6421_LDO_LINEAR(LDO3, hi6421_vout3, 1050000, 8, 50000, 0x23, 0x07,
+			  0x23, 0x10, 20000, 0x20, 8000),
+	HI6421_LDO(LDO4, hi6421_vout4, ldo_0_voltages, 0x24, 0x07, 0x24, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO5, ldo_0_voltages, 0x25, 0x07, 0x25, 0x10,
+	HI6421_LDO(LDO5, hi6421_vout5, ldo_0_voltages, 0x25, 0x07, 0x25, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO6, ldo_0_voltages, 0x26, 0x07, 0x26, 0x10,
+	HI6421_LDO(LDO6, hi6421_vout6, ldo_0_voltages, 0x26, 0x07, 0x26, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO7, ldo_0_voltages, 0x27, 0x07, 0x27, 0x10,
+	HI6421_LDO(LDO7, hi6421_vout7, ldo_0_voltages, 0x27, 0x07, 0x27, 0x10,
 		   20000, 0x20, 5000),
-	HI6421_LDO(LDO8, ldo_8_voltages, 0x28, 0x07, 0x28, 0x10,
+	HI6421_LDO(LDO8, hi6421_vout8, ldo_8_voltages, 0x28, 0x07, 0x28, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO9, ldo_0_voltages, 0x29, 0x07, 0x29, 0x10,
+	HI6421_LDO(LDO9, hi6421_vout9, ldo_0_voltages, 0x29, 0x07, 0x29, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO10, ldo_0_voltages, 0x2a, 0x07, 0x2a, 0x10,
+	HI6421_LDO(LDO10, hi6421_vout10, ldo_0_voltages, 0x2a, 0x07, 0x2a, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO11, ldo_0_voltages, 0x2b, 0x07, 0x2b, 0x10,
+	HI6421_LDO(LDO11, hi6421_vout11, ldo_0_voltages, 0x2b, 0x07, 0x2b, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO12, ldo_0_voltages, 0x2c, 0x07, 0x2c, 0x10,
+	HI6421_LDO(LDO12, hi6421_vout12, ldo_0_voltages, 0x2c, 0x07, 0x2c, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO13, ldo_0_voltages, 0x2d, 0x07, 0x2d, 0x10,
+	HI6421_LDO(LDO13, hi6421_vout13, ldo_0_voltages, 0x2d, 0x07, 0x2d, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO14, ldo_0_voltages, 0x2e, 0x07, 0x2e, 0x10,
+	HI6421_LDO(LDO14, hi6421_vout14, ldo_0_voltages, 0x2e, 0x07, 0x2e, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO15, ldo_8_voltages, 0x2f, 0x07, 0x2f, 0x10,
+	HI6421_LDO(LDO15, hi6421_vout15, ldo_8_voltages, 0x2f, 0x07, 0x2f, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO16, ldo_0_voltages, 0x30, 0x07, 0x30, 0x10,
+	HI6421_LDO(LDO16, hi6421_vout16, ldo_0_voltages, 0x30, 0x07, 0x30, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO17, ldo_0_voltages, 0x31, 0x07, 0x31, 0x10,
+	HI6421_LDO(LDO17, hi6421_vout17, ldo_0_voltages, 0x31, 0x07, 0x31, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO18, ldo_0_voltages, 0x32, 0x07, 0x32, 0x10,
+	HI6421_LDO(LDO18, hi6421_vout18, ldo_0_voltages, 0x32, 0x07, 0x32, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO19, ldo_0_voltages, 0x33, 0x07, 0x33, 0x10,
+	HI6421_LDO(LDO19, hi6421_vout19, ldo_0_voltages, 0x33, 0x07, 0x33, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO20, ldo_0_voltages, 0x34, 0x07, 0x34, 0x10,
+	HI6421_LDO(LDO20, hi6421_vout20, ldo_0_voltages, 0x34, 0x07, 0x34, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO_LINEAR_RANGE(LDOAUDIO, 8, ldo_audio_volt_range, 0x36,
-				0x70, 0x36, 0x01, 40000, 0x02, 5000),
-	HI6421_BUCK012(BUCK0, 0x0d, 0x7f, 0x0c, 0x01, 0x10, 400, 20000),
-	HI6421_BUCK012(BUCK1, 0x0f, 0x7f, 0x0e, 0x01, 0x10, 400, 20000),
-	HI6421_BUCK012(BUCK2, 0x11, 0x7f, 0x10, 0x01, 0x10, 350, 100),
-	HI6421_BUCK345(BUCK3, buck_3_voltages, 0x13, 0x07, 0x12, 0x01,
-		       20000, 0x10),
-	HI6421_BUCK345(BUCK4, buck_4_voltages, 0x15, 0x07, 0x14, 0x01,
-		       20000, 0x10),
-	HI6421_BUCK345(BUCK5, buck_5_voltages, 0x17, 0x07, 0x16, 0x01,
-		       20000, 0x10),
+	HI6421_LDO_LINEAR_RANGE(LDOAUDIO, hi6421_vout_audio, 8,
+				ldo_audio_volt_range, 0x36, 0x70, 0x36, 0x01,
+				40000, 0x02, 5000),
+	HI6421_BUCK012(BUCK0, hi6421_buck0, 0x0d, 0x7f, 0x0c, 0x01, 0x10, 400,
+		       20000),
+	HI6421_BUCK012(BUCK1, hi6421_buck1, 0x0f, 0x7f, 0x0e, 0x01, 0x10, 400,
+		       20000),
+	HI6421_BUCK012(BUCK2, hi6421_buck2, 0x11, 0x7f, 0x10, 0x01, 0x10, 350,
+		       100),
+	HI6421_BUCK345(BUCK3, hi6421_buck3, buck_3_voltages, 0x13, 0x07, 0x12,
+		       0x01, 20000, 0x10),
+	HI6421_BUCK345(BUCK4, hi6421_buck4, buck_4_voltages, 0x15, 0x07, 0x14,
+		       0x01, 20000, 0x10),
+	HI6421_BUCK345(BUCK5, hi6421_buck5, buck_5_voltages, 0x17, 0x07, 0x16,
+		       0x01, 20000, 0x10),
 };
 
 static int hi6421_regulator_enable(struct regulator_dev *rdev)
@@ -552,42 +534,14 @@ static const struct regulator_ops hi6421_buck345_ops = {
 	.set_mode = hi6421_regulator_buck_set_mode,
 };
 
-static int hi6421_regulator_register(struct platform_device *pdev,
-				     struct regmap *rmap,
-				     struct regulator_init_data *init_data,
-				     int id, struct device_node *np)
-{
-	struct hi6421_regulator_info *info = NULL;
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-
-	/* assign per-regulator data */
-	info = &hi6421_regulator_info[id];
-
-	config.dev = &pdev->dev;
-	config.init_data = init_data;
-	config.driver_data = info;
-	config.regmap = rmap;
-	config.of_node = np;
-
-	/* register regulator with framework */
-	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&pdev->dev, "failed to register regulator %s\n",
-			info->desc.name);
-		return PTR_ERR(rdev);
-	}
-
-	return 0;
-}
-
 static int hi6421_regulator_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *np;
-	struct hi6421_pmic *pmic;
+	struct hi6421_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct hi6421_regulator_pdata *pdata;
-	int i, ret = 0;
+	struct hi6421_regulator_info *info;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int i;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -595,27 +549,21 @@ static int hi6421_regulator_probe(struct platform_device *pdev)
 	mutex_init(&pdata->lock);
 	platform_set_drvdata(pdev, pdata);
 
-	np = of_get_child_by_name(dev->parent->of_node, "regulators");
-	if (!np)
-		return -ENODEV;
-
-	ret = of_regulator_match(dev, np,
-				 hi6421_regulator_match,
-				 ARRAY_SIZE(hi6421_regulator_match));
-	of_node_put(np);
-	if (ret < 0) {
-		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return ret;
-	}
-
-	pmic = dev_get_drvdata(dev->parent);
-
 	for (i = 0; i < ARRAY_SIZE(hi6421_regulator_info); i++) {
-		ret = hi6421_regulator_register(pdev, pmic->regmap,
-			hi6421_regulator_match[i].init_data, i,
-			hi6421_regulator_match[i].of_node);
-		if (ret)
-			return ret;
+		/* assign per-regulator data */
+		info = &hi6421_regulator_info[i];
+
+		config.dev = pdev->dev.parent;
+		config.driver_data = info;
+		config.regmap = pmic->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register regulator %s\n",
+				info->desc.name);
+			return PTR_ERR(rdev);
+		}
 	}
 
 	return 0;
-- 
2.17.1


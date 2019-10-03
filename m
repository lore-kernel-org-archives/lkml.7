Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65DAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HWSk7j1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfJCR53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:57:29 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:21177 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbfJCR53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570125449; x=1601661449;
  h=from:to:cc:subject:date:message-id;
  bh=pkEbGwSdXkO0KIhSu99LMDbsUKsuwPoaCTPTe9gqrwk=;
  b=HWSk7j1U6JenIhgPFXr4BCC44tzrvTMRxAjmemJSX14oaq6zxirF7c6u
   0Z1P4mcp+mrr3z1FTOvMXbtACZJypdD9fy8QntB72MlUPwdVV1X51I238
   jc348rTyyWfgHy3wyS3zmdD17H8M20MSY9COZlM2TvS+hEolbxJj/oVbG
   abU4gBb4wV0RwwzdjUoX8GpjX+jZJuzCr4rmcqQr23FvT+LXPvGpct87f
   GQO4umXoghg6dyTPJcsw0z5/rtd8pG4PWrOt4B2kgSgTNna4t7YWnLRE9
   Z51CQBA8vUXG4B1L44SZzlMl5imPqcemTwPQ5YMNVhL5fUZHxJOgU/sZU
   Q==;
IronPort-SDR: QVp5eCUYxHJyLdekHNu98Tiaw0+1vfMpDonW/H7l+QUgCHsbp13qPsu9/3D2tucHsy4YErw3wi
 QKqojbG6vl+YzI7wJBfY/KXd9/cgvcxTgB0KF8BxWdxaytqOizv206kHKdtO2yqWyV6Q2w1MBe
 LATV0i4aJNGFZM8sTCYgp67mNqRatcy47OR53SB/mzE7T6sqeBsTH5k874aay76B+YM7WAQIka
 Nry+d4B3Vqc3ONKq/G1flK3PgKyQzsVV93BBg9WyWkPe17KYlAW6i7KT78PTylrrESauTFet7+
 XNM=
IronPort-PHdr: =?us-ascii?q?9a23=3AzpLjXBS3115Rz0IO5k/MxTQXWtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69bRCN2/xhgRfzUJnB7Loc0qyK6vumBTxLuM/c+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLucQbgoRuJrssxh?=
 =?us-ascii?q?bJv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4O5bosPFPEBPeder4nyulAAswKwDhSiBOPu1DBIgmL51rA+3+?=
 =?us-ascii?q?kvDQ3K2QotFM8MvnvJttX4LKccX/6owqfGzjvNaOhb1Svh5IXSbhwsu+2AUa?=
 =?us-ascii?q?52fMHMyUcvDQTFjlCIpIPnPjOU1+QNs3Wc7+F9Uu+ui28mqwFrrTiu2ssglo?=
 =?us-ascii?q?fEi5kIyl/Y7yV12pg6KsClSENiZ9OvDZhetzmCOodoXs8vR3tktSU6x7Ecp5?=
 =?us-ascii?q?K3YTQGxI46yxPbaPGLa5WE7xPnWeqLPzt1inJodKihixuz60StyOLxW8+p21?=
 =?us-ascii?q?hQtCVFiMPDtnUV2hzW7ciIV+Vy81+62TaKywDT8uZEIV0olabDK54u3Lowlp?=
 =?us-ascii?q?0LvETGBCD2mUH2gLaOdkUq5+Sk8urnbqjiq5KfLYN0hQb+MqMhmsy7H+s0KB?=
 =?us-ascii?q?QBX2+e+eik1b3j+1P2QKlSg/EojqXUtIrWKMcbq6KjHQNZz5ov5wyiAzqi09?=
 =?us-ascii?q?kUhXwHI0hEeBKDgYjpIVbOIPXgAPa/glWskC1kx/HaMrH9DJjANWXDn6v7fb?=
 =?us-ascii?q?pn9UFT1RczwchF551IErEBPO7zWkjpudzcDx85NRG0wun+BNV+yIweQ2SPDb?=
 =?us-ascii?q?GdMK7Jr1+I6fwgI/OWaI8Wpjn9Mf4l6ODqjXMjnl8dZ6apjtM5cne9S8VnMU?=
 =?us-ascii?q?WEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H2CAAXNpZdgMbSVdFlHgEGEoFcCwK?=
 =?us-ascii?q?DXEwQjSSGKgEBAQaLJoEJhXqDC4UogXsBCAEBAQwBAS0CAQGEQIJIIzQJDgI?=
 =?us-ascii?q?DCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCQgEMAYFqKYM1CxYVUoEVAQUBNSI?=
 =?us-ascii?q?5gkcBgXYUBaIlgQM8jCUziGUBCQ2BSAkBCIEiAYc0hFmBEIEHg3Vsh2WCRAS?=
 =?us-ascii?q?BNwEBAZUrllIBBgKCERSBeJMUJ4Q8iT+LRAEtpy8CCgcGDyOBL4ISTSWBbAq?=
 =?us-ascii?q?BRFAQFIIHji4hM4EIgnONYgE?=
X-IPAS-Result: =?us-ascii?q?A2H2CAAXNpZdgMbSVdFlHgEGEoFcCwKDXEwQjSSGKgEBA?=
 =?us-ascii?q?QaLJoEJhXqDC4UogXsBCAEBAQwBAS0CAQGEQIJIIzQJDgIDCQEBBQEBAQEBB?=
 =?us-ascii?q?QQBAQIQAQEJDQkIJ4VCQgEMAYFqKYM1CxYVUoEVAQUBNSI5gkcBgXYUBaIlg?=
 =?us-ascii?q?QM8jCUziGUBCQ2BSAkBCIEiAYc0hFmBEIEHg3Vsh2WCRASBNwEBAZUrllIBB?=
 =?us-ascii?q?gKCERSBeJMUJ4Q8iT+LRAEtpy8CCgcGDyOBL4ISTSWBbAqBRFAQFIIHji4hM?=
 =?us-ascii?q?4EIgnONYgE?=
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="80046173"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 10:57:28 -0700
Received: by mail-pf1-f198.google.com with SMTP id i28so2649573pfq.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oo2H5flqAtdR7YUve6C3D77RQl9Z9syaV+vQooiIMr4=;
        b=CCxYCiuuYAL7wAOdcJ+dJW4cmpJ3+6FzjuzoW0Hz4zCPGG61f6wLQ9YQOW0OZByliD
         mPAegNsqKIEy9K3jWrDo3wsCGu5SkrNwp0MK897BWbYw5oPLJ/hyzR3cIPrSQMVes9rn
         1RLAPul8l1MIPNawqztPDJ+nFrnPdrJM+779ul3dq2v4OFVmurAQnkl4GD63aK4xoJ+D
         Lj1hypl2l+Sgap/rynetxpwblIecWmwZXr9KhiQdD/02oZQA3TSJlm8lxieEy84n0s53
         OeTd+0J7zXQxEWoiBHQZKE0uCc4y8TC8zLpHAtVp5ure/YfwebRM+e3ysMCYcmnxnewA
         uuHA==
X-Gm-Message-State: APjAAAWJy3PqQx2QVPDD4yein3TwxVy8rm/o/S05iVUc8L/XAAd7+AC2
        IQ71sl2OQNK2/S6awjRk2O8vNKj8v9jKmwNcs7vcm/W07NqiPg6EvXE2//1YXRPQLDKf9fvEoJs
        1wrwrcxk4noCaaYmZ7rYtjbN2bA==
X-Received: by 2002:a17:902:9b86:: with SMTP id y6mr11123543plp.10.1570125447404;
        Thu, 03 Oct 2019 10:57:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtmkikMBwhsbAzdy5yiHmL6JQbl0aqGdeC4G+s15gd3bNwdPdj8838+DpSLj+3ySR3z7yeKg==
X-Received: by 2002:a17:902:9b86:: with SMTP id y6mr11123520plp.10.1570125447048;
        Thu, 03 Oct 2019 10:57:27 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id 2sm4293602pfo.91.2019.10.03.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:57:26 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max8907: Fix the usage of uninitialized variable in max8907_regulator_probe()
Date:   Thu,  3 Oct 2019 10:58:13 -0700
Message-Id: <20191003175813.16415-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function max8907_regulator_probe(), variable val could
be uninitialized if regmap_read() fails. However, val is used
later in the if statement to decide the content written to
"pmic", which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/regulator/max8907-regulator.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 76152aaa330b..96dc0eea7659 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -296,7 +296,10 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 	memcpy(pmic->desc, max8907_regulators, sizeof(pmic->desc));
 
 	/* Backwards compatibility with MAX8907B; SD1 uses different voltages */
-	regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	ret = regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	if (ret)
+		return ret;
+
 	if ((val & MAX8907_II2RR_VERSION_MASK) ==
 	    MAX8907_II2RR_VERSION_REV_B) {
 		pmic->desc[MAX8907_SD1].min_uV = 637500;
@@ -333,14 +336,20 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 		}
 
 		if (pmic->desc[i].ops == &max8907_ldo_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & MAX8907_MASK_LDO_SEQ) !=
 			    MAX8907_MASK_LDO_SEQ)
 				pmic->desc[i].ops = &max8907_ldo_hwctl_ops;
 		} else if (pmic->desc[i].ops == &max8907_out5v_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & (MAX8907_MASK_OUT5V_VINEN |
 						MAX8907_MASK_OUT5V_ENSRC)) !=
 			    MAX8907_MASK_OUT5V_ENSRC)
-- 
2.17.1


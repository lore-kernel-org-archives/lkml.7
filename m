Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935F9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992720716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLSLe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:34:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40388 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLSLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:34:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so4101700lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UWTcxLjRNGx3qhOx1gaC3pYwCsh+7bFhFzDxuEIhOJc=;
        b=Uum80g68qNuQv9eN9ufdefnm46JRsfmzhEZHyq6QfRcJOQbqTxuS/KQAJPGLwQTYHe
         sUxdOonv/QohZXe5sxOMUrpgvKkUnVDrKKPPpYd3KnHvtTns9NkD8gGwZ7wCB2bgDoCI
         8Enx8vQfP0Vsc5sWcPuQhUabEhz+NGU8GmfZu56uh6P3eCnIMHrteAyKttsBflPhNJLG
         vXkRvYJN+cW3lMY4EFXOm/6hCPD3Zho8PRIfh6gvKFTg5Z/4hT9CukCTRW/BQH6J9V8z
         ZxYnJbaigZuiAFxoeQoGjXUe2Bm3RtV4mbGRseLulAzIKhWyEvhu5bsEK1UmY0/siass
         XhyA==
X-Gm-Message-State: APjAAAVaNe+/2q1sVdVTooUl+cl374qZF4JTEAZ/qfid57KaGt6aeGxJ
        JmhVFbM1BEfukMd+oohMp/E=
X-Google-Smtp-Source: APXvYqyMapJ/JH5Bv0qFxvEqmKYmywXIpq/Yq+KTp6XVcip+HSNOV+6PRF0avcrbDMiRVGfBhnQ3rg==
X-Received: by 2002:a19:4f46:: with SMTP id a6mr5080638lfk.143.1576755294050;
        Thu, 19 Dec 2019 03:34:54 -0800 (PST)
Received: from localhost.localdomain (dyt4gctb359myxd0pkwmt-4.rev.dnainternet.fi. [2001:14bb:430:5140:37cf:5409:8fcc:4495])
        by smtp.gmail.com with ESMTPSA id t2sm2634098ljj.11.2019.12.19.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 03:34:53 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:34:44 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd71828: remove get_voltage operation
Message-ID: <20191219113444.GA28299@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify LDO6 voltage getting on BD71828 by removing the
get_voltage call-back and providing the fixed voltage in
regulator_desc instead

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Suggested-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71828-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index edba51da5661..b2fa17be4988 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -197,15 +197,9 @@ static const struct regulator_ops bd71828_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static int bd71828_ldo6_get_voltage(struct regulator_dev *rdev)
-{
-	return BD71828_LDO_6_VOLTAGE;
-}
-
 static const struct regulator_ops bd71828_ldo6_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.get_voltage = bd71828_ldo6_get_voltage,
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
@@ -697,6 +691,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.id = BD71828_LDO6,
 			.ops = &bd71828_ldo6_ops,
 			.type = REGULATOR_VOLTAGE,
+			.fixed_uV = BD71828_LDO_6_VOLTAGE,
 			.n_voltages = 1,
 			.enable_reg = BD71828_REG_LDO6_EN,
 			.enable_mask = BD71828_MASK_RUN_EN,

base-commit: 522498f8cb8c547f415a9a39fb54fd1f7e1a1eda
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 

Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A423C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D62208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/kH1vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfIDVmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:42:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45324 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbfIDVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:42:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so114064pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y2iMYe7Rxl/lrXSbCDLL6TYyLJkEO4Va2eFRfd15ipo=;
        b=Bf/kH1vs2YyzTOuEPvny+9ZwmOejOyUrzYbpn6r6PIyJYOEIeSR62bUek+ETvcPUZ0
         yyqhuehjsFWCvtD2daxGSsT2ZmaZVksQYOW2+ReBlOdomQ8oLxkGkFDWWIy05LJMKsIo
         2CelD5uRKAJmCAH/J8Bu3ynUkrh7fv3YOdWkpOtskClIMwZ+pW5clFYTAiIIBrORKnM6
         QXS0N9+Zv2ockcucdL2umTAzGLoE6707xaSORJkoZBtGWvRe7ZTSWFcSaTjSnIdWG76Y
         uhVypWLvwbTLMD9N1Ji6VVJYHVopDwM5Eft+DrDscrwHzsTIhKMR+/g0c33mJYVedm5s
         WUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y2iMYe7Rxl/lrXSbCDLL6TYyLJkEO4Va2eFRfd15ipo=;
        b=pfNBEbUQUhnuYDdkXllADmegrpHIlXPb/naD9Y78pr69ejATmGCWPS2yRX3vYMyzeJ
         E9Yq/uJ2deGlG7xmNrwZjWbUA/8SC9L5PqD1NR3CLNO/nq4AQkCpGJzfw4Jhl+OV0apU
         aQ86D+NXGGWCETWo883FEehDmLq5OM6v355aA+ROtZGADR9dnA+/vxkUagXRPRe5nrx/
         6rtWlfA+uU9jH3z6WMwUAKZ0xKHJ31hLf464oOqcP6R3aaEWFOORyDn2YPuIHgCyc+qj
         8jNAJSlMcWdG9HzOqnedkJPq08ICummupO9JQh3QTLc0HsNVewweh3Whu0OrNgncSZu8
         b0UQ==
X-Gm-Message-State: APjAAAVx8rwLFFVMhF0z+ol58wvZPantfHC/BbY64KclnYvP56jgJty5
        v4yuqnCvBoBMbjfEjsGuMZw=
X-Google-Smtp-Source: APXvYqwQPp+BlL/2MT6TLYNmgzjIGDBL+tV9c0zwYsdQERBbkjn8HFqbJRdSXMZCCRTyI/bVuv3s+A==
X-Received: by 2002:a65:528d:: with SMTP id y13mr249378pgp.120.1567633322759;
        Wed, 04 Sep 2019 14:42:02 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y15sm14086pfp.111.2019.09.04.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:42:02 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:42:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: slg51000: use devm_gpiod_get_optional() in probe
Message-ID: <20190904214200.GA66118@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS GPIO line is clearly optional GPIO (and marked as such in the
binding document) and we should handle it accordingly. The current code
treats all errors as meaning that there is no GPIO defined, which is
wrong, as it does not handle deferrals raised by the underlying code
properly, nor does it recognize non-existing GPIO from any other
initialization error.

As far as I can see the only reason the driver, unlike all others,
is using OF-specific devm_gpiod_get_from_of_node() so that it can
assign a custom label to the selected GPIO line. Given that noone else
needs that, it should not be doing that either.

Let's switch to using more appropriate devm_gpiod_get_optional().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/regulator/slg51000-regulator.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 4d859fef55e6..a0565daecace 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -447,19 +447,20 @@ static int slg51000_i2c_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct slg51000 *chip;
-	struct gpio_desc *cs_gpiod = NULL;
+	struct gpio_desc *cs_gpiod;
 	int error, ret;
 
 	chip = devm_kzalloc(dev, sizeof(struct slg51000), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	cs_gpiod = devm_gpiod_get_from_of_node(dev, dev->of_node,
-					       "dlg,cs-gpios", 0,
-					       GPIOD_OUT_HIGH
-					       | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-					       "slg51000-cs");
-	if (!IS_ERR(cs_gpiod)) {
+	cs_gpiod = devm_gpiod_get_optional(dev, "dlg,cs",
+					   GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(cs_gpiod))
+		return PTR_ERR(cs_gpiod);
+
+	if (cs_gpiod) {
 		dev_info(dev, "Found chip selector property\n");
 		chip->cs_gpiod = cs_gpiod;
 	}
-- 
2.23.0.187.g17f5b7556c-goog


-- 
Dmitry

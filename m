Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63618222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlMTkoM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfJDXKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45588 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfJDXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so3795514pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cm58LI6h4jAqsDBKxV++l0e4ZOMCLYhH6Wxp6SfSZww=;
        b=YlMTkoM+/Jlxqs3Sq21Fb3tLnvPSM/+KqpMO5/nwQZgzlrgLD+5UCoK7wwOBrunMOo
         FzcZyaHjF4MN27ftKyNjhLYFlrYn+LcA1KltQ7YupR7cNp60JvbzBM5OCGkSuYVmH9q1
         g87WGTrTDkwR2IKQN+FRlUBHzVi+WwaFaOgZxNnE/kkFEGTcokSFT6c2ghzmT890cqYd
         yONTx/1RPPo/BHTb8u4ePV8fjmpExhx5oROer6WJXyP8WY2/GN1SamS8e/Qxne9x6StD
         38LWKVVm2p5siEnOwIrNOZMzZ+WDLmI3qiML4ga987sfWDS8EQ2t9RQM9u6npX1pLUAB
         l6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cm58LI6h4jAqsDBKxV++l0e4ZOMCLYhH6Wxp6SfSZww=;
        b=ov3OePpRsKhaeTEXUUMOMqwsUxQmSwpDsHIxra8jbxlcg72IGD4vYWaaKXR63iumPf
         TK9NQubp6PhVTdy6NsU49y0TuFCGSnNuNPH0mduZVnifX2T4S/CViAVQGH/d1zPKugq3
         R/8lf6clBGP66ZhkMnKYPg0xvdEl31jkbpp10l4K1lwyeLWfC3+M9d++na9yfUDWLMl/
         V263se86tvahYsqJyfj/t1q+LII4KwYB5tvJNiu/Nn/ATW3B7sq+J5zyW+EtCZHugpaV
         e47LyuP+HZF8nAh9Y2/T1ohcwz1+jOH+uou85yQkBrmaGHicNxLy0T4WkeI/M915tYkh
         B42g==
X-Gm-Message-State: APjAAAUr+4CnUorQo+u1I1VVwcYAtTNDBDp9BPEZUpyWD9Oo7tPr7JA6
        eBm9LWs6obc0qEbO6tsY6Dg=
X-Google-Smtp-Source: APXvYqyCmVp4XhLd0gKGmmYx/OReapyUsshneu034hXsRRXZ3s4A5oJoHCg8M3Hcu0yl5d2JLUi4wQ==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20mr17003667pll.229.1570230624731;
        Fri, 04 Oct 2019 16:10:24 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/7] regulator: tps65090: switch to using devm_fwnode_gpiod_get
Date:   Fri,  4 Oct 2019 16:10:13 -0700
Message-Id: <20191004231017.130290-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_gpiod_get_from_of_node() is being retired in favor of
devm_fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/regulator/tps65090-regulator.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 10ea4b5a0f55..f0b660e9f15f 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -346,16 +346,20 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 	for (idx = 0; idx < ARRAY_SIZE(tps65090_matches); idx++) {
 		struct regulator_init_data *ri_data;
 		struct tps65090_regulator_plat_data *rpdata;
+		struct device_node *np;
 
 		rpdata = &reg_pdata[idx];
 		ri_data = tps65090_matches[idx].init_data;
-		if (!ri_data || !tps65090_matches[idx].of_node)
+		if (!ri_data)
+			continue;
+
+		np = tps65090_matches[idx].of_node;
+		if (!np)
 			continue;
 
 		rpdata->reg_init_data = ri_data;
-		rpdata->enable_ext_control = of_property_read_bool(
-					tps65090_matches[idx].of_node,
-					"ti,enable-ext-control");
+		rpdata->enable_ext_control = of_property_read_bool(np,
+						"ti,enable-ext-control");
 		if (rpdata->enable_ext_control) {
 			enum gpiod_flags gflags;
 
@@ -366,11 +370,12 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				gflags = GPIOD_OUT_LOW;
 			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
-								    tps65090_matches[idx].of_node,
-								    "dcdc-ext-control-gpios", 0,
-								    gflags,
-								    "tps65090");
+			rpdata->gpiod = devm_fwnode_gpiod_get(
+							&pdev->dev,
+							of_fwnode_handle(np),
+							"dcdc-ext-control",
+							gflags,
+							"tps65090");
 			if (PTR_ERR(rpdata->gpiod) == -ENOENT) {
 				dev_err(&pdev->dev,
 					"could not find DCDC external control GPIO\n");
@@ -379,8 +384,7 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				return ERR_CAST(rpdata->gpiod);
 		}
 
-		if (of_property_read_u32(tps65090_matches[idx].of_node,
-					 "ti,overcurrent-wait",
+		if (of_property_read_u32(np, "ti,overcurrent-wait",
 					 &rpdata->overcurrent_wait) == 0)
 			rpdata->overcurrent_wait_valid = true;
 
-- 
2.23.0.581.g78d2f28ef7-goog


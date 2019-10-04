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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BBCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584EA222C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SodK6+/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfJDXKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36803 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJDXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so3817760plk.3;
        Fri, 04 Oct 2019 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc9tGVeJ4olVgaKePn3t6HbonR38LaaryzX91Se5rAI=;
        b=SodK6+/xa+e4ldidjLKc5QB0qs8HJbZzihBLhcV41Gv49iVQLtoRhio/UufZW9ir7G
         dXvlkyc/2BZ6QhUKfynNyAr/RiD2y00kNLlVrP/jKjIQgda5CYA8mSS8f9Ra5+wjzW2q
         BoPfRRuRIZowm8ac84qqkHNo54j1t3zqwKfrHj0GiL1NTR+HHoahivJq693U91HEeAkB
         AidC5XPHHZ9V456LZlJ3TrtvDRsdkjoFEDhVBy1IWgw0BuEJZH3rCvETf3TmiHK1FVO8
         JV/6m79OL6XSqQzLhnkOwoBZ6NRqk1yLC1Xz78EE1LoonNYgXFFipFgmraWvHi9cubVc
         oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc9tGVeJ4olVgaKePn3t6HbonR38LaaryzX91Se5rAI=;
        b=dFWKd3r4Rr4zsVolcAkHV+34psAeeORnAzIQfYD4NF0kAfQUf8YuGJiP8EWajbvl2K
         0TZX7bYrEkXFj8f2qNzMJzy+EYw92toNrxqJ9cOwyFN2xJN751vz6qgeY0p6/k/9M6Ld
         oRNF4PGtABtG0SHHD4GisJgYG/E3w280OkqYNb4yxvd061D76AOHvbz3wgNWHkzye7IE
         1H3Q9bgzlin69HVngkPwoiiSL/uGXNnJ2aOPtojg63pG8SXvv/YQ13UEaQB5scxTcRcH
         YK0QuxSilpavEDVIIQHnTdYKRJZAIBo3A/+xSJv5qy/w2V/KkvhoEV1bj77GKxYMaSmn
         HEbA==
X-Gm-Message-State: APjAAAWkKKjEajlIuQAa1gta8g1Gt/qcwP6XgHWwdIP2gO/ykNSQlvax
        XS7cfuz8uAYm6UKzeOYdXgY=
X-Google-Smtp-Source: APXvYqxc1YTK7GZZaOa6IlN4K3qw0kyub04c7nWYesQHa+EsVVo+UARwT22654v3Yt6yrKNzkUxwPw==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr17719352pld.150.1570230625926;
        Fri, 04 Oct 2019 16:10:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/7] regulator: s2mps11: switch to using devm_fwnode_gpiod_get
Date:   Fri,  4 Oct 2019 16:10:14 -0700
Message-Id: <20191004231017.130290-5-dmitry.torokhov@gmail.com>
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

 drivers/regulator/s2mps11.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 5bc00884cf51..4f2dc5ebffdc 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -844,10 +844,9 @@ static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		if (!rdata[reg].init_data || !rdata[reg].of_node)
 			continue;
 
-		gpio[reg] = devm_gpiod_get_from_of_node(&pdev->dev,
-				rdata[reg].of_node,
-				"samsung,ext-control-gpios",
-				0,
+		gpio[reg] = devm_fwnode_gpiod_get(&pdev->dev,
+				of_fwnode_handle(rdata[reg].of_node),
+				"samsung,ext-control",
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				"s2mps11-regulator");
 		if (PTR_ERR(gpio[reg]) == -ENOENT)
-- 
2.23.0.581.g78d2f28ef7-goog


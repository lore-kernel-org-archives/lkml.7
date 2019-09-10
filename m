Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4443C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857DC20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDSgQd3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437014AbfIJRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:02:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42123 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437004AbfIJRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:02:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so11885626pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=331RNabWtb60kqhgnVTFAtsMSj9tZLuroHtAQOBPHUk=;
        b=sDSgQd3qmFs96lJTvB5DCgU2/oeklTqTiXsrPG7nhbB2x5SXApm7s0nPTZhlg6iJGN
         Y4hgHT/1dlqpDghG/2wjJWvHsqFY+czx46L5N9mo3A3rw5gTPTkNLs9GggfOLN3R+xw1
         xr0wUHGdnl6qRyn1+IwrEdCMqdVQhwksRttOUPbdFjHPxQnuTThc9afK2wH5CE61CI2I
         IP50jbCqMWecxRC5CBQGTLHVmkD63WVtlBt2W2ltX2faqZA+z68vRINs8sooTtZkKoc0
         f746Io9+WK4p9lTi59Lkwe89M04tiUA+4QttD8vBc2MYv1pBjpWYg/Q1f7qW4BD0C6LO
         CS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=331RNabWtb60kqhgnVTFAtsMSj9tZLuroHtAQOBPHUk=;
        b=R2Fkaz0ShYCUXos0k/3gAV9pQBbevD10ktkdCb+RTWAS++J5dkkP1ky6ywXF7AiN1/
         ZxWk9WqswEsL2Sn6JLsfeyXF2uEVIRIwAjsVjf8/floh+wXVdqi6o3fpjiw0JDCOYp9C
         9O49R6PYYYji93k4+mGVeHQnrRtZLgqCPOk1vGHw6JKRvRopUqH37rYTtY2z/KGix1JA
         uZmxW+soma0LzNRY7UnSZvkRNM51DxMk19YKHvH/ZZdi3RsTOxzDrnmTOrjZRroOcJEE
         IiCiw65OgqE+wJC032Q2vfrEBm8DsBj3anNQrb8AsgmmHGywaHt7UtohJvCGyVu/LXmv
         i3AA==
X-Gm-Message-State: APjAAAWOQoeBoNATEiB9D2IOr+Js/W94hhucPWJIEU1yg2+JlIGhC/Wk
        d/HttriXCMF4ChC10MBJKvo=
X-Google-Smtp-Source: APXvYqzW1FhbDKX0449h3r0I8mhKyhuV0JV5ajdGYtZieMQlG4PLrEMH08om2Z4oFTeld2BjWBK+UA==
X-Received: by 2002:a17:90a:af8d:: with SMTP id w13mr509181pjq.92.1568134969327;
        Tue, 10 Sep 2019 10:02:49 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t3sm19971572pfe.7.2019.09.10.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 10:02:48 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:02:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9211: fix obtaining "enable" GPIO
Message-ID: <20190910170246.GA56792@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes 11da04af0d3b, as devm_gpiod_get_from_of_node() does
not do translation "con-id" -> "con-id-gpios" that our bindings expects,
and therefore it was wrong to change connection ID to be simply "enable"
when moving to using devm_gpiod_get_from_of_node().

Fixes: 11da04af0d3b ("regulator: da9211: Pass descriptors instead of GPIO numbers")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/regulator/da9211-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 0309823d2c72..bf80748f1ccc 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -285,7 +285,7 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 		pdata->reg_node[n] = da9211_matches[i].of_node;
 		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
 				  da9211_matches[i].of_node,
-				  "enable",
+				  "enable-gpios",
 				  0,
 				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				  "da9211-enable");
-- 
2.23.0.162.g0b9fbb3734-goog


-- 
Dmitry

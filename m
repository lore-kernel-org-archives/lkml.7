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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ED5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692A1222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtyrvbQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfJDXK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38365 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJDXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so3808581plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9Tcr8H66a/ItWUKfyzgngKKlcGkzwk48GNoumxAsGU=;
        b=DtyrvbQvGOExbukCQcV+ZhSehiVj45mWdMpVe8rk+5ULj6b+828TKo0meBgkrFG7sr
         FWyKMxOvrfzRGtn8GISG6942bAa0z23ve2DBkQq61s6j8Uelk6WK/onpnhV5ekM9BEjy
         uyG5GxaWyLZ4FDvyACLaIWbONxAbboIPhePGbqY+JSPEncu3SndiC10aZkgXd0fx5Jxq
         B/I3LoEuOOm0GI7r4B5I6EWN2650eC0vjkWgsHtIqjTb3QeU3GYKbg8faoHNFIZXu16d
         Oxxl8Vgz4O0H2YjFUFOrSLy80Xp5acW2ns68HeztHeDWug1WkEcHhkWZXa1BaKXELeEk
         tB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9Tcr8H66a/ItWUKfyzgngKKlcGkzwk48GNoumxAsGU=;
        b=c4A2IUIeAh1iL6X5riGitN5IZGic3OaSCp4dFkIBgw8XKFAeKMALHD1QPxQ4qT7XXc
         rjRQt68gnZmvdwM7jNLdwCVsSOGpECgJ/IDW/c8ahfY2SXiJoW7kHk/0XWVqZ9Xc6Rxe
         DwFHWpTlJzFb7AHxq/NvpDCKcYzNlQngAHHUGmHEr++b7rJn5x3kS/eFyXzGYZKOPnfT
         +K6rW6qGB0LxZCwA/wQfAqiKS8qmb6TX1HsTyqVFqvMD6QMj8rskyYWGx1QfzPu+KDsZ
         36sfh1FCX/q/vjx2Jz916E2NLRODVil/53CwX/J4fsSK16WdmOsCdhibi3OKWHGzMk/3
         yC9g==
X-Gm-Message-State: APjAAAXFD4eSAqbskZnvcRslZLA7Mq1+HhTa6OEWAJx+ko+ta19hd63E
        LHqHzf7HTrE307CRrlCXQXQ=
X-Google-Smtp-Source: APXvYqys2V9xdyLefeURldgYi/4pamBqBS19ybhuqrGvzipZhaleiPO7tgFJ1lw2+G2Do9oilGhShA==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr18089936plo.232.1570230623837;
        Fri, 04 Oct 2019 16:10:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:22 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 2/7] regulator: slg51000: switch to using fwnode_gpiod_get_index
Date:   Fri,  4 Oct 2019 16:10:12 -0700
Message-Id: <20191004231017.130290-3-dmitry.torokhov@gmail.com>
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
[devm_]fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Note that now that we have a good non-devm API for getting GPIO from
arbitrary firmware node, there is no reason to use devm API here as
regulator core takes care of managing lifetime of "enable" GPIO and we
were immediately detaching requested GPIO from devm anyway.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/regulator/slg51000-regulator.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index a0565daecace..bf1a3508ebc4 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -198,17 +198,14 @@ static int slg51000_of_parse_cb(struct device_node *np,
 				const struct regulator_desc *desc,
 				struct regulator_config *config)
 {
-	struct slg51000 *chip = config->driver_data;
 	struct gpio_desc *ena_gpiod;
-	enum gpiod_flags gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
-						"enable-gpios", 0,
-						gflags, "gpio-en-ldo");
-	if (!IS_ERR(ena_gpiod)) {
+	ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
+					   GPIOD_OUT_LOW |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					   "gpio-en-ldo");
+	if (!IS_ERR(ena_gpiod))
 		config->ena_gpiod = ena_gpiod;
-		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
-	}
 
 	return 0;
 }
-- 
2.23.0.581.g78d2f28ef7-goog


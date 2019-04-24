Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31EAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C162021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdBasy6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDXWtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:49:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38037 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfDXWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so18419668ljg.5;
        Wed, 24 Apr 2019 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hdevTv8hliL5DYcFCHwzS6rx3GtVPRahkeQ1sd86fQ=;
        b=XdBasy6wmfSS2Xm5o0yjQPIXPjlr3zkPpTw7viZLdH+LJiFXfm8oRDg5/VRU1HZEPU
         PnaZvMRcSNFYAuO/c/nav7u/EKNgC/k8xWTGAMwz4gyp28YSx74nRJ0gYg6Yp+iwZgnM
         Qn/quCrumIVc8uQSO95A0F2Yk8uFrpFfXyP/jCvLb/gp4P1SUp9l0HMDPhBlpUVKtkks
         q9BC/Y71wC3+kt31FfdebOcOQFL+jVuRkzpxQNXafn07Wxw/RX5e+4YrUEME/t0PdQ5M
         Ji3xfw29PmYGwfnDuv3q712osaYRtqS8K4g57Frd99LQoRGShX4yoKfsWdM5bfwSlrUZ
         mLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hdevTv8hliL5DYcFCHwzS6rx3GtVPRahkeQ1sd86fQ=;
        b=JbqqPZOPl1h/JsmTS63i93VJEHvTLZtM8qK7n9/8aybqtfJ/KhPeadY4oHB6RtJERQ
         1VVdlZY2c03DAgLYKYolRpLe8a9KwJn6g2IdwLdLcSYjbulkf1VdzwOey8+GpIHqaZw8
         iHg7KVFBlGr8RmrD5zPimnlb4TEvE/eBbYVZETV4sGifjyzVp2Y7oO2/tc1p/WDWIer/
         dPY5MPTIf8DuV0uVzDzzgNIgDDM7w+FojTqnG4M3oMDXH1zgvTv7WasGDnN4jmTvfuhw
         UGSeHf3jaaaMxYL/kJ2FBjVKE9+OL0xqxzFt2FK9ZKkYlbzGe5tI5BLi5eDZVidXmzB+
         RWYw==
X-Gm-Message-State: APjAAAXOJOd/frLows0CsIsAC8isOE5aSaR2paR7pwXlJoUk6vLEYJU/
        ZoOG2Y2P6n6rz/52tcVp5lg=
X-Google-Smtp-Source: APXvYqwgHtygc+azQGe/TgEh/hDntEj+q2a2n0tTGHYuN8PUZLZH0oQSUIMFyt5gIhqz7BuambIkyA==
X-Received: by 2002:a2e:4ca:: with SMTP id a71mr16861241ljf.39.1556146187113;
        Wed, 24 Apr 2019 15:49:47 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] mfd: max77620: Provide system power-off functionality
Date:   Thu, 25 Apr 2019 01:49:00 +0300
Message-Id: <20190424224900.8018-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide system power-off functionality that allows to turn off machine
gracefully.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 9b0009c29610..e56223bde568 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -37,6 +37,8 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+static struct max77620_chip *max77620_scratch;
+
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
 };
@@ -481,6 +483,15 @@ static int max77620_read_es_version(struct max77620_chip *chip)
 	return ret;
 }
 
+static void max77620_pm_power_off(void)
+{
+	struct max77620_chip *chip = max77620_scratch;
+
+	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
+			   MAX77620_ONOFFCNFG1_SFT_RST,
+			   MAX77620_ONOFFCNFG1_SFT_RST);
+}
+
 static int max77620_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -488,6 +499,7 @@ static int max77620_probe(struct i2c_client *client,
 	struct max77620_chip *chip;
 	const struct mfd_cell *mfd_cells;
 	int n_mfd_cells;
+	bool pm_off;
 	int ret;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
@@ -554,6 +566,13 @@ static int max77620_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	pm_off = of_property_read_bool(client->dev.of_node,
+				       "maxim,system-power-controller");
+	if (pm_off && !pm_power_off) {
+		max77620_scratch = chip;
+		pm_power_off = max77620_pm_power_off;
+	}
+
 	return 0;
 }
 
-- 
2.21.0


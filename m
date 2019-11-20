Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A17C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2A621826
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py3Czakg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfKTOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:44:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36894 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbfKTOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:44:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so21441877qkf.4;
        Wed, 20 Nov 2019 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zddixLIG407nblq8qKNkbMRSz9Vj+er4J47xlaoa6s=;
        b=Py3Czakg14gAO6zBRImaKEwmRkF3AiNWIsMu+LPZtITTbzPpJL355Mh7QNVjnzRoPz
         PztoBX4p2XlCX/O03UL0/s5cicb4RclvClWblUuXKHL8E+gK/Y0cC7CQhmvrAhHWAbM8
         XW9lOQvd9Q2W8xMdY4cYeHo6O64RAcf5fYwb2BRYmuG+1/nv0g14j7ArP37FC6fe5D5n
         Z3Z3Pjf3l+xGDi55RrdceHrbXl0lIg2RqOr6663ll+qVkdSXfzOJI158t2mDkgWLDb3U
         UfueECg7mYzdXZGHVwb5kHXBImwi/vJiaqbOfBkbi++7DiSlBwwZIj7jjSQh3XnxDglO
         7zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zddixLIG407nblq8qKNkbMRSz9Vj+er4J47xlaoa6s=;
        b=nCI8U1+9W3vzP4bDYUVHpVtKEwPvWvVHPxfW+etCfCTSAIyOU9Lx1oDnmwF9YjDhNR
         EYxZtNXjrj8CRaqyxdz/CON/oe0ChR7oYSTsnHWuwC8Ro0t2gj4BpRZNegAaZacb+Jeb
         PfVq2255rB1U+0iEVnq7EMafW7PTzB+lcwMluSr4n4Ga8MzJgFXayocVq0DQ21xIlBVN
         p/ubZXpvHXPpOynL/W7rZuLYloCl+XuL5lYnpX5ahsyd9WMIg6tswv6Od775khde8TTn
         7WMe+CcPO/b3Jep0xSXEIasCpVlzaiNjnHoOzAl1VlfQmu7JwlHAYMQiWvy5uFGDCVYh
         jIHg==
X-Gm-Message-State: APjAAAXWqyVDzSopl134PzpHBHdJizOVdpEfgRTRHgVPP5R31B1+gZUv
        onFU53fa6ScvmO7IjdDYz5o=
X-Google-Smtp-Source: APXvYqzF0ePZZnsNnPj+3UpvP978JvhIYNlTfHXjTIIhcnJue8H6QLBKqmiS3zt+03fgTh4nElz8Tw==
X-Received: by 2002:a37:9145:: with SMTP id t66mr2707826qkd.332.1574261048122;
        Wed, 20 Nov 2019 06:44:08 -0800 (PST)
Received: from localhost.localdomain ([72.53.229.209])
        by smtp.gmail.com with ESMTPSA id 62sm953069qkk.102.2019.11.20.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:44:07 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 1/3] tps6105x: add optional devicetree support
Date:   Wed, 20 Nov 2019 09:43:59 -0500
Message-Id: <20191120144401.30452-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144401.30452-1-TheSven73@gmail.com>
References: <20191120144401.30452-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver currently requires platform data to specify the
operational mode and regulator init data (in case of regulator
mode).

Optionally specify the operational mode by looking at the name
of the devicetree child node.

Example: put chip in regulator mode:

i2c0 {
	tps61052@33 {
		compatible = "ti,tps61052";
		reg = <0x33>;

		regulator {
                            regulator-min-microvolt = <5000000>;
                            regulator-max-microvolt = <5000000>;
                            regulator-always-on;
		};
	};
};

Tree: linux-next
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/mfd/tps6105x.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 6ac3607a79c2..c906324d293e 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -91,6 +91,32 @@ static int tps6105x_add_device(struct tps6105x *tps6105x,
 			       PLATFORM_DEVID_AUTO, cell, 1, NULL, 0, NULL);
 }
 
+static struct tps6105x_platform_data *tps6105x_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct tps6105x_platform_data *pdata;
+	struct device_node *child;
+
+	if (!np)
+		return ERR_PTR(-EINVAL);
+	if (of_get_available_child_count(np) > 1) {
+		dev_err(dev, "cannot support multiple operational modes");
+		return ERR_PTR(-EINVAL);
+	}
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+	pdata->mode = TPS6105X_MODE_SHUTDOWN;
+	for_each_available_child_of_node(np, child) {
+		if (child->name && !of_node_cmp(child->name, "regulator"))
+			pdata->mode = TPS6105X_MODE_VOLTAGE;
+		else if (child->name && !of_node_cmp(child->name, "led"))
+			pdata->mode = TPS6105X_MODE_TORCH;
+	}
+
+	return pdata;
+}
+
 static int tps6105x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -99,9 +125,11 @@ static int tps6105x_probe(struct i2c_client *client,
 	int ret;
 
 	pdata = dev_get_platdata(&client->dev);
-	if (!pdata) {
-		dev_err(&client->dev, "missing platform data\n");
-		return -ENODEV;
+	if (!pdata)
+		pdata = tps6105x_parse_dt(&client->dev);
+	if (IS_ERR(pdata)) {
+		dev_err(&client->dev, "No platform data or DT found");
+		return PTR_ERR(pdata);
 	}
 
 	tps6105x = devm_kmalloc(&client->dev, sizeof(*tps6105x), GFP_KERNEL);
-- 
2.17.1


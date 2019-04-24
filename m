Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FF4206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNSmJ2ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfDXMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36149 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfDXMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id l6so1878107ljb.3;
        Wed, 24 Apr 2019 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YW8mkRr9Gd3ekemnp28mgGnOxmrO43x9tEZ83C3zgJg=;
        b=CNSmJ2eitEaO22Rm5rSTGBQSGNibnCZQHV8j6ec9BF2rLCA8SVeQQGJ5uVWI1dHNfn
         97JTJePCD4Z1SFe5kPGw5tdSScBMq+HUomeNC+OCrecepCD2bYx2y8yKhvw3Bo1gkRvm
         s+g+XNvGXJi5jMiIqmJ6tlTtS9AxOkpNAuAAsHdoK7X3e6Hr5fd1f58o3Zt4uju2y92N
         JfX4cdnqbpcLee1Zu6I+Y4i8Ci3LF9feW6AsjhkYyaFa4jrf5wshvNeq4tDgNDpLPGzj
         zRQKvoAgVvgNpiBpLu10zGoKe0ojeQ7b87+aP7yZBYOuKZIL3uhhgtofLwKTWnPYXcTO
         oexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YW8mkRr9Gd3ekemnp28mgGnOxmrO43x9tEZ83C3zgJg=;
        b=Dwpsasdt8NzTjn8xC5uiz52q+XtY7wLey8EgVFWJ1mszy1ChREhurFdPweBq23bcP6
         8T8nAOcg6BRhPHVCx+7TQqeje9F5vBeSrA7O99m+R+xBALsE0S3ZSTQBNpVQ9t1oVAgy
         +9XCbCK2zMUMPWEoNmMy0aeQT7al7ftlm90UwezUvPnFr6v5uhbeoKD0/lETq1O1rQ7r
         LXch2SKQdCWuyGHg2I8HKFgYjJauTLfsceRifubaqB7vxkK3UUHnLMu1O0/+rDyHcptp
         fXh9UiKW85r3QoCBKMjlD95AFjIzUSo8021YnjzmxKmNR0DULeS1DAve0zD/W7N90Cc+
         X9vQ==
X-Gm-Message-State: APjAAAVU+GIdlzY2BvG1Y6CNbKqVA4uO94WDvoCp3T1t38fQmnqyPeLU
        UYJA6j+H0ogvKyxz31METbI=
X-Google-Smtp-Source: APXvYqxXCYrW7mwtF1t+GDFiO+IqpaZ7oR8SzyVQN6RUckJAg1xkkZX5L2bakLgH2q5qdPux1jTTng==
X-Received: by 2002:a2e:888a:: with SMTP id k10mr3820729lji.57.1556109270294;
        Wed, 24 Apr 2019 05:34:30 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:29 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the idle data field
Date:   Wed, 24 Apr 2019 15:34:12 +0300
Message-Id: <20190424123414.25311-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case if the idle state has been specified in the data structure,
the idle variable is left untouched as before, so to keep a default
channel number enabled in the mux idle state. But if a platform doesn't
specify which channel is going to be enabled by default, we as before
don't setup the deselect callback, but the initial state is saved in the
idle variable for further initialization. We can safely do this here
since that variable is used for initial state setting only, when no
idling lane is specified.

The reason of this change is to prepare the code for future GPIOs request
path being split up into of- and plat- based methods. The idle variable
here is used as a container of the initial state for both of the paths in
case of idle-channel isn't specified.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index a14fe132b0c3..535c83c43371 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -171,7 +171,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
 	struct i2c_adapter *root;
-	unsigned initial_state;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
@@ -204,12 +203,14 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	muxc->mux_locked = true;
 
-	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
-		initial_state = mux->data.idle;
+	/*
+	 * Set descelect callback if idle state has been setup otherwise just
+	 * use the idle variable to store the initial muxer value.
+	 */
+	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE)
 		muxc->deselect = i2c_mux_gpio_deselect;
-	} else {
-		initial_state = mux->data.values[0];
-	}
+	else
+		mux->data.idle = mux->data.values[0];
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
 		struct device *gpio_dev;
@@ -224,7 +225,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		}
 
 		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
-					    initial_state & (1 << i));
+					    mux->data.idle & (1 << i));
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Failed to set direction of GPIO %d to output\n",
-- 
2.21.0


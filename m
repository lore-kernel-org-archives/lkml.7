Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C4C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC8D21D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QzNqSGXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJBRDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36337 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfJBRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so7744111wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4R1pFMiYgGmsrKFaVjsr4CfqOpIjL8+dlsXA4/2/eWc=;
        b=QzNqSGXXrkEMylsWIdkVp1QE2PoiBzEzoPHXnSdEzwqM/i27K0EnnoMQsy8oXtMzMz
         G0erLAZr3GqGCvyIN8vGCo1Krf2cnDHjKo3F7i7O5lXp4LCRDLFmixDQGL/pRcovDnZ+
         3+2YpF6bpI7mdXb0Wd1buJ3VF8yhLlhvl1oykTsRmencBi8cUrv3ZQ3XmvO6T9HyzNLD
         bfk1YRitp5l8qLsK0SwBDbY2qlbu5ykgoNdccKNDD9+bchQOb8XeKGZfT+NGPc/DSqE+
         HgIMAkgs2/+RKb6rZx5/nRGjPvpHvDbu2fZ5xa4BmpmUrjIvjyjnBqSJm7EyBd+TkqNO
         heMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4R1pFMiYgGmsrKFaVjsr4CfqOpIjL8+dlsXA4/2/eWc=;
        b=MrN1pqTrENb4vEmo1YkMPsVzhiRntbQAfW9lIXu1fktlUcjvYqulDaq4+SJVldzFwu
         r8IX4y1Cg1JcXz97HNZldhIAnvSdg6wlnDCG6KRKwFz5Nw/9eo6M47YU9TzpZwUzBY+S
         Bisjig+rkDEUymrBQN3MF/AVHO4+X3Cr5UQyz6KRUEll2vfEidE7hx3VwGKxUAM4f8wE
         BJKyu7d5sol9LgU4xiv5BzanTHKzjxfs8/KenUOUzVPOBsnLTR549TsgooHkHpyc9AIG
         a3JrMeI+Fsh6dLbCbShK8q9TQ/4eG5ulncI5nYQY+m45w8MugFuNfB0BDsTT037EYika
         wK2A==
X-Gm-Message-State: APjAAAU1p12pVSs6HLv531tQPa0SmeEUoln4UPUrdzOBxO0BLL4zmKC8
        xlAX33rbl7EQjrdI1r8K+uAP3A==
X-Google-Smtp-Source: APXvYqzpviBQxFnllxgLIMD5etZwxvfroogQ32SBiQEuYxpYuHJZHwqSJFyGGMaiLTknVGRotdfxLw==
X-Received: by 2002:a05:600c:290c:: with SMTP id i12mr3808333wmd.77.1570035782386;
        Wed, 02 Oct 2019 10:03:02 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b62sm11188575wmc.13.2019.10.02.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:03:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/6] gpio: ath79: use devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 19:02:47 +0200
Message-Id: <20191002170249.17366-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002170249.17366-1-brgl@bgdev.pl>
References: <20191002170249.17366-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need to use the nocache variant of ioremap(). Switch to
using devm_platform_ioremap_resource().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-ath79.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index f1a5ea9b3de2..53fae02c40ad 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -226,7 +226,6 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct ath79_gpio_ctrl *ctrl;
 	struct gpio_irq_chip *girq;
-	struct resource *res;
 	u32 ath79_gpio_count;
 	bool oe_inverted;
 	int err;
@@ -256,12 +255,9 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	ctrl->base = devm_ioremap_nocache(dev, res->start, resource_size(res));
-	if (!ctrl->base)
-		return -ENOMEM;
+	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctrl->base))
+		return PTR_ERR(ctrl->base);
 
 	raw_spin_lock_init(&ctrl->lock);
 	err = bgpio_init(&ctrl->gc, dev, 4,
-- 
2.23.0


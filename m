Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1ABC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C95E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VL9mENzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfCXXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:10:10 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44676 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCXXKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:10:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 7E0ED5B8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRzT4MBnM1HS for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:10:08 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 521AE595
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:10:08 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id e72so6555911iof.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GFuI5+RxpdKf7NbqYWML+tnl7qVmbDtvtw+sDjvanbg=;
        b=VL9mENzPoTUnyXLjPexCQ2dZFktMRsbKO+ImWUnKwK/sMp7Aup2RXoOMhVLPGNDBrm
         1Kh7WvRCjWUXgbU+2Cp/JJa36eR/hI7RGVwUrTZ4+jQO65JlnHMtzDwZRCPgWMSvH15l
         80XXxnJ59ul26KDDKc3uMbxT2vue3AVUjmgBOAh/xqhGkVTlzCDoOs2ByhjSpV/8151L
         mXRkvh0uTXlqaT5/Mw7g/Rzbmhj6W9uwIaFmMvspu3b89PSw0FagiVQvzgeEYDK/38uE
         +mW6E+c6qiWtHp7EU+/5A4TmQcypZ3nND6ouzK0VMz2pgncuQM8Ey5MC64uDby1FbpfG
         q7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GFuI5+RxpdKf7NbqYWML+tnl7qVmbDtvtw+sDjvanbg=;
        b=Gjadq7TvBxH7v/hfQklK0E8FKcIordDsKzQV/RxGAIrruZRbW8u4EdGIC2rDBkmUZY
         FeBFYH+9TQ0e4lU8/N5gBbdVB7XeBotz2LU6VO52BhLuwEh+h8AQRdN0bCB6Xb4Rj5I0
         iSZFMta3YEs6WGNCtK8sFqiitE6GGpy6REFquL5r3TqdG7ZxRvZYFSiClkm1VYAQuK17
         j87WzWBCXxRxBxsITrJodHaIG8p4b3I0YjJVNsxmcH/vOECFtmgMKKGVqQC4KH4JuLJb
         pBApUQVehy2QV9tPk+Kubv4L+wLimfIkNriYguvMnkdabMmqBjccrek8HKrS7FphUzrM
         8njQ==
X-Gm-Message-State: APjAAAVO744iwQVdQpzpKEt8kZouZ95cjKfuTvO0FRPoZZh8wdfC1jcU
        G7xCBHZxkH6aaLWtcr+5kx6vu7o+Xys76p+sqPh9tW6h64q73bPkB7QvilgNo0J7C7icKeSFnwy
        4UivCFxEvAW9/4nHmGuCgvWsnE1XV
X-Received: by 2002:a02:b60b:: with SMTP id h11mr16219038jam.125.1553469007974;
        Sun, 24 Mar 2019 16:10:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8aw+DKyd/uMPAWUkRpDqFT+9EceV4jBjtO1GE2nJOCVEbaCOzQZ7ous75xLI92Wlw68ynvA==
X-Received: by 2002:a02:b60b:: with SMTP id h11mr16219026jam.125.1553469007782;
        Sun, 24 Mar 2019 16:10:07 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x79sm4313839ita.17.2019.03.24.16.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:10:07 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: fix a potential NULL pointer dereference
Date:   Sun, 24 Mar 2019 18:10:02 -0500
Message-Id: <20190324231002.2106-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_kzalloc, the patch returns ENOMEM to avoid potential
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpio/gpio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 854bce4fb9e7..217507002dbc 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
+	if (!gpio->offset_timer)
+		return -ENOMEM;
 
 	return aspeed_gpio_setup_irqs(gpio, pdev);
 }
-- 
2.17.1


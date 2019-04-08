Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1095C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C395C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDn0cM1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDHTkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35556 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfDHTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so7886798pgf.2;
        Mon, 08 Apr 2019 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8MkCNyjFg+P+pMxDYmTJBU3ZbWVK/GY3Ec8mlqC2fOk=;
        b=sDn0cM1XDp8iKXLCfAt4nxPQy3AyKBv+w6PI6PdYGnn0gfHFWugxQhN17yRv4P4RGR
         kzO7KjouFiA+nByg+oqaiJOelAWRIRSAbnE4ukN9rE/egap8X4hyJwRSL9Cgkc1qEPKN
         MK9Kw6NSYWpebqoNBeld8l3xdO24f1BryqVqHwRVw5LPWpOKGepVzpKTU3DGBqU5LvDE
         R8y1K+ppxQJkeUmrDl7zLDDVZ/larvs1Db7HP9bU+BzGc7sdSU8RPciRprlN2Xku+ebv
         8DFCsEBoHkktl4FN1ASah3Jrk7/4X8bxh/lVLKSF5lIfUYBv4oJBBRFxoWpNE/0mhod8
         ipxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8MkCNyjFg+P+pMxDYmTJBU3ZbWVK/GY3Ec8mlqC2fOk=;
        b=c7455gHcv2+JyRkmtTjtCPK8QoKzar/SWj3SlYV3qa/OWIi43G+4bndAq4I5T4G3FK
         CVr5CNGJyO4LCCvEJ1ZcG9wX2diy3L2th6N0z7a/QCQH17rmddzpBMJ6yQ47rkhGJzI4
         bLgsoqB98UrXuqQiSLVOLxLkG2Y4LsdQoI35C4H+Ou80W2/zS6yTz9YHVuy7PhpJhIW+
         EGkyABWksEYwZ2aGEulNB9qfeJ9xIEEzSxtBAFrPEq0cczAlaiz83T6TlyDwh1v+Zzgf
         KsDP28gcOLP3zDDaliNgsmR9PoWkYdwv7yXBSbTP3bIRs7CHkKUPHd3/BNehQAB7hZZS
         2pVQ==
X-Gm-Message-State: APjAAAUEDGMBrevXF4Au90EMjjM8oZuLoIfRZ6Qja4weP+WJlEPXX/R4
        xS7rmW0vZruTwuYATh4AmGoJHgi+
X-Google-Smtp-Source: APXvYqx5HKVp/RxawXqu2jZLQyBfL4d+jyATxGOpCIdy2UdmCZCwuv90TfoiIUC7+Q1NAAUjh1Khsg==
X-Received: by 2002:a62:5144:: with SMTP id f65mr32128637pfb.13.1554752406654;
        Mon, 08 Apr 2019 12:40:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20sm24486530pfe.188.2019.04.08.12.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:06 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 21/22] watchdog: lpc18xx_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:45 -0700
Message-Id: <1554752326-13319-22-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/lpc18xx_wdt.c | 43 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index f6f66634cedf..0e82abd71d35 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -200,6 +200,11 @@ static const struct watchdog_ops lpc18xx_wdt_ops = {
 	.restart        = lpc18xx_wdt_restart,
 };
 
+static void lpc18xx_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int lpc18xx_wdt_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt;
@@ -231,19 +236,26 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 		dev_err(dev, "could not prepare or enable sys clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
+				       lpc18xx_wdt->reg_clk);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(lpc18xx_wdt->wdt_clk);
 	if (ret) {
 		dev_err(dev, "could not prepare or enable wdt clock\n");
-		goto disable_reg_clk;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
+				       lpc18xx_wdt->wdt_clk);
+	if (ret)
+		return ret;
 
 	/* We use the clock rate to calculate timeouts */
 	lpc18xx_wdt->clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
 	if (lpc18xx_wdt->clk_rate == 0) {
 		dev_err(dev, "failed to get clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		return -EINVAL;
 	}
 
 	lpc18xx_wdt->wdt_dev.info = &lpc18xx_wdt_info;
@@ -274,24 +286,8 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lpc18xx_wdt);
 
-	ret = watchdog_register_device(&lpc18xx_wdt->wdt_dev);
-	if (ret)
-		goto disable_wdt_clk;
-
-	return 0;
-
-disable_wdt_clk:
-	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
-disable_reg_clk:
-	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
-	return ret;
-}
-
-static void lpc18xx_wdt_shutdown(struct platform_device *pdev)
-{
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
-
-	lpc18xx_wdt_stop(&lpc18xx_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&lpc18xx_wdt->wdt_dev);
+	return devm_watchdog_register_device(dev, &lpc18xx_wdt->wdt_dev);
 }
 
 static int lpc18xx_wdt_remove(struct platform_device *pdev)
@@ -301,10 +297,6 @@ static int lpc18xx_wdt_remove(struct platform_device *pdev)
 	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
 	del_timer(&lpc18xx_wdt->timer);
 
-	watchdog_unregister_device(&lpc18xx_wdt->wdt_dev);
-	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
-	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
-
 	return 0;
 }
 
@@ -321,7 +313,6 @@ static struct platform_driver lpc18xx_wdt_driver = {
 	},
 	.probe = lpc18xx_wdt_probe,
 	.remove = lpc18xx_wdt_remove,
-	.shutdown = lpc18xx_wdt_shutdown,
 };
 module_platform_driver(lpc18xx_wdt_driver);
 
-- 
2.7.4


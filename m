Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1FC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9C521874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsNB/CZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfDHTkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37208 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfDHTkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so7881049pgc.4;
        Mon, 08 Apr 2019 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7THh9qsnCmidCNLaJzA4Mcp6adtL0OU5E3d8WEfwEdg=;
        b=hsNB/CZn/LdC5lYgP1F5SKG++4XATZEIpPQ4fS2xvzKgvl81GfVqB7kvW/L/pSXPCz
         JqWPIjo13jDes7CVn/MwT44NMRNr+CJGrBnTYtVMHBEv+0bhEgY+Gq87zElTQvc1IFcn
         Z+JH8X+NrqMvoKplyuEXuMmV8v8w22ixmHkxmSAo99vNeOERE0YAiPT+GBM9cFu77vPQ
         LUU+5WegxsVaaVw/whOpWx+UaGupUOWKSqJFTSfPr63PGWy1xYag7dNChnIl2VUipuXM
         fizS/f5hHShZeDfobIoRSxBin83trhsX5B2BJV89+PukPcGwfTgwPTctZURt+ccPOh4i
         1dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7THh9qsnCmidCNLaJzA4Mcp6adtL0OU5E3d8WEfwEdg=;
        b=N6sK1MTABBr4/SA3xi+UkYwtGC3avfd+qlDkPguHC2dLOdA6om+LGrbsMeib5TI5Cv
         9kXd7nr6dV3kU1HDYSLcTiSuMieBULhZF3F1DMVSka+CCGzveLrQDCNLmUqoWcw3/H+1
         //3+tFXkjC4qsCPm26cWhfWG5qJpCwxU73AmUgLVxUTaqdX2tSFS/y3E/xTR5UWSP04T
         RLnaTAzXeVe9SPF62HQdrIfcfIpndctuX3/ncxKK3LMKWBNgaBlt1SQIjPyIpgehXWtG
         6qMD+jtYkaR67niIw4kxPj8z3bVXG8Msnd6aQyQEMNPZrwo7GWf5UFatucYrvgAwrhYR
         hrsA==
X-Gm-Message-State: APjAAAUKqJSIrlbjzfXyCveJuX54ucYPvhzBhkW4CtY6/oRo+LZHG/wy
        ogUw3IlFWAb3sa2Ths/ZgdQ=
X-Google-Smtp-Source: APXvYqyA7yGKHn60b8Hc0KAj6jwBPG5avvELRuvuYKb5+A3mb4iiRg3vs7Kekq0NxmZsmiMpGD/Esw==
X-Received: by 2002:a62:12c9:: with SMTP id 70mr32152540pfs.156.1554752402547;
        Mon, 08 Apr 2019 12:40:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm49326074pgx.68.2019.04.08.12.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:01 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 18/22] watchdog: imgpdc_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:42 -0700
Message-Id: <1554752326-13319-19-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imgpdc_wdt.c | 91 +++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 84c9fb905072..0fc31aadeee3 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -178,14 +178,20 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.restart        = pdc_wdt_restart,
 };
 
+static void pdc_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	u64 div;
 	int ret, val;
 	unsigned long clk_rate;
 	struct pdc_wdt_dev *pdc_wdt;
 
-	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
+	pdc_wdt = devm_kzalloc(dev, sizeof(*pdc_wdt), GFP_KERNEL);
 	if (!pdc_wdt)
 		return -ENOMEM;
 
@@ -193,42 +199,48 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(pdc_wdt->base))
 		return PTR_ERR(pdc_wdt->base);
 
-	pdc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	pdc_wdt->sys_clk = devm_clk_get(dev, "sys");
 	if (IS_ERR(pdc_wdt->sys_clk)) {
-		dev_err(&pdev->dev, "failed to get the sys clock\n");
+		dev_err(dev, "failed to get the sys clock\n");
 		return PTR_ERR(pdc_wdt->sys_clk);
 	}
 
-	pdc_wdt->wdt_clk = devm_clk_get(&pdev->dev, "wdt");
+	pdc_wdt->wdt_clk = devm_clk_get(dev, "wdt");
 	if (IS_ERR(pdc_wdt->wdt_clk)) {
-		dev_err(&pdev->dev, "failed to get the wdt clock\n");
+		dev_err(dev, "failed to get the wdt clock\n");
 		return PTR_ERR(pdc_wdt->wdt_clk);
 	}
 
 	ret = clk_prepare_enable(pdc_wdt->sys_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
+		dev_err(dev, "could not prepare or enable sys clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
+				       pdc_wdt->sys_clk);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "could not prepare or enable wdt clock\n");
-		goto disable_sys_clk;
+		dev_err(dev, "could not prepare or enable wdt clock\n");
+		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
+				       pdc_wdt->wdt_clk);
+	if (ret)
+		return ret;
 
 	/* We use the clock rate to calculate the max timeout */
 	clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
 	if (clk_rate == 0) {
-		dev_err(&pdev->dev, "failed to get clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
 	}
 
 	if (order_base_2(clk_rate) > PDC_WDT_CONFIG_DELAY_MASK + 1) {
-		dev_err(&pdev->dev, "invalid clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		dev_err(dev, "invalid clock rate\n");
+		return -EINVAL;
 	}
 
 	if (order_base_2(clk_rate) == 0)
@@ -243,10 +255,10 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	do_div(div, clk_rate);
 	pdc_wdt->wdt_dev.max_timeout = div;
 	pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
-	pdc_wdt->wdt_dev.parent = &pdev->dev;
+	pdc_wdt->wdt_dev.parent = dev;
 	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
-	watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
+	watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, dev);
 
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 
@@ -257,24 +269,22 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	case PDC_WDT_TICKLE_STATUS_TICKLE:
 	case PDC_WDT_TICKLE_STATUS_TIMEOUT:
 		pdc_wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
-		dev_info(&pdev->dev,
-			 "watchdog module last reset due to timeout\n");
+		dev_info(dev, "watchdog module last reset due to timeout\n");
 		break;
 	case PDC_WDT_TICKLE_STATUS_HRESET:
-		dev_info(&pdev->dev,
+		dev_info(dev,
 			 "watchdog module last reset due to hard reset\n");
 		break;
 	case PDC_WDT_TICKLE_STATUS_SRESET:
-		dev_info(&pdev->dev,
+		dev_info(dev,
 			 "watchdog module last reset due to soft reset\n");
 		break;
 	case PDC_WDT_TICKLE_STATUS_USER:
-		dev_info(&pdev->dev,
+		dev_info(dev,
 			 "watchdog module last reset due to user reset\n");
 		break;
 	default:
-		dev_info(&pdev->dev,
-			 "contains an illegal status code (%08x)\n", val);
+		dev_info(dev, "contains an illegal status code (%08x)\n", val);
 		break;
 	}
 
@@ -283,36 +293,9 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdc_wdt);
 
-	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
-	if (ret)
-		goto disable_wdt_clk;
-
-	return 0;
-
-disable_wdt_clk:
-	clk_disable_unprepare(pdc_wdt->wdt_clk);
-disable_sys_clk:
-	clk_disable_unprepare(pdc_wdt->sys_clk);
-	return ret;
-}
-
-static void pdc_wdt_shutdown(struct platform_device *pdev)
-{
-	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
-
-	pdc_wdt_stop(&pdc_wdt->wdt_dev);
-}
-
-static int pdc_wdt_remove(struct platform_device *pdev)
-{
-	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
-
-	pdc_wdt_stop(&pdc_wdt->wdt_dev);
-	watchdog_unregister_device(&pdc_wdt->wdt_dev);
-	clk_disable_unprepare(pdc_wdt->wdt_clk);
-	clk_disable_unprepare(pdc_wdt->sys_clk);
-
-	return 0;
+	watchdog_stop_on_reboot(&pdc_wdt->wdt_dev);
+	watchdog_stop_on_unregister(&pdc_wdt->wdt_dev);
+	return devm_watchdog_register_device(dev, &pdc_wdt->wdt_dev);
 }
 
 static const struct of_device_id pdc_wdt_match[] = {
@@ -327,8 +310,6 @@ static struct platform_driver pdc_wdt_driver = {
 		.of_match_table	= pdc_wdt_match,
 	},
 	.probe = pdc_wdt_probe,
-	.remove = pdc_wdt_remove,
-	.shutdown = pdc_wdt_shutdown,
 };
 module_platform_driver(pdc_wdt_driver);
 
-- 
2.7.4


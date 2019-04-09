Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F89C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244522133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfQarJYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDIRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45427 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDIRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so10090002pfi.12;
        Tue, 09 Apr 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YEVlYxcVMQ+udZOYQMBpKUyQvjiSc8bbYElkffO0rRU=;
        b=JfQarJYVrpruasuUhAMsdXQlKQS6hMFlFJFresi8WkLysRiXPH+VRUqRiAvJVDmSue
         ORvTIqoH3OuIhMCcWiYWbQQVUUL6qm3bnxscl1fyCAkuv3q8cpqmHG+bGhrpw6Q8oEG1
         QxD8htrDqMfYPgLn7Z+TF+NKpi3euyebZqLTN+Sy1ypykeXUUN/dWpcEa/DANcoWIjKN
         z3wxnomLta1RCMrsFJD+MyvSm5Jz7My+Zq+FmEPquD70flV6YLiiPuPgFjgzbBfMvKX0
         LPpLLvRi/pOySZ2KJiDQTTMathOID4y0DlRGZlovUDSa3cKr3xV5qG4DPpdzoddm8h75
         kfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YEVlYxcVMQ+udZOYQMBpKUyQvjiSc8bbYElkffO0rRU=;
        b=ZOaC6YTH86Z+18u9tDAsYk8IVQ/wGuAjeqDQ4zflpayYR+qfW8IbR+nttzN+QDFOjX
         0qyMG81/wsZerN+x46grZip7AQBPAOJOS4T0A6Xo4UdywR83YmLaZ297lN3htppbTtGO
         VdG87OcuGgSZMqRfAk5zDO6XGfQyx25vcwHJRwGz8/pHGjJnWMi4LpDI88l+ewmvuJHN
         adfuBMbuUGBHnbjrmh7WNy2eZPyc4wazhtGlfO9ZozTVYMZ9YZxZVepZTUJBGTFdDOTn
         Ag/Ro+JK52As9g/Q/2MyoOBgAo3RJKkK+9GGDjpSoUIkVP/I435KlOpsbueogmABCfBY
         6LrA==
X-Gm-Message-State: APjAAAWdkscSDGZ5lSR+hREQB8KhRzIMyy78JdI926G91hL6Dpm7KoNF
        idx+fxCsoB4MeOj3SJ/YGqg=
X-Google-Smtp-Source: APXvYqyDqUkCR5hqaZQ5hYE7oUTpuCoF5l4pIT4LeR9fyh0o0RPI6nXd25B46cXbot4bZhyCpERiiw==
X-Received: by 2002:aa7:8208:: with SMTP id k8mr38574721pfi.69.1554830669689;
        Tue, 09 Apr 2019 10:24:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r76sm34023097pfa.39.2019.04.09.10.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:29 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/23] watchdog: rn5t618_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:51 -0700
Message-Id: <1554830641-9247-14-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatedly.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/rn5t618_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index e60f55702ab7..21fcb36f9074 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -146,11 +146,12 @@ static const struct watchdog_ops rn5t618_wdt_ops = {
 
 static int rn5t618_wdt_probe(struct platform_device *pdev)
 {
-	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct rn5t618 *rn5t618 = dev_get_drvdata(dev->parent);
 	struct rn5t618_wdt *wdt;
 	int min_timeout, max_timeout;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(struct rn5t618_wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(struct rn5t618_wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -163,10 +164,10 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
 	wdt->wdt_dev.min_timeout = min_timeout;
 	wdt->wdt_dev.max_timeout = max_timeout;
 	wdt->wdt_dev.timeout = max_timeout;
-	wdt->wdt_dev.parent = &pdev->dev;
+	wdt->wdt_dev.parent = dev;
 
 	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
-	watchdog_init_timeout(&wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&wdt->wdt_dev, nowayout);
 
 	platform_set_drvdata(pdev, wdt);
-- 
2.7.4


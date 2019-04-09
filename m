Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72FAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AEE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/uDCxMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfDIRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46531 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDIRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so9786214pll.13;
        Tue, 09 Apr 2019 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQNFeFQAIS9IcQnzgiGsF4bv+r8/UL2D7gAeGH/2zP8=;
        b=u/uDCxMfyJYUC9wKKiiREszTvY2wHTAHAVAQagHKdh/JWWn7ZEZu3fHo0vAbbRIkF9
         GrrJa3PGVbIynVHH8fqTAFF9/INzvtFcpSlYq/qaSLzVknty0zTPdMUsEFL5nLV0EOxJ
         XuV/yHBg8kWIq4ThmK8yKu3iP1efUgcfnaAjg84gA/bigRNOQ1xpAH6Q/sMxfzkEug20
         w6Q8v1HlYuMcriOokxWzLYcgDL+Aaj5aiP58dImiCQVtRkiSnGqmK3c1sHg3wjSMdMQP
         9Y1QFGWhpSeSXB/WO6W/gv8m+ml6mHHSmJxoHtfqAd94lfz+lkkTrfP4jATVyiBY3k/7
         /ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RQNFeFQAIS9IcQnzgiGsF4bv+r8/UL2D7gAeGH/2zP8=;
        b=e/q9U6/0YZ/VtKCeErVk75OUBqnT1zEHDWp8Z15vNn4o/PRCmfpRn7VLFPXdLmVaxX
         k0Xim15PEYwgwE5nKHtzxNZOrfmq+aonv5XhI/kI+EBA6DzqvjTK6cQT73cm4e8SaV4R
         Kq7t3L6mMC5xr7uBgCQdKsXzZ1a+Yi+9+ho0Dlx+dkqj9A38jI+uD51YkXGiaFMbxSx8
         86ZSRPDpZE3YLdOp8SibqgMpXPEkoy07OtNTO1MhmoLFeV/oDG06el6SbeLuDBYByvW+
         QAA4uPkEmC9Wrucb7UXPpC+AX4wEuKF7yOIM0g5C0RY6IkRpQ2R0WOZiYgF3E8zHvLOt
         a9oA==
X-Gm-Message-State: APjAAAW4QqudpfWRxiMh+shCeQXg14n8IeKWZhKDOIVDTQdYVTni5wGW
        M0gszp25cS2SamKI4nGDiwVZaXGG
X-Google-Smtp-Source: APXvYqyN2Ln9xTqWl936KqgLjDq7Ij1yK1ABMygWKepDDZC5gmO7TT045JQewXBNA/kedsv1MB5UiA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33mr38847467pll.7.1554830679831;
        Tue, 09 Apr 2019 10:24:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q11sm47414470pgs.94.2019.04.09.10.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:39 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 20/23] watchdog: stmp3xxx_rtc_wdt: Convert to use device managed functions
Date:   Tue,  9 Apr 2019 10:23:58 -0700
Message-Id: <1554830641-9247-21-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 994c54cc68e9..671f4ba7b4ed 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -89,31 +89,31 @@ static struct notifier_block wdt_notifier = {
 
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
+	watchdog_set_drvdata(&stmp3xxx_wdd, dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
-	stmp3xxx_wdd.parent = &pdev->dev;
+	stmp3xxx_wdd.parent = dev;
 
-	ret = watchdog_register_device(&stmp3xxx_wdd);
+	ret = devm_watchdog_register_device(dev, &stmp3xxx_wdd);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot register watchdog device\n");
+		dev_err(dev, "cannot register watchdog device\n");
 		return ret;
 	}
 
 	if (register_reboot_notifier(&wdt_notifier))
-		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
+		dev_warn(dev, "cannot register reboot notifier\n");
 
-	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
-			stmp3xxx_wdd.timeout);
+	dev_info(dev, "initialized watchdog with heartbeat %ds\n",
+		 stmp3xxx_wdd.timeout);
 	return 0;
 }
 
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
 	unregister_reboot_notifier(&wdt_notifier);
-	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
 
-- 
2.7.4


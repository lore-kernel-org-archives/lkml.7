Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69AB20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBy0ULhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfDJQaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:30:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43606 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbfDJQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so1719128plp.10;
        Wed, 10 Apr 2019 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2dbwiTzjex313CSAoOauK9n+B2nkUG9p1gWKyCrLDw=;
        b=MBy0ULhcPapht1HIARJ+gUc8r5fKZG8nKEYFvd6MAjP3G+QkK9PG5CB3Ip5T2LMUvb
         ZfLjfJmBnXsQTsrPd0BfVjUZCYi6BQEom+EMsH8GhyyxML81ABmhRSeL6klHeF0nHPz2
         ipit3lT1GBFm3RmY0gFjFTLc5dVtrYbmCc1a/l5FRLxVrK3vja8ZO1FpQyBGpGIG9mdg
         waddcDYBRzNl2GJ6+pSuAMf54pyJa+Frsx5mnrYSuNAqB1oHVgm7JXR64Dqm9GIhkU9s
         6MxH19IxPVoteCQnEwQtElB7a0KTCVlL3b9Ym8vN1P4wnxjy6COJvQDbvAjmfrDlZU8i
         LuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=n2dbwiTzjex313CSAoOauK9n+B2nkUG9p1gWKyCrLDw=;
        b=N9jat8XY542vKT3AM2LZfOMcIiPbDM0byOZGVY6+Q0O0k7w8BPP8fmwYjkMWNncyvp
         gg7h3FysBmC+ovXY4m3/CcHMApzkOTepDgDafOR0tgax1rjL6LG5K8/1ohVmv8t26gLm
         Oq48d+gmV5tzLRa3enIE8rC8ubC1ipzhtMgfXhbo+bswQ8ujvi1KuoneAJ5uRmIZtbzN
         t2Jc0PBEac85UY0eWnpFLDUWQ9BlScdfKc4Q5SYR65VMLi3yvRvGvARNQlqf4yH5Ema/
         /ZdrRj2hGY/wUvHeyf51JfX5noQQxrntGAE5sWnoD3hvYWFi38IxvgzcnWJy4bioifwk
         5GNg==
X-Gm-Message-State: APjAAAX8n/XxzZhpc4XmEvp6PWNhKsIZtRsEtjg2UQ+WXlqeacJ+aaBt
        Z9Eqzo/zBXd6APSMBy88aZcA0ge4
X-Google-Smtp-Source: APXvYqyU1/TNYpqmcyM4bvl0fnIMtbnL/QMtSHjYKqTnuVvH8fTnz5zIi8e7Ha0+TDqOQA9Yg02shQ==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr6750867pla.275.1554913696222;
        Wed, 10 Apr 2019 09:28:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm54659978pfd.134.2019.04.10.09.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:15 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 06/22] watchdog: uniphier_wdt: drop platform_set_drvdata
Date:   Wed, 10 Apr 2019 09:27:47 -0700
Message-Id: <1554913683-25454-7-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no call to dev_get_drvdata() or platform_get_drvdata() in the
driver. Drop the unnecessary call to platform_set_drvdata().

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/uniphier_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index e20a7a459d69..8e9242c23022 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -191,8 +191,6 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
 	if (!wdev)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, wdev);
-
 	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
 	regmap = syscon_node_to_regmap(parent);
 	of_node_put(parent);
-- 
2.7.4


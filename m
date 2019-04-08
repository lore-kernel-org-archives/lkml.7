Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC9C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5820863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3/RF5WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfDHTks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40820 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbfDHTj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so7903573plr.7;
        Mon, 08 Apr 2019 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jqPXp0iBEFCnb3no5w/iR1we3MDq7vr6GEB66fBaE5Y=;
        b=j3/RF5WAM1wCQ0DLzUpWd/5ixzId/0mDWrKgTn/EjvS874ELVqpE0LGrEL4bCWk7Xb
         KJlLhbEOflBQdtrCSXuqMtnXl5XIJIgIy+b5YQIi1vNiLXxWOBBFEqUqMLqnT1Y5fZl2
         PIZw7HaJuz/x8OKUN4wmTZDg/UMmmYWIeQ1bDxgeg3kzWOLM3rVzQ/oXetjJNmEGl9GY
         VZ4OJOekSxhnxeAmIrvbhOOXZlGUQPGT5wTPT4s2EsVR9dmAi5biOwwysbSc1uzpjFvu
         wwIXYj+FA9ciDDKUC9w4KwA8hOIhcc1Qk+rXFTd2DGdYnbkppuFW26Ra650kRO1jDqCO
         ZwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jqPXp0iBEFCnb3no5w/iR1we3MDq7vr6GEB66fBaE5Y=;
        b=mzLFNR9JK2VF7eUOAPlhb19aRMyNSoM8E3YfqLdBfC4Tq0QTA/sCm3eXmzB8S7K+rA
         cd+cBIcMUkUPAjxHd4QcpRmFqaJ/XD59f+HV9TOFithZgYX9EjUDxtB3Oc5usiLQ2HFj
         U+5zgHL2tdBiXJz0YOVk7Kx4y/NF2YvzwkSrll/Kyd06iewncEhO2oIXSU3ACEUnvaN7
         A8OwNvXAigUra8ZUZzBRZm/kHnb7WTOWfCy3fglekuBz4oRo8ZrL5+Gw1dWEpIc39Rk9
         t6VA86VfR9h0vASU4No6IWCLrm8oq5f6B9eaGN9oOQd1Bqu20+7M/kwBVBNchBnztY8k
         V72w==
X-Gm-Message-State: APjAAAUFVdWuNL0C2L9qZSRLurnxnypbKY9023dzJot+16m9rSxUD0rN
        pQ20MWsJGaRbavmpfAty07k=
X-Google-Smtp-Source: APXvYqzKa1gehAiNWUuVbLk4x+Pb7P6Aka9tjtI+Th71oA4N8J0ud0EW9kZuY8Hc91ZvWgnWb4Bf+w==
X-Received: by 2002:a17:902:110c:: with SMTP id d12mr6041054pla.47.1554752398258;
        Mon, 08 Apr 2019 12:39:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f65sm49173051pff.21.2019.04.08.12.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:57 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/22] watchdog: ftwdt010_wdt: Use 'dev' consistently
Date:   Mon,  8 Apr 2019 12:38:39 -0700
Message-Id: <1554752326-13319-16-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local variable 'dev' consistently.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ftwdt010_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index ecb32c42e839..9ea0e56fa7ee 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -169,7 +169,7 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 
 	ret = devm_watchdog_register_device(dev, &gwdt->wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register watchdog\n");
+		dev_err(dev, "failed to register watchdog\n");
 		return ret;
 	}
 
-- 
2.7.4


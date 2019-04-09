Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E11C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDED214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwigojSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDIR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:26:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35539 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDIRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so9691795pgf.2;
        Tue, 09 Apr 2019 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dA8ux7CA/LyMnGAXtd3Ndhtk0tgOsCy2XAsz0prAjfA=;
        b=rwigojSrciJTV/G4AhGIyZE/zGC0vTvm0oHtK80B+/AWfTxZq0vnfQLu40ZwuosqNw
         lSf0em1eNLLpR9HIBB0nJg4EbbhOd5m6TKudxM7SLZ+fc0+lfJ1MgGwACLv2PWHfI2/2
         NfPyRgH0QdOdc62aAaymI1cWJ2nTyaKktEcdw9posh3HXO8M18Tnf0+ZmE5pbVAXgBel
         YfNFIXbPZBXbXX25glxLFuOeexdRUheAZG6bHGdLa/scUxripKNNg1pL5bei2+pPzD5p
         5Dwdtga9JtKwN50zEvAwaRQ1VZ9TLH3Bwmb51Q2gZ+syTVD40qXpliUWXXGWFWhGMuiD
         fQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dA8ux7CA/LyMnGAXtd3Ndhtk0tgOsCy2XAsz0prAjfA=;
        b=GidFsI8juWMgxYMLTb/nNRNRC34xXg6QpaJFcXeTDBQ2n4MJpBGek2+kOKnpSbCKtS
         G9P6LTG9W87MtFlhqUhpqVkXOA+Q/CkI3hC0GY1n8KRLQuOdKPGSwaF5BDdzAlhuFwZ+
         0SI1gk5ykk0pE3G1pzvaaAryeG/hQoKS9wbA8f06P7MwQ/37Ky5FdXRxvS9n8GM1ue3K
         ZLESUIVBEGk8w4LlTp+1nsrrd5FjbgP1E0efO4zPm6Qt+4n3JeSnwHHzjZJG52UylKqU
         53HC6jFEKygkHPVK4i/SFlZTNsc4v6SgJcKWhnjQL6/XDMyY3eeb9HU3Ch6GRG8hYzyf
         90bQ==
X-Gm-Message-State: APjAAAW1eOHv/f6VdrM491pA/GI4ch0coUSY+anRFzT9+JY3BvloGftf
        sNwjP+MX/FYWHGpFx6sbdRU=
X-Google-Smtp-Source: APXvYqyN/O2WIhyqI5qpK22XZuq8UyH5OjZJjQBdiUjHCdk0fUHfY7CEjsMxQkDMsZ7lArIBxu/QZQ==
X-Received: by 2002:a62:1795:: with SMTP id 143mr38608394pfx.104.1554830664327;
        Tue, 09 Apr 2019 10:24:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h16sm10564900pgj.85.2019.04.09.10.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:23 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH 09/23] watchdog: npcm_wdt: Use local variable 'dev' consistently
Date:   Tue,  9 Apr 2019 10:23:47 -0700
Message-Id: <1554830641-9247-10-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local variable 'struct device *dev' consistently.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/npcm_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 4fce10c145c2..9d6c1689b12c 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -184,7 +184,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -214,8 +214,8 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 
-	ret = devm_request_irq(dev, irq, npcm_wdt_interrupt, 0,
-			       "watchdog", wdt);
+	ret = devm_request_irq(dev, irq, npcm_wdt_interrupt, 0, "watchdog",
+			       wdt);
 	if (ret)
 		return ret;
 
-- 
2.7.4


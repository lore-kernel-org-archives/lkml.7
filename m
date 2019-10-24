Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7142CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7C2205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFgTncfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503575AbfJXQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33597 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503537AbfJXQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so2385268wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4M/TuR9ElWDWsgab2CwXLXvo0XVpR3zUX6nx046dNY=;
        b=iFgTncfo27OyY3xOrjVf8k+LrQj/b3xCRYWuPYLMMo5ZBf6rQyO+w4OQN+tMw+qOb8
         PU/JI8owfgoVR8WZdCHfhQykvjBV7dSBMopw/8M8qWvolQzu0JP/iCuPwpVmK4ZXMMNx
         6rpHxMtmQGBEKg6By4WPJsLUgEwX95klixjUL2NWyK3JS17vlPYsCntul6yu4PvaKzVK
         1Ea79lATIqchM99hH4HVvRPqSwRUVxm9CkiO+n2uYIGICjFuOxhL1T0nQ5WKqpgSlSDN
         2i830iOga6S8ecjkM/isy9KN4zRSak1bEDGy/KVXxdytiyMJxx4SCpfrQyeXNDBDXg4j
         5I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4M/TuR9ElWDWsgab2CwXLXvo0XVpR3zUX6nx046dNY=;
        b=imVtsc60cdZkdt9HyTSqxOXrKw6NfpwbCjuhbWxpk/81aKqk85P8nHy28ts85/ctFV
         1ZRFlCX/4WLLx7sYslZWpTrC+/k7yoce5aV4NaoboZwSWplnDFLucjnltdGgXTRitnnS
         n4cEsUkOeg3uqBFKPrK3eDZ0fune7aticNpp32D1memcIQb6ODQN0img6PqISDD23cIl
         yKWqPw8a1a+4WnuvzuHRL/pFvmDfpQzEhdYzW6SVYl3yYmDM+aTekoRrL3n3JfxDdmYE
         Tmb3gzcWXAtvK8H8QPtPF59JGvyeqFS3VdNb8AKBrPrnkIhDPuoUOJvwVGEGnEKtfbs/
         KkPw==
X-Gm-Message-State: APjAAAUUvZDBlOtVjzmcloWKhIxo71S9XPkfQPzjafGEArDmGMwiIZ/0
        YbZxyGdfaqnDDVhkzOjX5bg3qw==
X-Google-Smtp-Source: APXvYqwyF86LO61G6Q/GTjGzQT35oPobFvCsp4KPMM+/nA54QMVhrVGQaJNdT23BlB1qxuMfJ7LVCQ==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5998222wmj.94.1571935123733;
        Thu, 24 Oct 2019 09:38:43 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 07/10] x86: olpc-xo1-sci: Remove invocation of MFD's .enable()/.disable() call-backs
Date:   Thu, 24 Oct 2019 17:38:29 +0100
Message-Id: <20191024163832.31326-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO regions are now requested and released by this device's parent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 99a28ce2244c..933dd4fe3a97 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_wakeup.h>
-#include <linux/mfd/core.h>
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
@@ -537,10 +536,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
 	if (!machine_is_olpc())
 		return -ENODEV;
 
-	r = mfd_cell_enable(pdev);
-	if (r)
-		return r;
-
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
@@ -605,7 +600,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
 
 static int xo1_sci_remove(struct platform_device *pdev)
 {
-	mfd_cell_disable(pdev);
 	free_irq(sci_irq, pdev);
 	cancel_work_sync(&sci_work);
 	free_ec_sci();
-- 
2.17.1


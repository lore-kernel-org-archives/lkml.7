Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15322087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHoRsmKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCPE7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 00:59:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37418 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCPE7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 00:59:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so7814303pgq.4;
        Fri, 15 Mar 2019 21:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OzPxfKH5q/W1N6L62C9gZZihNBCcvZZagm7xqbQ6YZ4=;
        b=MHoRsmKmg5EHBxbRsVxl/fYAfpIbYxuLeIATtVBHREBpH9mA3H98x5FRkm/OUapy/B
         FpBAmmjlPXEi3SFP9mNggzbN2ydTjRGmWoqm+56qIQ8Ufg+bIHLPSO2hs0DVUP7ApWqJ
         xhyz/nnzdPVHxBV3hoPW4D0WOakiAIgp89SdxclIG9nGxacPICeS45gtcMXnsuPAFyll
         akdixSU7wFtNirLMs94gKMENOlJg8B7seVzky6C4AnghoKFokSwOrkl2Mdgu/0M6DHCF
         BQIMMoNE/Cc9Sxk92YYv5GHsTuOB5TrBf54m7gtx2zZC9LYaVYEtEsLmyYIq7pdAMjjv
         C/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OzPxfKH5q/W1N6L62C9gZZihNBCcvZZagm7xqbQ6YZ4=;
        b=n+VPayUr/AJmXhvnt7VMOxAulO/KPDAdTYK8/SWjgieYGpYB5jSJTVVvjXxsgk1413
         Wmp4jOHQm9RpnRNduzz9GhCqaosjyDlTx95lOWbI0w/qlLl0nc49vgxJyIV4WA+x3PLx
         YwKZJKDl5RM8PI4lRBETjgF+789fW06a8pdAG7kIin5EsUueWoZmutJcaOSdWp3KsMea
         HvNxi5e6EAfy40BAtlh6KEvEjYhik6J/ZUsIH0ppWQXrUFaAtY5KmCpibk8+uZW9DgCU
         0WbVV7tdZnzi1VxREEksedmumNi4anzFOriWzysSKJBvzHmUFnYGTkv+7ibgkuGC55YE
         2XNw==
X-Gm-Message-State: APjAAAXYSMMIw4tcbSNHehlWyBo5oGLUHAFe3Zw8E2ak1yDMOP+egmJO
        Ugq1xE1mmfnhLQ7sVSR5MDE=
X-Google-Smtp-Source: APXvYqydQDudNS7Rlgn6Ny6H9tOLIGjxl29780o3+4ttR9yakmIcCZVbHNjoWaZvlO/RbscK/uSDJA==
X-Received: by 2002:a63:6881:: with SMTP id d123mr6974592pgc.10.1552712386757;
        Fri, 15 Mar 2019 21:59:46 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h15sm2067358pgd.12.2019.03.15.21.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 21:59:46 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/4] PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
Date:   Sat, 16 Mar 2019 00:59:27 -0400
Message-Id: <20190316045928.31934-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async_resume_noirq, async_resume_early, async_resume functions
are basically the same. As we have seen:

static void async_xxx(void *data, async_cookie_t cookie)
{
	struct device *dev = (struct device *)data;
	int error;

	error = device_xxx(dev, pm_transition, true);
	if (error)
		pm_dev_err(dev, pm_transition, " async", error);
	put_device(dev);
}

The ASYNC_RESUME_FUNC() helper macro can decrease code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 46 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 6026bda5e787..d512bee9d9ca 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -728,18 +728,21 @@ static int __func(struct device *dev) 					\
 	return __device_ ## __name(dev, pm_transition, false);		\
 }
 
-static void async_resume_noirq(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_noirq(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-
-	put_device(dev);
+#define ASYNC_RESUME_FUNC(__func, __name)				\
+static void __func(void *data, async_cookie_t cookie)			\
+{									\
+	struct device *dev = (struct device *)data;			\
+	int error;							\
+									\
+	error = device_ ## __name(dev, pm_transition, true);		\
+	if (error)							\
+		pm_dev_err(dev, pm_transition, " async", error);	\
+									\
+	put_device(dev);						\
 }
 
+ASYNC_RESUME_FUNC(async_resume_noirq, resume_noirq);
+
 void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -876,17 +879,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	return error;
 }
 
-static void async_resume_early(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_early(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-
-	put_device(dev);
-}
+ASYNC_RESUME_FUNC(async_resume_early, resume_early);
 
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
@@ -1035,16 +1028,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	return error;
 }
 
-static void async_resume(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-	put_device(dev);
-}
+ASYNC_RESUME_FUNC(async_resume, resume);
 
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
-- 
2.17.0


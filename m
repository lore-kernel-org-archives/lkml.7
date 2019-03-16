Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242262087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY2TecXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCPE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 00:59:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43797 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCPE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 00:59:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so7798810pgq.10;
        Fri, 15 Mar 2019 21:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38kWfbj8KCkTqbawPa9kq0A6n7fsMSJ+4LYh0RvsAFY=;
        b=EY2TecXG4mochJwBdz6rmVWpBqGhDmoy8DhoUgtQJSs3C6Qfod13HPhuit2xVR/dNK
         9u5sSAtOGm6Vr+gsaIhr7tFLZh4hRa91B1q5qVfyxwJPTs1Kyt+kgvuhq4GDeaSjG5Gm
         CAWdTS30mFeqFw7u0Agw5EoxFxZvzuZToQir4T0F6FgTiPkTRMJxuOzk5/+K/ZP+MqK/
         /UZng3r8/OaAyGpF2RALoKM5wDwVk3+CPbgJJtBm4njp7WVudS3nnlhciQKQZJbDJs5/
         1+pF+9lrONv/f2E37HyWqSX4BH7lDBFpRMEgxp4OuVYzTSPPIAJ0JVl2rST+icmkrtkQ
         82gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38kWfbj8KCkTqbawPa9kq0A6n7fsMSJ+4LYh0RvsAFY=;
        b=dVyk8D6iXCpCB9u8OEFItQZ+IXvPDAm1DgNB5GnJnc3LBk9HO+cAVlKuyZpUkzL78U
         OM837lRA8kDf7ps8DkUOInS0skCv5pTgfoC0B+mv2EGPF90/K1RYs1rGySeNvJSHjKT+
         1Awd4wS8IAKzHwXo8//zvhcfes0DSCnEiDhZhKODh5b27fW1FlcT96xTSSjYfCfMQpmF
         4mlMMoYxp0dsaBrfB0ugZ42RPZq9SRBLEKZ3RAUOgfQQC5kqx9DX/Zh4shCEfI+cymT/
         mN8G6VPE9H7ZS8KTdOnE7H9QONdpvtq+2ZxrNgYLIKokhjodCeT83qHRddyllwQ3sdWH
         /oUA==
X-Gm-Message-State: APjAAAXOnFncdaL3u9izHb54tnvvIDjYW6ZO6xv9PZ4mOVbE7RpS+pSY
        E2WN7hLR3FglpjEyTB4UdcE=
X-Google-Smtp-Source: APXvYqznrzcqNHAr0PuvnXMcJmLDZB+9KzY4TFBlK1foaB5Hbiahta1ibcYTzVmdNebXJk+jvPp+Sg==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr6696375pgc.22.1552712388740;
        Fri, 15 Mar 2019 21:59:48 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y13sm4922279pfn.31.2019.03.15.21.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 21:59:48 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/4] PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro
Date:   Sat, 16 Mar 2019 00:59:28 -0400
Message-Id: <20190316045928.31934-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async_suspend_noirq, async_suspend_late, async_suspend functions
are basically the same. As we have seen:

static void async_xxx(void *data, async_cookie_t cookie)
{
	struct device *dev = (struct device *)data;
	int error;

	error = __device_xxx(dev, pm_transition, true);
	if (error) {
		dpm_save_failed_dev(dev_name(dev));
		pm_dev_err(dev, pm_transition, " async", error);
	}

	put_device(dev);
}

The ASYNC_SUSPEND_FUNC() helper macro can decrease code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 55 ++++++++++++---------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d512bee9d9ca..3882dc5fee9f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1348,20 +1348,22 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	return error;
 }
 
-static void async_suspend_noirq(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend_noirq(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-
-	put_device(dev);
+#define ASYNC_SUSPEND_FUNC(__func, __name)				\
+static void __func(void *data, async_cookie_t cookie)			\
+{									\
+	struct device *dev = (struct device *)data;			\
+	int error;							\
+									\
+	error = __device_ ## __name(dev, pm_transition, true);		\
+	if (error) {							\
+		dpm_save_failed_dev(dev_name(dev));			\
+		pm_dev_err(dev, pm_transition, " async", error);	\
+	}								\
+									\
+	put_device(dev);						\
 }
 
+ASYNC_SUSPEND_FUNC(async_suspend_noirq, suspend_noirq);
 DEVICE_SUSPEND_FUNC(device_suspend_noirq, suspend_noirq);
 
 void dpm_noirq_begin(void)
@@ -1542,19 +1544,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	return error;
 }
 
-static void async_suspend_late(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend_late(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-	put_device(dev);
-}
-
+ASYNC_SUSPEND_FUNC(async_suspend_late, suspend_late);
 DEVICE_SUSPEND_FUNC(device_suspend_late, suspend_late);
 
 /**
@@ -1796,20 +1786,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	return error;
 }
 
-static void async_suspend(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-
-	put_device(dev);
-}
-
+ASYNC_SUSPEND_FUNC(async_suspend, suspend);
 DEVICE_SUSPEND_FUNC(device_suspend, suspend);
 
 /**
-- 
2.17.0


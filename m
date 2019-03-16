Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E50AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454B02087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4dKctg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCPE7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 00:59:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36757 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfCPE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 00:59:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so895257pff.3;
        Fri, 15 Mar 2019 21:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZgISnnBGFvMeW9jgtuox6c5E1qbTOU3Wfp7BqZXVGSw=;
        b=c4dKctg8QX/HuENMqXwVCqpJ9wcYu7YAH3EnaUuFfCLrIdK/Qv/ajnOgYB0IEayhX3
         5L1PRCagOOitP8w7eKrPEIwvEFh3x52/si6DrKnpoVSXHDOXnXDbirw/3BVfv2RprKqj
         j2FAsjSGf4JKdSq4RCNhR0DcV4zvuBIKxW+S2TAlrBJpchPmPNix1YkVunl2xvss6r2U
         MGtFngVtZy5maLvlOV+sB4eUEAqFzkbzXkEaihrqPA/1gZ/O/f8HQmOPdoy9rCXY/k82
         dNMShxY14blN5LfopJefJGhfjvfe8YsTcdpBvJmDJwpJJyLa9R3WkenB1/z/SvAzHEBp
         AQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZgISnnBGFvMeW9jgtuox6c5E1qbTOU3Wfp7BqZXVGSw=;
        b=awSoA2VmVT+86i1+1qLfCvlevrRzuPAhiIvE6y1QDRibRYv7A4BJtb0pjzOpHcS4Ke
         VJaJDhaRirILYyT+bDqa9v2zv1jc5b/svR9xx+IQzLjChi4ValI2keXPuOs+VqBKbcQW
         1KMhlFhaba3UYQkOxc7onKQcKpU9aAVlEhMvRTziozFGwr/mDgXMgkjNKzdnFi1Y/rZI
         jr5G5VxHlrCw3pCruocCeCkeZukBZxgiMSNgtbrModDp8XNCgTZmyIEuoKe2Tz5GVCEu
         N0RQ7wWeQr8816tDVvrT8xMHe85TJRXDfGezUQzuj6IjayI1mWi3H3f+6lNwDX/am830
         Ea2A==
X-Gm-Message-State: APjAAAWQTX2WmZBeRZ1XftPtlfPnUSXFsukOirYWBDYsmDgWVAy6rO+N
        dG6QpxwmOBV2+UZaAoe4S9Q=
X-Google-Smtp-Source: APXvYqzc/XWBcHSZBEqrz0KW41uWQ2wgpsp1acAc9qYkzpVlsbSkyoVOm4MkqKA8FsK+0m94p1aJTw==
X-Received: by 2002:aa7:928d:: with SMTP id j13mr7858221pfa.112.1552712384344;
        Fri, 15 Mar 2019 21:59:44 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r198sm1773595pfr.168.2019.03.15.21.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 21:59:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/4] PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
Date:   Sat, 16 Mar 2019 00:59:26 -0400
Message-Id: <20190316045928.31934-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices_suspend_noirq, device_suspend_late, device_suspen functions
are basically the same. As we have seen:

static int device_xxx(struct device *dev)
{
       if (dpm_async_fn(dev, async_xxx))
               return 0;

       return __device_xxx(dev, pm_transition, false);
}

The DEVICE_SUSPEND_FUNC() helper macro can decrease
code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index cb44bb6b2b66..6026bda5e787 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -719,6 +719,15 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 	return false;
 }
 
+#define DEVICE_SUSPEND_FUNC(__func, __name)				\
+static int __func(struct device *dev)					\
+{									\
+	if (dpm_async_fn(dev, async_ ## __name))			\
+		return 0;						\
+									\
+	return __device_ ## __name(dev, pm_transition, false);		\
+}
+
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = (struct device *)data;
@@ -1369,13 +1378,7 @@ static void async_suspend_noirq(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend_noirq(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_noirq))
-		return 0;
-
-	return __device_suspend_noirq(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend_noirq, suspend_noirq);
 
 void dpm_noirq_begin(void)
 {
@@ -1568,13 +1571,7 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend_late(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_late))
-		return 0;
-
-	return __device_suspend_late(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend_late, suspend_late);
 
 /**
  * dpm_suspend_late - Execute "late suspend" callbacks for all devices.
@@ -1829,13 +1826,7 @@ static void async_suspend(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend))
-		return 0;
-
-	return __device_suspend(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend, suspend);
 
 /**
  * dpm_suspend - Execute "suspend" callbacks for all non-sysdev devices.
-- 
2.17.0


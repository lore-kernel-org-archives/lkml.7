Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F146C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241DB206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lvt/2Ps1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfCEMze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:55:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36293 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfCEMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:55:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id v10so7510084lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gWyEqHA/4lgOIuTcQX9h9/NrX1gZ//qhXqd0YHJexV4=;
        b=Lvt/2Ps1sQsZNLREbbQRguwhDwfRM3dChaip9tVgk9TLS3bFs0qdNMIFa05LbPanHZ
         N9zqUUv1hVoc8/B8t5vWsH4Xex4+5xGf+/0fLASd/FA6nbzw4das4awKIDyPLZt4h4Ag
         B072r3reqV+ug8iU91tfbr2gDgWZYHm99FzMOqfKXilkSILchk14bzdPaBe0oog6XOD4
         XTa1qzf7IB+qienZIiZw0clEcn7MfQf9zeoj6+7g9m7lUssnGxtLjRNZ+QP+d89d4ozq
         mmF16CGeG6MDQTegZ3avZbMlIJA45R862GQNEuVwYZDG2hiF8e2S2bN0+VL9EMokUW9J
         sOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gWyEqHA/4lgOIuTcQX9h9/NrX1gZ//qhXqd0YHJexV4=;
        b=uSmu3VUbOHSAjP4SzSD69M82tZfHTzxNYDWH14vVYadQdCtVylJm+loGwMTPzQaOsf
         OQ0IMaiN7zvTuiX4g4r70TsiV0wAPfgnjNxbiB8m0GtGeMTQ7J+rPjEHrYtL/XPZZhvl
         Cdrvl+zPpBOP3Gln4N/xSrffulXBi/nlVqVCmpX6GMYSUo2AUGEgtc9tQ8+xrjyEaxJY
         Pmr5/k9rY3emM9PNYUg/SwEfPfD+qLO/xt46bxZhH1vs6FzWJI5puAMWqxWW+tpWXxll
         2DH5uicFPDSdEgz2ux7XH7OjjLoxKry2uSguDxuLjoladwku/cZkA7XUUyJo0wX8SjVB
         1xTA==
X-Gm-Message-State: APjAAAXiFxC/v/RKlV/rqlgFyVKHIiAne/mWdACF6701Ezr9Ha4OcAtI
        xvbsK7lC4IZX4EeIGHGbvhlMxg==
X-Google-Smtp-Source: APXvYqykXo951xPI4G3ZyPY38e+LHgEgCM/dc0wcZ9IMF+6vbQFvK5Cy1GjbQv1p0/K9Ia5RJBLsww==
X-Received: by 2002:a2e:780a:: with SMTP id t10mr11978377ljc.19.1551790531531;
        Tue, 05 Mar 2019 04:55:31 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l20sm2104499ljb.24.2019.03.05.04.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:55:30 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM / Runtime: Consolidate code to get active/suspended time
Date:   Tue,  5 Mar 2019 13:55:26 +0100
Message-Id: <20190305125526.21360-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a step to consolidate code around fetching the runtime PM active/suspend
time for a device, let's re-factor the existing pm_runtime_suspended_time()
and add a new corresponding pm_runtime_active_time(). Make the latter
shared internally to the PM core, as in following changes it starts making
use of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/power.h   |  1 +
 drivers/base/power/runtime.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index c511def48b48..ec33fbdb919b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -21,6 +21,7 @@ static inline void pm_runtime_early_init(struct device *dev)
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_reinit(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
+extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
 #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 78937c45278c..d1908fc422cc 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -98,7 +98,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 	dev->power.runtime_status = status;
 }
 
-u64 pm_runtime_suspended_time(struct device *dev)
+static u64 rpm_account_time(struct device *dev, bool suspend)
 {
 	u64 time;
 	unsigned long flags;
@@ -106,12 +106,22 @@ u64 pm_runtime_suspended_time(struct device *dev)
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	update_pm_runtime_accounting(dev);
-	time = dev->power.suspended_time;
+	time = suspend ? dev->power.suspended_time : dev->power.active_time;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return time;
 }
+
+u64 pm_runtime_active_time(struct device *dev)
+{
+	return rpm_account_time(dev, false);
+}
+
+u64 pm_runtime_suspended_time(struct device *dev)
+{
+	return rpm_account_time(dev, true);
+}
 EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 
 /**
-- 
2.17.1


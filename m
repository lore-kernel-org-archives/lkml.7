Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D525C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFBD206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2DNdgdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfCEMzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:55:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39848 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfCEMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:55:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so7496055ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lqBcCIf/d3yMHBCDc7uCjcM4/5sbo4a5Rm1FkoZ24m8=;
        b=p2DNdgdH9eMxR2E++Lrar2GThCfCbYHvgcFwiJwd+ePO7f+tA7lQ96cnNnbNAqNnWP
         Pju+2X728td6pviAx3KqA9zUpXvon2i/iSdFEftfLYwVIKF0PXfZLtV1zclijEhJRzWJ
         nNyzfXRksVQdaI5OlYlNkdRbNCjYUIKy5r1iRSpGtxLrslZNZt1jk+3xP4kaoxgegHfb
         TcIH9krvOimL4kBuuwt6RLgM91wq1teTbgHh4H3IrE0pE5I/NVUnfx3KiQ2tRA3SHJtB
         XO5SlA+faA3NCuU70vpDtyzpzkE/L+5bY9yG3/PgFL+nfa8siydPRSPswY/klOtI0xyM
         43sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lqBcCIf/d3yMHBCDc7uCjcM4/5sbo4a5Rm1FkoZ24m8=;
        b=bqx0Wp5ldXjuiPGuJqYtTNdYLWkOgiKs3yas0/7wcClaQjC1FXDInYTX8rewVeFOtO
         MdR+9xHi5fRa/7pJgwIdsuw/2low8da9NeG51gH/AJCvwyvRPy8kF3V1qEtgk5X60wCu
         25qU1kXbKLiC4Xj2PgVbW2qBrAGJN41UlC3f/zBSzQCeJ/4oQ4krPCEExBzOjxzyXp5o
         UqbJbEp4KJ3r6Zk1PjNIOMQc9yRRzn4lgd8kQtfZhvkW5Q9X67E68vAZI1VGxeuhflyC
         cjRowEPm9B0QMtNB3LHzmXzXyHirmpUPFntq7c8PkPuHv65RnmBqm79at2od7NH8tuxv
         UxQw==
X-Gm-Message-State: APjAAAUP/98otBgKAxut1IV5WCMpmSSwp6hU3dGLCYcJsyQuObQnMLN1
        mq9Vl0vGmARWQ8+/9BlTvNN6LA==
X-Google-Smtp-Source: APXvYqxTdspo6Pc6tE+bHBjMOehdXVbcah5poJiNRYfhzjPV7k6ExH/yenBBeF30aHV7t6Jul5Jlag==
X-Received: by 2002:a2e:2285:: with SMTP id i127mr13833745lji.40.1551790539141;
        Tue, 05 Mar 2019 04:55:39 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m1sm443898lfh.36.2019.03.05.04.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:55:38 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM / Runtime: Use pm_runtime_active|suspended_time() from sysfs
Date:   Tue,  5 Mar 2019 13:55:35 +0100
Message-Id: <20190305125535.21412-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid the open-coding in runtime_active|suspend_time_show() and
convert to use pm_runtime_active|suspended_time() instead.

Note that, this change also indirectly avoid us from keeping the
dev->power.lock held, while doing the do_div() and the sprintf()
operations, which is yet another improvement.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c |  2 +-
 drivers/base/power/sysfs.c   | 12 ++----------
 include/linux/pm.h           |  1 -
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index d1908fc422cc..17136da0bb6a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -64,7 +64,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  * runtime_status field is updated, to account the time in the old state
  * correctly.
  */
-void update_pm_runtime_accounting(struct device *dev)
+static void update_pm_runtime_accounting(struct device *dev)
 {
 	u64 now, last, delta;
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c6bf76124184..1226e441ddfe 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,13 +125,9 @@ static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
-	u64 tmp;
-	spin_lock_irq(&dev->power.lock);
-	update_pm_runtime_accounting(dev);
-	tmp = dev->power.active_time;
+	u64 tmp = pm_runtime_active_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
 	ret = sprintf(buf, "%llu\n", tmp);
-	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
 
@@ -141,13 +137,9 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
-	u64 tmp;
-	spin_lock_irq(&dev->power.lock);
-	update_pm_runtime_accounting(dev);
-	tmp = dev->power.suspended_time;
+	u64 tmp = pm_runtime_suspended_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
 	ret = sprintf(buf, "%llu\n", tmp);
-	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06f7ed893928..66c19a65a514 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -643,7 +643,6 @@ struct dev_pm_info {
 	struct dev_pm_qos	*qos;
 };
 
-extern void update_pm_runtime_accounting(struct device *dev);
 extern int dev_pm_get_subsys_data(struct device *dev);
 extern void dev_pm_put_subsys_data(struct device *dev);
 
-- 
2.17.1


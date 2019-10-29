Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0785CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BCB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHYClrty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfJ2WGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:06:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46779 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfJ2WG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:06:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so11685826lfc.13;
        Tue, 29 Oct 2019 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DA0uvhs8DIoBh1CWracS38Bzq8LzkULaFtY91qkNA3c=;
        b=MHYClrtytEHvOQYdNIgd07qJKbkRDZIZjASCwTuZJsaOddiGXFXlEgHnDHLNOj4Bms
         m4NkP4YDigXhuy06/Z7Ei6UROIWjyJ9mRTVRzrKSIuG5kgSmbsE31431tlTaKLA26y7m
         C5x693ChZS6HEkaVg7BmJuH2sGlZAqvmuFSz+v+1dbgHUAiAoQq/H2L+1AR9mBLL1V8Z
         rSyFPvoZvbOw6ufTMBUjKUBISGfWFxx5ZolJTGohwcFhFLctW2ThtCywdbc+4FvYN8cm
         TvAZBtyD3MjAfpperrtIG/KbbIPXPm9upZrvKh2WvBEsb/vkN7fnRQsRVkPgRvN1xJbZ
         Pg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DA0uvhs8DIoBh1CWracS38Bzq8LzkULaFtY91qkNA3c=;
        b=nCDkWwgZjcHkO2ICg/WF70OQkIi7mJmKgX7ZHtH8xl6Ng8jvlIIodOWA66Vqx++Vxc
         mNYcYQmuqdRvJ6fMfUZJtd75XmDdc07NNTPa9OvYq/s144ER/NLhIG4nxEpQwJpwLNI1
         xVgPCElw0NASFaljuwUhC84k/KKYZZJGCcszx0JtYCK+8sekJVAABu10xXs190KrVzwn
         jRd+ia9+xTWU1RgEYVbtwzh7B1vqoHjsqNXeDyzp+YkR3MHrXZGjlbhIHMyXTwNvPCki
         voeNxW0OCoUSVukEnj3tMemNm1csZ4rcVlxzEbadyhmvI85gN/E4aZtWIvUD65pChwEh
         YHIQ==
X-Gm-Message-State: APjAAAU0gCZGj37dNAG57tUZDGoA3Mj2riZKlWWZUHydn0afU88Etncg
        ox0QoMgz4D/fTqeUbzZvN6k=
X-Google-Smtp-Source: APXvYqwcmxKBCGrkkdSfTJoQ1qyaieNhFYp3EQL35Nx5Syni2sEI8zK+apWr9bY+sXxZCduVy4RjPg==
X-Received: by 2002:a19:22d3:: with SMTP id i202mr3759207lfi.69.1572386785527;
        Tue, 29 Oct 2019 15:06:25 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/19] PM / devfreq: Add new interrupt_driven flag for governors
Date:   Wed, 30 Oct 2019 01:00:16 +0300
Message-Id: <20191029220019.26773-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently interrupt-driven governors (like NVIDIA Tegra30 ACTMON governor)
are used to set polling_ms=0 in order to avoid periodic polling of device
status by devfreq core. This means that polling interval can't be changed
by userspace for such governors.

The new governor flag allows interrupt-driven governors to convey that
devfreq core shouldn't perform polling of device status and thus generic
devfreq polling interval could be supported by these governors now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c  | 14 +++++++++-----
 drivers/devfreq/governor.h |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b905963cea7d..0ef972264841 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -410,7 +410,8 @@ static void devfreq_monitor(struct work_struct *work)
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-	if (devfreq->profile->polling_ms)
+	if (devfreq->profile->polling_ms &&
+	    !devfreq->governor->interrupt_driven)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 }
@@ -474,7 +475,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 		goto out;
 
 	if (!delayed_work_pending(&devfreq->work) &&
-			devfreq->profile->polling_ms)
+			devfreq->profile->polling_ms &&
+				!devfreq->governor->interrupt_driven)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
@@ -518,8 +520,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 
 	/* if current delay is zero, start polling with new delay */
 	if (!cur_delay) {
-		queue_delayed_work(devfreq_wq, &devfreq->work,
-			msecs_to_jiffies(devfreq->profile->polling_ms));
+		if (!devfreq->governor->interrupt_driven)
+			queue_delayed_work(devfreq_wq, &devfreq->work,
+				msecs_to_jiffies(devfreq->profile->polling_ms));
 		goto out;
 	}
 
@@ -528,7 +531,8 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
-		if (!devfreq->stop_polling)
+		if (!devfreq->stop_polling &&
+		    !devfreq->governor->interrupt_driven)
 			queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index bbe5ff9fcecf..dc7533ccc3db 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -31,6 +31,8 @@
  * @name:		Governor's name
  * @immutable:		Immutable flag for governor. If the value is 1,
  *			this govenror is never changeable to other governor.
+ * @interrupt_driven:	Devfreq core won't schedule polling work for this
+ *			governor if value is set to 1.
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -49,6 +51,7 @@ struct devfreq_governor {
 
 	const char name[DEVFREQ_NAME_LEN];
 	const unsigned int immutable;
+	const unsigned int interrupt_driven;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
2.23.0


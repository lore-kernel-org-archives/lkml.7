Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B5C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2121D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONhgFHtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443257AbfIYSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:43:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439865AbfIYSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:43:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so4167551pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dp/NSvE8NWfdQurQ537pyCkYPqYnLNYFA74Wx6NC3yM=;
        b=ONhgFHtPOVQf/nU9i+9dQ27S1t5BQHbj2Jt8SoyakVnoyMKuOnFiBnUpAm0uaIWRDB
         uO+wnpVI2owNRCqsLRvu6G55iu9D/qCrAXRQAkAR8VAX/Yj3Jdv4FgBNmbQoe+uqTJ1P
         GwRzdh32/2iBGJtzJ/k9keEIcf7jgvTdENxcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dp/NSvE8NWfdQurQ537pyCkYPqYnLNYFA74Wx6NC3yM=;
        b=Uk5ORbVURmwqAUHmnC4yL9qb6ZKZCoC+ZKgUVZLSmRqyqllP1oANAPps2tv+wt0mQQ
         DkobWB7qrib2go4cFFrdZnWjVPsKiL5BI3C+lyXClMN0uUbEsF1xauJcLISsI0GCCBjB
         LxatRj+I6u4FtHpoWJcya2bLkfFN2viZKHXgEVNkq83VkDbSur4b2FyZd6aXcGTloHoT
         /2wNLKNhGxZ69Ta1skitVLj4eirQQqqu3GBK4G4/0/CLDmofQwOsKPLKYuPucUNUFru8
         UKOMKKsbY1FQ6DSVn/CliQyMhP1D9rsKrSWRhUIfvKoInXqo6oHgIn/kUIo22hXouSyh
         SiDQ==
X-Gm-Message-State: APjAAAWmfH+wZeuQFZQPsKJb0fO9nhzWs9XbNQGFjaX+d7+96EfZc18V
        JvIo/Y1mH8tO9XAnAsq2kdEsxw==
X-Google-Smtp-Source: APXvYqxs+hH1f6mq7/5x/k/mgP3v57zNyo4tQ9YCxWrTOaR7LjdDPeBa2Nq6qrQirdoZK5iQUXD1XA==
X-Received: by 2002:a17:90a:7f95:: with SMTP id m21mr8343380pjl.73.1569436998108;
        Wed, 25 Sep 2019 11:43:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e65sm4952047pfe.32.2019.09.25.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:43:17 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] devfreq: Rename devfreq_update_status() to devfreq_update_stats() and viceversa
Date:   Wed, 25 Sep 2019 11:43:13 -0700
Message-Id: <20190925184314.30251-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devfreq has two functions with very similar names, devfreq_update_status()
and devfreq_update_stats(). _update_status() currently updates
frequency transitions statistics, while _update_stats() retrieves the
device 'status'. The function names are inversed with respect to what
the functions are actually doing, rename devfreq_update_status() to
devfreq_update_stats() and viceversa.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
We could also rename the current devfreq_update_stats() to
devfreq_refresh_status() to make it easier to distinguish it from
devfreq_update_stats().
---
 drivers/devfreq/devfreq.c                 | 12 ++++++------
 drivers/devfreq/governor.h                |  4 ++--
 drivers/devfreq/governor_passive.c        |  2 +-
 drivers/devfreq/governor_simpleondemand.c |  2 +-
 drivers/devfreq/tegra30-devfreq.c         |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 446490c9d635..fb4318d59aa9 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -151,11 +151,11 @@ static int set_freq_table(struct devfreq *devfreq)
 }
 
 /**
- * devfreq_update_status() - Update statistics of devfreq behavior
+ * devfreq_update_stats() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
  */
-int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
+int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
 	unsigned long cur_time;
@@ -191,7 +191,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	devfreq->last_stat_updated = cur_time;
 	return ret;
 }
-EXPORT_SYMBOL(devfreq_update_status);
+EXPORT_SYMBOL(devfreq_update_stats);
 
 /**
  * find_devfreq_governor() - find devfreq governor from name
@@ -311,7 +311,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
-	if (devfreq_update_status(devfreq, new_freq))
+	if (devfreq_update_stats(devfreq, new_freq))
 		dev_err(&devfreq->dev,
 			"Couldn't update frequency transition information.\n");
 
@@ -450,7 +450,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 		return;
 	}
 
-	devfreq_update_status(devfreq, devfreq->previous_freq);
+	devfreq_update_stats(devfreq, devfreq->previous_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
@@ -1398,7 +1398,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	unsigned int max_state = devfreq->profile->max_state;
 
 	if (!devfreq->stop_polling &&
-			devfreq_update_status(devfreq, devfreq->previous_freq))
+			devfreq_update_stats(devfreq, devfreq->previous_freq))
 		return 0;
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index bbe5ff9fcecf..e11f447be2b5 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -64,9 +64,9 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
 extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
 
-extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
+extern int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq);
 
-static inline int devfreq_update_stats(struct devfreq *df)
+static inline int devfreq_update_status(struct devfreq *df)
 {
 	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
 }
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index be6eeab9c814..1c746b96d3db 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -110,7 +110,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 		goto out;
 
 	if (devfreq->profile->freq_table
-		&& (devfreq_update_status(devfreq, freq)))
+		&& (devfreq_update_stats(devfreq, freq)))
 		dev_err(&devfreq->dev,
 			"Couldn't update frequency transition information.\n");
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 3d809f228619..2cbf26bdcfd6 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -25,7 +25,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
 
-	err = devfreq_update_stats(df);
+	err = devfreq_update_status(df);
 	if (err)
 		return err;
 
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a6ba75f4106d..536273a811fe 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -526,7 +526,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 	unsigned int i;
 	int err;
 
-	err = devfreq_update_stats(devfreq);
+	err = devfreq_update_status(devfreq);
 	if (err)
 		return err;
 
-- 
2.23.0.444.g18eeb5a265-goog


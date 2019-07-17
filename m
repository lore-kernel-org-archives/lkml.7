Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEAC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EED217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnRzkWoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfGQWYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:24:08 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:40047 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfGQWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:24:04 -0400
Received: by mail-vk1-f202.google.com with SMTP id p193so11804551vkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hlgN2kJF8O2fjyDEv3zuJRNqQ1+92Wl3CueXhQyVzIU=;
        b=NnRzkWoN5/S27nZtGN8yKD37RUeIb30TAYui+l8MKkJjjOT5PipUtajEOAMDk3YNoc
         8PTBCgW0yWc1MCot3JFGVlX5HzIjsbmZczGK5SNXBXM6xPTUEjTFyzzAUFh66LXRZ2yf
         V49f5emTq5XuK2SSmMsDaN20WSehh/hCsKJ+cnTyJvPTXH6CtdFx0vRDarSfmgThKmdz
         bNj4bz2ocVw0o9Loue41WzGw0CyLlFFVs/s8DwT3wOQgsYug5wJZjnxA0QwV55V6XxDF
         JRjsdyUDNLiB5KUNQtrXX51GVqXwEjhJvFrupEnXsyMIpNF0B3yA23l9dvCmdFsRQZ2u
         Zo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hlgN2kJF8O2fjyDEv3zuJRNqQ1+92Wl3CueXhQyVzIU=;
        b=QiezB5FE2sn74A4k3qjGTweh6ybQ36At6iOe1taVqbiIqwqZF1JPMJJ2lLTo8YmYhH
         jxuVyuOJNAk1+eD7/gJAPN0/ZkF7moUv4XMukXhol1RfAmGOVxWiyVxs8UhA40VIQ9O6
         GbjxAi7kg0fML6/XhLiOivdfoj0Ajd2bVm+UDVGymwi9vKaQYA4Nx8L7etGaOV79SyiQ
         xGtVAmhkY8zxNlt9CAsN46fVonq0iwSccm0xR7nyg/GCgAgbALOd2zAfOwpF25RT4e5Q
         hPTYrAnrSwuvIv5rs2GJ3o7Bu02tf/1oYJoL7Vi8RFSq7p4dnJpOm2DQhZGwVI0y+JXe
         qmMQ==
X-Gm-Message-State: APjAAAUZPujhmJAtP94K54cB6LENBWcw21RlGS6OGEc6zc8ZSqyDv5Kr
        UusQ4mFbjvd9W67oZoIFVfkhhBZWumFHo2o=
X-Google-Smtp-Source: APXvYqxT7Vys34+uPXtEl++ZtCFPgc1bYc+kkS7nUGHqMGkJzXWLXdIw67qCU6GNH5aCIzUf7VLs2KSSKQQV+0o=
X-Received: by 2002:a1f:6e8e:: with SMTP id j136mr17525706vkc.80.1563402243539;
 Wed, 17 Jul 2019 15:24:03 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:39 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 4/5] PM / devfreq: Cache OPP table reference in devfreq
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP table can be used often in devfreq. Trying to get it each time can
be expensive, so cache it in the devfreq struct.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 include/linux/devfreq.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e4f931..7984b01d585d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -594,6 +594,8 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	if (devfreq->opp_table)
+		dev_pm_opp_put_opp_table(devfreq->opp_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -674,6 +676,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR(devfreq->opp_table))
+		devfreq->opp_table = NULL;
+
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..1c05129f76c0 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -116,6 +116,7 @@ struct devfreq_dev_profile {
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
  * @governor_name:	devfreq governor name for use with this devfreq
+ * @opp_table:	Reference to OPP table of dev.parent, if one exists.
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -153,6 +154,7 @@ struct devfreq {
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
 	char governor_name[DEVFREQ_NAME_LEN];
+	struct opp_table *opp_table;
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.22.0.510.g264f2c817a-goog


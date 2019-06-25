Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47885C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7082085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph4Tz/3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFYVd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:33:56 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50344 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFYVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:33:52 -0400
Received: by mail-qt1-f202.google.com with SMTP id g30so143241qtm.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lpO4xjO0dM1h5Blpl/u+aSxMu+4T0qkcqrt5hW3H2qY=;
        b=Ph4Tz/3vcNuZ/WoEa6GYfePulm3GVZ4kU2VTUl4xi8WiaIEzqgtKU6RkGGEnwHXhhZ
         9vPvuryB17TSn9+Kp7LY1Gx5YrMIUz31583R/36kO/hMTIOoUV/sn5MclPgXsyQEdaLL
         WIe6divrdg6dWVjVEtjpiRsJwBEjA3bUGGFOMh4RHSgdB0xTwnKtTJwOoyaWrnMMYpAd
         QbMOf2mWXpegBj97lH2TEYZO3vf1dqaVfiROuXLySE89NxbGN8FrK94c3FRoqevPnQT7
         /FP1bPaZab4eIe5MhuWr/0DIfUBi2MH8sIArazkMN18QtI3T40b8uhGx83jsqsSJRcDF
         EgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lpO4xjO0dM1h5Blpl/u+aSxMu+4T0qkcqrt5hW3H2qY=;
        b=HMLRQA+Ogm6la/w7eORQukv+Z60TNB9NV0eNjqM2458WGwXP4eraCttiPj5FDvJc/T
         jyvU5Ue/a6vZb7eLymmm2xdFKfBR5BSFreu44zHRAmee/FPB2o6xrF7CAn4oEmLfbCL4
         Tc0hgz0LN1ZcuRRY6EaiIgoT9ZhIJhr9MTpdiHteyE1EwaQTO17LYjmISWgfOIrVsGsp
         zPIQl5SZF+6MqOugv9b235BbWKH1DcqWLghn2yrwS59R8ssxQ+IrOS3fE3muMjapADPA
         qnNE06wv74+cI7VN1Sa8fNwO/ic+N9bexISO/OBiacFor6y52fm9hMbfL9xDdrq8mnuF
         UrNw==
X-Gm-Message-State: APjAAAWV0yTwKZOURxDdkAxKCHcb0/frh/njV98n6IybrmnScyoqDLuV
        v1GmZkLxsEtM/Sj9Zz7SPcMC6Z9aktNcmLA=
X-Google-Smtp-Source: APXvYqxpfEm4nfiU1Dwk713424NCd7N55o3hovecqBTIbBVv3igByEAc4gkvXHdQsHautnOyLfUSl1qXDiJbjhA=
X-Received: by 2002:a37:a648:: with SMTP id p69mr815052qke.136.1561498431578;
 Tue, 25 Jun 2019 14:33:51 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:36 -0700
In-Reply-To: <20190625213337.157525-1-saravanak@google.com>
Message-Id: <20190625213337.157525-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in devfreq
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP table can be used often in devfreq. Trying to get it each time can
be expensive, so cache it in the devfreq struct.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 include/linux/devfreq.h   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6b6991f0e873..ac62b78dc035 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -597,6 +597,8 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	if (devfreq->opp_table)
+		dev_pm_opp_put_opp_table(devfreq->opp_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -677,6 +679,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR(devfreq->opp_table))
+		devfreq->opp_table = NULL;
+
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74bfc1b..0d877c9513d7 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -156,6 +156,7 @@ struct devfreq {
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
 	char governor_name[DEVFREQ_NAME_LEN];
+	struct opp_table *opp_table;
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.22.0.410.gd8fdbe21b5-goog


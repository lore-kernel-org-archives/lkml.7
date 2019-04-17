Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D2C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09FA217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0+T6SRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfDQWkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:40:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:40:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so141012pfr.4;
        Wed, 17 Apr 2019 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUeEb4L2PznAGGX6A12fvqFt4+0O7XpXxOJtNihy39E=;
        b=V0+T6SRj/yCzAmOAxViE12CwL/16gs7B8ptaNnnsR/geJPMLtoYHlTLSfEAnHxUeeU
         ECn0QYbWn3FBD1GdTHkW85fwuu5b2MiMmt7MiMytOvdGJCCKpLtthiVDArdcaBNCyh9R
         LevxLX+amq38n3kewC1dtRM21QcF6TEikMQI7fM0umyJRIjidPWYHUTaqLFpVZ3gkgSY
         uwF6tfXfCfk0mnpxZHDlOqI4YyZ8zj2qjR3O6xWmUf/KzAdElnzrDpDgYtGDWk2HCI31
         iFYrLczEX6Ybj3hPewKjRGa3KCrblEii4FrXJ6XF4v0YVefXe6SoTpwlN+cWsjR/8avX
         OhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUeEb4L2PznAGGX6A12fvqFt4+0O7XpXxOJtNihy39E=;
        b=fhUDTqbrcuLtM8yOYyoWbPmxv4NIPejFRP9T5nPsm4YZgA/ypGxzPR4jcFY4tcaBDD
         XSDdh8Pgw1aEvXYzHCUtLkGLofz8zRQdclirYV9gU0tAbeSIRLOneiwqP6ouh4VekN/F
         ObjPLB2mqSTsXpsPZmGH/5eVowZYLID5P1ZJXifpVf1VYAb6pyMLao9dItg5KSx1D2kr
         qy46zTKdZHhsJLwsCeGXVCmlXrpJuHIcH/TmIyBYCvOp17ajupHXUnIa4FpHnudZOnJq
         Oz+AcLREOqz7KtgfDasoAskoTEqfP+qNnCkjLqjtryfASKs7ObrEqG2FQA31UDUygRl2
         vHlQ==
X-Gm-Message-State: APjAAAXeoArvb8q89+KnBW+qMBxbOuEM2nSs9Hqhr7xFRcIt2A4YnXUY
        Vkc8B1Ir+RmM9/2M2CSKvL4=
X-Google-Smtp-Source: APXvYqw+fS97NbUebTghjOHpeoA2FJoUCKFmtWv421Bmr9husj2TTWqPojpS/1lS6tRd2xX4Kb6c6w==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr91170819pfg.130.1555540497790;
        Wed, 17 Apr 2019 15:34:57 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 09/16] PM / devfreq: tegra: Avoid inconsistency of current frequency value
Date:   Thu, 18 Apr 2019 01:29:18 +0300
Message-Id: <20190417222925.5815-10-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency value potentially could change in-between. It doesn't
cause any real problem at all right now, but that could change in the
future. Hence let's avoid the inconsistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 70946e432d3c..d72c16752012 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -509,13 +509,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
+	unsigned long cur_freq;
 
-	stat->current_frequency = tegra->cur_freq * KHZ;
+	cur_freq = READ_ONCE(tegra->cur_freq);
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
+	stat->current_frequency = cur_freq * KHZ;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -526,7 +528,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
+	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
-- 
2.21.0


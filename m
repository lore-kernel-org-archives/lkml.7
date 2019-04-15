Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD223C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF0220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOVlKkZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfDOO6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:58:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDOOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so15917751ljk.13;
        Mon, 15 Apr 2019 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN0Iq3Exkoe+g1IIlpsrZ/u3RxUCLf9jrmAQR40qhw0=;
        b=SOVlKkZ6C1fg13f+L3rNssmXT2jRFGN4OOi5XnNzT8xgr+ySe2A+hPsxKQuOGybJkY
         6bSVuPlwIZgmodrBQOKpYX7gjxQfLK4YrKOVk1gICVDWTQfsHVEdF5ot/KxKJI7fueDn
         aP9Mk1sNWOTwj/xNHYPqzE3sBICVZXFwnsZ6zb8BiKs6dTFZdwL1bE3UZFHZTWniCQs8
         6wGBC8k/qtQSOlCCMPjD3Mg8+Cwhul20QD+RZDcGD3MpRc6tnfs+1rqYdooaMMZ100/T
         Vyet6ANuzl2Id5B2McdcZKLNwTsKlEjIh63Amgj43pDdy3M9XPN0e0wD9nufwkf9+sVn
         PKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN0Iq3Exkoe+g1IIlpsrZ/u3RxUCLf9jrmAQR40qhw0=;
        b=P115ENPZowvSqdGhMrRdM+T87HH+Z0KtNI77k2lBVa07LaSw93PM4+elGmy2durERf
         xtHHNWcT1EbiHXYiMplZTiCNxmXHurO8o52H/jBrilbdNY6HT1HqhucKRShwanocgwYd
         NjrR0A9zhkCMbXQoSyiOnivPSIQQ+kd9RCqZ3CCsbT24/tYiYvvk0X2im3zHYkl7D0FE
         71uSkiSwMKT7pBO21M52Tp/796/00D6kHPiaHM8sB0ecULvUMuDqxY0Uzlpn5Zxs0wSD
         7xCyc+ObTfJ5XqtHK1JVbKCsMrAS49f8QYN4sLCYF1p9bsmsLnPny8y6t/xJG9hSYdIz
         wDqQ==
X-Gm-Message-State: APjAAAVhX2164/v9wVjSqcy75p8T0Ow0q/7ekCQzb6lhhPdK+qwbWshg
        TNA+RMdrRO9CvFYEViGaQs8=
X-Google-Smtp-Source: APXvYqw20O0sIuZ5Rwb0n+gJumFLmZUNIC+os7tFM+w/O6oSB+iXnigvBFmHezrd52qDcT6viY4lfw==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr17316128ljj.21.1555340138094;
        Mon, 15 Apr 2019 07:55:38 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 03/19] PM / devfreq: tegra: Don't ignore clk errors
Date:   Mon, 15 Apr 2019 17:54:49 +0300
Message-Id: <20190415145505.18397-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_set_min_rate() could fail and in this case clk_set_rate() sets
rate to 0, which may drop EMC rate to minimum and make machine very
difficult to use.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 0c0909fba545..69581c9082d4 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	unsigned long rate;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
@@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	clk_set_min_rate(tegra->emc_clock, rate);
-	clk_set_rate(tegra->emc_clock, 0);
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.21.0


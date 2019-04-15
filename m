Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4675C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24DF20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFB/D+48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDOO6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:58:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34895 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so7445480ljc.2;
        Mon, 15 Apr 2019 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyEWyd/0/FOQqZopdUl0UO49wVaBKveFMv7rmBv9s6k=;
        b=iFB/D+48kanPXUd9c+KTDTPEaK2DGIPtI/y1W+50te+5dWUK8c80SnQWmjgu530V6C
         neE+v4gjVqDulAvJsAm2FMeAQ7dIU84nAq38pGbtgSgHOMnxeNWKuWeViO4iuFC1//+6
         Ue6uwZiT+mxf/njtGDYaK7dWt4amiqLeFqHQY4BRTxX05wON+At/QDQUXoBRrgFWysrH
         rf31ZzZjr/5odEaZrSg+lI0S6w0fEkMDj3JuFrE2ndY7XD0rDdxwjrPXx8zg/OU5LJy9
         ubPRwudVSXOkH4KWMXNu11H/EaYMQdms54xTu+sQpIMP7ne/ub44+6wgii1w5mW15HF8
         6fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyEWyd/0/FOQqZopdUl0UO49wVaBKveFMv7rmBv9s6k=;
        b=F7BDc8BnwT7iH5ARLgfeAmws2Dj+qw/PZiUQpPEYZuu5k1ViCRF9AH8ZQx5nUsjar8
         XbBnneNYt/IKLjiU1p187YLB5ZJyHyrZKM/QhcflpO7qfMM/o1k6ySS9RYZ5qZq/wFBJ
         Ypfc97UCzv5t1dJ15/fglyiWUGuzfTJ8sqatT8DDMlopN5SvkJddhjjWn9mtFU5zSKZ5
         kvqE/AzWFrx3gfRvxHgnfRWs0h7unsfqFc8YpyiipTiJtNH8SxRDvOBXtSrarX8rF+8p
         p/a/l5TAB8V7qDChLzzm8wtHdkMeFdRberhhkxjW4IdmKJlwQ28AQ8eNvnVU9Igr2r4r
         MmQw==
X-Gm-Message-State: APjAAAUCLRD4+/SjXrGfrSyQDRE4gRHXVLIyVelHEICu1e20E3vek/N6
        xBWsWQHupgCqyG9r3tog8pO1pwiL
X-Google-Smtp-Source: APXvYqxlHCj1h3ecJd5aGgmuZF3aw5DUepJt++1LHniEfWi7S0ndLg/AgcFkrd7YywmPYqQiPihItQ==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr27575063ljh.135.1555340135615;
        Mon, 15 Apr 2019 07:55:35 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 01/19] PM / devfreq: tegra: Fix kHz to Hz conversion
Date:   Mon, 15 Apr 2019 17:54:47 +0300
Message-Id: <20190415145505.18397-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
frequency scaling works properly now.

Cc: <stable@vger.kernel.org> # 4.14+
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..02905978abe1 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -486,9 +486,9 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	unsigned long rate = *freq * KHZ;
+	unsigned long rate;
 
-	opp = devfreq_recommended_opp(dev, &rate, flags);
+	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
 		return PTR_ERR(opp);
@@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
 
-	stat->current_frequency = tegra->cur_freq;
+	stat->current_frequency = tegra->cur_freq * KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq;
+	*freq = target_freq * KHZ;
 
 	return 0;
 }
-- 
2.21.0


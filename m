Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E74C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C319A20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClrIaoZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDKWaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43105 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfDKWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so6997200lja.10;
        Thu, 11 Apr 2019 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbTrxtZysIwn5iDlMzOsHBWMOUKj9H0CQz4iK6r7xp4=;
        b=ClrIaoZrqVJcHUyKQ9E7jPzHZTY6UjbpVhFOULYcNhiDS0kx9MUrg+xrNy0AP6800Y
         QGu9HqOW9hjI88xMHNXIbgOHCbqusL5rLhb/f+n0um4s9fePPFPPqzNt6uLoXj/U2q2W
         3WiM3y2+2cRbL57WmdLrGKpwS8Go4zkN9P/Nj7gK6ibXRYkUmB0lbpIEL7HWnhQJqPw7
         JY5nOosZoe8s6n21Y/GjI0q5FeFRwswedMXN8zeZxLfyfljd9yHoa/khYaUGXKWveD0F
         t9/LVo19e+0YEBxfyp5ddJe6SJXnQEwRlAgulw54w4vfdsTHBbNVduouXKbOAKURUUhv
         mMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbTrxtZysIwn5iDlMzOsHBWMOUKj9H0CQz4iK6r7xp4=;
        b=cbAQv5sTRi/Q6uBSkztzzFBYmQ7AG/ZHAjI8MkNngzJAbecEfYePGyhNMMzuIHrgdF
         Pia2LP2oxfla1D1eD+RkgbQyMSUMtCw1HxqmrZSD930gK5+kFlqZPEq4uKXycHihLa4H
         zmq3tip/MdLmkI6AeUH8KRPI+WqOl9xiYTvp2QYwC4byNPHu2U2aA4y6yFlbJAmlY7Rn
         hmigBQSlNAWQdIleX7sMn15njUnXfxGNcLnd6yVHOxfcM6GyAE0zikQal6dcvDi1FJM5
         iVtlCL/AVb3XcD9gJrxpKXWbRmVJ9r16vXFBkgpKJIFqfHEWC+Qi/P+ovgSjL7DWzKGp
         oBPw==
X-Gm-Message-State: APjAAAUtFKNMYad+pjfnSkBNEkYJMeBbmM3XuDRjnXxugVOU9xSUjWRI
        JJABY4bF4hTL8E2XGtZWk3s=
X-Google-Smtp-Source: APXvYqxQZAAOAPNfMXlx1PKIlSC8t1+RpzOM7HJ/3+aYu0IeHGGsLoaRq1tdJ9WyIt/efPtGMvkWyQ==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr2415168ljg.57.1555021806044;
        Thu, 11 Apr 2019 15:30:06 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 7/8] PM / devfreq: tegra: Remove OPP entries on driver removal
Date:   Fri, 12 Apr 2019 01:29:13 +0300
Message-Id: <20190411222914.25539-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes "_opp_is_duplicate" warning messages on driver's module reload.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 96f1e8e64e46..0985c02b75fe 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -691,10 +691,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
 
 	return 0;
 }
@@ -705,6 +705,9 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	u32 val;
 	unsigned int i;
 
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
 		val &= ~ACTMON_DEV_CTRL_ENB;
-- 
2.21.0


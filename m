Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A3C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF892070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgz75SUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGGWfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:35:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40210 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfGGWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:35:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id s145so8308417qke.7;
        Sun, 07 Jul 2019 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=Mgz75SUj6Os/EudqOEC/oBAyqgfTPVMfyIE8oEG4TWJBd5pvPJE3GL4gOQM7cBgb9B
         96QNKDj0hnltu1thjc9e1Br0BoujHjk1jfNLsFU5nKYetCLKuSYJOryiNnZ+66gEcBlF
         euRgHUu4jp3b21iDErEgsvhQ67mbuEiXST7Nkuw5tUqGG8WiVU/730iqxSqVunfPTdfb
         HptiByBY61179gR2xu278m/T7OBqGrdeTV41aL2GgjXTAJuyeaPmNsF9cu2tAmWJSmTq
         t9GpOsXQH0cBB4k51/lBxo8+iTWTZ3kFVk+GzpQHO7puzHLUwCIkUZWU55trWy9iXr2W
         ufsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=Y0YbP8MI7FDFn/gJUv7YJiuCfS7letkyk7Ry4FCPkKJjOkeWJRsyptI4B3HQlpK9mc
         xI+Q/MJQ14qZ9Uss0LHiJuZplLtuwMFAbQ9LlHu29kTBrczIg0rRE0B3n7OIklQPtz0C
         DJPSL9ntqDcj9Y7uMTt2ghyyp6kerYqC4RwsIUbKRwJ16f9TqygIyDkR181JRvWEHu5O
         pEorMcbphJT1Z+px190oDoWVwJGUYw8DpixBwwDgpUSNsxddUiHLLhWD2dsPAMjGcTSX
         Ohx+filllSofyfB4bA/azbR7QK94A4CSHiLX88x0DEPxnF/SPadS/WxZOmfOZYxc6s6S
         rxhQ==
X-Gm-Message-State: APjAAAU53B3Ey1gFLDGKw/yWJE2HEjwcdF9c8Zrq3IGywl6fQspL/it/
        WJON9g5gz908CLGvzclK7Yg=
X-Google-Smtp-Source: APXvYqwbavblSKuBFepupufoL+W7UvW2ZudBlD3FBiTWI2yAVYZ4gZRloa7pqqy/f72aOMYldgEVbw==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr11750419qkd.193.1562538911388;
        Sun, 07 Jul 2019 15:35:11 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/24] PM / devfreq: tegra30: Drop write-barrier
Date:   Mon,  8 Jul 2019 01:32:43 +0300
Message-Id: <20190707223303.6755-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need in a write-barrier now, given that interrupt masking is
handled by CPU's GIC now. Hence we know exactly that interrupt won't fire
after stopping the devfreq's governor. In other cases we don't care about
potential buffering of the writes to hardware and thus there is no need to
stall CPU.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5e606ae3f238..4be7858c33bc 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -230,12 +230,6 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 		      ACTMON_DEV_LOWER_WMARK);
 }
 
-static void actmon_write_barrier(struct tegra_devfreq *tegra)
-{
-	/* ensure the update has reached the ACTMON */
-	readl(tegra->regs + ACTMON_GLB_STATUS);
-}
-
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
@@ -287,8 +281,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
-
-	actmon_write_barrier(tegra);
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -376,8 +368,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
-	actmon_write_barrier(tegra);
-
 	return NOTIFY_OK;
 }
 
@@ -423,8 +413,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
-	actmon_write_barrier(tegra);
-
 	enable_irq(tegra->irq);
 }
 
@@ -439,8 +427,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
 			      ACTMON_DEV_INTR_STATUS);
 	}
-
-	actmon_write_barrier(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
-- 
2.22.0


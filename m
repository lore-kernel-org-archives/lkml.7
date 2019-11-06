Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED4C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC78218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y54iMZhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfKFN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:28:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35409 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:28:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so18892168pfq.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iZlXNo5QDi4Ku2OumCxTReBsuPP9X5fG3KsKTSejROc=;
        b=y54iMZhFsDkhFVspBHefTVsS0hpSeUoA3E6jZcdSI24ker0Pp8pVSHUKkHOnchnU2y
         bE3qmBDWjNZbAq+4XwhySlaLmsMnZ/V7IEwhs6HajcnVKTeVTuPwQcmh/HedpQx8YUgE
         4lZJmGpSURzeSqWHx3Cehn2x+RmRN8m0U3erKhQB2CDj4ScykGxNU4DmYjCNKxd5DbqR
         eOGiSGBesA+CLOh+by1tGNqI0KkNtofAJ6xCaueiAzznemhYiWztpVfVj7tH5tNqc4g8
         sTH+D/ReKhn2R0pteTZ0fOsKb8oNIbyMSIRcwCdwe7hceH3Be8Z4ysxaWGgd3bAvXFRt
         CGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iZlXNo5QDi4Ku2OumCxTReBsuPP9X5fG3KsKTSejROc=;
        b=je47dovrYpxFUkYtQ54hXyfaNCclXu5GxH0hFieWSSTTr2K+1Cft97ffl9c27XMBm8
         0YGoRw6/xvA6t3201/Z+lpa4Bj2OwfkwnU7mbH7ATiA2GQKFRXKQAynAfxaRU/JpmXVP
         ypEHhfyiZcHfvJXzmZUxaPI1r5aJHSzKTVxa8GIH3KX0A5LM/2T2uIm4iCHAMltvMD1f
         6txOWs0y/2AJui2Ta1KDJmf7wc+KjOZvmYVwt+fVAxmA9X6uhzLSA0B2ay0QfqRLyE5R
         MZ/DS9aZQxceaUrCbM0UrWHpb0sTQDhWAhCBCfXnEs7NuVot3OCz3UjXfJmIpCUVi1YH
         urmg==
X-Gm-Message-State: APjAAAWyyh87ddHNnnpDKcS++JvnZJEsgGUnGDQWOeJ5Ze8JsGTqGuj2
        rH89PGKPzNY58XZG/wisKeYxi/6EeN1qNA==
X-Google-Smtp-Source: APXvYqylDq4LroSCnkG+NIJ7kCS82rA20ZZVdTUzOtMvXKS2/99tTZNfrdM2gL5LpglHl3+0dWxrbQ==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr3803290pjt.38.1573046931527;
        Wed, 06 Nov 2019 05:28:51 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id u20sm6015923pgo.50.2019.11.06.05.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:51 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 04/11] thermal: devfreq_cooling: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:20 +0530
Message-Id: <fbaad8b0854e8127624e6b7bd5f1272eaf8aee85.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warnings with make W=1:

linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
function parameter 'dfc' description in 'devfreq_cooling_unregister'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff6..a87d4fa031c87 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -53,6 +53,7 @@ static DEFINE_IDA(devfreq_ida);
  *		'utilization' (which is	'busy_time / 'total_time').
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
+ * @capped_state:	index to cooling state with in dynamic power budget
  */
 struct devfreq_cooling_device {
 	int id;
@@ -587,7 +588,7 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
- * @dfc: Pointer to devfreq cooling device to unregister.
+ * @cdev: Pointer to devfreq cooling device to unregister.
  */
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.17.1


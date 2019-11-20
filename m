Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30260C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B32080F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyfzMEiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfKTPqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbfKTPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so14413566pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NSg5zBP2bkEtgf/AJ9lwtdlcJh9mMI+s8A/QE9EBrqI=;
        b=pyfzMEiXET5WNLh0lbzWH2k8Ma4kL/gchA2TSfgf9FOt77Ipge3tgeetL+B/eMQ3nQ
         qK74PRyKA6Xzfhp8SDKE8IDOG9FnvPqI6zAxyvVWg6TQP7y92eClE7VPgn5EQgevKmTn
         31isyeVwYrt/63T3W7c/7GYIA5cpiXc/FjWnfRx3+zoDJBZViOljMLADxrUxQ7RA6vsu
         R4P0FAggkEapQV9P/JrJvCvOqiJCr2EcBVxIorboYb7NdrqFEAaI3ZrbK10/PJQHQdmL
         XAbs0VUQKIfNCfpp8OueO+3Wys7vJrR6BqL9ZgscME+PrmMK7xFCfeyBCRbpBj9pzPrW
         baSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NSg5zBP2bkEtgf/AJ9lwtdlcJh9mMI+s8A/QE9EBrqI=;
        b=aYFBjUKWnqYuuEFoK4CDClmv2b6EBfDsLvG7ky/8znEIM7PXcAdVRmp99XwF05yC+t
         McZrOyxOoUaao7Hrcbha25Ci9k1IjD7xwvO7BCke0o5x8hJ2vdgjUtHxkx14M3uCbJYi
         OCdqyQGbW9a8KTqWdTF43gh1WpWu/tc29KvxaKPGXhaB4Yd2Clq4XqCt5iVIsk7lkQQe
         IPOlfSry8heOYoZUTHHysZmn77QG2g5qDwptyBEcLFiiClxkrUgHWJ9Bv/cM8FiNtZUg
         VAMdRIZwIj2mh4kwktAJOdWaT4VQeA2Tg7JKW4iDiRfj4dfxnVfDcML051zZEFJIS5NT
         AGVA==
X-Gm-Message-State: APjAAAXXzISYN3VHWwgQHy/rjDzhuAdMjtAspfcWSTmJPaRSZdqtHgH/
        QxDO5Qj2MPLjNZaCEbST7ZmKjB2x/ZHZBw==
X-Google-Smtp-Source: APXvYqzJUD458tw9LKLIOVTpzUVrazVeldBx+3/BvF6tmCLBMY2h07OohUoX/CJQd6M8piZEF0jNfw==
X-Received: by 2002:aa7:8b08:: with SMTP id f8mr4854182pfd.92.1574264757863;
        Wed, 20 Nov 2019 07:45:57 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id 125sm29559387pfu.136.2019.11.20.07.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:57 -0800 (PST)
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
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/11] thermal: samsung: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:17 +0530
Message-Id: <1ded1697c6e5eff11b034b3302b9c79e88fa9c42.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/samsung/exynos_tmu.c:141: warning: bad
line:         driver
linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
parameter or member 'tzd' not described in 'exynos_tmu_data'
linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
parameter or member 'tmu_set_trip_temp' not described in
'exynos_tmu_data'
linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
parameter or member 'tmu_set_trip_hyst' not described in
'exynos_tmu_data'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fb2c55123a99..8193b66a3f83 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -138,7 +138,7 @@ enum soc_type {
 
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
-	driver
+ *			    driver
  * @id: identifier of the one instance of the TMU controller.
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
@@ -162,8 +162,11 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
+ * @tzd: pointer to thermal_zone_device structure
  * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
+ * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
+ * @tmu_set_trip_hyst: SoC specific to set hysteresis (falling threshold)
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
-- 
2.20.1


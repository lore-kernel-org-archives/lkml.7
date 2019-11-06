Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707DAC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFBF21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mn966vw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfKFN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:28:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45808 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:28:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so6804101pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xqikAYh44q1RvKaIP5+2hl6tWdBpJ22RdpOXljk6mKo=;
        b=mn966vw3AW1uaRj57zIbm3u6xl/Aw9wAeNrB+fb2629K3AIHkxw/tKIq9xCOUIFzKL
         xBUHfSM7Mxeu1cLNyfYB/RNJyOPW/fmWeluDXCRYMs3oKvGBPgPTKrWuM6JXOXc7g8Ci
         JXFrBJbpapBuy/87Q4eLbgXshjS+lT2NS3BBEtvWvgdhq3k4QKsx1QTJ68ZpZ1E2SMQo
         ROock131JCmwxsgbRfOiYpvligGjk9P/uEAmQ1DTKuPyHw0upQrxDBfi6MvU1v5QCTBe
         G85aSo6ueIrQfuc8kNCfZ9H5Obe/YFdTJo04G1321jVx4dDxaeUY1oHPOlU1KCOPgykm
         p58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xqikAYh44q1RvKaIP5+2hl6tWdBpJ22RdpOXljk6mKo=;
        b=fMD56jQsMOuQaBEgh7pa/VrK1zBfOYXjFiInlyrQy08rCU3ElNuyNnpLCz708M8IgN
         sg9jUPQSbGNE8Ku4+UAQnhMnnl4HrXwhxswf9pSC7ulYeuxJ/8n2wK/aCabe9x1DVUPi
         Nnjd9Ge0wVQ7qd2KfEgpfMn5EnheOCeywj3Ll8AMlOfD/j4Vk8ErUyNshpqNPaWXC3VR
         MP94jKPQpFPHXxLC9KuSX9ffLQSsJu0pwY/gzjDk62XkNRcQzz2oXam0eanlZ/zC56P5
         HwT8qjV5YVzlqEcAp+sX8AAsTkRKwWvrCssfN7CbNB+dJPQtUsty+z8gdyE1JOE9O2DU
         t3Qw==
X-Gm-Message-State: APjAAAW99gVuvkhzwlDJzwKapjyGAkKqgi8qxD94Qlij9ZyVaP4WKLsm
        SaLVXBrd4wRJPs22xJ7JjM4Hkfxze956uA==
X-Google-Smtp-Source: APXvYqwTdkIDx3q9UvJjqYB+VMlADb+zD2cXYgO+541AFLOP/NdiYErFsS2Mt5h4UMVP3dqgdv3kGA==
X-Received: by 2002:a63:6d5:: with SMTP id 204mr2876602pgg.359.1573046923030;
        Wed, 06 Nov 2019 05:28:43 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id 22sm20183943pfi.175.2019.11.06.05.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:42 -0800 (PST)
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
Subject: [PATCH 02/11] thermal: cpu_cooling: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:18 +0530
Message-Id: <b545988db993ea8fe54c5250d35a8cb7ddaad1e5.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the function parameter to fix the following warning with make
W=1:

linux.git/drivers/thermal/cpu_cooling.c:92: warning: Function parameter
or member 'qos_req' not described in 'cpufreq_cooling_device'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6b9865c786ba3..c1523b9d06954 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -75,6 +75,7 @@ struct time_in_idle {
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
+ * @qos_req: PM QoS contraint to apply
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
-- 
2.17.1


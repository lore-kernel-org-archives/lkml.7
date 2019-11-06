Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D92C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4E520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jk++708L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfKFN3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:29:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbfKFN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:29:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so591970plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ndl0P+VsTZD2v+P2v9bn/U9V2szmDcFpE9QaZn60GcY=;
        b=Jk++708LXyo/7ByqvgwlIhPiri1IenbjKc2cSae50LsdvVJ10VmxSRemddzrpMGYof
         ybKFnP4OZTKR+IWnxPv3rZ9SPmHwVgfII4zpEmSWVuBQrRmabm5c3d8DPoBhycjaN1E8
         wi1E4HvuUCTJKw0uZbJVmAD24BB6z6q6XQSkrwm6bh4+2zlfDBTWijbLLo+BwJ9Vgnlp
         lHWz+p3h9owUvqYFwwuS4MD/Emodoj4SNJ6y436+Vqyu2XrS8bkMQxSUvLOMM/jsVOIs
         KGo41pjh56vWYLWunJ2sIYBrwuf6HTjyenTCgPLhrmloOJzaCwR87IgyzvWh/5QJM4fm
         VeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ndl0P+VsTZD2v+P2v9bn/U9V2szmDcFpE9QaZn60GcY=;
        b=WLTy7kcktx+eYp6bO6X5fWrJwlghenWiQpVsOdyj7hTO7Pn/N+SLIQUbN8JjOr8YBG
         gj0/tiwBvOwQtGMpRELi3ew/JXreVYUGcvNwtDUuCHg9MeZ4hi6XvaxarHRlDnN8v2TJ
         xg+Ffw6s+RKEEHRje6jxivdBGHqY3aqKlSZAXKo+rdrE/aGoZyzRo4csX7N/dN6B8QwS
         9+IOAlOpUKmml5H0LCHS3Dn/hF2BRR/5d0ksFFXK/rP5Lk9Q5EHkyqfcUOkRv3Qs49RT
         v3qOtyb/NpXHtaEYDEvHnMroF5Lkz7sC/9riWeyCecZV2pQuvoTwglgO2QHsRYJ5sdco
         RY9g==
X-Gm-Message-State: APjAAAVDZweJmRa3UqYObDVO1Y2slsWk3bw2HKKR5doizh5Nhs+cCMJJ
        8Jpm1p0q1AQvX+jE4p2+5HrbvNW34G7sYQ==
X-Google-Smtp-Source: APXvYqzXrRMY/E/IAnXs8Uf12RYzyqlGrByEWUa6Sj8R2R4qoSFZoC7S4GJxnvAfOPq5HOOXQ9Tv9Q==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr688438plr.227.1573046959859;
        Wed, 06 Nov 2019 05:29:19 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id x20sm23088825pfa.186.2019.11.06.05.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:19 -0800 (PST)
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
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 11/11] thermal: zx2967: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:27 +0530
Message-Id: <b8cca2b414eeb2db19f297571dd4654a733a2417.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/zx2967_thermal.c:57: warning: Function
parameter or member 'dev' not described in 'zx2967_thermal_priv'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/zx2967_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 7c8a82c8e1e92..8e3a2d3c2f9a3 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -45,6 +45,7 @@
  * @clk_topcrm: topcrm clk structure
  * @clk_apb: apb clk structure
  * @regs: pointer to base address of the thermal sensor
+ * @dev: struct device pointer
  */
 
 struct zx2967_thermal_priv {
-- 
2.17.1


Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F39B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4R5j8Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDKWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41894 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfDKWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so7007533lja.8;
        Thu, 11 Apr 2019 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpy62Ft5o0pJhXMy/3LzPtnD7kM0EZBl9Fb+iZKLSho=;
        b=o4R5j8UszW/bY+xUfqOWhR7qE7D51ygnD1aw8dtKRlo1vgwtnN/UMT9zwoWQ5d41nn
         xHi8bhYiVefcP4Hi3yfG4G+hjpCJxHDwB4zcCd7mIPoKO50rRo6W3JV9bg6eImmHSxZ1
         xnbnoCGCs+wCBzl4Gx9a71No6YEu/D0cr2rvZC2xcH9ZXL89pMt8QCZC9k1hMdC5ZnLc
         RP3MMvyHkf4s36pYfBQsn/AybfMx8qDPxWed1YKWA89PNx/30f8pU2g1w/dxQ+B2VOx5
         e9rw7ZMSX7WBbmi+Udh/hH5LF8kJ82Iw7sNis4ewpwvKnyi00cPDZecTtAuaBB+8nwvU
         jFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpy62Ft5o0pJhXMy/3LzPtnD7kM0EZBl9Fb+iZKLSho=;
        b=mU4CzWm091P84C4+ojnyG4pzNvyO5857DLETEfy6b19/NYKpAKYR+etJ60ytAqmMYl
         2LOie0Rqaof7rjtS+ICWVMlsd2B/XBK2CYKfWzI5Dwn89caPsTmLgw26+jNMYSPqbl+8
         kLTZSgSLcwxRRk40m2ERUPCqqgPDtgtmIBUX2Uy9alPMnH3ETIgg73bNJ+wiW6NDwdp6
         C3T/ZT9knRiRN1by+q2Sv5W0OhoaILBoDdVzbhfUL9UbuymN0Uur0hTFr7JbT4dL54N+
         j/kpWjUquN2Fzv2OiDA5D+l7oYqYV6qonYwftZjxzbuUCNYQ7bbGmsDsnW91z0w3zbsD
         hKlA==
X-Gm-Message-State: APjAAAXcqylRANhApoPry85iE29L4EpcPqI1MWSTVEJDyCSLxHZ45mmS
        oYrcMz7Gj0cLJJDhO4gt0/8=
X-Google-Smtp-Source: APXvYqyMMe1jQ59L8EGwuW3y2GT0MejD27kzVSWLuoB1tWLDOTCKfyXf9Dwvul0304B+kQYDwAUaaw==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr27778003ljk.123.1555021807291;
        Thu, 11 Apr 2019 15:30:07 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 8/8] PM / devfreq: tegra: Support Tegra30
Date:   Fri, 12 Apr 2019 01:29:14 +0300
Message-Id: <20190411222914.25539-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq driver can be used on Tegra30 without any code change and
it works perfectly fine, the default Tegra124 parameters are good enough
for Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 2 +-
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d338f6d..6bae9688a52b 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_TEGRA_DEVFREQ
 	tristate "Tegra DEVFREQ Driver"
-	depends on ARCH_TEGRA_124_SOC
+	depends on ARCH_TEGRA
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_OPP
 	help
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 0985c02b75fe..a0a3dafa9188 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -724,6 +724,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra30-actmon" },
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.21.0


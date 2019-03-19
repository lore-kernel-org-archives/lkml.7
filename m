Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CF42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="M8VCijeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCSBqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:46:01 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38078 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfCSBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:46:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 21E2FA30
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 20KCZPeugHnZ for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 20:45:58 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id E028995F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:45:58 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id y13so15002572iol.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7E3cjLWaXlGs4sSzpZNXX9cIzD+McIyyipKe6rnHRvI=;
        b=M8VCijeSg0vMf7NpLJcbmEJrSm8RpCCZvNvVQpA2hCA0ssclui4i2V2nIazmdNKggL
         AcuAKD0F945zGx7qAPsYpVJPMFNaQC6YKKeXdA1DeQLLRVZsQkr9KavnvnDcB2AzuPUZ
         22Bj1BB7oeMGX9qpAbwmWYXo+wKBx1/HYFQ3XNtovERynRqM+LVjzaFKbMTqVe2QeD3O
         gVyotVAmZWytr+v9Pps/lnDrUU3/wy776TaY25C3Z7eEZtSBSRYNzVfbfvWgrrfGTW9H
         jeAPkl5+YPgnJp0wrihF4p7FTjbl4Qa9xRNC0HGzFV+S1GV7jkUig85FAlCdDBgIVg1i
         W+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7E3cjLWaXlGs4sSzpZNXX9cIzD+McIyyipKe6rnHRvI=;
        b=nros+lCrTAfod/23ESm7P1bQQpyPiXcjprM6DzDEeQP68utvRF3pS0PvWmmZnQtDvc
         ETXK9YvV9kgsFpRm1LYWfuVJZ5L474+CogZDEBUM4w0fZJiblGfd6/oval+hNugEMPmk
         /A/McApHxNniZn0dFht9lMbeSKC4OFBq9ucyTUCQUPaPixY36k1IaShehwfW2CZF+U4O
         kRTvTwwOtncp7ngDKIuK9F2J6/6847nGCwyBaLn0HlRTpcuM30HCWR0qgIDuOgN/jBPA
         MbBz4PTSamDl+XZqWVX4nhLFNky85cfhSSfFNcRM+WwFksjgDjZpyzquZagdwnb+mm3W
         Aa8Q==
X-Gm-Message-State: APjAAAULgjGjXWcZsmDa7NR/U4U666M3Uf2vqlntbQ/odRc2jCwetMYc
        nYNXJJ9ExhP1YgfOkm8xTk5sY3tpQBypx4qyXlJheQP3DB5CT3qGfatTj1EtUW2NLsdZZgOs6cg
        Qm46QlRKQagqUNJY/mjblyJsEkXmq
X-Received: by 2002:a24:618d:: with SMTP id s135mr1312919itc.101.1552959958470;
        Mon, 18 Mar 2019 18:45:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8a/dFwQp6eK9IxpUsyTKK3H+i5ku1YvOyVqLPriSIXwOn6YzosGi/atOapl+kHK3nKwemsg==
X-Received: by 2002:a24:618d:: with SMTP id s135mr1312911itc.101.1552959958256;
        Mon, 18 Mar 2019 18:45:58 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id f9sm4874883ioo.24.2019.03.18.18.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 18:45:57 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] mmc: dw_mmc: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 20:45:51 -0500
Message-Id: <20190319014551.16559-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_node can fail and return NULL in case no matching structure.
The patches checks for such a scenario and returns -ENXIO.

---
V1: Added files dw_mmc-zx.c and dw_mmc-rockchip.c

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mmc/host/dw_mmc-exynos.c   | 2 ++
 drivers/mmc/host/dw_mmc-k3.c       | 2 ++
 drivers/mmc/host/dw_mmc-pltfm.c    | 2 ++
 drivers/mmc/host/dw_mmc-rockchip.c | 2 ++
 drivers/mmc/host/dw_mmc-zx.c       | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index d46c3439b508..8a75d7314606 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	int ret;
 
 	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..cc50b7546a20 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 58c13e21bd5a..b1948989f617 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
+		if (!match)
+			return -ENXIO;
 		drv_data = match->data;
 	}
 
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c86a800a8fd..20e3471260ea 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -344,6 +344,8 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
index c06b5393312f..abea35431045 100644
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -213,6 +213,8 @@ static int dw_mci_zx_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_zx_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
-- 
2.17.1


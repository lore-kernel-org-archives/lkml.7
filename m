Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C427C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A447222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMZOZA7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfIZTZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:25:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34505 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfIZTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:25:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so76595lfm.1;
        Thu, 26 Sep 2019 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKuN23lQstyoD1te2Tv+YFrDd//LmXbVG2f+T74e3Ic=;
        b=WMZOZA7szPUfdmcF9DIkfxQLlDQqv1j9nCsVKyhs9p3/UqYkMqFgvFPlaEMpMhPBiQ
         TdTfItz8I4hCfs2ZNa640VPXettCk+1gJBaiWSwSWzuyKzMcNZ6A67hTZsKUvYXZsKGq
         Zj/mgROUaUJ39l96IERYB31yaqH9VkRJcn8tPRoWrpr+JCgPwDyjMprF+qtah2KCtZSz
         SK9uoAO+xLUhPYzK1Yh9ad0AT5OnWAcTzYbF2KRaEuEw52Wc2rNtuYmK+I9Qhhz40c2p
         6h8UoQXWJKl+oB5NbcKcaB1RumKXlt7LQ7rIsOIbDZIvcnvwRUICChQxpDOeKAmxjKSx
         ItCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKuN23lQstyoD1te2Tv+YFrDd//LmXbVG2f+T74e3Ic=;
        b=jhSDVyDmC0PGm36Dg5GJBN0rnjcMLwP0swKKOxz1F+uiAqdFeR9NkodciSxIvbU+76
         pFr16SPAhqfC4WewDan0C2BE6V2YNSOqo3V504ksV1Mn3TpjtoXtvpKFVOd+KteGQUu2
         IZwWMVthLsYy1NlGPG1eVgn8NTiJP8I7lt+xmwQi3OlCdJ0arR8ooZCcuctB7SzXPn4n
         B0+7ZcC0gMgF24HoL11AYsXTB03rkByyGjuVEv5VSmSjVj4D0KGhYIj0PCtre9WHtt56
         4L9bXo3GcARp4emxXnPsPjEtJsBm5D7xoyNiF2KeQogjmQnZ0PcDQ26jOYIWv5kVpc3w
         vp8g==
X-Gm-Message-State: APjAAAXnT0laP8Vqva0vkKfqF4L1B8K9z8hT+KyS2ucIiF9/fXknN1pX
        Dm6ET7wbJPZBwSzJLaaR7oGPoztf
X-Google-Smtp-Source: APXvYqwb1G9oJA0tIuTHLun5+/SLSN97iOCQkmFWTj3AGx79VOzMWtwAFQqAr4i+aUw14dSVOp2vYw==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr114698lfo.35.1569525933062;
        Thu, 26 Sep 2019 12:25:33 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id 202sm13888ljf.75.2019.09.26.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:25:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] soc/tegra: pmc: Query PCLK clock rate at probe time
Date:   Thu, 26 Sep 2019 22:17:54 +0300
Message-Id: <20190926191755.27131-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to get a lockup if kernel decides to enter LP2 cpuidle
from some clk-notifier, in that case CCF's "prepare" mutex is kept locked
and thus clk_get_rate(pclk) blocks on the same mutex with interrupts being
disabled, hanging machine.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v5: Clk notifier now takes powergates_lock to avoid potential racing with
    tegra_io_pad_*().

    The original fallback to 100MHz when clk_get_rate() fails is preserved
    now.

v4: Added clk-notifier to track PCLK rate-changes, which may become useful
    in the future. That's done in response to v3 review comment from Peter
    De Schrijver.

    Now properly handling case where clk pointer is intentionally NULL on
    the driver's probe.

v3: Changed commit's message because I actually recalled what was the
    initial reason for the patch, since the problem reoccurred once again.

v2: Addressed review comments that were made by Jon Hunter to v1 by
    not moving the memory barrier, replacing one missed clk_get_rate()
    with pmc->rate, handling possible clk_get_rate() error on probe and
    slightly adjusting the commits message.

 drivers/soc/tegra/pmc.c | 71 ++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9f9c1c677cf4..ee39ded6bc7b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -309,6 +309,7 @@ static const char * const tegra210_reset_sources[] = {
  * @pctl_dev: pin controller exposed by the PMC
  * @domain: IRQ domain provided by the PMC
  * @irq: chip implementation for the IRQ domain
+ * @clk_nb: pclk clock changes handler
  */
 struct tegra_pmc {
 	struct device *dev;
@@ -344,6 +345,8 @@ struct tegra_pmc {
 
 	struct irq_domain *domain;
 	struct irq_chip irq;
+
+	struct notifier_block clk_nb;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1192,7 +1195,7 @@ static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
 		return err;
 
 	if (pmc->clk) {
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		if (!rate) {
 			dev_err(pmc->dev, "failed to get clock rate\n");
 			return -ENODEV;
@@ -1433,6 +1436,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 {
 	unsigned long long rate = 0;
+	u64 ticks;
 	u32 value;
 
 	switch (mode) {
@@ -1441,7 +1445,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 		break;
 
 	case TEGRA_SUSPEND_LP2:
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		break;
 
 	default:
@@ -1451,21 +1455,15 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 	if (WARN_ON_ONCE(rate == 0))
 		rate = 100000000;
 
-	if (rate != pmc->rate) {
-		u64 ticks;
-
-		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
-
-		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
+	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
 
-		wmb();
+	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-		pmc->rate = rate;
-	}
+	wmb();
 
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
@@ -2019,6 +2017,30 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 	return 0;
 }
 
+static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
+				   unsigned long action, void *ptr)
+{
+	struct tegra_pmc *pmc = container_of(nb, struct tegra_pmc, clk_nb);
+	struct clk_notifier_data *data = ptr;
+
+	switch (action) {
+	case PRE_RATE_CHANGE:
+		mutex_lock(&pmc->powergates_lock);
+		break;
+	case POST_RATE_CHANGE:
+		pmc->rate = data->new_rate;
+		/* fall through */
+	case ABORT_RATE_CHANGE:
+		mutex_unlock(&pmc->powergates_lock);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return notifier_from_errno(-EINVAL);
+	}
+
+	return NOTIFY_OK;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -2082,6 +2104,23 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->clk = NULL;
 	}
 
+	/*
+	 * PCLK clock rate can't be retrieved using CLK API because it
+	 * causes lockup if CPU enters LP2 idle state from some other
+	 * CLK notifier, hence we're caching the rate's value locally.
+	 */
+	if (pmc->clk) {
+		pmc->clk_nb.notifier_call = tegra_pmc_clk_notify_cb;
+		err = clk_notifier_register(pmc->clk, &pmc->clk_nb);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to register clk notifier\n");
+			return err;
+		}
+
+		pmc->rate = clk_get_rate(pmc->clk);
+	}
+
 	pmc->dev = &pdev->dev;
 
 	tegra_pmc_init(pmc);
@@ -2133,6 +2172,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 cleanup_sysfs:
 	device_remove_file(&pdev->dev, &dev_attr_reset_reason);
 	device_remove_file(&pdev->dev, &dev_attr_reset_level);
+	clk_notifier_unregister(pmc->clk, &pmc->clk_nb);
+
 	return err;
 }
 
-- 
2.23.0


Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDCC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFEF20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHOdijeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfHDUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:32:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfHDUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:32:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so82359083wrm.1;
        Sun, 04 Aug 2019 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b//BVTOWECD890zQi6jVIN8Ht0AZ1dnw7ou61dAnurM=;
        b=mHOdijeUbuPibzEwbzMeTtjwNiZN5QXAw8QRNjZVDA1rBBGHGK+/glzZOjum+jhxUx
         UGhDjIolJ6AWTTm3uyFZS3b8DpOZreTPDNjV6MgnF5Fj6CQvr29f0manRItqRdQwIZoI
         sFbOnpkkiWsexWrCInLsUWcFV/PtKCuUZFi3gsa80r6zT5oYvNrD/idfslI7G51YZjuG
         qyN/cx9Fj3FaT9L4s5s+U2BZziMuh5hmCwbeHBBo1i4K69BeQ3wCxdeLnZa0OPoyc3ZK
         vQzojEh+u7iGxCvBq8FFTZQBW1GqsOWcWqXi73MzpioGPN7Fa59pzXYZSbdF83KrSPme
         xeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b//BVTOWECD890zQi6jVIN8Ht0AZ1dnw7ou61dAnurM=;
        b=tTeCprilHCQnmqutAa79eXqKpny6ex7RHH6ASkcwzRfeJvBJBMlMbfXjD+m5nabI/K
         mJuSnkhiOoIv7D5TPJWY1ZSNhBA9cSRYf8z8wEi1nxuIyA0Pm5Uyz2A4M7Gw/nfXJy/s
         jzwy86j54ZA0s3cR945QDMzbaSg2/UcHycCWZFPqYJ0UWkptkHO/LK20HGG3LIux75bS
         SXeDxCsVLRB7SZOezM2Jv51aBEJ0ieWIh7uOL9ph2z+S7Sead3AAe434xA60xsE1t6DO
         QCCWkRb0dvvw/nOivVw/2QkiHKXR8eLcluEEAqnmKkgo0v51DKO8ou6kdqWAl9nBQnFE
         vR0Q==
X-Gm-Message-State: APjAAAVj1yS6wARD/J0Wmpokdn87GZ9IUJfIX/2TIPsSAwhgKAFH+TKI
        1en9K/rC6i/Sect5/dVDiiU=
X-Google-Smtp-Source: APXvYqwRY3GwJLIUcmbZk9vKGubQIFMPocKrEibYRevO9wl66mW2BHGQg4Ruld0509MVkkryVuh7Mg==
X-Received: by 2002:adf:a341:: with SMTP id d1mr108869494wrb.260.1564950755243;
        Sun, 04 Aug 2019 13:32:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id b2sm112066619wrp.72.2019.08.04.13.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 13:32:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] soc/tegra: pmc: Query PCLK clock rate at probe time
Date:   Sun,  4 Aug 2019 23:29:26 +0300
Message-Id: <20190804202927.15014-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to get a lockup if kernel decides to enter LP2 cpuidle
from some clk-notifier, in that case CCF's "prepare" mutex is kept locked
and thus clk_get_rate(pclk) blocks on the same mutex with interrupts being
disabled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

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

 drivers/soc/tegra/pmc.c | 71 ++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9f9c1c677cf4..4e44943d0b26 100644
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
@@ -1441,31 +1445,22 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 		break;
 
 	case TEGRA_SUSPEND_LP2:
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		break;
 
 	default:
 		break;
 	}
 
-	if (WARN_ON_ONCE(rate == 0))
-		rate = 100000000;
-
-	if (rate != pmc->rate) {
-		u64 ticks;
-
-		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
+	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
 
-		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
+	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-		wmb();
-
-		pmc->rate = rate;
-	}
+	wmb();
 
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
@@ -2019,6 +2014,20 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 	return 0;
 }
 
+static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
+				   unsigned long action, void *ptr)
+{
+	struct clk_notifier_data *data = ptr;
+	struct tegra_pmc *pmc;
+
+	if (action == POST_RATE_CHANGE) {
+		pmc = container_of(nb, struct tegra_pmc, clk_nb);
+		pmc->rate = data->new_rate;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -2082,6 +2091,30 @@ static int tegra_pmc_probe(struct platform_device *pdev)
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
+	if (!pmc->rate) {
+		if (pmc->clk)
+			dev_err(&pdev->dev, "failed to get pclk rate\n");
+
+		pmc->rate = 100000000;
+	}
+
 	pmc->dev = &pdev->dev;
 
 	tegra_pmc_init(pmc);
@@ -2133,6 +2166,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 cleanup_sysfs:
 	device_remove_file(&pdev->dev, &dev_attr_reset_reason);
 	device_remove_file(&pdev->dev, &dev_attr_reset_level);
+	clk_notifier_unregister(pmc->clk, &pmc->clk_nb);
+
 	return err;
 }
 
-- 
2.22.0


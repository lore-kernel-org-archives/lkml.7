Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4153C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ECE20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIe7g0Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDKWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfDKWaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id t11so1426275lfl.12;
        Thu, 11 Apr 2019 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsd72Y24Bsbr3wVQWECGfMMyUlcIQlnQmzyDN246j6k=;
        b=SIe7g0DhWKeAssBBfoBsdRm0fCjcOJz9kSRE/MZyFSN4MZfCuunXM1SfvAlqjL/J4z
         Pag1nRc4R798Fh6QeYQLlZfO3n+c+d9iPLXxy/5yrk/Vdo9YiH5VsjN9K144VH2fnj7A
         fhtYu5YjhsZ3H1YRObYU3dvJG/Jr0zSywfX9O8Eu2negO09DVF9DmqS6TcMKfXoDx2TB
         6eqBIVk0hryQTv6MEOKX6ge6Pj/XleuBTPMrkGhO9Xnna82C3M7KG/d2v2dFYBZZjijW
         Qaij+o7+/vwUQooG2arViImB0n/19y0kqOE/06Xlb8Taj9UOQiKLLcb8whmegQ+G5AJE
         PKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsd72Y24Bsbr3wVQWECGfMMyUlcIQlnQmzyDN246j6k=;
        b=sH1Uxdca0Gt9699YlKcEOMPslc/PEKn08Qd0rOVGMLND22c92lZkbIahbIAZIsisCy
         DNUfube0CnaWZu2wEwb7g9LWgShJ9EXxkm78gOhBEwBU/Lqh8Rqr9P3+QzY/VLcGlkAN
         GPXTvI2fLisxHKNW8SiJDHv/fYnRsLjBnBmkVUR5m1XxRK1Tthg61p12iA+xXpYOG51e
         MZq/Yny5nxa8F82ZwSSpH/HoYTiNWC4imc0IUURDMZ6QizdaAF3D/+Wsq+z7d646e9my
         yo95tp48jr2Kqfx7Mqjh3NhTg00jwCTbTfidWuiYBvE3QocWKe7oBbYnWi3iEXlKjBNL
         M/nQ==
X-Gm-Message-State: APjAAAVXsZC8t1yM7jpL7riqJS8KHBgr5e/jh0/Ci3rBWxyqkrqPiM1y
        WHlms/Wykq5ekrUzCrPdN8S5a1uL
X-Google-Smtp-Source: APXvYqyDHaOUDnR1whBzE1+K3QCnby+lnkMAfztTJs1M5JU+48cm7AgEKb4CPFevquRIOkTEeTDAdg==
X-Received: by 2002:ac2:4891:: with SMTP id x17mr10283290lfc.134.1555021801776;
        Thu, 11 Apr 2019 15:30:01 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 3/8] PM / devfreq: tegra: Don't ignore clk errors
Date:   Fri, 12 Apr 2019 01:29:09 +0300
Message-Id: <20190411222914.25539-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_set_min_rate() could fail and in this case clk_set_rate() sets
rate to 0, which may drop EMC rate to minimum and make machine very
difficult to use.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index d749399f67ae..6185e7ab20a8 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	unsigned long rate;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
@@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp) * KHZ;
 	dev_pm_opp_put(opp);
 
-	clk_set_min_rate(tegra->emc_clock, rate);
-	clk_set_rate(tegra->emc_clock, 0);
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.21.0


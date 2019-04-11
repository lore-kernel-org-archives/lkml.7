Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639B62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiG7ERTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDKVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:50:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36173 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDKVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:50:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so6982385ljg.3;
        Thu, 11 Apr 2019 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uY9GjYL/KZ0JqHQE/fQXJUwPiX1OmbKEkNGhtdtScw=;
        b=TiG7ERTlhicGn5qkr2n/8+OMROqI/SLy10DKwAX8M9SHdNag9AkfV2um/BlXPG/SNp
         Rl4VGhnHlbc0ArYZdgtb2/yrgDEXkQfc2vvVmGI19bFHRirMptYDIPT10cF5EOKdJUdH
         7yfHZlooLpAcGnSy28MaJhPl4xxJI2QflyBgu010diRNoqrkcWBlnLqyWHF4wg/HOnlW
         k3Mf1NESwffDoU5OcViqjdv9jv8cG0CJm5z9hETjm32j0Ivn1CWhi2vD05jwGwGydag0
         vSvwEXOkKAZmPf9/N2KY/soacuVJZUZWSigKysueh9GnZ13xjOV1oDW6ua48/3rHaOEp
         KHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uY9GjYL/KZ0JqHQE/fQXJUwPiX1OmbKEkNGhtdtScw=;
        b=hJqA7Wu3999N4QeLXv6pGpYsgB8+M+uMy1K1+S5TLOqlDCM5KmYb7jPf7Q0SjL70vQ
         zL3IzjvuuphTkBCzsT9SAVECZXoxFF93txn2oYztgWpoXiS4mn4HBfjbm4X9syA+8HCn
         Qcn7XmhUfXxEWd6RWD9uFAmKUdwE9Fiyl7tQaKDVSx6VoblZCONLe8KQbjlYVADb4uBF
         4U3hGZ/zsHpUvgw9YkCqOEYJPVIvrz4CH1VZlc5PdRi3P2SKz92P3gYf2AWv/rnLDGF8
         5ymu+LeBCnihzT6I7UVglwvy7NzSGaXMF7zuLy0KrCEpR0el+9QBv7c3Rt53WgYOxE8V
         3tqQ==
X-Gm-Message-State: APjAAAV3eWBr88YXXB/GzIuN2gMWMntADNn1URlg/2e0fEdhRdv9oVZ9
        eEBZ9YBrgdA3ZpqfCkV5QjE=
X-Google-Smtp-Source: APXvYqwVzGKb7xiFEmVjC8NeRe98OrP7LruZCkxyWHxq4mRwQ+tAAjPzTOL2eL1Tl4zTuG/1b/tfJA==
X-Received: by 2002:a2e:711a:: with SMTP id m26mr28125728ljc.40.1555019401841;
        Thu, 11 Apr 2019 14:50:01 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id t29sm7819985ljd.82.2019.04.11.14.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:50:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] clk: tegra124: Remove lock-enable bit from PLLM
Date:   Fri, 12 Apr 2019 00:48:35 +0300
Message-Id: <20190411214835.19947-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411214835.19947-1-digetx@gmail.com>
References: <20190411214835.19947-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Tegra124 TRM documentation, PLLM_MISC2 register doesn't
have the lock-enable bit as well as any other PLLM-related register. Hence
PLLM re-locking can't be initiated by software. The incorrect bit setting
should have been harmless since that bit is undefined according to TRM.

Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra124.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index df0018f7bf7e..940592375583 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -413,7 +413,6 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.base_reg = PLLM_BASE,
 	.misc_reg = PLLM_MISC,
 	.lock_mask = PLL_BASE_LOCK,
-	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.max_p = 5,
 	.pdiv_tohw = pllm_p,
@@ -421,7 +420,7 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.pmc_divnm_reg = PMC_PLLM_WB0_OVERRIDE,
 	.pmc_divp_reg = PMC_PLLM_WB0_OVERRIDE_2,
 	.freq_table = pll_m_freq_table,
-	.flags = TEGRA_PLL_USE_LOCK | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_freq_table pll_e_freq_table[] = {
-- 
2.21.0


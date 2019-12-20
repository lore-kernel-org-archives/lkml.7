Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D64C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9FE2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiq+MmO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:09:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42628 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLTCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:09:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so5766919lfl.9;
        Thu, 19 Dec 2019 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPFsiOc6wIGTPdQOWrJDR2PVV3TbtZbCXW2QKmzm3ys=;
        b=eiq+MmO3dGRP0TqUeZEGE6G4PCrIUTayW7yJWnOIahahTeIAUC/1+UsGb5cHfAQI2a
         gLS2ymBpQXr7/0wcCeY92BrZ4EmCsezQSqDIXFz+7XHIzfH4bTAbLEWaV1sT1GSWfq1p
         R1DFyE70eSGX4TEVaVIi2VoIiNjYe8zMHEnvoKN9LUizQPEUdPzjNxbgDlqEdBJ/oiv/
         6DN9fxHutZq55liURjmphIqS69dsK6cj5v/iQeO371HziQ/4i4Pneei8d+2EnDMogEk7
         rtUVU6mgz1n9G6TSck3tDY+SNy24KHtJorMZI8oVjgjprVVCuF8drFI5zFXpKgXW3jl9
         0ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPFsiOc6wIGTPdQOWrJDR2PVV3TbtZbCXW2QKmzm3ys=;
        b=UBRq6XIlOVWyga3DMdbhWwIW18yb14kHE2OlOapBAbGh4mN9MmePlcg7XxxDs16H6d
         Wq8y0E2kEorcXyaDzjuEh7JxV8vaTGyM+bawOjjEMbNynkiJ3qtfIoJ3dYT8xlhI3eai
         0I90d0PpIH4+WV4aeoVkgxq7OXZ+fYxqG6/GOpcLdYO4oFt1fCRs5NXiV6h1mZWv8Voi
         ZUPUUdb6g97pFmnPwWsywxZfxJLtlfSPbY/9IJLL++eSEUWpuhynK0uv3Fj+G9C/6Xlq
         vYXXAbOMfHcjUOjfb3rwVlkUcDkQTCaUw20A/yE1D34vW0JHkg3XQxpZ8TRIcWVMl0zB
         eCuw==
X-Gm-Message-State: APjAAAXCy0pyIuCs2/2IKhSPRd6SSJXVY7AhZrAmuVgGGQJQxe5k90gJ
        x+VW5FypiBNhJ/K6uEjCSJ4=
X-Google-Smtp-Source: APXvYqz0l3x4NQoUiCd3YVj85FJv8ZkPH0qnkGXUpnW1gnQKCznUKUrfRDTGB+eJao1PolOt+dPL9g==
X-Received: by 2002:a19:888:: with SMTP id 130mr7448620lfi.167.1576807762776;
        Thu, 19 Dec 2019 18:09:22 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3279818lfo.40.2019.12.19.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:09:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] memory: tegra30-emc: Firm up suspend/resume sequence
Date:   Fri, 20 Dec 2019 05:08:47 +0300
Message-Id: <20191220020849.11175-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220020849.11175-1-digetx@gmail.com>
References: <20191220020849.11175-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code doesn't prevent race conditions of suspend/resume vs CCF.
Let's take exclusive control over the EMC clock during suspend in a way
that is free from race conditions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 38 ++++++++++++++++--------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 0b6a5e451ea3..770808da957d 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -345,7 +345,6 @@ struct tegra_emc {
 	bool vref_cal_toggle : 1;
 	bool zcal_long : 1;
 	bool dll_on : 1;
-	bool prepared : 1;
 	bool bad_state : 1;
 };
 
@@ -751,9 +750,6 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 	/* interrupt can be re-enabled now */
 	enable_irq(emc->irq);
 
-	emc->bad_state = false;
-	emc->prepared = true;
-
 	return 0;
 }
 
@@ -762,13 +758,12 @@ static int emc_complete_timing_change(struct tegra_emc *emc,
 {
 	struct emc_timing *timing = emc_find_timing(emc, rate);
 	unsigned long timeout;
-	int ret;
+	int err;
 
 	timeout = wait_for_completion_timeout(&emc->clk_handshake_complete,
 					      msecs_to_jiffies(100));
 	if (timeout == 0) {
 		dev_err(emc->dev, "emc-car handshake failed\n");
-		emc->bad_state = true;
 		return -EIO;
 	}
 
@@ -790,22 +785,23 @@ static int emc_complete_timing_change(struct tegra_emc *emc,
 
 	udelay(2);
 	/* update restored timing */
-	ret = emc_seq_update_timing(emc);
-	if (ret)
-		emc->bad_state = true;
+	err = emc_seq_update_timing(emc);
 
 	/* restore early ACK */
 	mc_writel(emc->mc, emc->mc_override, MC_EMEM_ARB_OVERRIDE);
 
-	emc->prepared = false;
+	if (err)
+		return err;
+
+	emc->bad_state = false;
 
-	return ret;
+	return 0;
 }
 
 static int emc_unprepare_timing_change(struct tegra_emc *emc,
 				       unsigned long rate)
 {
-	if (emc->prepared && !emc->bad_state) {
+	if (!emc->bad_state) {
 		/* shouldn't ever happen in practice */
 		dev_err(emc->dev, "timing configuration can't be reverted\n");
 		emc->bad_state = true;
@@ -1181,13 +1177,17 @@ static int tegra_emc_probe(struct platform_device *pdev)
 static int tegra_emc_suspend(struct device *dev)
 {
 	struct tegra_emc *emc = dev_get_drvdata(dev);
+	int err;
+
+	/* take exclusive control over the clock's rate */
+	err = clk_rate_exclusive_get(emc->clk);
+	if (err) {
+		dev_err(emc->dev, "failed to acquire clk: %d\n", err);
+		return err;
+	}
 
-	/*
-	 * Suspending in a bad state will hang machine. The "prepared" var
-	 * shall be always false here unless it's a kernel bug that caused
-	 * suspending in a wrong order.
-	 */
-	if (WARN_ON(emc->prepared) || emc->bad_state)
+	/* suspending in a bad state will hang machine */
+	if (WARN(emc->bad_state, "hardware in a bad state\n"))
 		return -EINVAL;
 
 	emc->bad_state = true;
@@ -1202,6 +1202,8 @@ static int tegra_emc_resume(struct device *dev)
 	emc_setup_hw(emc);
 	emc->bad_state = false;
 
+	clk_rate_exclusive_put(emc->clk);
+
 	return 0;
 }
 
-- 
2.24.0


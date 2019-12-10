Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BE72077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLJNYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:30 -0500
Received: from foss.arm.com ([217.140.110.172]:44276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfLJNY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F3E1045;
        Tue, 10 Dec 2019 05:24:27 -0800 (PST)
Received: from DESKTOP-VLO843J.cambridge.arm.com (DESKTOP-VLO843J.cambridge.arm.com [10.1.26.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A23853F52E;
        Tue, 10 Dec 2019 05:24:26 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, smoch@web.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
Subject: [PATCH 1/4] mfd: rk808: Set global instance unconditionally
Date:   Tue, 10 Dec 2019 13:24:30 +0000
Message-Id: <f55d95c36ac21c4eeef38f5a17035574049a5f03.1575932654.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575932654.git.robin.murphy@arm.com>
References: <cover.1575932654.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK817 syscore ops rely on the global rk808_i2c_client being set,
but are essentially independent of whether this driver has authority
over system power control - indeed, setting the SLEEP pin functionality
is most likely wanted when firmware is in charge of power via PSCI.
There's also no harm in setting it unconditionally anyway, so do it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 616e44e7ef98..f2f2f98552a0 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -666,6 +666,8 @@ static int rk808_probe(struct i2c_client *client,
 		}
 	}
 
+	rk808_i2c_client = client;
+
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
@@ -675,7 +677,6 @@ static int rk808_probe(struct i2c_client *client,
 	}
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		rk808_i2c_client = client;
 		pm_power_off = rk808->pm_pwroff_fn;
 		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
 	}
-- 
2.17.1


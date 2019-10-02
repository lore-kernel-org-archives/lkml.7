Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A3C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072021783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahoJ80fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJBOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:43:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44291 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJBOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:43:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so6852033wrl.11;
        Wed, 02 Oct 2019 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9l/1MkRoZLCyZNPXaR5fzwvTbuyIzYA20JLtWuhYR4=;
        b=ahoJ80fONPxwQPqvbuQRAba40syj0YJFK3SbqTxd0FOzhs1n3WTvNd/gHQ+2WK5WwB
         8joqipXveUGBgePR1RwHR0oQyDAumewRmSMStvhyCHPeo154CNqZfGQNlbNlRng2QJqd
         1/Sq8GNJ1DjcLifpHWbCC9LoK5U3UkvdIWHPFx0cqJ+ENvPHkYPr2FdpaZ8jxuJta3TT
         dplkNk0AsL/tc33KBJbKUSlnYppX878WQXUvnhdB+TRmr5R3dtc5Ewc0TH4h7V1SXTly
         GiNnbbCc+BKzzqk9PTo/Pqf5dzWcpNDBA1GUkzQZDTXOXXUzBjnlrTaQctjSdE6meWfJ
         JbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9l/1MkRoZLCyZNPXaR5fzwvTbuyIzYA20JLtWuhYR4=;
        b=UIHX/qLK5s52vBAq1L96RTmfJilds1VFNEWvaiCVppi4zLOn6qtnJ4cmYZjb72c9+z
         zun/k9GlBVIM50W/c7y7n0zS4XlScmCrow1dpSpeoA1MQ0dEEQ6f2VrwTDIu3RSthlLe
         zIStAcc9gTHOssPfALuZYqYqaidYe0pvVSRnsZLW1401WkHPnL7UW7tZTAVROMBxyQi0
         tqvRjQIAvqJIxCqjo/eexRrbn7yj1BcZoqSpTPjJc+cXFWfWNvVEfaEZpHarplmdp8GJ
         q+LXO0MuoxYj02LNkPdr7sVp0V2FJZXVWz4eE4mBSPd8iDICTCAXMajh9XxvzH73bGnp
         3h8Q==
X-Gm-Message-State: APjAAAVKAuUfd0by9Hg2x+Fwhj2mqqSMOxL5aD+m3vkxazknSZx87Q+V
        UCbxEomHvmovLQcmy/xqrtWT0j2d
X-Google-Smtp-Source: APXvYqyETp8FIXhzzDrv+mhfzHhU0D9h3bcpLQ9oRbkEYPG7JvxLk5RVWx/ooYmku2+exI6oXsHTnA==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr2905889wru.85.1570027400467;
        Wed, 02 Oct 2019 07:43:20 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id z125sm10251381wme.37.2019.10.02.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:43:19 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: max77620: Do not allocate IRQs upfront
Date:   Wed,  2 Oct 2019 16:43:18 +0200
Message-Id: <20191002144318.140365-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

regmap_add_irq_chip() will try to allocate all of the IRQ descriptors
upfront if passed a non-zero irq_base parameter. However, the intention
is to allocate IRQ descriptors on an as-needed basis if possible. Pass 0
instead of -1 to fix that use-case.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mfd/max77620.c       | 5 ++---
 include/linux/mfd/max77620.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index a851ff473a44..c7ed5c353553 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -507,7 +507,6 @@ static int max77620_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, chip);
 	chip->dev = &client->dev;
-	chip->irq_base = -1;
 	chip->chip_irq = client->irq;
 	chip->chip_id = (enum max77620_chip_id)id->driver_data;
 
@@ -545,8 +544,8 @@ static int max77620_probe(struct i2c_client *client,
 
 	max77620_top_irq_chip.irq_drv_data = chip;
 	ret = devm_regmap_add_irq_chip(chip->dev, chip->rmap, client->irq,
-				       IRQF_ONESHOT | IRQF_SHARED,
-				       chip->irq_base, &max77620_top_irq_chip,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77620_top_irq_chip,
 				       &chip->top_irq_data);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to add regmap irq: %d\n", ret);
diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index 12ba157cb83f..f552ef5b1100 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -329,7 +329,6 @@ struct max77620_chip {
 	struct regmap *rmap;
 
 	int chip_irq;
-	int irq_base;
 
 	/* chip id */
 	enum max77620_chip_id chip_id;
-- 
2.23.0


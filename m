Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33645C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B1C20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Qq2uF8Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfJANX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:23:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbfJANXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:23:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so15477012wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UXwphbefxoaNIa3BWF+ZDcJIqlBkv2JNP3hYy5Lkdg=;
        b=Qq2uF8Z4L27uDSCEXrRA+mqw/EEYd7dJPlm3iWU9fq7yyhv2OXMdvhnqAeWCSfsyMl
         2H6I6pT6rRwrA9Qf4jNQduD6NJ6UI1eDWRsgxB0V0buAUaIsX87eFjaLgT1Eaf+62Jx4
         HgzBlQ9OnWgK37zKc7e9Ca5v3261eNGhHWdZap5De244frCEJkBY/ORUuGmdcubJBZ3R
         ohxVyEI+XnfdXiAACAnXCpFB5JDu77LF3PgzPMT/ZnAaKYLNay/eSrEQJ6qC9bCBphcJ
         BpER6vm+n6G2/0TSUg/h41avtO+8jBEg9cVPqG3plSmJW+qUHUn5KfBrZqBOdPFueBDQ
         0zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UXwphbefxoaNIa3BWF+ZDcJIqlBkv2JNP3hYy5Lkdg=;
        b=sixd5l0sNY1yXTEfA9pWZPTyEu+g88lkBpUCUCzc3hSgmpjQCbHda0/pnr2EP9wStI
         r8z5G8e/qV4SeGVWlv1azw+FvdjJDTQAgFzF91NF+6beKnKp2Zv0u9NLEaaDjf8CcktQ
         BVxYquDb8HZphp3Qu6bLte3DvEKa/6IIuWwfFi+jWkJgn9YVx4bfaCdMcNnYFIvqihnO
         A31SJBXmPb8hAqavN6ym/RuYA8EFTh8D/vtS6r8HWMwa/3NVO+kgI082dLVQMWgi2ZMn
         Ug/BVZZvIw7GgF/bG7I3O0F4cSyHqI3ZLleNXUpsxRXzIw1ERlr+pk6IoEn/SRLVb66l
         OrAQ==
X-Gm-Message-State: APjAAAXAKIYu32kMgTd4u+Mnc/GfKGNz7otQzQ4d3F6dCoCxH931uLbp
        UExObYcToYg6dQApOnGu5rlL0w==
X-Google-Smtp-Source: APXvYqwPIVOEtxMwDTuDgBXmP6KdpZSgvSoDSeHMC6aZMZXAjqNPoKCPrhHyDyfQ+hRhwa9Y0StEiA==
X-Received: by 2002:adf:f801:: with SMTP id s1mr2138136wrp.293.1569936226128;
        Tue, 01 Oct 2019 06:23:46 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o22sm41847990wra.96.2019.10.01.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:23:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] phy: tegra: use regulator_bulk_set_supply_names()
Date:   Tue,  1 Oct 2019 15:23:32 +0200
Message-Id: <20191001132333.20146-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001132333.20146-1-brgl@bgdev.pl>
References: <20191001132333.20146-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new regulator helper instead of a for loop.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/phy/tegra/xusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 2ea8497af82a..faf1137d1432 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -862,7 +862,6 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl;
 	const struct of_device_id *match;
 	struct resource *res;
-	unsigned int i;
 	int err;
 
 	/* for backwards compatibility with old device trees */
@@ -907,8 +906,9 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	for (i = 0; i < padctl->soc->num_supplies; i++)
-		padctl->supplies[i].supply = padctl->soc->supply_names[i];
+	regulator_bulk_set_supply_names(padctl->supplies,
+					padctl->soc->supply_names,
+					padctl->soc->num_supplies);
 
 	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
 				      padctl->supplies);
-- 
2.23.0


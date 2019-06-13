Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD91C468B0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A439120449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAXXgwog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392330AbfFMQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:27:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39970 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfFMQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:27:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so8868333pfp.7;
        Thu, 13 Jun 2019 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v6vzilPAtj2ODZwSW8fHlBGBIGUDcN2J3Si9o5NBA3E=;
        b=kAXXgwoguPvU4cAuhcaUgbXJuBSrc4pXZ01mFgLMVTiAUcb3NIkvnGdriEvuRYpcS4
         KCkN0/7AHFbsRxOm8x2szfUod289BCzSUB2ccFOtOVvhKdOyGMzy87Zl4dSeFroG+guL
         esu84wiMoP6w/H+9AVYLyYbjuEGjHZzfZcq2VaqLVuBVPuF438x9B/V4m6ISqtGWYOQM
         8j/Kz0duNoACz0A3QT+4bKsgCn6EYE+p503sKJ0P7oLkeyri1jHoyoEfTeT7CCHRCAYz
         W6zqItpX7twXVXqsYxk+Veh+fw38UvbAkJGCbeVSGbdwoGav2hPr0WylW6UZnDsmRVLn
         tv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v6vzilPAtj2ODZwSW8fHlBGBIGUDcN2J3Si9o5NBA3E=;
        b=V5VfdJ+hsQp4sMWKz4YXl9AaCAZioIlF6glvMh1tN60KWYJ8d71Cw/fy3uTv7opZLd
         3NRMBe1Mw/hkEC3MnAjz0zhvaxIflKxMbi03bD4omVg29k0swBuyFW1T4vxFte1GvND2
         FBndOQps1zcFHWZqvbKFMV8Yp8n3L3+3hgfx36QKH0BPKPhe/WoedsACXLJ7W5Vf5GCi
         V8Wmwap7B3gOrQPRGSUek2dKOxxT7kfbzqXpK2bZTZ0Nxvg3CuG5qEB2fewexrQhb2lY
         5P5Ha7eyLaUaA3iUrTBNv9axVwadTi9yNfJTF/FTwYb8aI+InKEh+WaFvHqQOsCrexL1
         DvFQ==
X-Gm-Message-State: APjAAAVYdx8XN/38i1QfHzVtvoRA0xgYes0bMSE0RiWAkA7BBOKX7Utw
        YH8sS5jp7V1FbvgIP3URfVI=
X-Google-Smtp-Source: APXvYqzPxG4x6iJ3bSwjicFDgP/gbJZePtynT5+d9Kai+1QhkL96mw1oCJcSqEHcntuvftQRVXyDCg==
X-Received: by 2002:a17:90a:db52:: with SMTP id u18mr6471125pjx.107.1560443229896;
        Thu, 13 Jun 2019 09:27:09 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z186sm185768pfz.7.2019.06.13.09.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 09:27:09 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
        krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
        agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
        heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 01/10] iommu/exynos: convert to SPDX license tags
Date:   Thu, 13 Jun 2019 12:26:54 -0400
Message-Id: <20190613162703.986-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 05c6bc099d62..938a33d2f89d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2011,2016 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifdef CONFIG_EXYNOS_IOMMU_DEBUG
-- 
2.17.0


Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41833C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6C0219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfGVWai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:30:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfGVWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:30:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hpgkR-00024f-KX; Mon, 22 Jul 2019 22:25:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: fix missing decrement of retry counter
Date:   Mon, 22 Jul 2019 23:25:35 +0100
Message-Id: <20190722222535.19114-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the retry counter is not being decremented, leading to a
potential infinite spin if the scalar_reads don't change state.

Addresses-Coverity: ("Infinite loop")
Fixes: 280e54c9f614 ("drm/exynos: scaler: Reset hardware before starting the operation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 9af096479e1c..b24ba948b725 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -94,12 +94,12 @@ static inline int scaler_reset(struct scaler_context *scaler)
 	scaler_write(SCALER_CFG_SOFT_RESET, SCALER_CFG);
 	do {
 		cpu_relax();
-	} while (retry > 1 &&
+	} while (--retry > 1 &&
 		 scaler_read(SCALER_CFG) & SCALER_CFG_SOFT_RESET);
 	do {
 		cpu_relax();
 		scaler_write(1, SCALER_INT_EN);
-	} while (retry > 0 && scaler_read(SCALER_INT_EN) != 1);
+	} while (--retry > 0 && scaler_read(SCALER_INT_EN) != 1);
 
 	return retry ? 0 : -EIO;
 }
-- 
2.20.1


Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DEC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734B12229B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SuMOXOPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfGVJ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:27:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8084 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfGVJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:27:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d35818d0001>; Mon, 22 Jul 2019 02:27:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jul 2019 02:27:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jul 2019 02:27:40 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 09:27:19 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 09:27:19 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 22 Jul 2019 09:27:19 +0000
Received: from viswanathl-pc.nvidia.com (Not Verified[10.24.34.161]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3581750000>; Mon, 22 Jul 2019 02:27:19 -0700
From:   Viswanath L <viswanathl@nvidia.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jonathanh@nvidia.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Viswanath L <viswanathl@nvidia.com>
Subject: [PATCH v2] drm/tegra: sor: Enable HDA interrupts at plugin
Date:   Mon, 22 Jul 2019 14:57:12 +0530
Message-ID: <1563787632-19762-1-git-send-email-viswanathl@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563787661; bh=VobXuXAYe397QeqmnAYN9rYN9lbzFlQxcw9Xph5TjYc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=SuMOXOPQ+wi8vYTKHk7TNtX85N90p7MnKBarcwa70v6aYm1BXN2D8Ld4uXqItiIjG
         KCANY6JGrjC7JL7uQ5pO9wVIqai9Y41gt19TQsh3NUPzuA7VQVNu/0qifmDyhCPm41
         Q38vQ99ONufQSzYmMZ4ghOBu/rwzidp7PDKoJKwt3RsclrL4KObuaZDkjDinOESnhL
         0uBpkB/OfTZCv5agtiq1Le1SYoEnU8hZ1lBJ1gCn8ito10W7N0dwXi3njwxsB2V90K
         E2ABl0naYs1qeX38PeaF/FqLKu2pZsm9ydvR/zTtVUliqoLyEJZsCnmj67tmNpbqna
         a5aTNgJXOEiOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI plugout calls runtime suspend, which clears interrupt registers
and causes audio functionality to break on subsequent plugin; setting
interrupt registers in sor_audio_prepare() solves the issue

Signed-off-by: Viswanath L <viswanathl@nvidia.com>
---
 drivers/gpu/drm/tegra/sor.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 5be5a08..0470cfe 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -2164,6 +2164,15 @@ static void tegra_sor_audio_prepare(struct tegra_sor *sor)
 
 	value = SOR_AUDIO_HDA_PRESENSE_ELDV | SOR_AUDIO_HDA_PRESENSE_PD;
 	tegra_sor_writel(sor, value, SOR_AUDIO_HDA_PRESENSE);
+
+	/*
+	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
+	 * is used for interoperability between the HDA codec driver and the
+	 * HDMI/DP driver.
+	 */
+	value = SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
+	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
+	tegra_sor_writel(sor, value, SOR_INT_MASK);
 }
 
 static void tegra_sor_audio_unprepare(struct tegra_sor *sor)
@@ -2913,15 +2922,6 @@ static int tegra_sor_init(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	/*
-	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
-	 * is used for interoperability between the HDA codec driver and the
-	 * HDMI/DP driver.
-	 */
-	value = SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
-	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
-	tegra_sor_writel(sor, value, SOR_INT_MASK);
-
 	return 0;
 }
 
-- 
2.7.4


Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549F92146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329211;
	bh=TkamJ2+/GEnDvFQn4XsLlBqL/ROlQDSbkq5gepWy8y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dF8oP+MJHj9lSvhEZqfBzEiuAZKmH6d0iVmPkszCaJJOtVddw83XBvnD0T8fY/rEo
	 lrA8uGAxEWiPF2cuLiFwjL6Q5x4QeLuFNo4sE3p0L7hTwdnPfKKFvDcFSgWbq9OZpn
	 9E/8XIS5Eacr/Snh256YA7fpLRyoId+VmLONLdH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfD0BkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfD0BkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EEB214C6;
        Sat, 27 Apr 2019 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329207;
        bh=TkamJ2+/GEnDvFQn4XsLlBqL/ROlQDSbkq5gepWy8y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn74ZwQeLyf5Gi3BffI3Ufwuxg1LPKxSEEO9jJLAG4rAwHYyGL/Cn9yJ3P8Y2dhZg
         c1HuYKBKf4A7kwP+mgRtBgpzeRSOSj2YU4EmCB5RR/8a2+AUS0Qhz3O1cFQoOx3YQ0
         aTpN43ejtK3YBcZGwEfVyGK0A3BAMmy88hu6DzTc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wangyan Wang <wangyan.wang@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 58/79] drm/mediatek: using new factor for tvdpll for MT2701 hdmi phy
Date:   Fri, 26 Apr 2019 21:38:17 -0400
Message-Id: <20190427013838.6596-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

[ Upstream commit 8eeb3946feeb00486ac0909e2309da87db8988a5 ]

This is the second step to make MT2701 HDMI stable.
The factor depends on the divider of DPI in MT2701, therefore,
we should fix this factor to the right and new one.
Test: search ok

Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 62a9d47df948..9160c55769f8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -662,13 +662,11 @@ static unsigned int mt8173_calculate_factor(int clock)
 static unsigned int mt2701_calculate_factor(int clock)
 {
 	if (clock <= 64000)
-		return 16;
-	else if (clock <= 128000)
-		return 8;
-	else if (clock <= 256000)
 		return 4;
-	else
+	else if (clock <= 128000)
 		return 2;
+	else
+		return 1;
 }
 
 static const struct mtk_dpi_conf mt8173_conf = {
-- 
2.19.1


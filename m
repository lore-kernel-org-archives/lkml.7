Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A1EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFF8233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbfHVVP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:15:29 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:17281 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732837AbfHVVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:15:29 -0400
Received: from localhost.localdomain ([90.126.160.115])
        by mwinf5d10 with ME
        id sMFM200022Vh0YS03MFMFh; Thu, 22 Aug 2019 23:15:27 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Aug 2019 23:15:27 +0200
X-ME-IP: 90.126.160.115
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linus.walleij@linaro.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/mcde: Fix an error handling path in 'mcde_probe()'
Date:   Thu, 22 Aug 2019 23:15:18 +0200
Message-Id: <20190822211518.5578-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't find any matching components, we should go through the error
handling path, in order to free some resources.

Fixes: ca5be902a87d ("drm/mcde: Fix uninitialized variable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 9a09eba53182..5649887d2b90 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -484,7 +484,8 @@ static int mcde_probe(struct platform_device *pdev)
 	}
 	if (!match) {
 		dev_err(dev, "no matching components\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto clk_disable;
 	}
 	if (IS_ERR(match)) {
 		dev_err(dev, "could not create component match\n");
-- 
2.20.1


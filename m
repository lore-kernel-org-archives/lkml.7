Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05396CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC45B21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408659AbfJYLNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:13:45 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:44324 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404433AbfJYLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:13:45 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id HnDi2100b5USYZQ01nDiZ5; Fri, 25 Oct 2019 13:13:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-Pb; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvpN-0006Go-9V; Fri, 25 Oct 2019 11:24:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/bridge: ti-tfp410: Update drm_connector_init_with_ddc() error message
Date:   Fri, 25 Oct 2019 11:24:11 +0200
Message-Id: <20191025092411.24059-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was changed to call drm_connector_init_with_ddc() instead of
drm_connector_init(), but the corresponding error message was not
updated.

Fixes: cfb444552926989f ("drm/bridge: ti-tfp410: Provide ddc symlink in connector sysfs directory")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index aa3198dc9903cefb..5ca4c0417c186e6e 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -140,7 +140,8 @@ static int tfp410_attach(struct drm_bridge *bridge)
 					  dvi->connector_type,
 					  dvi->ddc);
 	if (ret) {
-		dev_err(dvi->dev, "drm_connector_init() failed: %d\n", ret);
+		dev_err(dvi->dev, "drm_connector_init_with_ddc() failed: %d\n",
+			ret);
 		return ret;
 	}
 
-- 
2.17.1


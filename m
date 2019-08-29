Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F62C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E124420828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi/RX1M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfH2SKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:10:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35389 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfH2SKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:10:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so1955017plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lwos/Txl+3gJ4cILwAcWrc0vlbFbaTwlZO2rHBSP/g=;
        b=bi/RX1M1Ijpbeh12VwSBgshy5Fjr5hDjA9Qwq2DtksyQQOnnol0bIbdh0RSDIEq/+A
         lXOdQnRCLC2j7BBwoV6jXBSlyY/iHXu44XilPrlFGyd71C0CSG1RGLnNUsXWruQa+o7c
         v84kM6U3RwWLO7hRE5inK8Vwbwau/vcRYLUE7d4m0G/19HVyByJ0vV4VrAleCE7xDNGc
         6SJSPEmlw8FG21udJd5UyG3PoUrC/k8pMkbtC7RpgZtWj7+hQpkzHI1EbCTZ9KMAa86k
         zT5hAhsJlxEte35pG/eyo19c4Mi33KonhZk9Y4xCT/DJEBmWsh8M0oYEjSzAUNCq7H1c
         PIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lwos/Txl+3gJ4cILwAcWrc0vlbFbaTwlZO2rHBSP/g=;
        b=btG/jUz+QmY204Q/CpjbACEUkazqn7Zj8dlPhnxImASAASAKq9hd+zYJYWAlSPj1Vb
         QJhy4ftUtbf1hJwmzU5sR6Qwls0iFPqejkUT9+2Q3X0k+Y4PxqlnkV5cXPC1QB3D/fW+
         Qdx3nJXHYnbApdMe2iDEYItcidSbac0UeUdA7xCRMcrnZhk7LDda/Es11FcNsJ3n+vpk
         JbMnmqgAu/DSD7gUFKH1FIr921OweQ0pXJA+y1LDlfir0UcKGa79+2F2iUtttfEAfnt2
         T1MrLnOm9IQwDZtNHWLswYfEhmtJyN4Ws0Y++Cv56DOTPObdOpy5C9R17pRlTuZtwFI6
         7hqQ==
X-Gm-Message-State: APjAAAX/6Bc/JdKeqH6HBhBESGy4b1+YohKd4hMvobJYyMwIderJjYxL
        5UFIp684kNefWE8TLK+LLTs=
X-Google-Smtp-Source: APXvYqxFwYcGOl9PjVxoCcJRS8hZlP04fX9JS17R0y0SbFnrBi0/2SdeNJuIOCodksbEc47ozvhz3A==
X-Received: by 2002:a17:902:2d03:: with SMTP id o3mr9958930plb.311.1567102252861;
        Thu, 29 Aug 2019 11:10:52 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id 21sm3928774pfb.96.2019.08.29.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:10:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Clark <robdclark@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "drm/bridge: adv7511: Attach to DSI host at probe time"
Date:   Thu, 29 Aug 2019 11:08:35 -0700
Message-Id: <20190829180836.14453-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This reverts commit 83f35bc3a852f1c3892c7474998c5cec707c7ba3.

This commit the wrong direction, we should really be changing panel
framework to attach dsi host after probe, rather than introducing
the same probe-order problem that panels already have to bridges.

The reason is, that in order to deal with devices where display is
enabled by bootloader and efifb/simplefb is used until the real
driver probes, we need to be careful to not touch the hardware
until we have all the pieces probed and ready to go, otherwise you
will kill the working display, leaving yourself (at least, in the
case of real consumer devices that do not have a debug UART) with
no good way to debug what went wrong.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 98bccace8c1c..f6d2681f6927 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -874,6 +874,9 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
 				 &adv7511_connector_helper_funcs);
 	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
 
+	if (adv->type == ADV7533)
+		ret = adv7533_attach_dsi(adv);
+
 	if (adv->i2c_main->irq)
 		regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
 			     ADV7511_INT0_HPD);
@@ -1219,17 +1222,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	drm_bridge_add(&adv7511->bridge);
 
 	adv7511_audio_init(dev, adv7511);
-
-	if (adv7511->type == ADV7533) {
-		ret = adv7533_attach_dsi(adv7511);
-		if (ret)
-			goto err_remove_bridge;
-	}
-
 	return 0;
 
-err_remove_bridge:
-	drm_bridge_remove(&adv7511->bridge);
 err_unregister_cec:
 	i2c_unregister_device(adv7511->i2c_cec);
 	if (adv7511->cec_clk)
-- 
2.21.0


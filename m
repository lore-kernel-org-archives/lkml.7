Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA53C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61DC206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEQU5N1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFEHF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44860 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfFEHFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so11864411pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrkvpzIdMBYR+6B1XOi5qDamesEvOXiYhYzlfg/ShYA=;
        b=cEQU5N1uQTnf8WgA53Bsfw4aItgE0b7ohuBZXIsACGEzWjpuZOA5nXhdaE12lTADC0
         nFtadpYhSPGFC61TAqneAppwg7sTOPYLwBuKHiV5mqs9Lr3LxXf5EkN/0OHAf4MMlROP
         hZPX/I50VIJVyuxT9PhVStp1EQRwc1YXciLzlcbRcejHKp3m6vVBAq7cLLzfU5GZkXg+
         QicBleD9b18ww0oIO6S/xb5zW0jELkZa/YZhcKDYOFTarQnFP8F4chPj4vo3+iBCl8vt
         ycPPgbRgLI/s7KdZRiNaat80Z2i4Hu/m0x3kTu7KkdMcsE2gaG5R9FyyxFFOXroLDxgC
         m8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrkvpzIdMBYR+6B1XOi5qDamesEvOXiYhYzlfg/ShYA=;
        b=CNbafwPogX+bFg4Z/K+cZweGoNAtOyRt286J5/tvN+BRBeynBsO9PdOeg1u1z0HBLc
         kRG/2NW/77bcDbdzM4bSNqFpa42aJoMGKrcQEJLCdSwlqvUyBQDJ9yvnQOwU/QgB7SUv
         hnpYUdV749E1inXxgYucd7Nm2B551EuH6fIaZBmrw1+SLNO99dzOJBTHs1i6Br4e7E+i
         micoPvCZeE+IP7Uvdfgyre0uPXF62g8WeLkS7+dyJOmx3rWRdC7wD7TtgdvB/gANElgU
         pPt69iY9xX1oxB7r4MTj2R5O48p/mec/9M2cLe0KjZ2/IRD5af5sNUxRISYNP9eUkbB0
         UPlw==
X-Gm-Message-State: APjAAAVtzcZ9gQXFhT7m5rog6R2JoC5ii9z+BhNhVPwaOHGt4iNb8KnW
        S7iLJ/jW/cArSRxokT0dqAg=
X-Google-Smtp-Source: APXvYqw+xZC+7hjXfGk20eLYBK8EepIKcBqrCE4j8N3tZILC9uyzNyadULeyQv+RW/cmUlTSO7NPbw==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr2428121pgm.10.1559718344605;
        Wed, 05 Jun 2019 00:05:44 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:43 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] drm/bridge: tc358767: Drop unnecessary 8 byte buffer
Date:   Wed,  5 Jun 2019 00:05:06 -0700
Message-Id: <20190605070507.11417-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc_get_display_props() never reads more than a byte via AUX, so
there's no need to reserve 8 for that purpose. No function change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4fe7641f84ee..41a976dff13b 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -680,8 +680,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 static int tc_get_display_props(struct tc_data *tc)
 {
 	int ret;
-	/* temp buffer */
-	u8 tmp[8];
+	u8 reg;
 
 	/* Read DP Rx Link Capability */
 	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
@@ -697,21 +696,21 @@ static int tc_get_display_props(struct tc_data *tc)
 		tc->link.base.num_lanes = 2;
 	}
 
-	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAX_DOWNSPREAD, tmp);
+	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAX_DOWNSPREAD, &reg);
 	if (ret < 0)
 		goto err_dpcd_read;
-	tc->link.spread = tmp[0] & DP_MAX_DOWNSPREAD_0_5;
+	tc->link.spread = reg & DP_MAX_DOWNSPREAD_0_5;
 
-	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAIN_LINK_CHANNEL_CODING, tmp);
+	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAIN_LINK_CHANNEL_CODING, &reg);
 	if (ret < 0)
 		goto err_dpcd_read;
 
 	tc->link.scrambler_dis = false;
 	/* read assr */
-	ret = drm_dp_dpcd_readb(&tc->aux, DP_EDP_CONFIGURATION_SET, tmp);
+	ret = drm_dp_dpcd_readb(&tc->aux, DP_EDP_CONFIGURATION_SET, &reg);
 	if (ret < 0)
 		goto err_dpcd_read;
-	tc->link.assr = tmp[0] & DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
+	tc->link.assr = reg & DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
 
 	dev_dbg(tc->dev, "DPCD rev: %d.%d, rate: %s, lanes: %d, framing: %s\n",
 		tc->link.base.revision >> 4, tc->link.base.revision & 0x0f,
-- 
2.21.0


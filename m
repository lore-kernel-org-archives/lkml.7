Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAEC215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKnkGBzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfFSF16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43840 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfFSF1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so9009801pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kqfNfq2UBNDicaf5X51z/Q4e+iOBdOxSEncrwbn1+g=;
        b=VKnkGBzwHQed1BokAjAHwbkD/TQscY7KgmLWz4WdOquEFfqFRAZMniBRgtbwAGhdCZ
         CWEPO8uqUbasup+P9Un0t7HUaoDCoAqyb7iGAUnlARMggtNed+AzAombOeiZS0J/ZV5C
         IMWe3vhqlOvDoNU7ugT2zAnE5JR93SzAlkEqDuHL3grfWAg9Jt/zEG50YpJuJjpBgNUo
         dpgh3dZpBHZaT9CvzHUQzydshxWMwsCnjUzrrgIA7hCDxVChUnZFT0xcc1D8Zm/u/RCz
         SgS1TFbGHqq2waIaDKgFAS79RyMfBCwTbEBA4ibAuYCr/npcF2zEnZFyxH4wlrJUuGdE
         wS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kqfNfq2UBNDicaf5X51z/Q4e+iOBdOxSEncrwbn1+g=;
        b=G0H5HBxQu/LEsh1v4xtnOY4Pn/oDHh9OHf1wg/lEuIUmf5tRcJBAonnjmmyjMJSXm1
         yBkR+fHbjXtJ8ubrZjs5IxHtCI9z/v5JNf3XsQqnh5ojlfCcn5KksgUrbTi6WrMz+Vlv
         6hcJMldhATNAGn999KiiHgSdFlbQ4+lpodwm0oifWsMlRkv/v1LqEilVHGtyqcB2pzOo
         H181gWihAamJb6CEnm82QhKnquTw+gerkXFD6YtQkr0D3Cg/zZqIqUbWUOOd4J64Mf+7
         qCUpt9Q3ys6dGl8kN29qKSjo638cSPKRvZqFwIk8/6xMGjIC7AZkrrdWUWwKOqUktGb5
         65+A==
X-Gm-Message-State: APjAAAX2qsr04Ucx8OZfFkCXY/tZNf7gLx4vyzLsAoCrGHSfYIJe8+PQ
        UDuRVmbx6/nklMySI9L6xb0=
X-Google-Smtp-Source: APXvYqzriyZXGK0wY5cBfBCHFDASRS5djuRj1Oe3WfuNFONcc9OeF9VJ2Cz2byzINYz71aJ1lkXkWw==
X-Received: by 2002:a62:28b:: with SMTP id 133mr1226137pfc.251.1560922071770;
        Tue, 18 Jun 2019 22:27:51 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/15] drm/bridge: tc358767: Drop unnecessary 8 byte buffer
Date:   Tue, 18 Jun 2019 22:27:14 -0700
Message-Id: <20190619052716.16831-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
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
index 7cc26e26f371..f0baf6d7ca80 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -645,8 +645,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 static int tc_get_display_props(struct tc_data *tc)
 {
 	int ret;
-	/* temp buffer */
-	u8 tmp[8];
+	u8 reg;
 
 	/* Read DP Rx Link Capability */
 	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
@@ -662,21 +661,21 @@ static int tc_get_display_props(struct tc_data *tc)
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


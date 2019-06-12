Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1065DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D1C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwFHJ1ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408670AbfFLId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36331 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408658AbfFLId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so6337471plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyNFZYwRtJTUSjA/j/X46P0EDgr7MIqfAVin85AHqAI=;
        b=NwFHJ1ZUWon7SC/JBcHFqHY051wqR07OEucDIeCaZGA8LF72pnQkrBT/x5hUhw3VQg
         Z+RSeejCeRkBA4ZUkROJlYa9AS9yFz0aTj/lPr2kE+Zht6m5IUpFFRgX94Jl3yAYHNdd
         0MVsYoA6+UvOXs7g1t75Uz36W+z+KJqH6dexsuYTuoCEk/7rY83nA4Dr7UdskONtbpCl
         O/xKuzTds5M1p8ytbTb2D4WGr9MKOGf0y7SH5199K3rIG8B/xVMPW/hukMc6oi0svIpB
         9gtHXr22GyGVMzwsnvR+shi5WUzI+FRysYEbzFuYJDln4wTb5lbftZxlG1JYHKtOw0Xn
         KSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyNFZYwRtJTUSjA/j/X46P0EDgr7MIqfAVin85AHqAI=;
        b=mGgEYRKOdroEJbxKyyiLsF8gmj9plxDeqIAbgqQeOJ7bZNLSV/YfhtZ7CLViNI7qto
         kba/U1HMNRiJzaA7liglVUxhgJGiOU0MU8zW8uKeufObPT5lrouuR6WacIMqffmQs51k
         PCmMz1AZCmeYABzk46Q1jRPJH4zVKJNCC2W40qwBhPoerz3StOHf5A1EsXuRvuH06Tie
         jYXl2z90y7bkxOLdttQd3eai9iGXbw317RR6Ift6QZMNNqpy8yKYlYKRyKKmwYTRdPmH
         W8HGUU8o9Px8hCmj/BufhsSy0Kgk5ekTM/RnLVc+MPnl+JH43P6GwtOjkVVEwYDjj3p4
         tVZw==
X-Gm-Message-State: APjAAAVd+4j91vh7CU3LVuY7CSl1BDJ3WMfrKL5AZFjSC8FICV/DqRgX
        SlzP8O89uP8SSP+j8ZE3J5c=
X-Google-Smtp-Source: APXvYqzIELws8sNQHkSyZt89mfV3IWc/t0/+hUi+5+4bzO8+gDeS+OMT5IdfFM7nDPVJYDeTbN8JDQ==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr66641679plt.233.1560328407157;
        Wed, 12 Jun 2019 01:33:27 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:26 -0700 (PDT)
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
Subject: [PATCH v5 14/15] drm/bridge: tc358767: Drop unnecessary 8 byte buffer
Date:   Wed, 12 Jun 2019 01:32:51 -0700
Message-Id: <20190612083252.15321-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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
index 01ca92a6d9c8..81ed359487c7 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -661,8 +661,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 static int tc_get_display_props(struct tc_data *tc)
 {
 	int ret;
-	/* temp buffer */
-	u8 tmp[8];
+	u8 reg;
 
 	/* Read DP Rx Link Capability */
 	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
@@ -678,21 +677,21 @@ static int tc_get_display_props(struct tc_data *tc)
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


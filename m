Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27DCC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C5208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKR+7BpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFGErK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:47:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFGEqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so443878pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgdOwNqnp0Gjq+joA7V9mjgAs2NzHLkYxSFjvzUHs/4=;
        b=PKR+7BpHUqh9GPIvN/+gvMrt3/i06c2a4yG7H7lAt9it+e9pwhD89xHu5hQbjFYXdP
         nmRgQJok/Hr387ZkXklBGvhq2JqdoEOFBbvC25tATmTCNTIuKBb6ibpo1bI70IpSwxvh
         KucuQHoiW7spWGd3Y7TbTrJmxg5iPg7Da8zX5UpzUmv1hoEl+YyTSSBARw2fZ7pYM0pf
         +UnPqJxfEmCbytrWwfBMI74b/45bYMNX4RXB/co/Q0dabWVIw9LEF0g+Gjw639/Tmx85
         Mdbw3ldo2JokvyVKamus/loaq4u5DC5L/LFuxuN3Kj5qh2OHtBR+3EYEoNpwWHHNdl3U
         84yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgdOwNqnp0Gjq+joA7V9mjgAs2NzHLkYxSFjvzUHs/4=;
        b=ThERXweyX9Hz0mN0JUWMbepKb52qJWxiq0jFDveR3fI9pRWCQwWYUUv+PqNAkVd7od
         do4llRR/F9LghOUg0zZHObVKmtWiNADsvE+1UT0KDjom27iC0TmI/Me5pSL5I9/nZ0we
         KNJ5JVf4cuuKv6hdBwnNHwfFau4ahzEMpeIxUJcWEFpB4+ywO2+sHTo9j8IYqe+g6uJ/
         JUsQbevpa3ICZ0vi8fAtuG7LnzUNXs3SOA7JsF6btTWKzvHFA4n8Asrdl5ogWeYRbtJQ
         R08TqWzNWcjYTyS7JAqAJ8lsItGtNuzIGc0TDe4JvSMwff5L/zpnAoiXr7diKug6tKGH
         PnGg==
X-Gm-Message-State: APjAAAUE9F0K9+7QZgaKO1JmT+GTffa8IMuqyEMku9x7JZWHmpJcCuN0
        LFK5JrJKQiCjTJ16dnDw0eE=
X-Google-Smtp-Source: APXvYqwam1URsEmZ2ebvDAJp9wTGRh+FONNBUjqu1HieSfLQJEb70uedTW5rIv5SrW0eyZuq8n3sbw==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr3466223pjn.134.1559882808233;
        Thu, 06 Jun 2019 21:46:48 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:47 -0700 (PDT)
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
Subject: [PATCH v4 14/15] drm/bridge: tc358767: Drop unnecessary 8 byte buffer
Date:   Thu,  6 Jun 2019 21:45:49 -0700
Message-Id: <20190607044550.13361-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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
index e747f10021e3..4a245144aa83 100644
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


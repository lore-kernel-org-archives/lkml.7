Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B207C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0CF21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6l7lu8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfCVD3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfCVD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so551317pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2pUVl85WTK27TjuFsywFRLpzvqMpXhlPibWJ+DDAXE=;
        b=Y6l7lu8WDnNblQcW320Lc/MAAmqLRFPcHr4H0wAUI19FU5whViPeIMu61YW0eoLoWX
         n0/xZK42iLTuX02jmb7RTkFf0cKtvW4M2t/GjlS92uWVLVldaqxzV6LkVuza5TVlfP8s
         bHNJRDQxbFadDQ2pzAv6Qiy1RZn9kEOtoEYDX4A+vsyuXNoAue+gH1HKZf1a9KBN0AXT
         ShAPVHzVLeEK6Eb8YL+eDfHRZUCBLI48C45ESjDNm2DveiD8wvmUw8gsZ95btWo7p2AZ
         JgUS54t/yUwSN79jX8cdmS+himUmkEtD/uzBNBmVn3Fd7q4CQz+YfhpRWdWZks3eWWb1
         pYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2pUVl85WTK27TjuFsywFRLpzvqMpXhlPibWJ+DDAXE=;
        b=boNhbPquBfVFaFqzz+ruGhq+6GEnE0008XlN7s7pT5LwLoyi/ScfmkBm3CR3fuFWnh
         5h02oFVV3v+JPRW03SXQHRgBWg/bivhID/Kdv9LX2PdvJmoWXq3UsC5tAqzDSySdTbHY
         eQBORqdTQKxeyzpFfrEgVJdpOL2ZN8cPmhBvGCyHKLWtApIK4MTYY8RxcU0yElEqSKsC
         DT3OVLuS6E8MNp8JvazKskCkl07Y01EkpO8mafd8O5cEsAjQseA6IxnYUMInGOQ24iw8
         p+dG7F17A4ZK+lagOFPWoJHsrVyPEBd/ur7iKEr0seTEMQ+x8un4FoHYY/Ap6CcJLjaH
         +NyA==
X-Gm-Message-State: APjAAAXBKLhQ+xNA2xdnNKep4LjLBdw5aZ/6lKfqMWLdJCqsZEkCP0Qv
        WtAouvhz7iE3TqHm4ZxDHVQ=
X-Google-Smtp-Source: APXvYqxIMiSuNyLWsnL1btTMzjK+GscDB8j6pHTo2ESUDPbJiryENsUL7aJdNxKDDDXXoWJOyAYMEQ==
X-Received: by 2002:a65:6489:: with SMTP id e9mr6682897pgv.260.1553225374020;
        Thu, 21 Mar 2019 20:29:34 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] drm/bridge: tc358767: Drop unnecessary 8 byte buffer
Date:   Thu, 21 Mar 2019 20:29:00 -0700
Message-Id: <20190322032901.12045-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 07d568761463..b106e6181a5f 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -664,8 +664,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 static int tc_get_display_props(struct tc_data *tc)
 {
 	int ret;
-	/* temp buffer */
-	u8 tmp[8];
+	u8 reg;
 
 	/* Read DP Rx Link Capability */
 	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
@@ -681,21 +680,21 @@ static int tc_get_display_props(struct tc_data *tc)
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
2.20.1


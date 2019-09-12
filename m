Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176CC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E0B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8RkoSyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfILBhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 21:37:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37682 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfILBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 21:37:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so4738317pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 18:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKeAg+VF+an1CS4EAOX6mzh4xSkLDxRJGmMk96zvPtg=;
        b=R8RkoSynna9fUZ82qTTBLWsp8mmGw0D1aNjBWsLQkMBGqjUZb1Gu7HthaRUwfFvWp9
         B6iu7K3RNF0qXfz01/zG8Sg2nQknz/X/bWwi1XaOmRngYqgqWLQeZy4249AtaVDGVkKR
         nU3Ejjp7LBypukxflAzpJN3KrUzLN5HsO2wxXXnxLyBh80S9XG4wwYQjeH7Q20ikpxa3
         NofseIH7W9lG3EKBQSgtVm9kbhQOGQEJQR6N48kcmBUvdDa1oECos0ZXZW13Z6r4g2Cc
         IjcLiEd/GCNMJmxsOYo2qsXiYLyj3wbvI8mIvt7RgIkBo55cStBqaJBkNLWWJ2gAkUzO
         HFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKeAg+VF+an1CS4EAOX6mzh4xSkLDxRJGmMk96zvPtg=;
        b=amG6g1DHCu3zX3psbMAdtWhCXeR8z2AfhNTHSeMGd3vHtmqHnxuIdRC1WCTwBqPrgO
         dFKG2OkU7/23DS04h8ELrfnkjLOyfPD8dmCDUsFkjOqNrihlonGfNWvSXTB8fuaj9G3C
         G07m72U7z9IxZCMPaRemfEOlSmc5vccTKOpoaoauuHjEBPIFwaFItBiiQZOLmaskCq/N
         IX7T2FZZCFMdbaLZyLlM/NpEz4DUULuJJ1JRel4SSF+68u1cFWlon3hmT7gKREjbclzU
         j8KxkdysxBDIGnFHgoTlIeUrlJAGtcJKTOoQz8D3x5YWaxOeevKnj2+kAFLsodPBNFcK
         IONQ==
X-Gm-Message-State: APjAAAUhFoGn1+cdtZmPdOzvv+nQgwuUIvNvpyqN9NzC1jK81gyBSlkw
        f1WgV0Pg4wERheCr5JTrXU0CFy+eUXs=
X-Google-Smtp-Source: APXvYqxNosCn6ujN1bE5LevzZf60CVo34Xv1sZu8cGf+q+1adoxxMxF7CrQnTVSHjsX5cxvhEchZSA==
X-Received: by 2002:a62:5ac1:: with SMTP id o184mr44954059pfb.67.1568252268670;
        Wed, 11 Sep 2019 18:37:48 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id f22sm8682967pgb.4.2019.09.11.18.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:37:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/bridge: tc358767: Introduce __tc_bridge_enable/disable()
Date:   Wed, 11 Sep 2019 18:37:39 -0700
Message-Id: <20190912013740.5638-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013740.5638-1-andrew.smirnov@gmail.com>
References: <20190912013740.5638-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose underlying implementation of bridge's enable/disable functions,
so it would be possible to use them in other parts of the driver.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 32 ++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 6308d93ad91d..8532048e0550 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1220,39 +1220,43 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
 	drm_panel_prepare(tc->panel);
 }
 
-static void tc_bridge_enable(struct drm_bridge *bridge)
+static int __tc_bridge_enable(struct tc_data *tc)
 {
-	struct tc_data *tc = bridge_to_tc(bridge);
 	int ret;
 
 	ret = tc_get_display_props(tc);
 	if (ret < 0) {
 		dev_err(tc->dev, "failed to read display props: %d\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = tc_main_link_enable(tc);
 	if (ret < 0) {
 		dev_err(tc->dev, "main link enable error: %d\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = tc_stream_enable(tc);
 	if (ret < 0) {
 		dev_err(tc->dev, "main link stream start error: %d\n", ret);
 		tc_main_link_disable(tc);
-		return;
+		return ret;
 	}
 
-	drm_panel_enable(tc->panel);
+	return 0;
 }
 
-static void tc_bridge_disable(struct drm_bridge *bridge)
+static void tc_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
-	int ret;
 
-	drm_panel_disable(tc->panel);
+	if (!__tc_bridge_enable(tc))
+		drm_panel_enable(tc->panel);
+}
+
+static int __tc_bridge_disable(struct tc_data *tc)
+{
+	int ret;
 
 	ret = tc_stream_disable(tc);
 	if (ret < 0)
@@ -1261,6 +1265,16 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
 	ret = tc_main_link_disable(tc);
 	if (ret < 0)
 		dev_err(tc->dev, "main link disable error: %d\n", ret);
+
+	return ret;
+}
+
+static void tc_bridge_disable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+
+	drm_panel_disable(tc->panel);
+	__tc_bridge_disable(tc);
 }
 
 static void tc_bridge_post_disable(struct drm_bridge *bridge)
-- 
2.21.0


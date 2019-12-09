Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65CC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC720721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuFj1L/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfLIFJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:09:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:09:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so6591447pff.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 21:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2OHqcwVDr9+5ezRjBZJc/vTDH46fty81Rw45NE7AE8=;
        b=ZuFj1L/RTPD6b652FRkaqTT7gYm04h8zIBfLVNE8+FpZPgecaSyfVXv7nlYgtEMdUb
         aQ32CZ7r5xP/F8PJk2QBoamtwzMr5ObsKOvRuvugrY5OxcGMAq1LGGpgqYhYBdm1UNFA
         2Q38oQHG9uRw1PGq51xSbBTlRru53smE82OV6S3VU3ZQZtsgJZmA61CX1OjDL7/KDhqV
         YlXMkL/IYYLqaKFnea2+hm6y0fCVX5XMPcK6xquKSfSWAt5aF+WoM/Rkr39MwoYj+HBE
         r0SCCRnjgfp+TWXa6BMsnATFVzNayztlB7ZBW3dxJ4Haj1E3mRUgC9fFa4qfyoKBbN7T
         mNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2OHqcwVDr9+5ezRjBZJc/vTDH46fty81Rw45NE7AE8=;
        b=Xi1/pdIMXBbYOjc9Ak0+QjJpCd0xiSbi2lTZC+i+p0fiNUy0p6PgxiTNY423G5DNE+
         zAkNuEfzioF6LK7dVOkbmbJx5uU2BwiQ8vK1bSdMC4uCoTDX5Ob4ckERxAe58FAF4J5v
         An2qwhbIupFAZ7d26TBuXWQ4UOUIO5sQg3fgufhQ0m1gpEmQeMb5GIdA8QHWLoDb00m1
         BAuAc/CsPk/+TQ07uc/OpWL6j8qPRNM0udHuy7ul5PRHNpW4OTnbs8KmqDs9Wvy3fH3j
         RjmWyhnePFzDjVO4Dvbm7QOQBSVSTWTe2Lcu4ISC0nsgK3X4zSs1ZnvAIN1sUpcyIx8i
         Havw==
X-Gm-Message-State: APjAAAW/1pPq27UuRdNv10tN3kYjXsnkk7VyV7K8SbWC8Bz9qiuI5lXW
        WZJ3uQYl6v26fYmZ3FwHTmM=
X-Google-Smtp-Source: APXvYqznSPSBRdPUtHXJID+lr6Go5PbSAOz5w3ewSHHSZGkKfkun066IEFBVJMejkW0Qwsh7paSIiw==
X-Received: by 2002:a62:e208:: with SMTP id a8mr27642069pfi.258.1575868144048;
        Sun, 08 Dec 2019 21:09:04 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id k15sm25752119pfg.37.2019.12.08.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 21:09:03 -0800 (PST)
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
Subject: [PATCH v3 1/2] drm/bridge: tc358767: Introduce __tc_bridge_enable/disable()
Date:   Sun,  8 Dec 2019 21:08:56 -0800
Message-Id: <20191209050857.31624-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209050857.31624-1-andrew.smirnov@gmail.com>
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
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
index 8a8d605021f0..3c252ae0ee6f 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1222,39 +1222,43 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
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
@@ -1263,6 +1267,16 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
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


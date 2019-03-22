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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03220C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970DA2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6hf30br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfCVD3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43798 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCVD3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so484845pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPSVcf+dfvV2lEaXqE0Y3BqqEMdwT4aIXnO4VFTAii4=;
        b=Y6hf30brOL+wOWTz7vL8GCUFl8DNj6a8LAREJ/5QHZMMjy3qeQDGjarGn8XZiGxIad
         CCBvgA4fsFGLLPf8sRpmVbZ1HeU6I7fbTGWJV7WzRbYBggwecEWd66GQe+iJnNTRIDXT
         f60eqBiIsw3j5PwEazlePVcNWA1H3CytBIcIwn2oAAkK28kkbQFFWsDsWEnyakRjIo/G
         skHiJrJ8uOtqLsEkfEvlMlAJowApzvE4CZKQiXpOQKMeJjoKn1qXPI7PLsiZPfwaZEVg
         ehmuirYb7IZCpwd60ZEuy6k5GZKO9uuOmGx9uqdZlKvV9H7Vcm4jb95g2AS9ov1TDLs7
         BOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPSVcf+dfvV2lEaXqE0Y3BqqEMdwT4aIXnO4VFTAii4=;
        b=pTUN3mlHjV8M6SwgL9NtMeUjto/nM/9ehffrQzrKhIEDLIZfBxQFRyVs5B6yW2upjz
         /YYOHTBNWSh8RPnyfI3s1CKT08h7Xk1h55IOxXMOdqBVGjF59zyu5CcCYtwU+W6ZgI60
         FtjH7yAbKM25UZ5fTc67dyWav9sHFu8BkgaJbsuaxKA9/pPZuXJQdqDn/WMnhRsyT0dJ
         bPjP7ya5tqaoHPOD+LwKxiBGKD0Lg8FVNLAynCa/9fZ8WQOR7IhPCDlfpXPbRkMLOt81
         OGZFt9jnVFPo2JVtpqjHb1awXl1b41MX+/9+XbsP29q3gjJDUptlzkiX+ceAhZ9ccmcV
         YHkQ==
X-Gm-Message-State: APjAAAUjdNkBFpOCJMCI1UobxWmMUGHqsjbzH09HsQSZ3OoLsNqXM8fe
        also86PAGDipyVLVAFeWIPI=
X-Google-Smtp-Source: APXvYqzX50NhTPanZDDio+q1H5JolPCSOsSvXxaGUxsYqZA9UE9Q3XxlDQyM0IjwZN2iX5KguKFP2Q==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr6691138pgn.274.1553225355378;
        Thu, 21 Mar 2019 20:29:15 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] drm/bridge: tc358767: Simplify tc_poll_timeout()
Date:   Thu, 21 Mar 2019 20:28:47 -0700
Message-Id: <20190322032901.12045-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
the code for regmap_read_poll_timeout(). Replace copied code with a
call to the original. While at it change tc_poll_timeout to accept
"struct tc_data *" instead of "struct regmap *" for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 51095ab1e996..89a4392dfa35 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -250,34 +250,21 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
 			goto err;				\
 	} while (0)
 
-static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
+static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
 				  unsigned int cond_mask,
 				  unsigned int cond_value,
 				  unsigned long sleep_us, u64 timeout_us)
 {
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
 	unsigned int val;
-	int ret;
 
-	for (;;) {
-		ret = regmap_read(map, addr, &val);
-		if (ret)
-			break;
-		if ((val & cond_mask) == cond_value)
-			break;
-		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
-			ret = regmap_read(map, addr, &val);
-			break;
-		}
-		if (sleep_us)
-			usleep_range((sleep_us >> 2) + 1, sleep_us);
-	}
-	return ret ?: (((val & cond_mask) == cond_value) ? 0 : -ETIMEDOUT);
+	return regmap_read_poll_timeout(tc->regmap, addr, val,
+					(val & cond_mask) == cond_value,
+					sleep_us, timeout_us);
 }
 
 static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
 {
-	return tc_poll_timeout(tc->regmap, DP0_AUXSTATUS, AUX_BUSY, 0,
+	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0,
 			       1000, 1000 * timeout_ms);
 }
 
@@ -584,8 +571,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
 	tc_wait_pll_lock(tc);
 
-	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
-			      1000);
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret == -ETIMEDOUT) {
 		dev_err(tc->dev, "Timeout waiting for PHY to become ready");
 		return ret;
-- 
2.20.1


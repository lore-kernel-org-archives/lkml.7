Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB4C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25F2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqkuosh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFGEqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34128 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFGEqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so472835pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDwCywSe61AQ1huKdlpoPGgNH/JzLRb7/WTxXy4tPVM=;
        b=rqkuosh7bus1+CQNj1IUovSeUOrdago6Q35nYRMGgLHqAi0vBgspWZgqbfYaIMa4ff
         rg5KytX4vwhB/koX5Fk7aVH7Q8QcEog+0o9I90Jqa97phlmZgYw16KHHA6lytcNWyp7N
         TjUnzHAM3Pq6tsIPpCBiL8wW6rNpe7oaZgcVYIvsC6H1BLQ/yJjB0sdLaxzf7BdGUAKq
         hwtR6quXURXz/heBxGjj1e4WolkLoIuEb6EZx//C16Ii80YfR6g4lo0xXxmrLXjPqotf
         YTIRa0kt3joBYhkQJ0lh75JfKkRQj8OY/qANmrixbScx4IgPGXVOynnVHtJBky0d6YSC
         LCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDwCywSe61AQ1huKdlpoPGgNH/JzLRb7/WTxXy4tPVM=;
        b=WKQbskD9FrjhFeiK2gPRqBkgvMQR8UHhuKMyRqmCINRtXF1xVnKBrrZXe1//7PNMiD
         HpuF0vxHCza7niIQpJqM5KDymLQxx2zBRR02MUOzpmVxLwsVf0bULn0SO7g+0akZjfbd
         RX5E89DAAhwaKNrpxEvCDD0b21ShEyZWYYsnthXBUR6MBGLwpcvBWra+WWv8rHFhmron
         nQxVj/4gn1JJYh1oxWLsHbjkxeP/dlX8eMO/nCAlXgKSNPmB7S5KkpYwRihz1WX/75BB
         U0p+p2fQtmyECgZkab+NF+Vei3cLXOZ/JJqRwt3zLM/IdbtLsQZXnQMKDVikfgdWDRvR
         60vQ==
X-Gm-Message-State: APjAAAVAK9XBGJhwlPNVCZXHXGLnLtgk/qFt01MZBNzZL2O7x3U04oKP
        RVNPOGs4GBtO1Bi1wt+Pe+E=
X-Google-Smtp-Source: APXvYqySat2DyZ9xoRjJ9Wpbr9PIP1MKA0v9pw1oAYWGEsVd0BXbMu98JyCubWUknFwPYp3UOgHPrQ==
X-Received: by 2002:a17:90a:1951:: with SMTP id 17mr3432822pjh.79.1559882799751;
        Thu, 06 Jun 2019 21:46:39 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:38 -0700 (PDT)
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
Subject: [PATCH v4 09/15] drm/bridge: tc358767: Use reported AUX transfer size
Date:   Thu,  6 Jun 2019 21:45:44 -0700
Message-Id: <20190607044550.13361-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assume that requested data transfer size is the same as amount
of data that was transferred. Change the code to get that information
from DP0_AUXSTATUS instead.

Since the check for AUX_BUSY in tc_aux_get_status() is pointless (it
will always called after tc_aux_wait_busy()) and there's only one user
of it, inline its code into tc_aux_transfer() instead of trying to
accommodate the change above.

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
 drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8b53dc8908d3..7d0fbb12195b 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -152,10 +152,10 @@
 #define DP0_AUXWDATA(i)		(0x066c + (i) * 4)
 #define DP0_AUXRDATA(i)		(0x067c + (i) * 4)
 #define DP0_AUXSTATUS		0x068c
-#define AUX_STATUS_MASK			0xf0
-#define AUX_STATUS_SHIFT		4
-#define AUX_TIMEOUT			BIT(1)
-#define AUX_BUSY			BIT(0)
+#define AUX_BYTES		GENMASK(15, 8)
+#define AUX_STATUS		GENMASK(7, 4)
+#define AUX_TIMEOUT		BIT(1)
+#define AUX_BUSY		BIT(0)
 #define DP0_AUXI2CADR		0x0698
 
 /* Link Training */
@@ -298,29 +298,6 @@ static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
 			       1000, 1000 * timeout_ms);
 }
 
-static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
-{
-	int ret;
-	u32 value;
-
-	ret = regmap_read(tc->regmap, DP0_AUXSTATUS, &value);
-	if (ret < 0)
-		return ret;
-
-	if (value & AUX_BUSY) {
-		dev_err(tc->dev, "aux busy!\n");
-		return -EBUSY;
-	}
-
-	if (value & AUX_TIMEOUT) {
-		dev_err(tc->dev, "aux access timeout!\n");
-		return -ETIMEDOUT;
-	}
-
-	*reply = (value & AUX_STATUS_MASK) >> AUX_STATUS_SHIFT;
-	return 0;
-}
-
 static int tc_aux_write_data(struct tc_data *tc, const void *data,
 			     size_t size)
 {
@@ -356,6 +333,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
+	u32 auxstatus;
 	int ret;
 
 	if (size == 0)
@@ -393,10 +371,16 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	ret = tc_aux_get_status(tc, &msg->reply);
+	ret = regmap_read(tc->regmap, DP0_AUXSTATUS, &auxstatus);
 	if (ret)
 		return ret;
 
+	if (auxstatus & AUX_TIMEOUT)
+		return -ETIMEDOUT;
+
+	size = FIELD_GET(AUX_BYTES, auxstatus);
+	msg->reply = FIELD_GET(AUX_STATUS, auxstatus);
+
 	switch (request) {
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
-- 
2.21.0


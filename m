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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0222C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUdmC/bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFEHFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46621 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFEHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so7608257pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnLLdVOlusYEYXI+itkoU5Jat5K5TT8w7N1F2rwe390=;
        b=XUdmC/bvWolT7eI9YQ2cUFGxT2x+UR40fKEvKzQytbCtCbLnVXn60ri7ZaGHoMx0GJ
         gHZMwaJ6ULtsNFeV3IRzhIAMLH9gi897sX3lZoyKqf1NqL389JgUcjcA938NcnXuyQxg
         zyy2gu9IBni0w5Y1sX4HSUvJxt+UaZK+svntZSnv0eWIgJyzhbx0Om8SL83kUCQ4dQlM
         Up5MZamVlHETacU8vcyB6GOrmyLuxwUD4XYMv1fgLBVVM04j8B1RDH1WDRYwyAhFuFo/
         SWhV8WXS23ZWu4J6clcwGKBzcCm7bZxM8l3G94IId7hQL6GyPWPH7tOkpvtmA06S5xok
         yZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnLLdVOlusYEYXI+itkoU5Jat5K5TT8w7N1F2rwe390=;
        b=s3XfI9oiNNQewZFWgkjZjNYbAvF6h/zcX/5I+Na64FO7FGdQjLKS/TMGRBaeqklyPe
         Zl39YUBWgg9iUL3hHhUZbxt3hQkJ1Hv39KyA/9zysqBimDAR/xxQ4WBayrnwOL/y7hQ6
         U0JWRSEHJGtndEaspdCAsFQeCIe7Au7kL2CU3ocYL7JxQ+ZZTmc07zG9yjuXXlAtbOmq
         0kCq5UhV46pY2dodWYNDMqrCUIRYngQWkmXhdrB4pjJMjxx9tatyPrFcUdAtt7dG0Gze
         tJcEWk6w960LWlJmFLH4bHksq73JBWTtGVNIaErp1n4u+tIz7HWLbE6sih0qUtT98oop
         sT4Q==
X-Gm-Message-State: APjAAAVQb+/KyyAP4e4INcy9ybLuY3Hjty9eRRzRriuaICBbF/P5iPJC
        2RipCUXolTXXRG8csitVgHQ=
X-Google-Smtp-Source: APXvYqxosOSGK/X48hpPYA1EtlqllcZl4FXcITFWzaZyuWAPxItNSho0urmjq/AA02M7XKgLnhenPQ==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr14564567plp.216.1559718337640;
        Wed, 05 Jun 2019 00:05:37 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:37 -0700 (PDT)
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
Subject: [PATCH v3 10/15] drm/bridge: tc358767: Add support for address-only I2C transfers
Date:   Wed,  5 Jun 2019 00:05:02 -0700
Message-Id: <20190605070507.11417-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transfer size of zero means a request to do an address-only
transfer. Since the HW support this, we probably shouldn't be just
ignoring such requests. While at it allow DP_AUX_I2C_MOT flag to pass
through, since it is supported by the HW as well.

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
 drivers/gpu/drm/bridge/tc358767.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 90ec33caacbc..7b84fbb72973 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -145,6 +145,8 @@
 
 /* AUX channel */
 #define DP0_AUXCFG0		0x0660
+#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
+#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
 #define DP0_AUXCFG1		0x0664
 #define AUX_RX_FILTER_EN		BIT(16)
 
@@ -347,6 +349,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
 	return size;
 }
 
+static u32 tc_auxcfg0(struct drm_dp_aux_msg *msg, size_t size)
+{
+	u32 auxcfg0 = msg->request;
+
+	if (size)
+		auxcfg0 |= FIELD_PREP(DP0_AUXCFG0_BSIZE, size - 1);
+	else
+		auxcfg0 |= DP0_AUXCFG0_ADDR_ONLY;
+
+	return auxcfg0;
+}
+
 static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
@@ -356,9 +370,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	if (size == 0)
-		return 0;
-
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
 		return ret;
@@ -382,8 +393,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 	/* Start transfer */
-	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
-			   ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
 	if (ret)
 		return ret;
 
@@ -397,8 +407,14 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
 	if (auxstatus & AUX_TIMEOUT)
 		return -ETIMEDOUT;
-
-	size = FIELD_GET(AUX_BYTES, auxstatus);
+	/*
+	 * For some reason address-only DP_AUX_I2C_WRITE (MOT), still
+	 * reports 1 byte transferred in its status. To deal we that
+	 * we ignore aux_bytes field if we know that this was an
+	 * address-only transfer
+	 */
+	if (size)
+		size = FIELD_GET(AUX_BYTES, auxstatus);
 	msg->reply = FIELD_GET(AUX_STATUS, auxstatus);
 
 	switch (request) {
-- 
2.21.0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D5C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E52086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjTQEQM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFEHFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40086 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfFEHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so11865466pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWa3xMhIG7h2ZDJedBrnEPzMrydSyBPoX1txGwYk6+U=;
        b=pjTQEQM/NCzvm3rKIdA/jf1ynZxiZDf1SDBIDA4M3O+FwsyScIvnbcO2uajRBeDUtB
         H8KwDgjBWXNTr778cITsLegfEbxsGpzdjdTK2zo6F2G4Iy0xZDr9X2D9/0I3P5O51IiJ
         ITp6L+msYtdfxpBb5c+q+0dWFCgZTqojOjEjocVxnPZGZzwE5BHpVOVZZskAAsXR2Ij1
         l5iMa1GGT5zjOTltNAP63i3RWMc2hHDu1xt1opU8JDqDW9EXuaOdOCj9fKVJLzDZ5lPK
         l/CFuL1ntsYHcdvBYjgg5CfcnQaSxnTuzQcLJr9XizuEUxe0QIMS44IbHJkiTP5KDtxV
         QHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWa3xMhIG7h2ZDJedBrnEPzMrydSyBPoX1txGwYk6+U=;
        b=aZH3m3RQTzqKyyO9pWyJsHeZ/FAq+sklAIqFkTBgWjTnFQk3G6bt5N7zJSTDakuVUy
         pfH+WjZwRXKPc04PhQfB6j4z/a+HvLzhYgFfF7n0Ysgd9VdgUDVfgS5QCsa72nAx/ACK
         gGU2AyJCoIqcpI3UWm15JCmiFXvx9tmtls/QfVp5RHTlumk2iQOy66GR7fAeLerhki+O
         G4Qo1SeB4DGcAB5eruR8M4SBflzBWLBoCRJ7VCEAUCjTcbxTEQaRuNOAKqAQRFBhfoBE
         M+3sAJNTeIRKJGO17rq2O5MzIQ6GGbSSe4p53Iy4pQa5OLaYDjTncXGKv+fbedkNWdrY
         BzHQ==
X-Gm-Message-State: APjAAAU/C4jZG7cgXTOF/FMMdCLKH9N3TsLBVPngQ8dbl5FRUpBNRc+H
        tC+iE7hP8Sd3g00ld/0XAgo=
X-Google-Smtp-Source: APXvYqzfIFPHQiaOX73DfBXVOSKeNpTqj0fwulD+Nk3oYEtTenve0VlAKDYYowF5v2VUvbCDLrLCrA==
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr42228780pjq.51.1559718331351;
        Wed, 05 Jun 2019 00:05:31 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:30 -0700 (PDT)
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
Subject: [PATCH v3 06/15] drm/bridge: tc358767: Simplify AUX data read
Date:   Wed,  5 Jun 2019 00:04:58 -0700
Message-Id: <20190605070507.11417-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify AUX data read by removing index arithmetic and shifting with
a helper functions that does three things:

    1. Fetch data from up to 4 32-bit registers from the chip
    2. Optionally fix data endianness (not needed on LE hosts)
    3. Copy read data into user provided array.

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
 drivers/gpu/drm/bridge/tc358767.c | 40 +++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e197ce0fb166..da47d81e7109 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -321,6 +321,29 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
+{
+	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
+	int ret, i, count = DIV_ROUND_UP(size, sizeof(u32));
+
+	ret = regmap_bulk_read(tc->regmap, DP0_AUXRDATA(0), auxrdata, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		/*
+		 * Our regmap is configured as LE for register data,
+		 * so we need undo any byte swapping that might have
+		 * happened to preserve original byte order.
+		 */
+		le32_to_cpus(&auxrdata[i]);
+	}
+
+	memcpy(data, auxrdata, size);
+
+	return size;
+}
+
 static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
@@ -379,19 +402,10 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
-		/* Read data */
-		while (i < size) {
-			if ((i % 4) == 0) {
-				ret = regmap_read(tc->regmap,
-						  DP0_AUXRDATA(i >> 2), &tmp);
-				if (ret)
-					return ret;
-			}
-			buf[i] = tmp & 0xff;
-			tmp = tmp >> 8;
-			i++;
-		}
+	switch (request) {
+	case DP_AUX_NATIVE_READ:
+	case DP_AUX_I2C_READ:
+		return tc_aux_read_data(tc, msg->buffer, size);
 	}
 
 	return size;
-- 
2.21.0


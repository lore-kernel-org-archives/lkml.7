Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C38C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E6D215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEmVluxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfFSF2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:28:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfFSF1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so8971480pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLH0lqvZF2YW47kF82c+4eI137sw7vALgNnez8nJtAo=;
        b=qEmVluxmK/18OQ+++SpHWnGDCghiUyUaW14rwQjiPOLI5J4BeYe4D1gCQuG5NyvqXN
         qwCRgux/LCIMpoAp+VNhY01o8kStEkjtw0OW1JelbTj++ZKv8Lwuo4Q1LkcJYyp2WoWt
         gODUNatTlmb/Kqe9OYCrQN6s3EGk4DpGHx//kS5fXN8kIOiSZr316AUv+c0NC+1s8enS
         Ud7+1sYqow2wwTvUKaNbSE1AJzsBv33ET0g3lmPh7oiLEDy0kmb6hEsyvRf4pxvgsisO
         26a/8KSibKbxMimvGU7lNlS1/p4uaGZnk47necXS2AU+9c286QVCZHtHT25yIOjTROPR
         j1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLH0lqvZF2YW47kF82c+4eI137sw7vALgNnez8nJtAo=;
        b=Em9onqevK+fCydSLCCAjJAY1kTTPRNkcvc3mSnkIllXM6oui/2uOAah/7SMnLV5rUA
         wze4W44Y4Z2gq+pPTebhmhKgb5UIFN4wIXAaFG5aBP7Rk7hIhfiytS/k8xPhX5/LSQ0h
         w1fsed63MU1mjO8AkPcKB2B5ECK2ZXwP/D/bG/CjeXXxfgZ3eiRwqjpPoCmOVDf9pAYs
         cp+EWEfV4c4tHcTBlkIb5vaP86HICYNpTIFdBS/Ra2Eo1N0I3tVYi4u3cuM8yvXBesta
         ChHfNm0LVQal4SvUApjE4x03bMb9Wwl7gi0UsxzBOsUp5XiROBBqfKfPkZ7VY+1edfPd
         5sLw==
X-Gm-Message-State: APjAAAX8GJeUyKRee7NP9xv0iWP3BkcLyLlaOjBQnBd1QhCCPbP7Mkg9
        DVZpFgdZSVBFiZLbetc9qDo=
X-Google-Smtp-Source: APXvYqwEo/5VnxgZr65e8cL5i0qkfqYPmZ0/fI74F+U4KjS3UH+04Mf40Dg1QxYprFHJRxYt5LoSrg==
X-Received: by 2002:a63:145f:: with SMTP id 31mr6055673pgu.320.1560922074652;
        Tue, 18 Jun 2019 22:27:54 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:53 -0700 (PDT)
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
Subject: [PATCH v6 15/15] drm/bridge: tc358767: Add support for address-only I2C transfers
Date:   Tue, 18 Jun 2019 22:27:16 -0700
Message-Id: <20190619052716.16831-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 42 +++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 3f8a15390813..7b8e19d6cf29 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -145,6 +145,8 @@
 
 /* AUX channel */
 #define DP0_AUXCFG0		0x0660
+#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
+#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
 #define DP0_AUXCFG1		0x0664
 #define AUX_RX_FILTER_EN		BIT(16)
 
@@ -326,6 +328,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
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
@@ -335,9 +349,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	if (size == 0)
-		return 0;
-
 	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
@@ -348,9 +359,11 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 		break;
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:
-		ret = tc_aux_write_data(tc, msg->buffer, size);
-		if (ret < 0)
-			return ret;
+		if (size) {
+			ret = tc_aux_write_data(tc, msg->buffer, size);
+			if (ret < 0)
+				return ret;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -361,8 +374,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 	/* Start transfer */
-	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
-			   ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
 	if (ret)
 		return ret;
 
@@ -376,14 +388,22 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
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
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
-		return tc_aux_read_data(tc, msg->buffer, size);
+		if (size)
+			return tc_aux_read_data(tc, msg->buffer, size);
+		break;
 	}
 
 	return size;
-- 
2.21.0


Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693E42082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq0k8Pei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfCVDaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:30:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34742 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCVD31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id v64so547813pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INRHOGy/wyO5pYqIz/meaocRgOP5THaNDqBF/skxbt4=;
        b=Yq0k8PeiQl3yK/RRqk7tB5Tpq9qP39QD/K7vz5XiXmREuzE1jjheXMwsDzj3UnAB4R
         tbA0rW/cLjNP7uLbzFH0sJ6ed4UqGfmPiXZ/Q8Xq8cvvwrZaH3aMST6qsod5XyFefp7c
         D+PwVn9hv7Vvmub0TGfZfRhXvYXe0TIBPhHdtQLlj0dfkHshQ799o7WbbSs4bZB6TGkC
         ajGAm8Eyq5QMESZuTqTjP9hGDALze1DcsdG7zdvtfp3OdnXVxoz0EHyG6/+o7MnfJ4ub
         oeY9yiXnziM7Ob5Ea3YgB6NcraTnYNZRx5KA55TpLyfuNmPhKNCtx3P6wSbWyl2ThoU0
         4UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INRHOGy/wyO5pYqIz/meaocRgOP5THaNDqBF/skxbt4=;
        b=Zjv7mRkwSoSs4LdlyTurlEAuqxjWIQwXNRQGVQNM1MwxKN6GWGshiabjNSCWZndo4H
         NcIhdG6i5WhdK8uufrqaewXd2VHYpz5Y4SbF2Ot3uz3WKFvvYSPkT2NEEWn7C/KgrkKM
         Tx6/UMtGwy1Q26hGUXmVkkM+j2Zq1YE566YT4k7eWL3TCvILgkUz482ctT9NgIDJ9HT5
         0wV1FziDjl+vsX6OXjfIKetMNkYd5TlFzRskXLALMPtxOVdJxEAKqmiQ1mi02iG57ytz
         6jHVV1t3n0sXYQYHu5PnyYOfkjaRKP1SIb6AgFLeb8LzUOkaCR4GSuaHR+NKfE75bwCC
         kIfg==
X-Gm-Message-State: APjAAAV5wj0ZCLPNiJWl6+Pb4hbzDggnSgD6SDuY1714jhNJ5Enyt8bq
        jAQcTyCKy2+FBqk9TyEx11E=
X-Google-Smtp-Source: APXvYqykN/xMdFgOu0eVfhId68HO23vr/yRbgfH0CrsrHywVeFeKxRK8nrqEjRSs1hL0TpPEltnh9w==
X-Received: by 2002:a65:43c7:: with SMTP id n7mr6796715pgp.173.1553225366880;
        Thu, 21 Mar 2019 20:29:26 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:26 -0700 (PDT)
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
Subject: [PATCH v2 09/15] drm/bridge: tc358767: Use reported AUX transfer size
Date:   Thu, 21 Mar 2019 20:28:55 -0700
Message-Id: <20190322032901.12045-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8adaac5ca271..7e4607c6907f 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -144,10 +144,10 @@
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
@@ -284,29 +284,6 @@ static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
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
@@ -360,6 +337,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
+	u32 auxstatus;
 	int ret;
 
 	if (size == 0)
@@ -397,10 +375,16 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
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
2.20.1


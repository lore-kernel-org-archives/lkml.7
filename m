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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C00C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2519208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpv0d8+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfFGEqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40129 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFGEqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so477141pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZklS6pvicUZ0eZgV6GpKRPOoi/1A0xUpeNx3/aPjUOI=;
        b=jpv0d8+ZXAQ+2X61Nf7nBWIFtO5jUETkOgnHZOlrzKrjsGI+Nn6CALs52tXmnb2gKP
         W3dtrTyDXrsHnQcMfsXIlj22QjR4RPyQ65u1LcqyndTQwnqMXAStyB7Aq3zL7daA8gl/
         01/bV9eyRdVZ/PERH2ltdUb711QiZWR7MrIxvZPZcFEgB9V9f+dDuoE7ufyRMSb5nknI
         tpAsCXG9oaDgQsDjPbBdZQoOSJ1F2JSJzZXYkUqbMt2hkZ+iWGN+0rYx+pAj1xi8pVih
         BmoCcADuUdDn0khUzcpvevIsLtWiCsPSoS9OCk7gt4rAQv1bjh+C54KQ/WB4F/MeanFa
         N6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZklS6pvicUZ0eZgV6GpKRPOoi/1A0xUpeNx3/aPjUOI=;
        b=LWrDtHkyQOhnPqJDomilqVLOxP7cTrGXR9/NGn4PA2h2SggY7kBrMYJlPvkWWmztlm
         7ll1DhoAwc38wDU3v+ifZ5C68q1C5hko1WTqtu5/WS/9+SwJtYElpbognObTWLOWPrWh
         J/+/HT1a2vgoZ/By70Pl9IWkmBFqFn8ao2c/Wmv7oE8tM1dfm1mG/5I13g7YYIM7cq1R
         /08d8EAKTc1gShurVz9piateD14nXalCNHcLHMeQ+wMihWwIHRi3UKmwxdFL5HQYv4cX
         Du2SSWftkdy7oiTnjDgacNK+1YKTaV5jiFA/QD+PNqHIBeNo37e/k5Gc92UchxckNGBS
         CH1w==
X-Gm-Message-State: APjAAAWVUAjby07mlLh6nLLv+K1bfNr+JORZbEhheYfzbrq3RjHXKUbN
        4Z007+1/fCLQY6lZc+Fs/P1f1RiqiTA=
X-Google-Smtp-Source: APXvYqxjQbKhj2ZbX2wC2n96f6CvtKnLMTZtKZGyB/bfY7GaK4nGznNKTwUM0cAIyeS5maEECqbAgw==
X-Received: by 2002:a63:191b:: with SMTP id z27mr1076245pgl.327.1559882801111;
        Thu, 06 Jun 2019 21:46:41 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:40 -0700 (PDT)
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
Subject: [PATCH v4 10/15] drm/bridge: tc358767: Add support for address-only I2C transfers
Date:   Thu,  6 Jun 2019 21:45:45 -0700
Message-Id: <20190607044550.13361-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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
index 7d0fbb12195b..4bb9b15e1324 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -145,6 +145,8 @@
 
 /* AUX channel */
 #define DP0_AUXCFG0		0x0660
+#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
+#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
 #define DP0_AUXCFG1		0x0664
 #define AUX_RX_FILTER_EN		BIT(16)
 
@@ -327,6 +329,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
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
@@ -336,9 +350,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	if (size == 0)
-		return 0;
-
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
 		return ret;
@@ -362,8 +373,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 	/* Start transfer */
-	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
-			   ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
 	if (ret)
 		return ret;
 
@@ -377,8 +387,14 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
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


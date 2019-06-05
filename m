Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0DC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDBE206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVPIYke/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfFEHFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFEHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so11881194pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQDXy+HnUfgnkG61CQzmVPka5AA3kE5ajdtEw9kTzGA=;
        b=OVPIYke/b/AIKAzyPux8I7yZ7ovCGIn+2LxvLJt9s/ISoCcFERqZq3sO3IP56UsOKN
         32Kv5LyNimcOqysNm/VvAy1lvohHuI9wnd1Ag9QdqzJbxy4G1msJDx/z+r6t3UOMKZTS
         byGyg1/N40tuVrl/IgqUahQXHjQ/JYxZU9EV1yz5iY7AjUJt0qvnpfstKDNZKCIFaVcK
         Mr078IyHi3Q50uvBDFu4F4rZeXw19PjqtoSxByzV4NxEKEwBlF/hIj3tIzAQTglMjYQW
         O8lW0mBBRysyn4RW4RtgTV1ihhMPC2wLQtfdSZlDiN5gDhF/nNrePEL4PConR1Fagd5D
         Dd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQDXy+HnUfgnkG61CQzmVPka5AA3kE5ajdtEw9kTzGA=;
        b=XNkILTYZnryeuJaeUUwuQqI8bV8Rn+TjV9SNcTtOwvUMW0qJ3ufaec8wYx8eUtV/sZ
         Lx7ayHpNoAo8o/ufvlAkoJuxXhZN2qGQVAAfbkuvMHQcHdOodKqJAp3hdkGgcpfwCLJv
         rI3O4Xd5EabW0LzOg6WrFk18bh87rpUhROqPWbPo1bLAG7R8yefq3r2zkLQVUWZilUZp
         Yue/k8NxwaTf5T+oxdk/GG7qOYmEhvbUCns90kTleF/1iOlKh+J0RW8RAHB+wVX7YKP4
         IA8QlSyj7De9fPf70ky7Dflz3AK5IBj8IOs2eWI4wgZXK9NL2BqDELUWdNL+uWljjsWf
         C4OQ==
X-Gm-Message-State: APjAAAX6LJlC3T1+N0ZN2KRs+hfHR6nYbNnnRvdEuylg/e1x5ChtO+bN
        PGyKS96A3E2DsXEtvHmpyCQ=
X-Google-Smtp-Source: APXvYqyPa/jIWF9TiK5toybcTHSLUzjMSrkUQDGpCbglp7r6fxWNk69jO+RmimgwTrVUa+33h6ONNw==
X-Received: by 2002:a63:6111:: with SMTP id v17mr2444359pgb.206.1559718335807;
        Wed, 05 Jun 2019 00:05:35 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:35 -0700 (PDT)
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
Subject: [PATCH v3 09/15] drm/bridge: tc358767: Use reported AUX transfer size
Date:   Wed,  5 Jun 2019 00:05:01 -0700
Message-Id: <20190605070507.11417-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
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
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 0125e2f7e076..90ec33caacbc 100644
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
@@ -376,6 +353,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
+	u32 auxstatus;
 	int ret;
 
 	if (size == 0)
@@ -413,10 +391,16 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9A21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByvcdlD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCVD3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43814 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVD33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so485156pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9KJU5GGLHd0BB33nLbrEqhw9z1YlxFx7twPur0/P5o=;
        b=ByvcdlD8zmiJ/1V7dJ36mjbjXQb7bpoJAmvuQPm36AJR72ZD65gXwrFKv3xbOfqU12
         vsx9rZ9BwcYwOEB7YLXJUs0Mu0PWLvuL+xeTtpSxEJma48PjQAvWyaXTlSio7q1Qh1Bl
         UtOJgh631ZK+J0Kun94jbZX2sX2GI/28F2MJ5NmuFNi2Y0gzzS0PYGUQxWCBxkVTSep6
         TUYmI3h2MtUIqd9ahsIYtXb7Rw2mkiuFlxAFfPhljcpaeQcQVRDsEz3C2+rMXer5IAJj
         Pw+Wz1CFXMr1LY8kKrd3seIF4Jao2anT1qUXkfSzhDyFy66TPuQ1bKCiZL5ttZmGMLuR
         /tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9KJU5GGLHd0BB33nLbrEqhw9z1YlxFx7twPur0/P5o=;
        b=rI0po6GZ/ZufyYWMURJnbU6oR1J8W7bj5W2gV7kl6JZyecnp1trhOfJWhacOr/MTTW
         3AZPRh79rAwIKx5NmX2fUkw3Qv9Y9qOLilgbIfic5scW3rkY3z/jeqT3zuuZ+KrFfKhX
         AAjnvZ0krY5t1/hpeCaStNN1wHoRSfN4hGpr6ECzeMcDGfda1i30lct6XSm0xbguNRvw
         5t3GKk/vLB7HeRUWnOe8sEtalppd+UFGY8xnPOWMZYEyaiwAiikevWkdRZ4uCEKaZkr8
         uzD7rQ9RzhnA0LtBQyIar1k+3KzZltSRWy6VMr4wpV6ToOva0o9VRHVL+TJ1CkO27FW8
         cUxw==
X-Gm-Message-State: APjAAAU+5YSN22HYjSCCKyBX151I4HsTLhLE/Cl2DKvDRwTKqb97v8u8
        RSXXAMIs5ecD999GkzlbJmE=
X-Google-Smtp-Source: APXvYqzTmIrFqQ4GtBBFMrgQ/hYXApdmhbK6u3RR41S5P6FQPM3eM51k8mgqm2l4Q915j+Y6Dxd0Ew==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr7067357pll.44.1553225368095;
        Thu, 21 Mar 2019 20:29:28 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:27 -0700 (PDT)
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
Subject: [PATCH v2 10/15] drm/bridge: tc358767: Add support for address-only I2C transfers
Date:   Thu, 21 Mar 2019 20:28:56 -0700
Message-Id: <20190322032901.12045-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7e4607c6907f..768f01cc2a30 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -137,6 +137,8 @@
 
 /* AUX channel */
 #define DP0_AUXCFG0		0x0660
+#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
+#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
 #define DP0_AUXCFG1		0x0664
 #define AUX_RX_FILTER_EN		BIT(16)
 
@@ -331,6 +333,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
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
@@ -340,9 +354,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	if (size == 0)
-		return 0;
-
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
 		return ret;
@@ -366,8 +377,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 	/* Start transfer */
-	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
-			   ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
 	if (ret)
 		return ret;
 
@@ -381,8 +391,14 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
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
2.20.1


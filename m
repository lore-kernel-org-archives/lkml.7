Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebH+e+yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfFLIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:34:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36232 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437239AbfFLIdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so3335564pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVdZCLFy6QEDGvyvStVGqispy/JrU6lkx44tS0r6TYo=;
        b=ebH+e+yRL03RD84DE66s1KelaR+9leWYSMIwRIAWYA5aXrQAAkVvL2oCcizYNskH02
         MIL5/ZHmccqPa/hYl2SfmClEogn4UxqAKKoOdJ/Y+dUjX+xGRD7r9jViQDAMPkCadeUi
         xsx07/ikMU88hRqRIuygDMj3xWF/S7eBmhkptKjJvSnhEoInIc9Reh1QpdM25KXHVfja
         XGaBSoWYfRtxQopXIjLMdqz3es4WwYhkrsBtfCPtyZCLpBoS3/qVaz+JvybH9syeFOzV
         HfZ0vKVBOP/dvWqH8Jd7nm/arv+NBZ8SJLEG53JUu6MiBqXBEjO4Qm/bmR6o/HH0zVvw
         lcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVdZCLFy6QEDGvyvStVGqispy/JrU6lkx44tS0r6TYo=;
        b=E7tMyo+Q3c02GOdm5lr9MGGHjM4Y3PxtEHvhGEszIyuqZATLNL+k5viuMIvIn2Q8bp
         378WsVwMkg0N05oY6TgtB2HBSTJgFwg3moEWTzr/7EFzQHWhqUw8JD/YxJkyAc1FH30L
         b+hOty2BZtT1uPU5s9VRxxT8dUdo0ZH8SXJUdqDr2Rf0eDjwGv9cDmMgw3xPZV3KIElV
         rMaXVAUHJHKzIzBX+jryQLTqVTmQlUXIj6KlredadJOLB9U+BSRAtaBQOiMNAukBPI0g
         KL85I5Iri5qJ+/VmX7xuirJu49Lye0fttn4kFLl4Ybzb3oVPh6UbinPPJmF0fZwPH5Js
         ZVRQ==
X-Gm-Message-State: APjAAAVCUbtnRN39iXGt4h8qgKB59B140XoliFTICbn1nTWCie/8dqSb
        f3PINN30ERi+mTUq0T7EZcA=
X-Google-Smtp-Source: APXvYqxwac8t/w9FHxZ8pFvq8zaU82WOfOOMYMbMWsMabAk3eaNlCmW35IaZ5yFdd/dAGwB+P8Kg6g==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr26901449pfc.62.1560328394213;
        Wed, 12 Jun 2019 01:33:14 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:13 -0700 (PDT)
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
Subject: [PATCH v5 06/15] drm/bridge: tc358767: Simplify AUX data read
Date:   Wed, 12 Jun 2019 01:32:43 -0700
Message-Id: <20190612083252.15321-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify AUX data read by removing index arithmetic and shifting with
a helper function that does two things:

    1. Fetch data from up to 4 32-bit registers from the chip
    2. Copy read data into user provided array.

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
 drivers/gpu/drm/bridge/tc358767.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7b15caec2ce5..7152b44db8a3 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -321,6 +321,20 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
+{
+	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
+	int ret, count = ALIGN(size, sizeof(u32));
+
+	ret = regmap_raw_read(tc->regmap, DP0_AUXRDATA(0), auxrdata, count);
+	if (ret)
+		return ret;
+
+	memcpy(data, auxrdata, size);
+
+	return size;
+}
+
 static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
@@ -379,19 +393,10 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
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


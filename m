Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB365C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A072E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksac89Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfFGEqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43424 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFGEqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so319973plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVdZCLFy6QEDGvyvStVGqispy/JrU6lkx44tS0r6TYo=;
        b=Ksac89OhxrBR2L37EQXPCoWnkvmzPUwqLErujAiTPxVRT8MtlvKwFEzG1sOKCTpb0C
         3FTX55PAe5Du3XxWT9SSpr/f061wbzFwEwRsz/YshIobK4tdI2X7SVZwTXU6tFXchgSf
         VlleRE/kS9ChdaHbr6uBVxXwihVieZVoDALaqL5CDSjrjeD6d0grWplEck3eTp8b1Emg
         yi2OU1EaNUMw7j+DmEdReM+qvjqboZ8g++y2VrHC8Kwsw5eyzML/CF9NkgQMmwh/R8cW
         r58YRYuxseR4tJLRcdYlMaPSElihI3z1j4LjaWSFmRmcoWNgfxHg2sL5BiwTYPd/h4o2
         w2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVdZCLFy6QEDGvyvStVGqispy/JrU6lkx44tS0r6TYo=;
        b=C5FEPJi0udN4YdqpZ30OVTu4U8q8/4qGgaCtN6lgtbGHG4zbd4VTTUmilLkVXuXfRo
         5blqLfIpRLtRntjWtYYJjT8Z9FXFf4GmyhBXpA6TB6RLYw7hjvwzyXqL/O8li6xSbx0E
         9kGVnW9uqNa3nIs6t4UCfMHPYnRJ9LqRmhk0ZTBkijFCDBMwLml9kkRQazXrPhWcwwUu
         9B03w32XvkdagUOhH1ja5CAFHurWeqHQx4ueUHERGoSyzx64BEAt0bDO1rzYIzj/3TuI
         R756c/2uw3mcinfq8NiYUoYZqX+pRVHDlMbaiX0PtyaokV9PET2IXH3IahbAB+GsM6b7
         5wnA==
X-Gm-Message-State: APjAAAVsLKBbhvY/Yjpt47I604EC0ahDZhxYHYzcAGKK3IiPqu0RtLF1
        oDMcoa4S9EENefJk8O7olrY=
X-Google-Smtp-Source: APXvYqxy3TPySpG9DViq9xZAMZQx+gYKScsVQArqUSH0RU32FjJINPVr5QL+rXn94MY0SojzSddZoA==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr54556218pla.172.1559882795599;
        Thu, 06 Jun 2019 21:46:35 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:34 -0700 (PDT)
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
Subject: [PATCH v4 06/15] drm/bridge: tc358767: Simplify AUX data read
Date:   Thu,  6 Jun 2019 21:45:41 -0700
Message-Id: <20190607044550.13361-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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


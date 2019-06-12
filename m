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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC73C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A252063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhMh7/ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408633AbfFLIdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33394 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437245AbfFLIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so8031663pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ys5ot99QQmo5wes1He3CHIb6XYcn5zHRbOZecMkTIfw=;
        b=OhMh7/ZFCz6ieIk3FzR15PjAHfvEDfddbqX+tiJrBrUiJupwU/CbnA80l9TqMXR9EB
         +fLKBKDT4oGTvu6lzl5h8McRHxY964mrksc+B/VfVNWtJTBhOmT9Cl1YIRBJz/lVss6v
         dpPHDBPqbWaK/jHZczCDqV2TmV77Xkt1e3s7QtZDnc79LE0Z00ysMXtEzv+S8QFgEmeD
         oposAjbVCo9CZ8yBbxUboFeU0VMwNZk61R+bzVAAqm3riKtvGcLDCE85W8+QJPcYLtEj
         x90XblVA7IKIGt98HOwIJXUEPDvba7DS02FujTj1CQMSr0wTfRhJIWC6amXPExYJyulK
         OTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys5ot99QQmo5wes1He3CHIb6XYcn5zHRbOZecMkTIfw=;
        b=la5Gv0w5AhgIO2JQ9yoW5uzpb/u8UesOXR0xIZUJ1WlvYMgP5LYE7Ko4IK3AfLhJ2U
         csiuiUywpJTQ312x1gg5GWUs7IFvU48YhSdpzjIDMc/j31CDS8txbxqXIMKqqSSuyhzf
         +Ol4EH3VGak48wC7ueSjcs+BFeVxc8DCpuwu4esoF1ZMQWlEF0ctcHtux91fGn51zSbP
         +87oblLyz3ZX8VKPeB5GMrsfG/nE56Ox4HGjPu0D1v2LMkUJBaU6TdTepKbgbZeff3GA
         CogUg6OlgKeZy/dvimlOJtV5Vs0SOB4fXSCW8803+7stgHCweMa95WNj7tyOjREfcmCh
         rXyg==
X-Gm-Message-State: APjAAAWt84G/BvaSPupazcya6iafE0q8HWfGXX9RqBSGFEhuTexUokSy
        gO+oVZa4jhjZs/lI4zLCGrU=
X-Google-Smtp-Source: APXvYqyO+VvAumRpJK7LxG/uIT/wghlJGiBJ1ODRfwDdmeYbKxoym+jXHryyyn8pKhZVCn3XMQ8Frg==
X-Received: by 2002:a63:1a5e:: with SMTP id a30mr23541763pgm.433.1560328395862;
        Wed, 12 Jun 2019 01:33:15 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:15 -0700 (PDT)
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
Subject: [PATCH v5 07/15] drm/bridge: tc358767: Simplify AUX data write
Date:   Wed, 12 Jun 2019 01:32:44 -0700
Message-Id: <20190612083252.15321-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify AUX data write by dropping index arithmetic and shifting and
replacing it with a call to a helper function that does two things:

    1. Copies user-provided data into a write buffer
    2. Transfers contents of the write buffer to up to 4 32-bit
       registers on the chip

Note that separate data endianness fix:

    tmp = (tmp << 8) | buf[i];

that was reserved for DP_AUX_I2C_WRITE looks really strange, since it
will place data differently depending on the passed user-data
size. E.g. for a write of 1 byte, data transferred to the chip would
look like:

[byte0] [dummy1] [dummy2] [dummy3]

whereas for a write of 4 bytes we'd get:

[byte3] [byte2] [byte1] [byte0]

Since there's no indication in the datasheet that I2C write buffer
should be treated differently than AUX write buffer and no comment in
the original code explaining why it was done this way, that special
I2C write buffer transformation was dropped in this patch.

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
 drivers/gpu/drm/bridge/tc358767.c | 48 +++++++++++++++++--------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7152b44db8a3..e60692b8cd69 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -321,6 +321,21 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_write_data(struct tc_data *tc, const void *data,
+			     size_t size)
+{
+	u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
+	int ret, count = ALIGN(size, sizeof(u32));
+
+	memcpy(auxwdata, data, size);
+
+	ret = regmap_raw_write(tc->regmap, DP0_AUXWDATA(0), auxwdata, count);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
 static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
 {
 	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
@@ -341,9 +356,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, 8, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
-	u8 *buf = msg->buffer;
-	u32 tmp = 0;
-	int i = 0;
 	int ret;
 
 	if (size == 0)
@@ -353,25 +365,17 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	if (request == DP_AUX_I2C_WRITE || request == DP_AUX_NATIVE_WRITE) {
-		/* Store data */
-		while (i < size) {
-			if (request == DP_AUX_NATIVE_WRITE)
-				tmp = tmp | (buf[i] << (8 * (i & 0x3)));
-			else
-				tmp = (tmp << 8) | buf[i];
-			i++;
-			if (((i % 4) == 0) || (i == size)) {
-				ret = regmap_write(tc->regmap,
-						   DP0_AUXWDATA((i - 1) >> 2),
-						   tmp);
-				if (ret)
-					return ret;
-				tmp = 0;
-			}
-		}
-	} else if (request != DP_AUX_I2C_READ &&
-		   request != DP_AUX_NATIVE_READ) {
+	switch (request) {
+	case DP_AUX_NATIVE_READ:
+	case DP_AUX_I2C_READ:
+		break;
+	case DP_AUX_NATIVE_WRITE:
+	case DP_AUX_I2C_WRITE:
+		ret = tc_aux_write_data(tc, msg->buffer, size);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
 		return -EINVAL;
 	}
 
-- 
2.21.0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F278C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30820870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMqlvux0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfFEHFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38219 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFEHFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so13590134pfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TiqV4mMjweNF+QK2RThSopUBwGbQaMYJC9n9xdVUsw=;
        b=FMqlvux0IyVO4Q2gN5is5VAXLp56S9MMHjROii34P7CJIrq248pneh1idjkzxPzSdO
         y4Eqy/wzHbvhzs8GDgsr4kdWcHYK9YM0/ZO1hUta8o4v4zbl2VGJZvTeVBSmA9ByXw3R
         gZJZLBz4kejggi8nxi5tqJ8Er+wa83oE7/B/VhGvwhNlqf8VQs1iqO2Z/a286RU19H5n
         rbfSJYsT4h8qnQQipR0Y6aL2fgQqMAOZA6HhJ1bXSnxrEYRyzxxe4kwkfqgDCW+aEUlJ
         bCZu+2euB9BrbXow+VX3KQ7WfKVOfcd4t29n98BXEoy3Mw7QKKIpv5qw8M7gdhyBl8AH
         NSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TiqV4mMjweNF+QK2RThSopUBwGbQaMYJC9n9xdVUsw=;
        b=m428mh8taXePxl/ogpXnzfjHR0DSsVSh0qODfN0ijQQlWyGU77ZfsvTeH3hHmP+gr7
         WPXjBULuEcDNOoHv4GHp9OIilHbvbXkBfeov6S25V2eeQcODXckkXP6EUficyp8A9XOx
         TqpaEqTOH8meoKifNgFI2hBS8lhwwfIpKNIWOJHO1XH/bnQStUSMKO/5hb6hdmVi/by4
         6EtDl/99b5veFCITwqgLWY3If82WkNi2w/LPoo10loQaDfbfXywqSl5Km9WUqMGCw3Ak
         +vQvaV7Ig5n01KABeAPJczm8DLprAgBXHZ5HobNWn82aCjXs5kkbEHRSHUWK8D6kV915
         1a4g==
X-Gm-Message-State: APjAAAX9MEZExCzC4Cqvt1scav7CTsbRBNySptHdq55arQFebS9cBGGl
        nzoQYVPHyF/BUaRGZ2ING4s=
X-Google-Smtp-Source: APXvYqytj1VIxoAkPQupNhvqAWieA38OdYwJJWqXlQjXPalSXcHewpIiMeC3IL6FgZWct/RVpdiJLQ==
X-Received: by 2002:a63:6603:: with SMTP id a3mr2510186pgc.239.1559718332791;
        Wed, 05 Jun 2019 00:05:32 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:32 -0700 (PDT)
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
Subject: [PATCH v3 07/15] drm/bridge: tc358767: Simplify AUX data write
Date:   Wed,  5 Jun 2019 00:04:59 -0700
Message-Id: <20190605070507.11417-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify AUX data write by dropping index arithmetic and shifting and
replacing it with a call to a helper function that does three things:

    1. Copies user-provided data into a write buffer
    2. Optionally fixes the endianness of the write buffer (not needed
       on LE hosts)
    3. Transfers contenst of the write buffer to up to 4 32-bit
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
 drivers/gpu/drm/bridge/tc358767.c | 59 +++++++++++++++++++------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index da47d81e7109..260fbcd0271e 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -321,6 +321,32 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_write_data(struct tc_data *tc, const void *data,
+			     size_t size)
+{
+	u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
+	int ret, i, count = DIV_ROUND_UP(size, sizeof(u32));
+
+	memcpy(auxwdata, data, size);
+
+	for (i = 0; i < count; i++) {
+		/*
+		 * Our regmap is configured as LE
+		 * for register data, so we need
+		 * undo any byte swapping that will
+		 * happened to preserve original
+		 * byte order.
+		 */
+		cpu_to_le32s(&auxwdata[i]);
+	}
+
+	ret = regmap_bulk_write(tc->regmap, DP0_AUXWDATA(0), auxwdata, count);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
 static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
 {
 	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
@@ -350,9 +376,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, 8, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
-	u8 *buf = msg->buffer;
-	u32 tmp = 0;
-	int i = 0;
 	int ret;
 
 	if (size == 0)
@@ -362,25 +385,17 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
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


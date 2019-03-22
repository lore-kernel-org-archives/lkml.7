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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600FB2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofq/VCA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfCVD32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36560 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfCVD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so508999pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN+UVi1xXiDD03PDbdwofs9lsLwAu0xcW30rFoQcclA=;
        b=ofq/VCA/8//9wm+Cmv96RWNS5f+TSNVAoC14wrGBvAI8QClu6xdbqkCn3GC3/hp2UJ
         GU83eWJ7bhlfofRMJZD49zHp/2gV1z5LzIEqcpMSNbVDDv8p5YOX8H4kuWK02IhqBCHi
         O8ihvdQ6sHzvr31AtwuMwz0oYLMM42Leo+o3QduVMmSEJobf2PnrbUPGOYG/seA6zbpT
         WhRtdnGg4/UBZbB4DZYNE8V84O8XStDGkXqcl2FyX48inq5633ENWQ0qc5O2QT2GMMG/
         KLyL62F/xFJ/YzkUcX5Rgpwbk7cf/y/m+9SF62ORV6THTwc7zX66W19/fsVNT8uAR1/4
         QOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN+UVi1xXiDD03PDbdwofs9lsLwAu0xcW30rFoQcclA=;
        b=aphiZOr74Asai7/rZorOqUsa1LRAu0PaSb31m5W0Lt/V1TWA1LCJVYwt3uTv12+fSM
         uG1slW5kx7T8Pvl98WKUCXmd5qsr+bGuBorWNULh9NRo2fhuevoeX/V9p3VVrozheRue
         6dEXvcNAg82JEPiFE6c4C3XhKQ69PdbaJJvumC1y5OYi6qiueHuitv8h+qQOvi9e2tTB
         YxkecU2MGC1GuALqZOckuGxQnitAsZ5shMASMBFl5UR91YjLI7mgDNr8c4sj1CfAw+IZ
         CIyOynCa/M3bzA/xTCU6z2V6JiTV+7/esPhjNk5sjV0LTpPOpEFWbXjomixGaj2VS3qc
         A7Qg==
X-Gm-Message-State: APjAAAVBlApYYa+HJ8RF6bSknRZ2qn74zsEvJzFm3454dMFvIczxxSq7
        iZrVCKRd7Porf2ClrcbRLZJcEcreSZI=
X-Google-Smtp-Source: APXvYqxnrYXyyWEqNTClbtfNy0d3DMxfLKSI5hG4NIYXHB9SfIpxmnDLM4Gc+03UbZ2OO4FY+0z+DQ==
X-Received: by 2002:a17:902:586:: with SMTP id f6mr7048149plf.68.1553225363743;
        Thu, 21 Mar 2019 20:29:23 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:23 -0700 (PDT)
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
Subject: [PATCH v2 07/15] drm/bridge: tc358767: Simplify AUX data write
Date:   Thu, 21 Mar 2019 20:28:53 -0700
Message-Id: <20190322032901.12045-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 58 +++++++++++++++++++------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 81c10a5d8106..21374565585d 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -307,6 +307,31 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_write_data(struct tc_data *tc, const void *data,
+			     size_t size)
+{
+	u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
+	int ret, i, count = DIV_ROUND_UP(size, 4);
+
+	memcpy(auxwdata, data, size);
+
+	for (i = 0; i < count; i++) {
+		ret = regmap_write(tc->regmap, DP0_AUXWDATA(i),
+				   /*
+				    * Our regmap is configured as LE
+				    * for register data, so we need
+				    * undo any byte swapping that will
+				    * happened to preserve original
+				    * byte order.
+				    */
+				   cpu_to_le32(auxwdata[i]));
+		if (ret)
+			return ret;
+	}
+
+	return size;
+}
+
 static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
 {
 	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
@@ -335,9 +360,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	struct tc_data *tc = aux_to_tc(aux);
 	size_t size = min_t(size_t, 8, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
-	u8 *buf = msg->buffer;
-	u32 tmp = 0;
-	int i = 0;
 	int ret;
 
 	if (size == 0)
@@ -347,25 +369,17 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
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
2.20.1


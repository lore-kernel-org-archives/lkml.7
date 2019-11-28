Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD8C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E6421771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KWe7360w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfK1O7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:59:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46787 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfK1O5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so28811081ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWyaIwq9mdmvZ/JuYUnZiMulaql+3s1ZVx5WN7km3uw=;
        b=KWe7360wBhzV77hKN+t349b+mPvaiilCDUxIUxULEYnN/2BFgQPleVjKrpxA4uHfHL
         BIRRBKcwfnATFr4REC7warrEOdFOAngsSQ5yxOQM9UaBYWHHFb8ZpUZqId/xsdBpRG25
         5xPHs3YpJ4keFEuArLXA40it4ZOh1rVS3sVPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWyaIwq9mdmvZ/JuYUnZiMulaql+3s1ZVx5WN7km3uw=;
        b=Yu5OITZ7FViJa8hJVWFTiVdYKPzAG2Yv4CWYVWn315LghTBYvfBijPt5JpiHTAqxfP
         Qutk+X4UjKgseaOklPzE4FvK1Rr3yEMiHm2AAnkA30Z21jbttBLm6rNhfpPDQnqxFvhF
         vte4BAB0WYsDX7vv0VfMmznVr64vz1mPuX50ZV3vMXTaC2rGJFgxshJfLGWYSq718PbR
         DGGywMkEYj3d/aKeL2tyGNhM7go+RKPQhVG8+6zPyqH8PdWEBHJEo0Yt9zYwwb3jLL/4
         y04iWwlpaIenS5fPVch2wPEGBdzrf++21TTcnUJyzVNvTSTxQaDjvCeN7HZkBZ6ymueM
         TU8w==
X-Gm-Message-State: APjAAAW13gsOqjoHyjPM9IRJ4CnAn6/v9gBmS/VDcawD9nSUSNhqGDVU
        y64Kzqko8nyA50mq2pwhqb6zvQ==
X-Google-Smtp-Source: APXvYqyVDq6NQJ2Y1gdqv1S8h+9+Uo9oKx4Z5PDYEkDUD5ZetIxhlvatqxTyxBBUOdBPmmbBkDpi6Q==
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr33941792ljn.188.1574953053452;
        Thu, 28 Nov 2019 06:57:33 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:33 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 22/49] soc: fsl: qe: qe.c: use of_property_read_* helpers
Date:   Thu, 28 Nov 2019 15:55:27 +0100
Message-Id: <20191128145554.1297-23-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually doing of_get_property/of_find_property and reading
the value by assigning to a u32* or u64* and dereferencing, use the
of_property_read_* functions.

This make the code more readable, and more importantly, is required
for this to work correctly on little-endian platforms.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index a4763282ea68..ec511840db3c 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -159,8 +159,7 @@ static unsigned int brg_clk = 0;
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
-	int size;
-	const u32 *prop;
+	u32 brg;
 	unsigned int mod;
 
 	if (brg_clk)
@@ -170,9 +169,8 @@ unsigned int qe_get_brg_clk(void)
 	if (!qe)
 		return brg_clk;
 
-	prop = of_get_property(qe, "brg-frequency", &size);
-	if (prop && size == sizeof(*prop))
-		brg_clk = *prop;
+	if (!of_property_read_u32(qe, "brg-frequency", &brg))
+		brg_clk = brg;
 
 	of_node_put(qe);
 
@@ -571,11 +569,9 @@ EXPORT_SYMBOL(qe_upload_firmware);
 struct qe_firmware_info *qe_get_firmware_info(void)
 {
 	static int initialized;
-	struct property *prop;
 	struct device_node *qe;
 	struct device_node *fw = NULL;
 	const char *sprop;
-	unsigned int i;
 
 	/*
 	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
@@ -609,20 +605,11 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 		strlcpy(qe_firmware_info.id, sprop,
 			sizeof(qe_firmware_info.id));
 
-	prop = of_find_property(fw, "extended-modes", NULL);
-	if (prop && (prop->length == sizeof(u64))) {
-		const u64 *iprop = prop->value;
-
-		qe_firmware_info.extended_modes = *iprop;
-	}
+	of_property_read_u64(fw, "extended-modes",
+			     &qe_firmware_info.extended_modes);
 
-	prop = of_find_property(fw, "virtual-traps", NULL);
-	if (prop && (prop->length == 32)) {
-		const u32 *iprop = prop->value;
-
-		for (i = 0; i < ARRAY_SIZE(qe_firmware_info.vtraps); i++)
-			qe_firmware_info.vtraps[i] = iprop[i];
-	}
+	of_property_read_u32_array(fw, "virtual-traps", qe_firmware_info.vtraps,
+				   ARRAY_SIZE(qe_firmware_info.vtraps));
 
 	of_node_put(fw);
 
@@ -633,17 +620,13 @@ EXPORT_SYMBOL(qe_get_firmware_info);
 unsigned int qe_get_num_of_risc(void)
 {
 	struct device_node *qe;
-	int size;
 	unsigned int num_of_risc = 0;
-	const u32 *prop;
 
 	qe = qe_get_device_node();
 	if (!qe)
 		return num_of_risc;
 
-	prop = of_get_property(qe, "fsl,qe-num-riscs", &size);
-	if (prop && size == sizeof(*prop))
-		num_of_risc = *prop;
+	of_property_read_u32(qe, "fsl,qe-num-riscs", &num_of_risc);
 
 	of_node_put(qe);
 
-- 
2.23.0


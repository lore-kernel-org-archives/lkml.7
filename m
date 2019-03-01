Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D472C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB620854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAyVW/PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfCACwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:52:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39656 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCACwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:52:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so26156511qtk.6;
        Thu, 28 Feb 2019 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jo0ywifYp8m+83R2PezpNq71Nb/0EjDLIKmTfnUEXcY=;
        b=LAyVW/PFvyaBl1TyKXizNKc03N0O/iBKxis81sd+LM4mhvoyzw2m1omSZBjSdjLcY4
         2CbIDwgxji98Ssoeu0hO5xEPwmlFQzgBFF/QCCTt+UprsttLaNou5ipsB8misrR/4Fkj
         0H77TEDAkhIZAE12330cHA0kccC+eXCdZyp8cevm4Lsv3Ing2uEiBbYMvsksUNMMBSOg
         CIlS0ZnRH2NGuHwKsO9ihBgga3lqTNREHycVeNPWjQKHJ706eMl1KfwnqmwY7K6ldKIJ
         8kasnEmDIzUEyJWqgB65kKMPvDtFg4tYLvglqhhL7irUjO/GQxV5j2BLGIyLnjrJKUNA
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jo0ywifYp8m+83R2PezpNq71Nb/0EjDLIKmTfnUEXcY=;
        b=bnyEXCulDM2MiV/J2uhLIW86N8BdU0WgBNqbmNobPgSw1riGjSCQrrcRLCG405Ssyc
         D2ohU7mp09Z+o4qh9LaS/2LNs0TVU3avNhjcg2/dPoxuLFXQqUcNM1bBFHJVtzFgoFQf
         iaD9IBoMBLjlqB0T4LlonW74HyzoVwg/lA7FPYRNNG1WXN6s8hp/RMJmKwosnnKOyKc3
         DUe7wIeAnM9w/aqK1Eobt1+L2lvQdJ7l1Ex8jil8W/3dvgPyqkLCqsMWTAEnudQqpHtR
         9v+bd2/I5snOG4CKM7ePT2V6zf+tpgROZu2l9u6qwdM8P/jYRPv2/4YZmJ5CV5Q1SJUI
         EWLw==
X-Gm-Message-State: APjAAAUJ8y3fhq5dSP/yb+hOaTKZR7+xwKOknr9CTUdrPiz5Bz2XTqMw
        yZLkxnRPHnNtBng6HMyfA2Y=
X-Google-Smtp-Source: APXvYqx5pcfHcfdudonhDUGcnfjdaCwOCFJzRGtUpS/d9jOaRRqle/Rm+sm3TPPN2sLZlGsOeY+UNQ==
X-Received: by 2002:a0c:b597:: with SMTP id g23mr2017659qve.142.1551408753833;
        Thu, 28 Feb 2019 18:52:33 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m128sm11787198qkf.53.2019.02.28.18.52.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 18:52:33 -0800 (PST)
Date:   Thu, 28 Feb 2019 23:52:30 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v2 1/4] staging: iio: ad5933: add SPDX identifier
Message-ID: <20190301025230.2cws5uths6yyuo5t@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier of GPL-2.0 for the ad5933 driver.
Organize imports.
Make multi-line comments compliant with the preferred code style.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3134295f014f..d75bdfbf93de 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -1,27 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5933 AD5934 Impedance Converter, Network Analyzer
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/sysfs.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/clk.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
 
 /* AD5933/AD5934 Registers */
 #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
@@ -474,7 +473,8 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
 			ad5933_store,
 			AD5933_OUT_SETTLING_CYCLES);
 
-/* note:
+/*
+ * note:
  * ideally we would handle the scale attributes via the iio_info
  * (read|write)_raw methods, however this part is a untypical since we
  * don't create dedicated sysfs channel attributes for out0 and in0.
@@ -572,7 +572,8 @@ static int ad5933_ring_postenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
 
-	/* AD5933_CTRL_INIT_START_FREQ:
+	/*
+	 * AD5933_CTRL_INIT_START_FREQ:
 	 * High Q complex circuits require a long time to reach steady state.
 	 * To facilitate the measurement of such impedances, this mode allows
 	 * the user full control of the settling time requirement before
@@ -663,7 +664,8 @@ static void ad5933_work(struct work_struct *work)
 	}
 
 	if (status & AD5933_STAT_SWEEP_DONE) {
-		/* last sample received - power down do
+		/*
+		 * last sample received - power down do
 		 * nothing until the ring enable is toggled
 		 */
 		ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
-- 
2.20.1


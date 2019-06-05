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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A8C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554702086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5dqH+Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFEHFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37302 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfFEHFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so14309226pff.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEdoucIRvOwXz8lKtgT8K+SiuGv6C9zcqCSBrAPMFTE=;
        b=I5dqH+TzNTJpgyNOOv9015vJ6/TMkO+Gmn883gqBvMlxT+ruw8egkE0RFMPqfHjE5J
         Zlg/pZzS3ilmWxi961+ILbRS/x47rDCdqyx9DwVjIAibiFmMug99/LDJP/cIOvVye6m+
         HqcEfb/OwX/GNSWtkk8qnjnjQdKPi4qXFsGZwothUAkYWWk7M8P7FPrF1ijbcaN+tY4L
         KLk8R+QW8OXw+egbz7OhQcF/o9P1d2+x478Dn9K1iwnCOeFS84p0uP/XdwTFIDuERx96
         GCAgff0Dj+Ruh/xDVSjSUdZE9g7E1jArSLwNUgK2Ahcky0taniezp/8IzqSYNwczZ/5R
         7fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEdoucIRvOwXz8lKtgT8K+SiuGv6C9zcqCSBrAPMFTE=;
        b=ItrQYUyz/PiQKEXYm8kAn6Lp0+uZ4r9NLgMd6WF9Lg7t4EAfaH3Q+Ck4Serm1OfOUN
         W4vlZyc7AcRN9iZlgXowfBJYRT31hHMBI9BKtOPZaMAudjejsIi8aeooO26qXMULkU1k
         QR9GCWROnE8sYWXylxo4ne8vpEGcJ9L4BJlqk8CsER2gUoPVRVkWDo1P4jjEm1tOSSsX
         Fafei1vyubkeunECi9GIIsTiOp1sHFZSdXAmg03ht7E2dfOcsVCEoV5qeS7GOBdMehKD
         t9oJ0PeRXySR/Ldw0gkTpuOS5ThMnMq48J1O33Bi7JNhG9/4R2MCpinyifWyh4Tg/Uhp
         Uw0w==
X-Gm-Message-State: APjAAAUvsb56CXa39P3PPXTB0fy/wsIbGVNWEycg3krXi3TOgvplJfTW
        PPjnBokOuJ74Zfoic/oDdz6r3nl9+3A=
X-Google-Smtp-Source: APXvYqysHjyKNTH4wmvmS0sBKjq4T6J9yXXLxk7wdUG6OpwbwwY5yG4T5uzxamvnGnxUtBrDlp/Fjg==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr28732792pjw.60.1559718339752;
        Wed, 05 Jun 2019 00:05:39 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Wed,  5 Jun 2019 00:05:03 -0700
Message-Id: <20190605070507.11417-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common code converting clock rate to an appropriate constant and
configuring SYS_PLLPARAM register into a separate routine and convert
the rest of the code to use it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 46 +++++++++++--------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7b84fbb72973..c58714daa0a1 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -601,35 +601,40 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
-static int tc_aux_link_setup(struct tc_data *tc)
+static int tc_set_syspllparam(struct tc_data *tc)
 {
 	unsigned long rate;
-	u32 dp0_auxcfg1;
-	u32 value;
-	int ret;
+	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
 	case 38400000:
-		value = REF_FREQ_38M4;
+		pllparam |= REF_FREQ_38M4;
 		break;
 	case 26000000:
-		value = REF_FREQ_26M;
+		pllparam |= REF_FREQ_26M;
 		break;
 	case 19200000:
-		value = REF_FREQ_19M2;
+		pllparam |= REF_FREQ_19M2;
 		break;
 	case 13000000:
-		value = REF_FREQ_13M;
+		pllparam |= REF_FREQ_13M;
 		break;
 	default:
 		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
 		return -EINVAL;
 	}
 
+	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
+}
+
+static int tc_aux_link_setup(struct tc_data *tc)
+{
+	int ret;
+	u32 dp0_auxcfg1;
+
 	/* Setup DP-PHY / PLL */
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		goto err;
 
@@ -887,7 +892,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
-	unsigned int rate;
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
@@ -915,25 +919,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	if (ret)
 		return ret;
 
-	rate = clk_get_rate(tc->refclk);
-	switch (rate) {
-	case 38400000:
-		value = REF_FREQ_38M4;
-		break;
-	case 26000000:
-		value = REF_FREQ_26M;
-		break;
-	case 19200000:
-		value = REF_FREQ_19M2;
-		break;
-	case 13000000:
-		value = REF_FREQ_13M;
-		break;
-	default:
-		return -EINVAL;
-	}
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		return ret;
 
-- 
2.21.0


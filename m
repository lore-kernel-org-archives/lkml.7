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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E20C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CAA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLfQOiMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408645AbfFLIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43358 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408624AbfFLIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so6319172plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtcIT0Jg32O6R6ayXabHjP4bybCS1tEkrHIRDEcAfKg=;
        b=gLfQOiMJREwfLUGXRDG7KOpR/5wG1izZ1Nif5YzwPV5Hj7i4bwIH2Mh2vYpcyc5nB6
         UvGNDCNyfSxrvL79GEHgWUCd6+NkBhjyPsGE0PntsfIRSQwaGylm1UPm/uSTSRIN43D9
         BDFn9H3lCoHIniq3aDXMFn2+LD4wha1P1UzvjwxwDtCGNl8a4h9Gubgd1PT71pe9sX7i
         TtpX3QXehQ4H60y2rKeMGHF3A0t+PsEQLqux0C0uEtcN3hsS1W8WTXCkPxRGNiN4H1tP
         YZpZf+jRWTkOqpmqqjoDKUMn8+vQVDb3cB1b5HSJEcwGeEkMQ+a+sq+a0ubdo8SwNI1F
         GxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtcIT0Jg32O6R6ayXabHjP4bybCS1tEkrHIRDEcAfKg=;
        b=m17wtya5z+ic/IUerrlx6RvQd2NHYd1EAk/giphHTv9tozKAuFogczrBZBiSLVbTzZ
         4h8wMuN3VDUlZ0rwl/V+7fQnh0WozPrb3Q8DaUdyiO7S1hmJa/EJP1aQRTZ2iqIeuEVd
         2yDmXsXSXoqQeE3Dbt7l+zeNhRceflmtQ/AmHBcsOwTXJjCebI/lCmBm41gM4o4CbJDr
         ivWB1SzE2uR8FOev79KcPfTBjWp1IAqJ/3RC0LMfaIT6XKMzEk3+Kq8irwabxGXkYakP
         KU0mNKRoRHSyjiR1wcMJWmtz+60Q0CNUYAX+O2kE/8Nf5yfjRDTkOIBsWCqgqeyr5Q1a
         fw4w==
X-Gm-Message-State: APjAAAUEhCF9xaA4Rvp+pAdjYgKew9UwROIaCSBySmsdAnqaWBsht1uQ
        IVWst92mBC+kU0Jx2LmSAGE=
X-Google-Smtp-Source: APXvYqwbAe6w+pBXWpV/khAknaLn9mlo9tU7IuRdpdOReRnnZw5AJcw0sBxGVtGoOg7RDSyg5KHqbg==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr20639549pll.248.1560328401708;
        Wed, 12 Jun 2019 01:33:21 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:20 -0700 (PDT)
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
Subject: [PATCH v5 10/15] drm/bridge: tc358767: Add support for address-only I2C transfers
Date:   Wed, 12 Jun 2019 01:32:47 -0700
Message-Id: <20190612083252.15321-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7d0fbb12195b..4bb9b15e1324 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -145,6 +145,8 @@
 
 /* AUX channel */
 #define DP0_AUXCFG0		0x0660
+#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
+#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
 #define DP0_AUXCFG1		0x0664
 #define AUX_RX_FILTER_EN		BIT(16)
 
@@ -327,6 +329,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
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
@@ -336,9 +350,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	if (size == 0)
-		return 0;
-
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
 		return ret;
@@ -362,8 +373,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 	/* Start transfer */
-	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
-			   ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
 	if (ret)
 		return ret;
 
@@ -377,8 +387,14 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
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
2.21.0


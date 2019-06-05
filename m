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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B177BC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8091720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH00neYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFEHF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so8634160pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgORgJz2civFnf3JPNeTbcWwHZBa/hdHBoQiM2otHkM=;
        b=eH00neYSh7+Uuk3fa+0te52F39630X0h9Ql8M7fGODiNzU+dGyrfpLzY/c1ql48tEN
         xMkvrpa9uaq9N5gKz2eCSl2GfmxoZYnWz833Z9ZOxKg3962WaT/9KHL0V2SehgOv1PlH
         eoDaPIhIp79QpqJ7sERYNmopyo5lhYtixOdwGpE9LJHrsJ9TQMjPzUAOAm8++0YDC/Gf
         sQCIo2JRunRuqVmcx4w+DF3Nj/S5dkr9kUVRYRsga1+b7aB1WoN/VRcfZruB+CKWsPU9
         Hudm4D6yKAfwnhaVIU6q/m1DUmVrLkQo6GPfwbM+J7G8jtsBKdE7dG1gLhu73HcfSi2j
         9ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgORgJz2civFnf3JPNeTbcWwHZBa/hdHBoQiM2otHkM=;
        b=QiL6pmgcnmlK8B52KGR5A7EO/Wj3UJXenY7yFrmHkb0Ndftx0a9N+S/Bq4P7LzUt8Q
         2lOdnz+oa6HAhLAcpKhIqkQ0XvowPc3oTMnhWqB2QGuBHidMbMiaicLVHvQ3TN3ZSZu0
         aaU/uIb6Hiy+hXY0zAcw5xzjgQdQsWZ9hbNau07NHvGHO7dz9jLXNskrpehnOLt6jIBN
         WhGmA+t3cY0WJ11S1P8sPP/QnyHH9kLAMUVFUtjfFm85FGGRR5OvGv6lRLLI1r8C2yB1
         12qRRTW4rfZj6pQUtkkeovtJdEZTlRJjfDZ0V2mPqhPeoHaCVtdeVWmQZzzrWzQonTiv
         JMww==
X-Gm-Message-State: APjAAAWRK/LHCISt5/KoORXSh9sZJ7wJhmXekQ8Lrt/joJhk0qVBQJtw
        pqoFdXBjbkXw+FMJ9FuhstI=
X-Google-Smtp-Source: APXvYqwRDK7bClOTnZ2vYtsiCmEOhixT5TOMWzo+qM3mLXAhRRfos3unkQcydH4NA6ybZe3DmSMvgA==
X-Received: by 2002:a63:e358:: with SMTP id o24mr2409745pgj.78.1559718323398;
        Wed, 05 Jun 2019 00:05:23 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] drm/bridge: tc358767: Simplify tc_poll_timeout()
Date:   Wed,  5 Jun 2019 00:04:53 -0700
Message-Id: <20190605070507.11417-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
the code for regmap_read_poll_timeout(). Replace copied code with a
call to the original. While at it change tc_poll_timeout to accept
"struct tc_data *" instead of "struct regmap *" for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 58e3ca0e25af..fb8a1942ec54 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -264,34 +264,21 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
 			goto err;				\
 	} while (0)
 
-static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
+static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
 				  unsigned int cond_mask,
 				  unsigned int cond_value,
 				  unsigned long sleep_us, u64 timeout_us)
 {
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
 	unsigned int val;
-	int ret;
 
-	for (;;) {
-		ret = regmap_read(map, addr, &val);
-		if (ret)
-			break;
-		if ((val & cond_mask) == cond_value)
-			break;
-		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
-			ret = regmap_read(map, addr, &val);
-			break;
-		}
-		if (sleep_us)
-			usleep_range((sleep_us >> 2) + 1, sleep_us);
-	}
-	return ret ?: (((val & cond_mask) == cond_value) ? 0 : -ETIMEDOUT);
+	return regmap_read_poll_timeout(tc->regmap, addr, val,
+					(val & cond_mask) == cond_value,
+					sleep_us, timeout_us);
 }
 
 static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
 {
-	return tc_poll_timeout(tc->regmap, DP0_AUXSTATUS, AUX_BUSY, 0,
+	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0,
 			       1000, 1000 * timeout_ms);
 }
 
@@ -598,8 +585,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
 	tc_wait_pll_lock(tc);
 
-	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
-			      1000);
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret == -ETIMEDOUT) {
 		dev_err(tc->dev, "Timeout waiting for PHY to become ready");
 		return ret;
-- 
2.21.0


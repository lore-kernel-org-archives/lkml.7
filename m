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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CCC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11C120866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsiW0dB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFEHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:06:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFEHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so11854242pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBDB5XdTP7dfG6WE/Wv8QzDZU0TBBhHw3g3JoSOOGeQ=;
        b=IsiW0dB95u8meFnmq6fBHoTrfdGSMbu7kMUi4sRnXRsKgAqQ0cY5rJTNe5IEvAos+f
         xPeHHQoLo1sebUFCqzWRJ24IYagKiDZFIZfmOu17ZHgwsMMT4sH82A93yb/0vwTBeHPR
         U83nZrZ1X8xCacIMORgBKfMxy+NZh+1b4fIB2gPNFLQwY4hXhsUawBmB/L8MC3ZXU6E3
         px9cJZkZPMPYVVmaKu0Floi6r8QP4KOhK5VmjP8QDdFpxd8Cwz/3Z4aaxKC0FPosMwve
         2xAa5AQ/yvaLI18Z13lqFMuMHedoUFKLXr02tsTQ2HnlYCdks5kegmgKTTUBv/ku76Q5
         OURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBDB5XdTP7dfG6WE/Wv8QzDZU0TBBhHw3g3JoSOOGeQ=;
        b=a6pKjP2Il3d2NFGKon4IZT2shNiHpCuGmoMD2nCYTT2DbBRZW90uRgw1UW5SwBXml7
         PLWHa8VH4wkUIBXIDWbUMMb4iQcfWwgMgUwbyg9/RgfquEebAaNkoabJ0RUObfiEFx2E
         RxwhPiymDqsQaHCoB6iIq/PwdeHlPo5W5lxwJ9D0iPZtdQBHZL/sZYrXfUGb9lByaEan
         EY0jnlEy+nU6SE3M9kJWtXOF3QcaXx5xQG+mkbBWQ6I/SOefY1mUxDoHEWFJsozWCZQu
         Nu0ZlT58v5k0WYq6oTVAjbswYs6aHjifpzdfgcNJQuk1n5Ur4gei+ECl9R80b4xwlxhc
         xAGg==
X-Gm-Message-State: APjAAAUYnP/luVqg4patSCbXCbEuo8oVSqd7HyJmRPadyZDPC+el++J+
        kPGm3s0z0jJpvkQod2/EkoQ=
X-Google-Smtp-Source: APXvYqxH12xJ9obmTAXnsJLtnkeZDdF8uUugVPCYIHscRNujwwAb3eWErduiCWaic9942Ye7N5I12g==
X-Received: by 2002:a63:fa4a:: with SMTP id g10mr2393869pgk.147.1559718334365;
        Wed, 05 Jun 2019 00:05:34 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:33 -0700 (PDT)
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
Subject: [PATCH v3 08/15] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Wed,  5 Jun 2019 00:05:00 -0700
Message-Id: <20190605070507.11417-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet tc358767 can transfer up to 16 bytes via
its AUX channel, so the artificial limit of 8 apperas to be too
low. However only up to 15-bytes seem to be actually supported and
trying to use 16-byte transfers results in transfers failing
sporadically (with bogus status in case of I2C transfers), so limit it
to 15.

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
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 260fbcd0271e..0125e2f7e076 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -374,7 +374,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
 	struct tc_data *tc = aux_to_tc(aux);
-	size_t size = min_t(size_t, 8, msg->size);
+	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	int ret;
 
-- 
2.21.0


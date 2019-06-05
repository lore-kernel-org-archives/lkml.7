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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31380C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943120866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjYe4rFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFEHF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42643 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFEHFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so10615343pgd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vB9H/x4K9GTr/5xe5x0phbXLq3ehoCrZ4GkVzDpnKQ=;
        b=AjYe4rFedvHM4DhxC0na29BxekJqa4X9v32x4XZi2Q39H5ng8wiTdhUTtgpZMGJUwQ
         R+LjWw3FAPY62dWja57kC+lwLcypzOLy6GubqwgDHSW5hDGcpjylBcixDG8fqXMFZj0j
         QZcKtvqnYZ9zXk3px0Na91tpVv9fXcWAYGRFwEUOEHPm6ZDdl5JHe+6gFKnR4b71scmE
         fHMKeLuTyBiZxIgrzDTS5qdKzivqsZ4ax26lcSDWfzsP/YtTFafuUmpd57C4v9JtemUH
         Tack3nU6dFSTavg/alF8O3/9K4POc1b2vE8sj/b8CSWwNjVejwSQVnN4Pc85ZJrPp3Cb
         2oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vB9H/x4K9GTr/5xe5x0phbXLq3ehoCrZ4GkVzDpnKQ=;
        b=oX7syWLI3qie7cLFjgFpL8kCbg2B/yMrO4HmBHdIM7X8rN793Xp2tjNzM+98P1IIp7
         l3AtdySITa9nNIieogyXDVKUUvfEBBWiHHNe2F0eunFsiqnivc3+z9wNrsm1jsy7W2uY
         /IrheTA9Sw8t/TyUi9HB2I7gANqOnxGT+w2GRIf/KXEZOahxd0fjx80oEnvLDTi1RhWK
         yk2pqsrFOtjI26faacprfuAK1F8u65Fj/xagGoENUQM0HfLS//tm+Y2HkDWHlm1K63H8
         P2PTbnKHIn9or9zetC4TQ+UlsdniQGthL4KEXg8reLTu9vwykMJPGss/anOpzBInkGrs
         yy4w==
X-Gm-Message-State: APjAAAW07fXtQAnAqHPC/3IMTszPCtb00b+3uDAcUwukv6WJpl5TbL/P
        +DJHUZyQucEd4ErV9AFZjzo=
X-Google-Smtp-Source: APXvYqxRSH/hRKkBpLnP6nbJfTNZ7bEjPBPE2gktY46JAm1wZv7l8pycaOuo9PUBCY/OkTDAXT13gA==
X-Received: by 2002:a63:374d:: with SMTP id g13mr2444294pgn.413.1559718324783;
        Wed, 05 Jun 2019 00:05:24 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:24 -0700 (PDT)
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
Subject: [PATCH v3 02/15] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Wed,  5 Jun 2019 00:04:54 -0700
Message-Id: <20190605070507.11417-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling loop with equivalent call to
tc_poll_timeout() for brevity. No functional change intended.

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
 drivers/gpu/drm/bridge/tc358767.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fb8a1942ec54..5e1e73a91696 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -774,7 +774,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 	struct device *dev = tc->dev;
 	unsigned int rate;
 	u32 dp_phy_ctrl;
-	int timeout;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -831,15 +830,11 @@ static int tc_main_link_enable(struct tc_data *tc)
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
-	timeout = 1000;
-	do {
-		tc_read(DP_PHY_CTRL, &value);
-		udelay(1);
-	} while ((!(value & PHY_RDY)) && (--timeout));
-
-	if (timeout == 0) {
-		dev_err(dev, "timeout waiting for phy become ready");
-		return -ETIMEDOUT;
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(dev, "timeout waiting for phy become ready");
+		return ret;
 	}
 
 	/* Set misc: 8 bits per color */
-- 
2.21.0


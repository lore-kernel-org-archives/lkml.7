Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40663C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F262A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDQ50ait"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFGEqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35988 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFGEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so486468pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=rDQ50ait0AZSnhNs+94DRKzZufz/mXjTyd6b5gGmiEbxWpq/cW1J35S7np/gsPajII
         uyA5y5WQIZ7KAwEy4a8W1KlnNjodjoFYMlKh8Ti9RTCaNJH2cMZhBBIlpikE3Ruz3rmz
         td8fuGtMY5YgUuLkQyon29mrFvOfGnkxzG+mg9zxbG41Krv0zWaPxrbm5SmIZU/5stH1
         Tj7o71t+Xd9RwZAh/EbWuWRq6R5PInS0vUE8DmePswBCkpc3t3rYJ3IzyNLqAgumsK6C
         yuWkxzzNrekpGSexrj1/O6t4Im23EUL8SlxjfRFhC62yeu9H+dmmNbEnYlOb5EAktV7Z
         +ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=m7goBTiBuYr14fXAIBo91a9OtPoS8LPMZAib/uJ1kF8wTr9svU+YrhJOYzGGGLZZnT
         LCjUZ1vJkSllxbf3YEj6CGDvLWunfxOJ2LGNDHstTr5jLK3f2h45HsaX8YIHdNfgehRo
         oYrPhJlmk313KMlvF197k0n4ovZv8m9THLQPWPygHzNFah9DNloovP4y2Eoe2+MpYlFM
         k+rqExdDpF9R2MKOKfHzHS1ewWVtdUhNSlPzNIA4Ha+2dQxZa2vBrBzcuHLQmBv+5lUP
         diKBHJV5gHaiLD0hV4/wsHGeF1V0I5+uAomoZMAtKTsjqMqtavHErUZUs537+UgrQYB8
         J+tQ==
X-Gm-Message-State: APjAAAXwHlA3EEhZP5HAUDfuA8ltNSynvoArXlzkn7myWbjJrJCDCUVb
        7lqvbMQdspfP0T7o9Qs8i6A=
X-Google-Smtp-Source: APXvYqwldgVunQd7qxmyJ+Xn/e/agu1l+MYj5yw0wR8Ter7sPfmPIFdnHlyKscrzkGRhciJLS4S4Zw==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr52436969pfa.119.1559882788909;
        Thu, 06 Jun 2019 21:46:28 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:28 -0700 (PDT)
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
Subject: [PATCH v4 02/15] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Thu,  6 Jun 2019 21:45:37 -0700
Message-Id: <20190607044550.13361-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling loop with equivalent call to
tc_poll_timeout() for brevity. No functional change intended.

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
 drivers/gpu/drm/bridge/tc358767.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fb8a1942ec54..f463ef6d4271 100644
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
@@ -831,15 +830,10 @@ static int tc_main_link_enable(struct tc_data *tc)
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
-	timeout = 1000;
-	do {
-		tc_read(DP_PHY_CTRL, &value);
-		udelay(1);
-	} while ((!(value & PHY_RDY)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
+	if (ret) {
 		dev_err(dev, "timeout waiting for phy become ready");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
 	/* Set misc: 8 bits per color */
-- 
2.21.0


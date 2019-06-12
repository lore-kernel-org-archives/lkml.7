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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316EE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px0moJIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbfFLIdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33014 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437214AbfFLIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so9251387pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=Px0moJIgf6UCrKTsv66zOIr2CYRDTt3kp+Jx5ZHdJ10awkaKiL6pec965dOTq+x1DR
         KG7T24uyStQyE0xe/gMNpF0m1qOC1PuA/4oBYrCOljZWw6orrW0vmC0azJi1RIIRD9Ha
         ZC7L4LSstWfFPVC3i650UQAf55O8QsLXO3m5yR4l4brmM+GxnAcdgZkw5Dlvz80vVdR/
         WBDhe/qQlwDH5M952VeQO8YwdXJkhzV0cRrRxqDvV4QoWNNx5j6qXcHjHy37cfkvsscX
         yxH7sV9dTaBesygfWjDUrRhteGEhoC7cWef9CIf42q3VHgXG1iPUsd7aMw/zpujDoUQR
         Rvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=sr/m0oUYfgl2wjEnY+NZo7+19vNcEQaBl9M+TBmVsmnuOrHMY08fxxGHc5ltMy83bT
         4EInsKnL3SNmrZ7knHCiBBuYsWMujmyEb1iIOoaFcHvM076WUZeNbbS3UJ6uRdHwwdHs
         Ol38FdqpQdVCIsBTY4n3xsHVXqxJXo1uLgivnOs8i5JbWxf0rnC3ZAsHt0lzkKiTp0Hl
         YdbMm8DUrdzbuJwMrS7gNPfmyRE4OKjO8mltKU9qP/mgoPjPv/JaR2SseLJtH2DxR57/
         nA1CUF6+MMxNXNEU1wnk/1/X1VD9YarkpRReKnOjdr9+JUjfSD8ycUmTt5trU4xRbA30
         sz8w==
X-Gm-Message-State: APjAAAU1EGLL6xxioSlLCSZTZOSe+C69IduFwuF3Of/RbeN+SSNyavPc
        wFGisAR1V44beQsmD3MUffs=
X-Google-Smtp-Source: APXvYqxu/68UN5ee/XLEOoMWqU1CAHmnTAiCB5LQXT4k9WzbNZN9ZnxukE+Rx14u23lMuAeDxLP1EA==
X-Received: by 2002:a62:ed09:: with SMTP id u9mr84945237pfh.23.1560328387838;
        Wed, 12 Jun 2019 01:33:07 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:06 -0700 (PDT)
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
Subject: [PATCH v5 02/15] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Wed, 12 Jun 2019 01:32:39 -0700
Message-Id: <20190612083252.15321-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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


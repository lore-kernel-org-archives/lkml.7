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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C6AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549B321900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pva7vkP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCVD3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38201 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCVD3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so535753pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDOxiUU7Ui5Bt+r0LjeQZZzpwc0N9T5pZP48PklvOT0=;
        b=pva7vkP2bOWbxgia9upiIVTREtJhkJ97LTEOKexjCguUZUlWsRU9+OfJ+eKopsIqpC
         YVFFM4/OdWK1R/mnDJ4lUjd7EcjsKAVA/CraC1QhPn1WVjBTOHX+4+ekZgRMWShuPkg2
         uM3XpSQ3EwHNxsHB9xByQDQnQSdEIL5DTwKlcqFklbg9Y72HMPYgz/ZIzChtbC+A1xJv
         HCLRxUU5e75FXyiifLGI6rtuqoaua1nyVst7wCjOdU7/IAtOmIcEMunRGBH6zMfOV0VJ
         TqfbMUHZtMXYLiPuTdaUlCyA42bHz58dcqKghBieYw06/4D2udew1TsjIj1rxvGUbqQl
         nRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDOxiUU7Ui5Bt+r0LjeQZZzpwc0N9T5pZP48PklvOT0=;
        b=H/VDLMBvBEc26wDB8OYNMp9KinTdY1tQuFV/0IGp+xI7o6gm5IvLMqFGQRFkni8xjc
         /oalwYzw0DlgajfhW6jOei3yjiooNSjswZ8PIzTCBzOhmArwVBprne2uNr5tTlfyT2Cr
         P/tnUL3KmV7f6oKTaY+mG/nDbfbPbc6m/bGYzrUn9IaTiOGe4m7RXvNBZAXuhqUCgyQw
         3BBNHOJF1eU44UnMwgsR82VQ5AJQJYKRFhXbjW40cAgqLG/dFFt1AMOQXrNKgXloRFx4
         hiJazhwK6CqBUTtxwdcgtJJ9t5Uzop3cEHMdcKrGoZascQKpkuO412kBZtmPYZXuHKON
         1wSA==
X-Gm-Message-State: APjAAAUkEclRLxSiZumL4562SMarux2cWo7Qoferb99is/b9ZEGykzHj
        pkNNcRS4BlRFoh2AiYpNRVQ=
X-Google-Smtp-Source: APXvYqyDtc5hFWLx/HszbpiuOqlpwIURC5gUb2JrbG2ytBoasR5PXr8wzLCbEYD3DmGtmfhK9QhhDw==
X-Received: by 2002:a65:614a:: with SMTP id o10mr6780292pgv.51.1553225356934;
        Thu, 21 Mar 2019 20:29:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:16 -0700 (PDT)
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
Subject: [PATCH v2 02/15] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Thu, 21 Mar 2019 20:28:48 -0700
Message-Id: <20190322032901.12045-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 89a4392dfa35..2531f4dadbf8 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -761,7 +761,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 	struct device *dev = tc->dev;
 	unsigned int rate;
 	u32 dp_phy_ctrl;
-	int timeout;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -817,15 +816,11 @@ static int tc_main_link_enable(struct tc_data *tc)
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
2.20.1


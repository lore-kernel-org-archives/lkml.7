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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B8C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32842086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV/FZ2k5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFEHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33179 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfFEHFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so9362654plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbPIQS9Fmw5oTtgndIQLG4f4C7zxyYTux8kyKub57FA=;
        b=rV/FZ2k5ROTiwaU+QXmT18Q1X1XIfCyR4CuDNLomAL9GmG0K/H7k/bXUWOVlmzuxqr
         be68f1Qm8zwGc69LlLEY8vyoyGxmNKq55wQVgKt/VXliZaiPk3mV99UE1jVCCM/B4cPI
         /asHO2RFXQmPBlhXRY1iQpScW0QI69rG+4BevPUvNLGUIghl/BgY3M/rh1h2aFLGD26y
         Bs7o/6pdZ6XOABeOEynE65OpxMzLv1sFJd9kv0B8TCA770G1lPRQLoTCyzumG331Alzb
         0TSoxYTi5nJSmy51QGVkT8NUpMW7xCNmhtz+ulFHyySALZYnIobgPOCHzNk7YNdEOqoM
         Vudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbPIQS9Fmw5oTtgndIQLG4f4C7zxyYTux8kyKub57FA=;
        b=XuTfQu0YrA3ShkFVqr760F4AE1y2PX3moPGGiGVRsSQPJ6uoNvb7v43yIcLOer3Ctk
         HuQuyGn5tSbAFhiTwm0ZYhYdzDMXmNy45Y4+b8B4mYRPdTamuOBNXzscy4FZrKkoMxiJ
         I/bRk9hhw0+/iuvvYK1qMNticG1eCDuoYgYM+zsBbpUKkrJXYQXpTHVYbBTEUKjkmGN0
         1IwLkK5mnvh8FLBYOC+NEADrtRC051n4Odi4rBAK659ZcwFQgxXfBPKPRsIEPLdSuV3O
         8eeHcqlAgcYnLAPw6/S7Yu7x93Yo9dEq8M3tl5NeKF+3qo+f//efloEJEU1aKAublztQ
         1Qrg==
X-Gm-Message-State: APjAAAXe2Mib3gx270dz3JxS68cLO0Fy87kGl5RqWcxO31M1jIN9Qqt1
        pjwztvbnbSt+XRdJLYzJZZWOzluoeTc=
X-Google-Smtp-Source: APXvYqwwtx7cLpi6/3SbzLxsfe67iwSRMqCZtxpzZk6fJB29m0FN0KYAyk+OHByP79AIhNJLX7RDzw==
X-Received: by 2002:a17:902:542:: with SMTP id 60mr19568359plf.68.1559718346021;
        Wed, 05 Jun 2019 00:05:46 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:45 -0700 (PDT)
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
Subject: [PATCH v3 15/15] drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
Date:   Wed,  5 Jun 2019 00:05:07 -0700
Message-Id: <20190605070507.11417-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need 8 byte array, DP_LINK_STATUS_SIZE (6) should be
enough. This also gets rid of a magic number as a bonus.

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
index 41a976dff13b..cf38f943e656 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -893,7 +893,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
-	u8 tmp[8];
+	u8 tmp[DP_LINK_STATUS_SIZE];
 
 	dev_dbg(tc->dev, "link enable\n");
 
-- 
2.21.0


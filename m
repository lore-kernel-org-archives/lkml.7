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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52099C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D43A2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afohXmex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437241AbfFLIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39333 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437223AbfFLIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so1289882pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=afohXmexYd3wJdVyxOx1FBcrsMl+tDot6Jng9UlzTGqxMXcYq+tgzttatlHemrQKND
         QeaKnTN+FkYrkunmEJVmuwWPe3/4x2FIddEC+yBK7Tl5JYVcTJR3xQV/8rkJowf99Z2o
         c7wNrZmPqJsWBnVpyO25HUg/GHR9YcnexkxczY2Z9bREN0caDhSBs3fUHU8DjmaV2IMg
         MuyWybBxEAenUYMLruBmEdUNpQvmjoaSdovTbMP31CbASi8JhOwZ6Dx1xuDOj21o4Dhw
         2wAJ78x/T1YIiDQbg1ccJscQbDxTH6XpJ4fhMZ8FFqsIOdJqnqMjT845JNNNYBJpCDh+
         CfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=NDa03Qt3P7PBj+5Sj36JEBcH7meuqoSQenwkkH6cDVFAId10yKxOM/wWjy6v2wkTyq
         tQ4pmY2dXMB5/xPZhgTuWH47cgJA1usWW6hBK09eBArx2hcctmDhC134Q+d0jeHprIyc
         sQ6PasYAwubo2atzgOYmN68SMDbyNbmfUAZlI9gjt/Ix+i97DlFBcyzOGb6TN7xbih6W
         m8vc7baIVBD8RzCwQOeALvW7p5W59/edmXQ07OmZoaGEc8V5Lj7FimDF+85pBz6ayjn2
         8nBE1Cd0e5bLp2xwgSdHXc6baWoPrD4C/i/LKneTiE+B/yp8C7/NWUVubzxo37W/fhKG
         AjVA==
X-Gm-Message-State: APjAAAUf9JUFtMq4DZMXSW2xG6cnuDwgvm0uygzXTjmj4xgJLTB+LfxC
        sXFy2ul2GeZysk3KO3FGAh9e4bN5Lh0=
X-Google-Smtp-Source: APXvYqz0SCfmURsaGbalWFXaoUjBOrIErUa1pYVtdQJwdAbnXXHVgeg0Qtyu/jx9peDXZ5n/wM42Eg==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr20638789pll.248.1560328389392;
        Wed, 12 Jun 2019 01:33:09 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:08 -0700 (PDT)
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
Subject: [PATCH v5 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Wed, 12 Jun 2019 01:32:40 -0700
Message-Id: <20190612083252.15321-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling in tc_link_training() with equivalent call to
tc_poll_timeout() for simplicity. No functional change intended (not
including slightly altered debug output).

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
 drivers/gpu/drm/bridge/tc358767.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f463ef6d4271..31f5045e7e42 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
 
 static int tc_wait_link_training(struct tc_data *tc)
 {
-	u32 timeout = 1000;
 	u32 value;
 	int ret;
 
-	do {
-		udelay(1);
-		tc_read(DP0_LTSTAT, &value);
-	} while ((!(value & LT_LOOPDONE)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
+			      LT_LOOPDONE, 1, 1000);
+	if (ret) {
 		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
-	return (value >> 8) & 0x7;
+	tc_read(DP0_LTSTAT, &value);
 
+	return (value >> 8) & 0x7;
 err:
 	return ret;
 }
-- 
2.21.0


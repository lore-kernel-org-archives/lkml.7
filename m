Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C5C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24EE20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETVjVs57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfFSF1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45516 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbfFSF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so9016887pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=ETVjVs570hGEPhX3eVYxNEZszNuvFqfO6FnqddGwV2uWaCOLFWP2xy1Shdhqih4uJ6
         VtJOCup1WNZYUKXc9Stqt9l56xSnsJyrnneXaimRpEd/4GzC3IlQPg+AVPPD6IHlO+z4
         4vUY9g6LEySXPDKRNw+qK9pDDiuFKn9CRzkKIE9FN+JzeMbFUMxenDpe7oPpyZ9pgt6R
         wyrlL+kb6b0OsC+QuynTeH0K/bS7EOV1JXzLmb5KQSSgMrF5IRF6YyT6UeUyHZh1/ofi
         dm9Ac1dpn9VaRMOdb9b+Aqj6IO4VMliYn5AW6/qCM4RP6And7/UVZYdo2IptsIqzvMEo
         FSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=jlR1k3xnMCGAIUMk/0Jgs9FbQTeNAlkbReaXAD8po02OqQLAjJAJWIeImdZMlIwPhn
         SOHznagg94v3OHOcnCXmCnpR5zEHnxFSxF7rtxxgfmqhOApqhoKAclLym9brnF3N36Re
         ZR2/UEQRXNh9qrRn/b0hn+Rj6g9C2JU1jpmOIQPRB86T1qKe6yOZbfApuq9S77J+ebbV
         2aXL6Uvj7YK1SKOIN1IyndEkRn3aaT4vU1fNxvC8nJgIkaCdaNmQzpRai7sO3RBPHokt
         282RqKkNF37uvrxerDElUCT/iUuVyDVj1407m+OXyIgcHQw4AxejI0zR0HEHyyRVaVwe
         Z2xg==
X-Gm-Message-State: APjAAAVx4RuFRIukq5VbUCqOHigCiy4CD2nPeA1V+Ej6y4VwUKf+VJFU
        IscWBw1AP1knylO+R6JWyTWTOmgyJy4=
X-Google-Smtp-Source: APXvYqy/NwrsbsV8O2WZ1PxlIU6unkeciyb5wSA0toK+1G9xdpATGCjyQnL6B4PUy8Qcm7GoQKtaMQ==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr9111158pjb.137.1560922056542;
        Tue, 18 Jun 2019 22:27:36 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:35 -0700 (PDT)
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
Subject: [PATCH v6 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Tue, 18 Jun 2019 22:27:04 -0700
Message-Id: <20190619052716.16831-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
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


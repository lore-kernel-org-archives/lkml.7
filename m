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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D7C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639B020866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIHBvw4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFEHF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35055 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfFEHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so6264776pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wirFf7Bfi/9XjwkqOXDgrZYsLDnJpPp9vEZbkrcNQgM=;
        b=NIHBvw4DzFLmSh+4MdmMCikQr0aNv7Gkhi7yCDFo0EYZH942t+X3CFLkzVladA3Swb
         71Q8gWyOMwE3jAO5/hyjtYSrn6iR2qWSCXbJtWy8uax9XJLaSngzuIwi/YXsgG1aH7Pd
         haLYlVRzocFh+mB2qOhYiuw+xQbShOfzrN0O3xFV5DUjzqgDHw8/JboORuS6I74vjeSl
         uLZk7SSwhbspqq1qCdzWVDAQKZs50ov7P8cjBVcmiFW3RYf/0KbI22pVj/by6wPkG/uH
         2fzmlJcvJgU/DYfXDRkFPnc7s4QNVxJkxftGNP7WK+d73ctFN6/TW3yDjP+ZZCTyBtxn
         pu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wirFf7Bfi/9XjwkqOXDgrZYsLDnJpPp9vEZbkrcNQgM=;
        b=WVWd03ElgT/5x2bHg1gxIQK/NZESEvsjjO3IGekOus7O8S+apMQOXVoNc/keWjlUqt
         1ca+iQDuc7U7pzrZPyRsO8dA/XZWr0uoO5YFku4prLr/NVc/QwO2Arp561fytQKlmcJI
         MO9R6k6uHeu+G1iHyzuGFXqfTSWlmBa7Doaawqv2K88mYC7WwgXbRpfLrTv/onG5iKbt
         BXUcnnZf5J9VTWiV5lLFP7S/bFU6kiUCxJySX6oIdcNWhhPym6uYMAPtXxq8VTsYIgeK
         5/20+AdW8eS9z+cwQsUwkWqQa3qpNQHR+JN09S7LJA740Y/+l4rl8pktTc+HsZziyxl8
         VIag==
X-Gm-Message-State: APjAAAURs6GqtmK4TMlIzR9SNDlChPQgJob2vfFXQi5dOi7GJcirdR4o
        Wp6i4Tooe6z1Up5Pe9C1Cfo=
X-Google-Smtp-Source: APXvYqzdAjVBrJhFWY+RrjKSWzaYuKCZNU94Ec07F/vvaqCHIvzCwttviG6CztET7NH7lSx/v9qRCQ==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr2435554pgk.225.1559718326197;
        Wed, 05 Jun 2019 00:05:26 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:25 -0700 (PDT)
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
Subject: [PATCH v3 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Wed,  5 Jun 2019 00:04:55 -0700
Message-Id: <20190605070507.11417-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 5e1e73a91696..115cffc55a96 100644
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D481FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DF42086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk1R7MqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437217AbfFLIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46060 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437205AbfFLIdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so9197424pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eDYtx1SaX5ezeZL1yvMz2TA5bp73da63R7mtvE27ww=;
        b=Qk1R7MqZa9Gr9tjkCwl11RalVFSB915VNouBPrvwfBO9lorQBbp7X8Jyd7aga+98Rl
         FihMvVAZ8/EgFppumiMRcEQOdszZMnsM7re1t8uMnibI8np0u0Ydu8U74WWnwVUT7wXN
         AqVAf+cQdLwcy3UGMuga4TH5Fx3iWaA3KOKXPtlAYTdH1ng3iI+hAdHIEFotqb76HTJg
         yHnaoqMiTpAEpvppbim/2mKz8Xss5BrdGX8y74VPTi26CkqWljTS8aCH+Jul13rGjLd3
         zP+W3p5eMiEMWjqVbyfmLzQmVd6cVYHQAUmkpSYxS2QiU18Hxy6bzHflTAibffmeJ/BW
         lt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eDYtx1SaX5ezeZL1yvMz2TA5bp73da63R7mtvE27ww=;
        b=GE1JFakKdTnHwj8upldbgjjLtxPdCahbWE1aD6TeeYlfpqFak2/k92sNqP+r0CxTLI
         GKQ3p61R/S0aHvw4imk1kN/rZL0+etg4XakkO7gBmQxg4AMp3uAjEHzZ0ofMeA4bQd8M
         4+54SwXfrYhgBroSjjdrx5ZvMm1NbddVucgMKY47S31QbIQnEqFIodZJTQq+p0rs2koM
         ODLYMtLHUEcvdr+EKu42icj0efq830N8P3iyWelra4C1zWf9hwci1A3ZSY/CKFppmUis
         Os4bVJyEX6iHhDFwapbGI7dSnYZCaMhG1MWQw07hOodgjnVWlpq/rd8co3s5T0IjTd/z
         GTaA==
X-Gm-Message-State: APjAAAUyBTLEMB1yaOnwK1cqaSEjPtb8KJXy3jJtgQQkQKM9x9UqU6YV
        WxixDiz4HWrmeXidwFtdvbs=
X-Google-Smtp-Source: APXvYqylQdbs0qQNgPb6HfID161kQnJwYcxMWF/6k7/7L7g/NgRCf/rN0DEA4HcGT3+xR/9GdiUM+w==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr31232310pjv.52.1560328385785;
        Wed, 12 Jun 2019 01:33:05 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/15] drm/bridge: tc358767: Simplify tc_poll_timeout()
Date:   Wed, 12 Jun 2019 01:32:38 -0700
Message-Id: <20190612083252.15321-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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


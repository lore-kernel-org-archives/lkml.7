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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA45FC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DDA21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+EYppk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfFSF1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38214 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSF1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so455921plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eDYtx1SaX5ezeZL1yvMz2TA5bp73da63R7mtvE27ww=;
        b=q+EYppk2Lt/lSiYnCJzL5xttqZaAZCxIh8sJONSXZsj4l7x3V/PngusuMlRqtulhFl
         Ve+pX5FBRa+iW3of+4RIN6OJL/zxjz0FqN99zpCRIo+DWIKLFe8KZMU6UAtk9/5TzVGE
         9LPUkQZRFMDyxKMS47CnioABFrfqRIXMYNZilMuGrsvOT5sqiCWyYAynkQIygCjFASm9
         vx/lymeNWzeepkcAj5/He0DFNhb3EItsm/PTLFu4oSlJZpKUhHWI8aRFybAXlBAvXrDP
         7DvRDu4LlvPukuwUQ63NXW0diTqg2ZIQBdVeS2c63BMuUXDNEddpXmE8XFD6WI1HdBCT
         tYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eDYtx1SaX5ezeZL1yvMz2TA5bp73da63R7mtvE27ww=;
        b=mMYat+f3i9iJMJN4OFKwdbqgKbcNy9o8wBbgDl7fGZAU0BGOmApqTzs69Gp6hNvmSO
         ErOv4GY64HHtlgFMkHjGHsnMbrMa5c7y2Wey8UUmo2c07TL8GIT5w5/YqtCWhMbqyVdD
         m05N4BWzxSA59C/wCCH1PLk7K15e382qFqI1HLrq4TIJXnQH4asBS/oOdqDlJ2sjK9Nk
         lw6myB8PTpJnHfu2B46md7eWeCKdOnOdaik/bRPxQsvTlzHkat7ADH6r5MVif77Vpib7
         5vEcMe8uoXfPdFOwkP3W+zsAe9ZBDjvgliFfguW2u0rHvrpUNuS2i3OiHd0gN317wG0a
         r8qw==
X-Gm-Message-State: APjAAAVELWZ18O1+ofwUlKYg7GyOTJR4TsoZNdY574dSDIwiiusRvkSU
        0U3q5TNjMgHuB95PWq+QW4I=
X-Google-Smtp-Source: APXvYqyiiyikWTZpWv1pPJzEusYSkCJZ/IPd3dqPPPOlmb1TUYdIzAZQnjFWAAV0eTE3nSzpnNGf+g==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr37812405pld.174.1560922053691;
        Tue, 18 Jun 2019 22:27:33 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:32 -0700 (PDT)
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
Subject: [PATCH v6 01/15] drm/bridge: tc358767: Simplify tc_poll_timeout()
Date:   Tue, 18 Jun 2019 22:27:02 -0700
Message-Id: <20190619052716.16831-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
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


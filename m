Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76649C2D0CA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E16C24125
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BwlFP2Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLMXqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:46:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40666 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLMXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:46:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1878093plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1nojBCf3ACYVJFHPBZYBQ+QHefLuYc3mwl23M5Q8q4=;
        b=BwlFP2VxN5yIyheYiGfVUJDfU02ljIiH8mEkR9nkR5v18xNCedwkH/CezJqGykuC9c
         LpqfFJp+xSSFXkx2L//F4YDu2OhATsHjtx8aiyg+i4ZtyJJrODmjKdlxIdClOPZ/zxiz
         FWh/LlyZTdHKgzBKwjnn2Ya7tcAj053CW7/IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1nojBCf3ACYVJFHPBZYBQ+QHefLuYc3mwl23M5Q8q4=;
        b=Rqt+JQB3tBp2M9fHJigIvVMar/JuZTpTwpXW5UDJeDIMXUU6mTPUDr6+sBmM8ZEkbr
         DjQd3PIdtlrJ3bFw93BP+zAgELai8V0SQn4SUW7VfLJ6X3BYk3m2S9x0DpfmG0HhJ9Tl
         jqYavJYTIqe6jmHPB1BCjRiQlt2fiEHS0xI62ucZ4B3SZzyC5sCvY/a+OuYewYT5gQGD
         BYAm7niE4ytFQf2BHFAyqua8NvbDPJv2RVbhB/1Lg2ZiPbFMCxMqt1F1MKJgT7l0Rgik
         nsxbXDCg3RUwNkUM9WLeCIdoiKHR4XxNCt+7sRmxkb5MWIFxuRmkbLqj/3pijOPOOMGg
         rceA==
X-Gm-Message-State: APjAAAVJdqywZUiVfQV378khvZG1v/IwcG3glj+mxoMi8eOdnVz0t+4V
        p4YhVnvt9SnleiHfw1hE9t3bug==
X-Google-Smtp-Source: APXvYqzgVQQVXnj76kvMizRTtrW7NoC5P57JSnvWfTjS9YLSZhqDVTeudipaBSu8eFK5QpmKbFVNag==
X-Received: by 2002:a17:902:541:: with SMTP id 59mr2278359plf.190.1576280774444;
        Fri, 13 Dec 2019 15:46:14 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z19sm12282905pfn.49.2019.12.13.15.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:46:14 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 9/9] drm/bridge: ti-sn65dsi86: Skip non-standard DP rates
Date:   Fri, 13 Dec 2019 15:45:30 -0800
Message-Id: <20191213154448.9.I1791f91dd22894da04f86699a7507d101d4385bc@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213234530.145963-1-dianders@chromium.org>
References: <20191213234530.145963-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge chip supports these DP rates according to TI's spec:
* 1.62 Gbps (RBR)
* 2.16 Gbps
* 2.43 Gbps
* 2.7 Gbps (HBR)
* 3.24 Gbps
* 4.32 Gbps
* 5.4 Gbps (HBR2)

As far as I can tell, only RBR, HBR, and HBR2 are part of the DP spec.
If other rates work then I believe it's because the sink has allowed
bending the spec a little bit.

I hoped that we could tell which rates would work and which rates
didn't work based on whether link training passed or not.
Unfortunately this wasn't so good on at least one panel hooked up to
the bridge (AUO B116XAK01).  On that panel with 24 bpp configured:
* 1.62: too small for 69500 kHz at 24 bpp
* 2.16: link training failed
* 2.43: link training passed, but garbage on screen
* 2.7:  joy and happiness

Let's bypass all non-standard rates, which makes this panel happy
working.  I'll still keep the code organized in such a way where it
_could_ try the other rates, though, on the assumption that eventually
someone will find a way to make use of them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index cc8bef172f69..cb774ee536cd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -454,6 +454,15 @@ static const unsigned int ti_sn_bridge_dp_rate_lut[] = {
 	0, 1620, 2160, 2430, 2700, 3240, 4320, 5400
 };
 
+/**
+ * A table indicating which of the rates in ti_sn_bridge_dp_rate_lut
+ * is as per the DP spec (AKA a standard) as opposed to an intermediate
+ * rate.
+ */
+static const bool ti_sn_bridge_dp_rate_standard[] = {
+	false, true, false, false, true, false, false, true
+};
+
 static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn_bridge *pdata)
 {
 	unsigned int bit_rate_khz, dp_rate_mhz;
@@ -660,6 +669,18 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	for (dp_rate_idx = ti_sn_bridge_calc_min_dp_rate_idx(pdata);
 	     dp_rate_idx <= max_dp_rate_idx;
 	     dp_rate_idx++) {
+		/*
+		 * To be on the safe side, we'll skip all non-standard
+		 * rates and move up to the next standard one.  This is
+		 * because some panels will pass link training with a non-
+		 * standard rate but just show garbage.  If the non-standard
+		 * rates are useful we should figure out how to enable them
+		 * through querying the panel, having a per-panel whitelist,
+		 * or adding a DT property.
+		 */
+		if (!ti_sn_bridge_dp_rate_standard[dp_rate_idx])
+			continue;
+
 		ret = ti_sn_link_training(pdata, dp_rate_idx, &last_err_str);
 		if (!ret)
 			break;
-- 
2.24.1.735.g03f4e72817-goog


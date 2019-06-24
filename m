Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371378;
	bh=Y/MYH8fEzOhlLXY1NSLeaKuxk3L/Epd5P+oRdNS6+aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OFo6821cGMFWCpQdetJDe2JCFY3tOEx55BfLy6OYwmi7v9DKRKL5a12UYggb/ViXq
	 G5b7BKK7Y8fNRfOatIFif1+K2Zl+4FmLjEQvdR8YRuzMP1+dY9gAr77isfKLYJspL9
	 MT8UQZbTrGu/VKCbzjMxGlMvFWo/EBQP6G6AA7Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfFXKQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbfFXKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:16:12 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32DC205ED;
        Mon, 24 Jun 2019 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371371;
        bh=Y/MYH8fEzOhlLXY1NSLeaKuxk3L/Epd5P+oRdNS6+aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVnlY6DA4nlDDe8fn1usY5p8SSnXKPKohIoNmT0J2xCnhamWbrFw2AzB8DpaFw9WQ
         c8LjtNU76uIO0lmg1lfyDTllh1B5flYpub/Sb9AlqSMGUdghtzgfWtsiVG8l8eTVNn
         zl/vUm25PGpuwi3a1QSrp6fN2rjgvzzsyW0IvCgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 071/121] drm/arm/hdlcd: Actually validate CRTC modes
Date:   Mon, 24 Jun 2019 17:56:43 +0800
Message-Id: <20190624092324.519615127@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b96151edced4edb6a18aa89a5fa02c7066efff45 ]

Rather than allowing any old mode through, then subsequently refusing
unmatchable clock rates in atomic_check when it's too late to back out
and pick a different mode, let's do that validation up-front where it
will cause unsupported modes to be correctly pruned in the first place.

This also eliminates an issue whereby a perceived clock rate of 0 would
cause atomic disable to fail and prevent the module from being unloaded.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 0b2b62f8fa3c..ecac6fe0b213 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -186,20 +186,19 @@ static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable_unprepare(hdlcd->clk);
 }
 
-static int hdlcd_crtc_atomic_check(struct drm_crtc *crtc,
-				   struct drm_crtc_state *state)
+static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
+		const struct drm_display_mode *mode)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	struct drm_display_mode *mode = &state->adjusted_mode;
 	long rate, clk_rate = mode->clock * 1000;
 
 	rate = clk_round_rate(hdlcd->clk, clk_rate);
 	if (rate != clk_rate) {
 		/* clock required by mode not supported by hardware */
-		return -EINVAL;
+		return MODE_NOCLOCK;
 	}
 
-	return 0;
+	return MODE_OK;
 }
 
 static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -220,7 +219,7 @@ static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
-	.atomic_check	= hdlcd_crtc_atomic_check,
+	.mode_valid	= hdlcd_crtc_mode_valid,
 	.atomic_begin	= hdlcd_crtc_atomic_begin,
 	.atomic_enable	= hdlcd_crtc_atomic_enable,
 	.atomic_disable	= hdlcd_crtc_atomic_disable,
-- 
2.20.1




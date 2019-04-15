Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3729C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355570;
	bh=nfQk0ngZLn9Z95jPjbg83rWEtp/FkqerijGIbM4nnWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4hd6hEWi8LfPDTt/nfmULW7H39iunc10MI7OlQhq3gqf49gluSw2k5qIQoEoIbLJ
	 FtO92J8FiC8FjFEju2R93fP1WlD6wrE6MHemfUD9Ar5+QyB+akbRc4WX2FpBTFMLr1
	 H1a9deJg/ay9sw33RQbiWVYmCxzaUYfv+S2of92Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfDOTMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbfDOTMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0EE218A1;
        Mon, 15 Apr 2019 19:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355563;
        bh=nfQk0ngZLn9Z95jPjbg83rWEtp/FkqerijGIbM4nnWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGlXHTevpibpyTiNO5xxpsNfWVYHL96lui3jJEP+Bt/OPG/2+WIqQYETrX++M31zb
         wmT6ooThF/xNk/XoGJdpsfvYEznsPgcMLk+b4zuhdOrctZC0b2bJEJ6OPcjUo2SstN
         irqtcfeE2Xnr9mVM69mYy9jogob1dBwJlRUMXhl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 5.0 067/117] drm/sun4i: DW HDMI: Lower max. supported rate for H6
Date:   Mon, 15 Apr 2019 21:00:37 +0200
Message-Id: <20190415183748.361833181@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

commit cd9063757a227cf31ebf5391ccda2bf583b0806e upstream.

Currently resolutions with pixel clock higher than 340 MHz don't work
with H6 HDMI controller. They just produce a blank screen.

Limit maximum pixel clock rate to 340 MHz until scrambling is supported.

Cc: stable@vger.kernel.org # 5.0
Fixes: 40bb9d3147b2 ("drm/sun4i: Add support for H6 DW HDMI controller")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190324190609.32721-1-jernej.skrabec@siol.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -48,8 +48,13 @@ static enum drm_mode_status
 sun8i_dw_hdmi_mode_valid_h6(struct drm_connector *connector,
 			    const struct drm_display_mode *mode)
 {
-	/* This is max for HDMI 2.0b (4K@60Hz) */
-	if (mode->clock > 594000)
+	/*
+	 * Controller support maximum of 594 MHz, which correlates to
+	 * 4K@60Hz 4:4:4 or RGB. However, for frequencies greater than
+	 * 340 MHz scrambling has to be enabled. Because scrambling is
+	 * not yet implemented, just limit to 340 MHz for now.
+	 */
+	if (mode->clock > 340000)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;



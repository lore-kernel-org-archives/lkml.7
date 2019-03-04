Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C55D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688438;
	bh=vFqxc7+Voy/5DFR5djnBvTktJf8APXC7+bI4zOdb2fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pPU0/i8lR1f4wsWTBDLJ96SihI7jK7nTwUQJ7cBm562kMKbDWRSlVd5RkV3555fgA
	 Rjp4FK3NS1PVw7ad+5BtzMmF6D+fXSr9H5+KBQstFXsI9KUnMdqINZh+EsqxQjYekn
	 VwueUs4BIKeBsMbYWtgFiwPGVVMaNV41uKxYQOrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfCDId5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbfCDIdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1B320823;
        Mon,  4 Mar 2019 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688433;
        bh=vFqxc7+Voy/5DFR5djnBvTktJf8APXC7+bI4zOdb2fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgz+fsZXz5k+knSfk5E06xjA1G3Nl74VsBnU2uKMVFg1zc4jvahsJgX8Y0mGU0mTs
         /6MSGRt2vjPGuGQw7jGK+vdRwKX11chxYvDPUEiJRmLt2Xd+cKAu6aTIaFti51SzA1
         yv1DZl9cP+UZ76R9oTWol0adAQQfg/Pg5Cf2XW2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Priit Laes <priit.laes@paf.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 42/88] drm/sun4i: hdmi: Fix usage of TMDS clock
Date:   Mon,  4 Mar 2019 09:22:25 +0100
Message-Id: <20190304081632.237641909@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5e1bc251cebc84b41b8eb5d2434e54d939a85430 ]

Although TMDS clock is required for HDMI to properly function,
nobody called clk_prepare_enable(). This fixes reference counting
issues and makes sure clock is running when it needs to be running.

Due to TDMS clock being parent clock for DDC clock, TDMS clock
was turned on/off for each EDID probe, causing spurious failures
for certain HDMI/DVI screens.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Priit Laes <priit.laes@paf.com>
[Maxime: Moved the TMDS clock enable earlier]
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190122073232.7240-1-plaes@plaes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 061d2e0d9011e..416da53767018 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -92,6 +92,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
 	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	clk_disable_unprepare(hdmi->tmds_clk);
 }
 
 static void sun4i_hdmi_enable(struct drm_encoder *encoder)
@@ -102,6 +104,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
 
+	clk_prepare_enable(hdmi->tmds_clk);
+
 	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
-- 
2.19.1




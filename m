Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5488CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC2024680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011960;
	bh=MGJpwmzW8V6MK6vfbIXS/Ffo7ij6p1KHtpg0BMQrkBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WSoIPFaBp9lX55nN6WZQ/izbnWaSGTEdS4iXggqddr96ZkLxIaBLm0G8BY8al23Z6
	 g5FMlv+xzqwNht1n7Wrvlja+oHkhXQpcJvAvwngp4RoenycflP30/OtAnp/oCTJUiF
	 ogmerxJLp5hSEFI91MgV7j1VXv2WLbDGg51FW6u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfLJVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfLJVEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1B724654;
        Tue, 10 Dec 2019 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011870;
        bh=MGJpwmzW8V6MK6vfbIXS/Ffo7ij6p1KHtpg0BMQrkBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zqXJh64WM4Ql57n6aR44DwT/GzQTepasohY7PjfcdDHlfsnBJGjFMFhAdNmG4+CH
         fNx7NoHhDKlLRxIxlt2mTeIm4vReBzwsXAmZOrgdoKSStc0xEdkV//7aIhvH2X0Di5
         RqH+8rUFs0u6AAEnQ5MBkb/rSDvlv0SwKoR5bTCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 022/350] drm/meson: vclk: use the correct G12A frac max value
Date:   Tue, 10 Dec 2019 15:58:34 -0500
Message-Id: <20191210210402.8367-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit d56276a13c2b9ea287b9fc7cc78bed4c43b286f9 ]

When calculating the HDMI PLL settings for a DMT mode PHY frequency,
use the correct max fractional PLL value for G12A VPU.

With this fix, we can finally setup the 1024x768-60 mode.

Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190828132311.23881-1-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_vclk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index ac491a7819527..f690793ae2d57 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -638,13 +638,18 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
 		if (frac >= HDMI_FRAC_MAX_GXBB)
 			return false;
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
-		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
-		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
 		/* Empiric supported min/max dividers */
 		if (m < 106 || m > 247)
 			return false;
 		if (frac >= HDMI_FRAC_MAX_GXL)
 			return false;
+	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+		/* Empiric supported min/max dividers */
+		if (m < 106 || m > 247)
+			return false;
+		if (frac >= HDMI_FRAC_MAX_G12A)
+			return false;
 	}
 
 	return true;
-- 
2.20.1


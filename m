Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA123C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F742173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510142;
	bh=YcXokZu+2LkBvLe7ZRs8tH8d5NKI9sW+Q7ZWwSvA1NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qC6AuqbLLmwq07c698Wtg/IEGzJYZwY9UNAbOrQnsDDtjHbU+oG516PBfjYYOvt/I
	 LPyxQLy7vgFyw7x/JFYM6SkH3pw9R+z1qxaYLF8RmW59d5/zWsdwAkkmgO1AwTyqTB
	 RkVn6KjAeKQDOA0YG4cOwBd0hPwzLLBQ7gK/SBLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfGSEWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387473AbfGSELZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:11:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B55218D9;
        Fri, 19 Jul 2019 04:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509484;
        bh=YcXokZu+2LkBvLe7ZRs8tH8d5NKI9sW+Q7ZWwSvA1NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPNdB9J5v+3iY4WRD7ZMTT8NqSIrs4KsPuAP4h3WWZFzAg8v2vN27hG4TUHrX4Sg2
         QPQ0LnymH17PliDHPtOZ9GJVYyq2uCAKu/5gl52lyd5zaEDXegRtMjZXcPFfTIkPQI
         WQ9WqixFA1MQ5x/vHiV/tm50QfISh/bjetalVxAg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jyri Sarha <jsarha@ti.com>, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 09/60] drm/bridge: sii902x: pixel clock unit is 10kHz instead of 1kHz
Date:   Fri, 19 Jul 2019 00:10:18 -0400
Message-Id: <20190719041109.18262-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041109.18262-1-sashal@kernel.org>
References: <20190719041109.18262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jyri Sarha <jsarha@ti.com>

[ Upstream commit 8dbfc5b65023b67397aca28e8adb25c819f6398c ]

The pixel clock unit in the first two registers (0x00 and 0x01) of
sii9022 is 10kHz, not 1kHz as in struct drm_display_mode. Division by
10 fixes the issue.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1a2a8eae0b9d6333e7a5841026bf7fd65c9ccd09.1558964241.git.jsarha@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..109ab4c3df50 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -261,10 +261,11 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
 	struct regmap *regmap = sii902x->regmap;
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct hdmi_avi_infoframe frame;
+	u16 pixel_clock_10kHz = adj->clock / 10;
 	int ret;
 
-	buf[0] = adj->clock;
-	buf[1] = adj->clock >> 8;
+	buf[0] = pixel_clock_10kHz & 0xff;
+	buf[1] = pixel_clock_10kHz >> 8;
 	buf[2] = adj->vrefresh;
 	buf[3] = 0x00;
 	buf[4] = adj->hdisplay;
-- 
2.20.1


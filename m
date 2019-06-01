Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4EC28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD58273CB
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395589;
	bh=+xczNjbzexM5uQCXq7isyKQZuVsG1rm2P3V7I6eJ/To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVGi15721xMukHj25AwAqJy/Gs9N8g9A3BPmX5dJWeuljPLaIDGLknDsKm7QoZZtK
	 SEJZL6Tyyopv+0zdf2SsC6ocHznQJWiMDmBzvpWLTpaSxloCn62b+1MzGN+hd07Jx1
	 j+u5luncKqsZ4kWmlE8sfcfK5/0ELwEgbwo8fIIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfFAN02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbfFAN00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFAAE273B8;
        Sat,  1 Jun 2019 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395585;
        bh=+xczNjbzexM5uQCXq7isyKQZuVsG1rm2P3V7I6eJ/To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHQfq2A5IgcGYv+WT6BBoVkzDkOxNYQcRT1cBjvDcgrB5UjS9Zvffgn0jYilRRgcS
         h+GTOkpYUJutVYYkJO/MCMwZtEBki9MzDXGrfeqJWSCX/SyLhdk0Oj1DtEkL+SRlVn
         B2bMlFywiSjdtolvbnZM63MON+5U6wTMZwxVaLTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 11/56] drm/bridge: adv7511: Fix low refresh rate selection
Date:   Sat,  1 Jun 2019 09:25:15 -0400
Message-Id: <20190601132600.27427-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@thinci.com>

[ Upstream commit 67793bd3b3948dc8c8384b6430e036a30a0ecb43 ]

The driver currently sets register 0xfb (Low Refresh Rate) based on the
value of mode->vrefresh. Firstly, this field is specified to be in Hz,
but the magic numbers used by the code are Hz * 1000. This essentially
leads to the low refresh rate always being set to 0x01, since the
vrefresh value will always be less than 24000. Fix the magic numbers to
be in Hz.
Secondly, according to the comment in drm_modes.h, the field is not
supposed to be used in a functional way anyway. Instead, use the helper
function drm_mode_vrefresh().

Fixes: 9c8af882bf12 ("drm: Add adv7511 encoder driver")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190424132210.26338-1-matt.redfearn@thinci.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i2c/adv7511.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index c7c243e9b8083..4300e27ed113e 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -781,11 +781,11 @@ static void adv7511_encoder_mode_set(struct drm_encoder *encoder,
 			vsync_polarity = 1;
 	}
 
-	if (mode->vrefresh <= 24000)
+	if (drm_mode_vrefresh(mode) <= 24)
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
-	else if (mode->vrefresh <= 25000)
+	else if (drm_mode_vrefresh(mode) <= 25)
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
-	else if (mode->vrefresh <= 30000)
+	else if (drm_mode_vrefresh(mode) <= 30)
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
-- 
2.20.1


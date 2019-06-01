Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD40C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BD272FB
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395263;
	bh=Zym5nfYQabsOu0HM7LG3ClqZmIZ9QL9KNpVc6EOKBj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuSy30Y86BiadxsiVxFf4dHADD7aZh1tYIApF65N/8tP57LhunsxKTd069i1TeW9+
	 eBQWtXCX1Ww9hjNyAMql9BFRrKULcctqPUnty/VYIUAz+EVLNOJ9Obx7PV90Dnlu2D
	 j/emGdxTWE98JKc26e9KnGxvnsQ3m+Npe7SzveYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFANVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfFANU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:20:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08100272E0;
        Sat,  1 Jun 2019 13:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395258;
        bh=Zym5nfYQabsOu0HM7LG3ClqZmIZ9QL9KNpVc6EOKBj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bj8JrB2oOjiV8mpfH7t0mdE3UHt+YWcvuIdpWWNkLhk2+wmkOVpzNiRWVRwdujlKQ
         CSCngoOpVfCFTesYbtFT+7yCLe45QEW3DT5OIEa2MBvf5h/ehOlfiyZS4/uPHGVWvt
         7ENWcwC5xRSopqH2rYaHg6UOycD6aY6gK5KeBGSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 030/173] drm/bridge: adv7511: Fix low refresh rate selection
Date:   Sat,  1 Jun 2019 09:17:02 -0400
Message-Id: <20190601131934.25053-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
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
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 85c2d407a52e1..e7ddd3e3db920 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -747,11 +747,11 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
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


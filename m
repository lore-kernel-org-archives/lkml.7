Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E5C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C802064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FWiVkKJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfF0SVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:21:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46306 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0SV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561659685; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMTPz/E0Re9ZEDNi6A5HiGlO3zDC+PQxFDkb/cLcYIA=;
        b=FWiVkKJKVlCD9C4SuMljhAEFNZ3ed4WkettXKTs3mgvlVmcUH7Ec9RnU8ATnFJiC6cWZt7
        ueoUze9d2nkIl1kmFHgKbk+zvWTmZA4/R3+9+aiabjtu7Bjw/mN7U5PY1y5MQDtUd7aZMx
        0QYJr6gEps52Z46YbvmNzHEHfgOteEU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] DRM: ingenic: Add support for panels with 8-bit serial bus
Date:   Thu, 27 Jun 2019 20:21:14 +0200
Message-Id: <20190627182114.27299-3-paul@crapouillou.net>
In-Reply-To: <20190627182114.27299-1-paul@crapouillou.net>
References: <20190627182114.27299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LCD panels with a serial 8-bit bus, where the color
components of each 24-bit pixel are sent sequentially.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index da966f3dc1f7..ce1fae3a78a9 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -426,6 +426,9 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 			case MEDIA_BUS_FMT_RGB888_1X24:
 				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
 				break;
+			case MEDIA_BUS_FMT_RGB888_3X8:
+				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
+				break;
 			default:
 				break;
 			}
@@ -451,6 +454,7 @@ static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
 	case MEDIA_BUS_FMT_RGB565_1X16:
 	case MEDIA_BUS_FMT_RGB666_1X18:
 	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB888_3X8:
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.21.0.593.g511ec345e18


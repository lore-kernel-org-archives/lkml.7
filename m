Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79DB208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zpj6fpMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfFXJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:08:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40910 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfFXJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:08:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so12499527wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEu52n+Y1evOTBr/RTN/Q2dwwvERmXBMuN5/hCbfulk=;
        b=zpj6fpMApTCm1uSb0baA4zRqXFozjA1NmbDfYrIbC5puqTTVVr4Ip4tuf78NfHLMPW
         jRHxSv33gZcEw3lNw800YMoIxvguJGQ4UccHw7fV1bcUT9+xOYaMMZttaCoiRIV1t4x0
         yw3HCSakiGKLxpgVVMCL8kICcu2Ft9ns/uNQHY5ILUWk6nBpj+HYpzvMeqG45eM8M8hp
         PRMBWFq2+GWkoMIi9vj1FTVey7LiEuKUWBf8/+wHLmVg2gXxfxtuXhSsrM7EPIwdtm67
         Mpm+6X7uiV76HxU1So8tRso+Ca3qlNxMskPITNrLemqE4Gw97mTMQpD0H/XxPHM3XisZ
         Kxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEu52n+Y1evOTBr/RTN/Q2dwwvERmXBMuN5/hCbfulk=;
        b=ZAK/FbxyRVs/uGS9kpUsIXmUJafjna//MqkRFT8BG1YMArmQY6rAMMNVDy3me26BFL
         qo+oijf2G3YTzSOVyMLte9KLTI0B4l23n/z7OWy+t7QzL1DyKS1Adk3nlAUYOagY+wzy
         xwN6ihnVO2lIG35DxU8y0FFWZiGrCcjmFFgxwipDyCuFKizdf4OVgWgrIbVLGkQSx3aT
         cYtY7NHdejpSnmWxyYTV64IIbUahkPLSa86BUXzk9K5Frw4vTcQciyORtIyAsc0dtCfL
         Pra0fo3iQ0bykIl7NPhDID5cT2pbHb0uBTJ5Bg3CsFL33q7SZTOf8prpirufiPlyU1Nb
         Mc5A==
X-Gm-Message-State: APjAAAV1z+w0/HtqsRLHYPyws9ClrhZ6aexhZ8UQ9d2F+ShpHisaEqNA
        /UW3i9EMJYo4SV+qGcffJ182lg==
X-Google-Smtp-Source: APXvYqyuOUxAk76rjGNPPMmM7yFsLswDOXGsFqw/0ITcLsTGxOqVZbjDNuuDpg6k52rVA5PxBoP+Yg==
X-Received: by 2002:a1c:c549:: with SMTP id v70mr14632320wmf.135.1561367334867;
        Mon, 24 Jun 2019 02:08:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f12sm23457566wrg.5.2019.06.24.02.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 02:08:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@siol.net>
Subject: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM Bridge Drivers
Date:   Mon, 24 Jun 2019 11:08:51 +0200
Message-Id: <20190624090851.17859-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer of DRM Bridge Drivers then add Jonas Karlman
and Jernej Škrabec as Reviewers of DRM Bridge Drivers.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jernej Škrabec <jernej.skrabec@siol.net>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2abf6d28db64..dd8dacc61e79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5253,7 +5253,10 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR BRIDGE CHIPS
 M:	Andrzej Hajda <a.hajda@samsung.com>
+M:	Neil Armstrong <narmstrong@baylibre.com>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+R:	Jernej Skrabec <jernej.skrabec@siol.net>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/bridge/
-- 
2.21.0


Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC8C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A92339F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ASry5ZM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfHTIlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44549 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfHTIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so11448229wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4Y3CFbjNwiB1B+iBEVNDBDAoCejxlfh6zI1Bb1qZiE=;
        b=ASry5ZM5cg4Mj7+Gov+BV86kT6tt0zwKyCPGbFJdX0/Lu8alE9juf83M9UoeBkkeMB
         7MOHArPNau4G6zacpVCwL6YanyGVnykHAo6AKLPTc6nr6Do11bWbvxXmz7gk+b0rRy1A
         057DmSveWUXIDbN+clUhL+CxZGzO02unnS1XjPema2TJsi+MLlS6Rre6rr6N5uQ6unfX
         i4BzCDk2w6HSnBrYZbXbEeF1XvwHq/9JvV9B/7TXjHWseEVbgJC98KycMoegfyn96+Aj
         R2GkIg5HbW+iLN6G0lfxavZCaKoKJACnK0IPZ59zh776aY5aGWBVMrGYzdZPl+t8Vs1m
         yEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4Y3CFbjNwiB1B+iBEVNDBDAoCejxlfh6zI1Bb1qZiE=;
        b=B0nVt0Pj/9b9eoZioaCIEXq82hN0SoJ/OQNiV+x51qd+Tijn4aMFY1ltypvY++87an
         LS6HEqhmU7LGB4F45t/0dpcHSNG+HU/sPnGk0LfLdVm9x72Mfg2vD6Vvw4MJyizBMe3v
         Ipp7LsrzVC1l3uDOmis1daTpUWf7lH+SeF/VAB6gWNvNSWFNmO/FU50tTOE9Sa7oeb3R
         Zb8aPrQnKbah7v7CI6x1com9A5OSTUpIdK5P5WU/oWu14yGRdN1Rsr+571vnVNUVLkZf
         USn9u4sHw5JKrVu+lconRVeicmprzEQyL2gFSRkRztAeCl1ut2uLvdgmohrK/9m8rrwW
         WIyg==
X-Gm-Message-State: APjAAAW95RKheX7Mywt9zMckzxBAiUR0FSpznqmUsRakp79fZvzQkKua
        acP2zN3Lm8qpXnpJXOmtZ0h/IQ==
X-Google-Smtp-Source: APXvYqzVElNN6koqJa/MLyjtNn8tuQ5nmvel1gG2X/S1bupBdsBf82IjRZrX2thxmiDzXrm5ehO8tQ==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr32742170wro.337.1566290474464;
        Tue, 20 Aug 2019 01:41:14 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 02/11] drm/meson: venc: make drm_display_mode const
Date:   Tue, 20 Aug 2019 10:41:00 +0200
Message-Id: <20190820084109.24616-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching to bridge funcs, make sure drm_display_mode is passed
as const to the venc functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 +-
 drivers/gpu/drm/meson/meson_venc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 3d4791798ae0..c8e9840ad450 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
 	union meson_hdmi_venc_mode vmode_dmt;
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 576768bdd08d..1abdcbdf51c0 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode);
+			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
 void meson_venc_enable_vsync(struct meson_drm *priv);
-- 
2.22.0


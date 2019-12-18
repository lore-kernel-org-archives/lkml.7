Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163E120684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MOzKOrop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLRPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfLRPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2441836wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpYk4ZxORLK9U8orRADFrmupc+cuzyuzN13HM6sJYsk=;
        b=MOzKOrop/aoyr4aHIj6FlChhibXTxUnlZmKs6ikdRKUMp+zSYo/wlD5qVVbl1bw4xU
         2bQvOxNy3CKZAp/KwuCQ2D1lSZhlN70czrJ3IptHa86I+/J56DeLusiU1MhQSBSyY8Sr
         L5cEME2FEgqbnNkB3HRXe7jbvbP06MkcR1T000/54CvnL3zxejL+vAZvOofvDv+kDCFV
         FxlUgi5L/Euv8iHd7qBCWJrzLez753ga4pqG3QfpAwAsHqFHpwjTYIoV/CzRmnX+V0qZ
         vIKNRmdzeKo2CvN7ecthWLeOuGHMj9dab+jboQEZvwpuHgeEj+fNg1A+7661UXLy1MOe
         vW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpYk4ZxORLK9U8orRADFrmupc+cuzyuzN13HM6sJYsk=;
        b=CGHFkNUEtKnJpIH5ARyPKCqPwgofoQdUHZOmJOCI9b0XFFMEsVl0y9XLmrbds5Uf2S
         UR+fY7NoDN0Cv2/Uph0jqa+4a5e5iMcOq6GAJ64XeCKs53y+0vkZsiG0kt7kFSeiiQyU
         FL4NsKLEW7FtfIrVQVfAilUfcdij+uiVNbewoUBwV6ccE6oKhZO0PsDsqcj5X/60/pe2
         KQuPJz6RL7vK9D/OSIAjcApLnXumLa5u46c61GXgcbECBjysgR6r+JS37CKFzCCmO3EH
         Xb+RpNwggGalM/+OikIiZyuUBkLUUcvC00eXWRpFRjneDjdvMpMgvjV7jY87x8ixh10w
         Br+w==
X-Gm-Message-State: APjAAAXI+M5eBi9E6D0vpq4PC+ySsCNjy34h12V/CeyU6RuPTJP+wdvW
        jECI9z6pKEuMeP4IfgJh1tpeEQ==
X-Google-Smtp-Source: APXvYqxCqnYVSKzPfGvRns3vdEALXKpTqlz/AJkEO7HjSjYsW4oXY6y7UG6ZL4cgrP7B3eIwD7+Iug==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr4310085wmg.66.1576684002484;
        Wed, 18 Dec 2019 07:46:42 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:41 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 02/10] drm/bridge: dw-hdmi: add max bpc connector property
Date:   Wed, 18 Dec 2019 16:46:29 +0100
Message-Id: <20191218154637.17509-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Add the max_bpc property to the dw-hdmi connector to prepare support
for 10, 12 & 16bit output support.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 6a0b4b3a6739..e7a0600f8cc5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2368,6 +2368,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 				    DRM_MODE_CONNECTOR_HDMIA,
 				    hdmi->ddc);
 
+	drm_atomic_helper_connector_reset(connector);
+
+	drm_connector_attach_max_bpc_property(connector, 8, 16);
+
 	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
 		drm_object_attach_property(&connector->base,
 			connector->dev->mode_config.hdr_output_metadata_property, 0);
-- 
2.22.0


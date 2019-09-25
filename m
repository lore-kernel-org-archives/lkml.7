Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F5C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4950220673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nTzCAE+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfIYW6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:58:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45944 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfIYW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:58:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so172644pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e54uTjhrMjS+i3uZjyZOFqJvo1DiLqu+QVKk06QE/rE=;
        b=nTzCAE+GktkwHSreEF1W8BpnrqcEc/f/Sl9mRlJjDNjgJF8kMD+xID7r4VV4G3yX9w
         GZ1hgcf0hxBU7Opu+Kn3+gQYzHMijRDwGJP1xFu3Ki5JQhoF5qFt/RieM3KgHQxrdnk3
         Fkny4XUwI2dYgIVZ5jYPO407R700wwxt6I91Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e54uTjhrMjS+i3uZjyZOFqJvo1DiLqu+QVKk06QE/rE=;
        b=KR6ZO3f/uqIm0HkDu0ZPGvhD09KCIoEJUH64YV4mhiT+ojrnrrv5TDodN8AGt9q699
         NdQZsCCGERBdGhmqaWIvQu8qGqHtETB9y/HSdp4D+TEuHwqxhDoDFIMR2T5bScrCqJID
         Xfoun+mzfoYYJMeeE950SDD1RAXTdkxQZJFe1Kma8I1xOSN+2THBIM0KeJEubB3xOUHR
         OU6JNAD6+aJ96bZIEekDtvdhEu4GenSTTUfgnjORqMmHEN/WRwbSindSDW9CVBZ9JoJb
         gr27JMe3sLDsdJccjy6Fz3AId9yRlbifKYb5t/x/x8KO5Zq01pv4UZCP3JCoaEhtFXDP
         qR+A==
X-Gm-Message-State: APjAAAV9P8juYR/as2yWULNcqvYeoLORRjGcPKvh/qwnTJoSw6eMjcHc
        TwtD/7AsgqHMt1vymWNZGPkw1rRUWyk=
X-Google-Smtp-Source: APXvYqzK4P5iXr9jOF6+1L25eEXxPfuNyjSJPKhfdFr3rhdXJaKzGU5D+7A3nxPWuxjmqSRQYiqNoA==
X-Received: by 2002:a63:c203:: with SMTP id b3mr283133pgd.450.1569452321998;
        Wed, 25 Sep 2019 15:58:41 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id j24sm76185pff.71.2019.09.25.15.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:58:41 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v8 2/4] drm/panel: set display info in panel attach
Date:   Wed, 25 Sep 2019 15:58:31 -0700
Message-Id: <20190925225833.7310-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925225833.7310-1-dbasehore@chromium.org>
References: <20190925225833.7310-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree systems can set panel orientation via a panel binding, but
there's no way, as is, to propagate this setting to the connector,
where the property need to be added.
To address this, this patch sets orientation, as well as other fixed
values for the panel, in the drm_panel_attach function. These values
are stored from probe in the drm_panel struct.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_panel.c | 28 +++++++++++++++++++++
 include/drm/drm_panel.h     | 50 +++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 0909b53b74e6..1cd2b56c9fe6 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
  */
 int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
 {
+	struct drm_display_info *info;
+
 	if (panel->connector)
 		return -EBUSY;
 
 	panel->connector = connector;
 	panel->drm = connector->dev;
+	info = &connector->display_info;
+	info->width_mm = panel->width_mm;
+	info->height_mm = panel->height_mm;
+	info->bpc = panel->bpc;
+	info->panel_orientation = panel->orientation;
+	info->bus_flags = panel->bus_flags;
+	if (panel->bus_formats)
+		drm_display_info_set_bus_formats(&connector->display_info,
+						 panel->bus_formats,
+						 panel->num_bus_formats);
 
 	return 0;
 }
@@ -126,6 +138,22 @@ EXPORT_SYMBOL(drm_panel_attach);
  */
 void drm_panel_detach(struct drm_panel *panel)
 {
+	struct drm_display_info *info;
+
+	if (!panel->connector)
+		goto out;
+
+	info = &panel->connector->display_info;
+	info->width_mm = 0;
+	info->height_mm = 0;
+	info->bpc = 0;
+	info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	info->bus_flags = 0;
+	kfree(info->bus_formats);
+	info->bus_formats = NULL;
+	info->num_bus_formats = 0;
+
+out:
 	panel->connector = NULL;
 	panel->drm = NULL;
 }
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index d16158deacdc..f3587a54b8ac 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -141,6 +141,56 @@ struct drm_panel {
 	 */
 	const struct drm_panel_funcs *funcs;
 
+	/**
+	 * @width_mm:
+	 *
+	 * Physical width in mm.
+	 */
+	unsigned int width_mm;
+
+	/**
+	 * @height_mm:
+	 *
+	 * Physical height in mm.
+	 */
+	unsigned int height_mm;
+
+	/**
+	 * @bpc:
+	 *
+	 * Maximum bits per color channel. Used by HDMI and DP outputs.
+	 */
+	unsigned int bpc;
+
+	/**
+	 * @orientation
+	 *
+	 * Installation orientation of the panel with respect to the chassis.
+	 */
+	int orientation;
+
+	/**
+	 * @bus_formats
+	 *
+	 * Pixel data format on the wire.
+	 */
+	const u32 *bus_formats;
+
+	/**
+	 * @num_bus_formats:
+	 *
+	 * Number of elements pointed to by @bus_formats
+	 */
+	unsigned int num_bus_formats;
+
+	/**
+	 * @bus_flags:
+	 *
+	 * Additional information (like pixel signal polarity) for the pixel
+	 * data on the bus.
+	 */
+	u32 bus_flags;
+
 	/**
 	 * @list:
 	 *
-- 
2.23.0.351.gc4317032e6-goog


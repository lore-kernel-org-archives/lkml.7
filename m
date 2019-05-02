Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9523FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A997206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJKuaiHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEBWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:38:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:38:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so1716446pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGCfMQkKfqkKFZ8erX0b7VyU7ofDCnx2g9X0TKrb/HA=;
        b=DJKuaiHXmnpN5NHgJx3Ha85ILyIu0e1kfwt5qnKUaJz9o3ZLF8arJytmHtO7FqiFBV
         MBWtO7EXORv02Y2abZgYE36pxCrS+zMp4GRVryBr0oj3TWALLhx8FtS6V3FpEWfVdzdW
         96PKjpxXBqXPpYBCEru2M2NeyILoFnAEQplI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGCfMQkKfqkKFZ8erX0b7VyU7ofDCnx2g9X0TKrb/HA=;
        b=Hdkz47TVqKqBAqbNdMox9Tzn1zYBLGdUCzW+WM3LGG0NUXt2ahNbrmJDcp+fQxJ9/9
         JWVDp2yraHib04joYNvcKK73YDhhn4IukSUi1z0S1NpYWWyAJxHj9bkRjNxXG46hh+tf
         zQzhSSQkoh+Q8iu/RiblBIbg/6vHHAdZaEpfPFYndM5IONlrW9PPF+T18Nx6fZNwMt7+
         KdRgovfFtLXI4tfH9wFegh1waofOBoUkSHP+K1i1FqIWlft5fma+ALKkAgcCDVE1NPEt
         fBpwrxacBRQk64UuomGen6Zcsgu8hhJctOxT3f93xIBnwK7A7eYvv4g3/XWZMS/dllGD
         LpnA==
X-Gm-Message-State: APjAAAWEpAhhQjd0FBT7X6G4+jZGpJlKhTeRabrR9HnycOQ0qO6jNVii
        VMuCtLHuQ3dwTfTynQdIyLz/Lg==
X-Google-Smtp-Source: APXvYqzegNUKwWVFGK5+OSJGRGvk9lnvVlziVA8BSgZO2xFC57BLteuXPc+lxQ5gyK9oIUqE+P1Q3g==
X-Received: by 2002:a63:cd15:: with SMTP id i21mr6626004pgg.269.1556836711151;
        Thu, 02 May 2019 15:38:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k186sm244151pfc.137.2019.05.02.15.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:38:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
Date:   Thu,  2 May 2019 15:38:07 -0700
Message-Id: <20190502223808.185180-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3288-based Chromebooks when you do a suspend/resume
cycle:

1. You lose the ability to detect an HDMI device being plugged in.

2. If you're using the i2c bus built in to dw_hdmi then it stops
working.

Let's add a hook to the core dw-hdmi driver so that we can call it in
dw_hdmi-rockchip in the next commit.

NOTE: the exact set of steps I've done here in resume come from
looking at the normal dw_hdmi init sequence in upstream Linux plus the
sequence that we did in downstream Chrome OS 3.14.  Testing show that
it seems to work, but if an extra step is needed or something here is
not needed we could improve it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h              |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index db761329a1e3..4b38bfd43e59 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 
+int dw_hdmi_suspend(struct dw_hdmi *hdmi)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
+
+int dw_hdmi_resume(struct dw_hdmi *hdmi)
+{
+	initialize_hdmi_ih_mutes(hdmi);
+
+	dw_hdmi_setup_i2c(hdmi);
+	if (hdmi->i2c)
+		dw_hdmi_i2c_init(hdmi);
+
+	if (hdmi->phy.ops->setup_hpd)
+		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_resume);
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..c4132e9a5ae3 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -154,6 +154,9 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
 			     const struct dw_hdmi_plat_data *plat_data);
 
+int dw_hdmi_suspend(struct dw_hdmi *hdmi);
+int dw_hdmi_resume(struct dw_hdmi *hdmi);
+
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
-- 
2.21.0.1020.gf2820cf01a-goog


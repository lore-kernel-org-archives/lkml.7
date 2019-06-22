Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E5BC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED62070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zmu3mEbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfFVDlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 23:41:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42951 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 23:41:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so4246397pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbPgR1/hx/sADCMq1nG2N2yoZQYOu26NTJrjoG7x5xA=;
        b=Zmu3mEblG9DO62WX5N1m2VZeTpFPKI2jgrIhgPwPBE8rRFVmDo8DC3yfbw6MKAkpn2
         QK+/2+WdoWpH7KbIdh2MaZFoj/PgWlt//6JHJniNyGLTaUaUm9YBE3w87nd1tpmPH+7M
         gyr210lpu+qPBP9Wbc6uIa2I4m4M/QBeVwIhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbPgR1/hx/sADCMq1nG2N2yoZQYOu26NTJrjoG7x5xA=;
        b=NhCdlWYRfVqptjwZlO28CaPgjTifEJ4k3K40f+FOrCVhwiaozvEOdPrFIIIYUnHTy6
         PL4Yd2XizKsXrkMDMZ4OJkitxaEYjJKJ4dF/yuOY9MQMjhtTZ5a8bZJg4WKn3KZ3K3v4
         xoyWVW+5VE2d6Uy1lDUac/WMCew3agWq8n0mboptx6iHxwQq1THNcVeOfAF7WljWpm/4
         FqZEqjPhWqEuyztkzj99DMGei+zbVVPRZHoxiBHqQGc2CrAUNY7rcOB2lnqgJnz4OMWi
         upi8Htc8pJy67+371KCYLHNQW+S+2qnUm63C/Bjyaiv7taj4rCPDYCIyg8xv3V2l45X8
         +lBA==
X-Gm-Message-State: APjAAAUQQZmoybsIe8q1xgyol1XKw08/6Uk/oZRADiHlrIMJdmA3U3mm
        QMQOzYhGadtXqsM5Ck199DvOr5M/1eA=
X-Google-Smtp-Source: APXvYqyyqTs+2ZoGG0EdVdaCSlWo+2N8luEZi/UZqbDEHKFswtQZPVx6FuiDYjT4HRX+RhljHv8nHA==
X-Received: by 2002:a63:c442:: with SMTP id m2mr21570928pgg.277.1561174870871;
        Fri, 21 Jun 2019 20:41:10 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id u128sm4756688pfu.26.2019.06.21.20.41.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 20:41:10 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Panel rotation patches
Date:   Fri, 21 Jun 2019 20:41:01 -0700
Message-Id: <20190622034105.188454-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the plumbing for reading panel rotation from the devicetree
and sets up adding a panel property for the panel orientation on
Mediatek SoCs when a rotation is present.

v3 changes:
-changed from attach/detach callbacks to directly setting fixed panel
 values in drm_panel_attach
-removed update to Documentation
-added separate function for quirked panel orientation property init

v2 changes:
fixed build errors in i915

Derek Basehore (4):
  drm/panel: Add helper for reading DT rotation
  drm/panel: set display info in panel attach
  drm/connector: Split out orientation quirk detection
  drm/mtk: add panel orientation property

 drivers/gpu/drm/drm_connector.c    | 45 ++++++++++++++-----
 drivers/gpu/drm/drm_panel.c        | 70 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp.c    |  4 +-
 drivers/gpu/drm/i915/vlv_dsi.c     |  5 +--
 drivers/gpu/drm/mediatek/mtk_dsi.c |  8 ++++
 include/drm/drm_connector.h        |  2 +
 include/drm/drm_panel.h            | 21 +++++++++
 7 files changed, 138 insertions(+), 17 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog


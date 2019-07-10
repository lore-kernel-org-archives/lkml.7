Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32DC73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC342073D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQXF4izt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGJCRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:17:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43796 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfGJCRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:17:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so362637plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL/iKcky+DBal5hSRMsXARSXXCVch6Zl/oKMaiM15pA=;
        b=LQXF4iztDK4WfGH3yFPHfMFpFoxRGzJ5SJsuvt8PUYKH5sMMGeff6st/EcfYxwcIzc
         GxhzEvZK940b7dcqpFHyB4koUyH87iv3Ful02WPZLOgp+RbNy5HxSi0QtGxb1TioliFj
         to6SHdkOhkaignW44UcMR8L2Lb/KPwHiPg1zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL/iKcky+DBal5hSRMsXARSXXCVch6Zl/oKMaiM15pA=;
        b=RBuG1h9tETC4RZW9f7QRm1TIS9RVizQHHxV0/EpbG0rh2P/DePhK0fKx5LGF0/WjfG
         usa+XZVnwYIU7eG2Z+nB9+Kn4OQZpFJtVH3v1TMbwi6hbbXjL3SUfwHVx0PLG/iTWTO6
         YfFHBIfjsBG9kP0c/ME5Cgv9m8HX7VeTz4EwgTsMdQ/QBJYN6PqkDpQMOLOssGC/GPJC
         x3gLysFSHfCDO1xRlP7mIdOLv7Jv2zhukKB59mO0bH0jCYG3wcXIzDApnnBwfvjUwIwe
         2KHrpGUuzXI3IS5hMUlJiWY+Qogq8AQqjZYTJrdEeDEELRm9WFnnzW1pFZYbZbOhK4uc
         WFgA==
X-Gm-Message-State: APjAAAVYy79XaR+JEhEBH1ToDqg1vHJbnPBYyjEa1LndZwp6O3kmS9YQ
        TEd0RfZPKblzUNEmfdxLtk+umygO5fg=
X-Google-Smtp-Source: APXvYqyEKIBQy601LP2m94TC+l7EN0vjJQm/b7SyERDtRnwMRSIGypY9ZrywmAynnQCFbswC7bKmrw==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr36510488pll.236.1562725023757;
        Tue, 09 Jul 2019 19:17:03 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id f17sm326296pgv.16.2019.07.09.19.17.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 19:17:03 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Panel rotation patches
Date:   Tue,  9 Jul 2019 19:16:55 -0700
Message-Id: <20190710021659.177950-1-dbasehore@chromium.org>
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

v7 changes:
-forgot to add static inline

v6 changes:
-added enum declaration to drm_panel.h header

v5 changes:
-rebased

v4 changes:
-fixed some changes made to the i915 driver
-clarified comments on of orientation helper

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


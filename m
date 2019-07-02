Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2733C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E6E218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzRWt1d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGCAvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:51:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43163 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:51:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so288765pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbKEAFwQNgdJMuzfiYPMlyXAsoNdsnEp4Uok88ypekU=;
        b=dzRWt1d0cH9OT8aIY2cfNcZP1PY8roOuwd7uTGeLkG0cZl8zRBQFiUDispqLSA/UuQ
         7qtogcL/XgZ4GiHoPPdi2jdl9O8tG/VgyjT9Dvw6mhdOaxNhTFFazxDQ55AxHlhv/wMv
         Zs28goiGB3utYWKBKTNH2WzG18bLyrlTHqcBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbKEAFwQNgdJMuzfiYPMlyXAsoNdsnEp4Uok88ypekU=;
        b=PFeIkvy9uKLgE9w7SUN0roTqL2GAkCwc/AfEW8j3qq7nSZK5QoMGfBSFAHumvUTk//
         unAbgAJgXv9jot8M7hcgclYibdbo0pFghsC8uSg7XH/BLiDnlLo/ep/H6BaZlZUvQV/N
         gipb2WI++Gf+JrydTzfdoyYKIgkRUnqjgsynYafApmeZjHPWiTi7Ui8p3IZ5ESa7U9OZ
         Otav/ncLfNZZIZ/KkfKTxDPUQDKKVr/LUU23k9h+2Z59AZwmIcBekYGebrnd50/Bw2a9
         IWEHitxsHDkBqUtO4L2GkwM84bzsB/rsfTVKWezcVkpSTtUWxMEaHlwr58kaksSFdyYw
         lD7A==
X-Gm-Message-State: APjAAAWTg7dePgOyVktM8ROyVO0mCeEQSmWoqXp+XZKqRoYIdD9MaD34
        CbZRAKkhibhbyDZaM1cUXULIO5X4EOE=
X-Google-Smtp-Source: APXvYqzlQqAaaA9TlBYcDIIcItk2Sbug9JeUuEIc7DDU9bCUWN1kFgrxSAljeRrXbuNEk+5pPKxVXA==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr8573547pjb.1.1562110982720;
        Tue, 02 Jul 2019 16:43:02 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id c26sm167611pfr.172.2019.07.02.16.43.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 16:43:01 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Panel rotation patches
Date:   Tue,  2 Jul 2019 16:42:54 -0700
Message-Id: <20190702234258.136349-1-dbasehore@chromium.org>
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


Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28100C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2FB21852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mtOVyYmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGCXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:02:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44175 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:02:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1993411plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZrZzCDWL8uR9GukOyNtVnJ0nmZVvvWXcGkMP18atyY=;
        b=mtOVyYmG2IzpmlsHOH/bFwJl21qcA8lVJRKpae+DMHwii9l1x+40yEervyi7qpqpr4
         hB3hlY3oPRMK55uHK1HYswgIkYyVHxU6REHY5Rgc5rlePiDU4gDvgc2YkR5l77Prg3Cc
         W/Ejps3fU5hazueodIieCVdr1ZyHbm6gx14qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZrZzCDWL8uR9GukOyNtVnJ0nmZVvvWXcGkMP18atyY=;
        b=pFUuXeogIap8gFSr5T40NBiRBSbCDrIq9c4Oo9bflbcJNOmRd3wFszdnbzyiZOmmhv
         1hF5K+MU4ejBu59kuzjd5WYDI22pNozrtWo6u2QTXDeIl9SytjK4euunj0fxOMdnAbFE
         MZ9pPEIYLfNX7jb/wjfoq5ueordh2bkwZ23jfxVeIo/YyG6cPMsuCqeFmieE3y6ueWx8
         5RH2lfBJ6l9V/EST95eDbpnPSmMaioENes9vk9ZsjjhsXJoxhOFBipS2asWAOVP4aflD
         VwkihtKD8LYRTMG9NE75FCCezbug1Agt9gpdxgwzdWBz8NqG494KGgXdm9GDDgngiqHQ
         vLJA==
X-Gm-Message-State: APjAAAUwtabbaM5vG/mVvfpNoYfc4w7o66T2TW5LYJYnh0r+Fcr077c7
        RxgnGAGeQZBe6R3DxU44c8dbCOYo2xU=
X-Google-Smtp-Source: APXvYqwM3KsV4pYEtclP2v6OFHEPEkTQxv4xInN46kPm5Ul21is2Kyu5NnJ0VVIbZBrV9EgR7m7IMw==
X-Received: by 2002:a17:902:16f:: with SMTP id 102mr43528588plb.94.1562194934905;
        Wed, 03 Jul 2019 16:02:14 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t8sm4245171pfq.31.2019.07.03.16.02.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 16:02:13 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Panel rotation patches
Date:   Wed,  3 Jul 2019 16:02:06 -0700
Message-Id: <20190703230210.85342-1-dbasehore@chromium.org>
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


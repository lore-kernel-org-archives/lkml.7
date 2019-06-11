Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B2C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E912E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPeWijeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFKED4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:03:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44415 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfFKED4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:03:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so6144391pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ep5PT5nJYpz/Bj3Iz+6dAuGsY6URZpg14AnULVjTGA0=;
        b=BPeWijeb5HdxjyxppQb40ApVn/nxLgHSyp0AL/ASYmRCiKlPLM1ddJO4q+5DVFlKJo
         M/6tW2VGGMmJt5p6uRnJYncIATIm7J5usdTrrpfDSsoiEwZOhO6s75rGbFLm+gF0M/Zu
         OXBZxzrusRa5BRO0jGY04Rtc4em07eeQ66PnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ep5PT5nJYpz/Bj3Iz+6dAuGsY6URZpg14AnULVjTGA0=;
        b=c/a551qtV1cSEs+AeNU0LEnAepSrD3vcq7gbcE7n6bp1yAXCN7+slOfb70ZySYc5L0
         Zj6dRxbQ6EBzYk1KCReQyX/Yg0tUqUFYBbLNQSqiCfUBK273WELGkeF04EddXmy3PjG5
         m/Ug8qML6vUZy7cRGMRSiglVoCACnjJjdme4rYpn9Cg1Xcl5KSmK/po/19oTxjSU40mH
         +35gZhKfMr+IMpPUOsFohXrLVcrn87aIYrlg8yu4NHRNftOoU5amxF7crdCzmYQxmHu4
         yTtrLP3q+c2Thbwl2iL22CUtQOPMklMXuMHtmTZWt65N0TCQrm1JZi6rOoBh8dAexT+9
         Q1bQ==
X-Gm-Message-State: APjAAAVcXs6AzNUp1vP1i5hD7ZhlUtpo4DgCC9BlQak8pwPnS+tnIvdN
        kyV44xZN7cAYNsya3wFlmdHx2mhoZh0=
X-Google-Smtp-Source: APXvYqwomU3EkmGbmD6lmNUwogikv7z13A3K3b0++X/UrjCKXAXsfZu9Zj3Dxfvxg4ZWCL337q4OtA==
X-Received: by 2002:a62:e0c2:: with SMTP id d63mr21262331pfm.60.1560225835215;
        Mon, 10 Jun 2019 21:03:55 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y133sm13301185pfb.28.2019.06.10.21.03.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 21:03:54 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 0/5] Panel rotation patches
Date:   Mon, 10 Jun 2019 21:03:45 -0700
Message-Id: <20190611040350.90064-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the plumbing for reading panel rotation from the devicetree
and sets up adding a panel property for the panel orientation on
Mediatek SoCs when a rotation is present.

v2 changes:
fixed build errors in i915

Derek Basehore (5):
  drm/panel: Add helper for reading DT rotation
  dt-bindings: display/panel: Expand rotation documentation
  drm/panel: Add attach/detach callbacks
  drm/connector: Split out orientation quirk detection
  drm/mtk: add panel orientation property

 .../bindings/display/panel/panel.txt          | 32 +++++++++++
 drivers/gpu/drm/drm_connector.c               | 16 ++----
 drivers/gpu/drm/drm_panel.c                   | 55 +++++++++++++++++++
 drivers/gpu/drm/i915/vlv_dsi.c                | 13 +++--
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  8 +++
 include/drm/drm_connector.h                   |  2 +-
 include/drm/drm_panel.h                       | 11 ++++
 7 files changed, 120 insertions(+), 17 deletions(-)

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog


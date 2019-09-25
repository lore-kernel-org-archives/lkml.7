Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C544C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573C021D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnwzlxaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfIYW6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:58:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfIYW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:58:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so209968pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBfAYVzrUaZx8A81lQKWZtaimNSs6Q4Prkr1zyCu8Sk=;
        b=lnwzlxaOGXON5kJ+mJtUQcGIZKlxrNequk5F3hmYazLKV6g7hVjA4zue24ICSCflnJ
         TKbxKfS27WL3LmgHu6tGZzEsOKLplx7ahSTC12La2RWxtT71Bg5QSABWFvbHMg+cKhUb
         Z23L/NT/IQHnf3aCqP6reQvCq6mvnOL9t8NLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBfAYVzrUaZx8A81lQKWZtaimNSs6Q4Prkr1zyCu8Sk=;
        b=adFnn67SkRSMJrgSYbA01vPn1kw3GAMYIyC/qi0iFALkZnD2MovGWX33ZSv7lvkbF+
         WdT6bzEnA8sWWp8ETAIU0XrgXqwq+2MlNB6Rx7WZ3YmlYUqU2Jm/GyFD4rUtBiTkBEQr
         6dLKKUbUoKP3d+5gEy/bP+xJ8mhaJ9I9ktcJXwemht8UR4q6nGG2aGsCbDwBQqRjS3KL
         htimvZqpNs+rI4xnk38mo6Kag4thiisaK3SSXrpvOpWao5hXYDAdVfkdLVqELmL+2yqS
         b+USaaFTuF+plhuB4VAcLlw1xD/xupMun6ciuu8AJ+b46Q5CF2CvzZ9eGnAePi45IT4P
         xaCg==
X-Gm-Message-State: APjAAAVGOFIQCDXjcMITEUFUXnkzUqgA/Lhq56/7BAGO/U0WrhHgl6gv
        qnP41d4N9et3RwIsB3wulKVcVvbjFjI=
X-Google-Smtp-Source: APXvYqyBkPb/ka6PSD+JEb9aEIXdZQPZKoux3UfNWddn261c/1mhYqrBDYlaAvmnqxOn2W4DIIYmEQ==
X-Received: by 2002:a65:420d:: with SMTP id c13mr260391pgq.293.1569452318669;
        Wed, 25 Sep 2019 15:58:38 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id j24sm76185pff.71.2019.09.25.15.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:58:37 -0700 (PDT)
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
Subject: [PATCH v8 0/4] Panel rotation patches
Date:   Wed, 25 Sep 2019 15:58:29 -0700
Message-Id: <20190925225833.7310-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the plumbing for reading panel rotation from the devicetree
and sets up adding a panel property for the panel orientation on
Mediatek SoCs when a rotation is present.

v8 changes:
-added reviewed-by tags
-fixed conflict with i915 patch that recently landed
-Added additional documentation

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


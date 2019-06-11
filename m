Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E518920896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f5ipcdNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbfFKAXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:23:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41596 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbfFKAXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:23:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so5724116pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ys/QIuTzESKgIhK+4lqN2GBOgNe/RQ4XjHnrFVNq/bg=;
        b=f5ipcdNBMgeYN6xIkspolGbToPlj9rnUy85L/384p3yAVGYdbKT3rIYX2R9DTVe5DZ
         BYJNhX2Lc4MpUKIIZ8Uvygx+l7dI/iqp1tjbx6cPL9JzfUDgJZKWqECoYuYfsfw24UwA
         BoOUkWOPjP/ynt3LEWf2YKuM3gT243RbvpPTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ys/QIuTzESKgIhK+4lqN2GBOgNe/RQ4XjHnrFVNq/bg=;
        b=RyfkEYDvk4lTNZlbSc7vgyM4T6gTWBMHT1KXIcpeLWnhSemr2AelyG0gDm2jVQ3eoU
         PkoXydNLHFyWQ2mxfO87Di/Q2kzI0EKJL4HbLWnsDrW1o/n/nUK3GHwcGh8tp3dUo8ix
         9C6PKwo8XIV02pSK8VVWeZ75ECCN8tkwBY5S24EJezOrviP6qJ9rRH687UJfZ6b3o/OW
         Tn0nar67pOEPcwV28k3/xxEW6JiK7GfIoLT7JbjME7SWfFMGyZHtvCag6keyA0jRZhSV
         nx1Q86EPdiOg+M9eaceaH1FKJT1x0vBuQTeLbtorMaIa2rH9ZpWhdB+30RiRXQpQ2R8v
         II2w==
X-Gm-Message-State: APjAAAUA06OfqfMREv3DEMwTvynlTxJXc3pqiXp0u1o3IGPdoj0WbRk8
        PPdFwWkORETh2ACEE/ZEYqQHmwWxdlk=
X-Google-Smtp-Source: APXvYqyFDNopqPX7XaEAu7EG9CwttGgKSVT073ogwDm3kj5G1I2Zurlp7yaWcrSslQANYBeJiel1uQ==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr2852849pje.129.1560212582590;
        Mon, 10 Jun 2019 17:23:02 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t4sm540317pjq.19.2019.06.10.17.23.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:23:01 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 0/5] Panel rotation patches
Date:   Mon, 10 Jun 2019 17:22:51 -0700
Message-Id: <20190611002256.186969-1-dbasehore@chromium.org>
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


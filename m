Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408AB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bQv5u87d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfCYOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so10361908wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6lXMgJkbNJYoX51nM2DSyC+pdFe3+x6sveMv4LgZRo=;
        b=bQv5u87d8xeq3pTrIKhQHu04gqYQqBUfe0F8spmdU8ydb0ojqoWvPmgxBedhE0EmHh
         0pNYDWwZLQKCwBwbdml+VyHBBrCT1kTgW71a7NrHuYsYbx8G52TmygavBXGZzYMNV8Kp
         YkdMjsQkjxtaCcJ68ajt9dH+CXiSpFprQ6o7jZlhjXxVFSxCKZny+u1WB45ugzIpmkNA
         9qSPuol6c8EokVDGp+SfrcfDHUixwT1R/FAXgrZacEBDjiXEzehqqYu+Tfw57yOfI7lH
         ITCz2nn22+3s/w77CvBdEtC2KNQcwPbzhmFSG5IKq3j8SgMZQSUY3AEVf2ZI+DMGr1hU
         nMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6lXMgJkbNJYoX51nM2DSyC+pdFe3+x6sveMv4LgZRo=;
        b=rkNWc7BBW+g1kmxBvaHnyZtuEpyJ2TkkRIScDf0JrbIQD49SiMQ2FnStLLwwChjDpK
         xkAmArgznuwwT2ZkKYvXu2In6eJgkZom7sUrNwNLZv2Ut9pFh0GmF+NeJGMq+7lVuUY4
         NOfO1YL/WCVgswjdxf64jPkDGrxT0nOADue068uC2Fe87B6BABNeQ6Pa7z7hMXPIyeiG
         UAiLfiJEcxkTePQlXIU+CLEjyGd9thQ4DispuzjPTE5FAwhUgdu0PfRTayeVFT25fhBd
         bi1LgD+0xM6P+kYfnqEz8KVJNM5+m8qEFgtK2d7JYQeax2l7nSy3+yPLQhH/wYsMeYFx
         bb5g==
X-Gm-Message-State: APjAAAU4pNIadH0uI5E2refYh7fLhPCxs6xK0vNNELTN41/2i3WU+4bE
        KKsBU0+HSCBU/ZpqwcumBFiVmg==
X-Google-Smtp-Source: APXvYqxXjEUWykNzKlubJowVhJ9OqMpsTbP96CwZoWJF0qg7cwK8zXIgdtR6saIMDZlg6khXCh/1Eg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr8619269wrn.89.1553523507309;
        Mon, 25 Mar 2019 07:18:27 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] drm/meson: Add G12A Support
Date:   Mon, 25 Mar 2019 15:18:13 +0100
Message-Id: <20190325141824.21259-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoC offers very close Video Display
functionnalities with it's older GXBB, GXL & GXM predecessors.

The main differences are :
- G12A Support now 3 "real" OSD planes with a new Blender module
- Instead of having a single Scaler for OSD1, G12A has two scaler
  that can be applied to 2 out of the 3 OSD planes or on the outputs
  of the blender module.
- The HDMI PHY now support RX-SENSE, Dynamic HDR and it's registers are
  now memory mapped instead of using an internal bus.
- The VPU now support a DSI interface to connect a display, using
  the Synopsys DSI controller and a custom PHY

The complex Blender routing, HDMI RX-SENSE, Dynamic HDR and DSI support
are not handled in this patchset.

This patchset implements on-par support with the currently support
GXBB, GXL and GXM SoCs. There is no support delta with this patchset.

patch 10 & 11 implements the bindings found at [1].

[1] https://lkml.kernel.org/r/20190313141030.5958-1-narmstrong@baylibre.com

Neil Armstrong (11):
  drm/meson: Switch PLL to 5.94GHz base for 297Mhz pixel clock
  drm/meson: Add registers for G12A SoC
  drm/meson: Add G12A Support for VPP setup
  drm/meson: Add G12A Support for VIU setup
  drm/meson: Add G12A support for OSD1 Plane
  drm/meson: Add G12A Support for the Overlay video plane
  drm/meson: Add G12A support for plane handling in CRTC driver
  drm/meson: Add G12A support for CVBS Encoer
  drm/meson: Add G12A Video Clock setup
  drm/meson: Add G12A compatible
  drm/meson: Add G12A support for the DW-HDMI Glue

 drivers/gpu/drm/meson/meson_crtc.c      | 269 +++++++++++++++++++-----
 drivers/gpu/drm/meson/meson_drv.c       |   1 +
 drivers/gpu/drm/meson/meson_drv.h       |   4 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c   | 163 +++++++++++---
 drivers/gpu/drm/meson/meson_dw_hdmi.h   |  32 ++-
 drivers/gpu/drm/meson/meson_overlay.c   |  10 +-
 drivers/gpu/drm/meson/meson_plane.c     |  15 +-
 drivers/gpu/drm/meson/meson_registers.h | 247 ++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_vclk.c      | 123 +++++++++--
 drivers/gpu/drm/meson/meson_venc.c      |  11 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c |  25 ++-
 drivers/gpu/drm/meson/meson_viu.c       |  72 ++++++-
 drivers/gpu/drm/meson/meson_vpp.c       |  51 +++--
 13 files changed, 880 insertions(+), 143 deletions(-)

-- 
2.21.0


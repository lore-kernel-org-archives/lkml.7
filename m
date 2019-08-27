Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70B8206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0VeKXm8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfH0IOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:14:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0IOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:14:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so17798478wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKa+G+WNTHyk8o+xbr/dEWEAIM2ZkisNR8p1GVxWpVo=;
        b=0VeKXm8Af8pEVqLyMPQhZTzMrsz8jVxkUaD5N4qpJaKNrac9JiXxDZSi2OWY6CJWXH
         k5TbIKg5WQsbaPPeCNzPx5q65qXgXWpUZV626HZ+sCdW1tzeSmkqZVrkaEI7+Z+3zPbK
         UWO9sJlC4cwbiPfw8AoNHVhuCBhQl4gjU4uNNRNE8VIyHE7+6C1KSIxq6//YMwYgEOUA
         Y5gtfrxTpa+GeYTYY/8Ze3/m5eUSQrahDFgPWgCyd4xmDWJULzeglCAIyALZVUEMCX2b
         4UWdV38bJNagvtev1EUAI43EFYDNZyKZtN5fp51ZG77+1QiXjSdH0bWKye3oln5N1neH
         svkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKa+G+WNTHyk8o+xbr/dEWEAIM2ZkisNR8p1GVxWpVo=;
        b=t5nutEcLGxFE6o6uWQpx4fd+imOkRSC5KdPBsjDrSq3kFCEKJaMpFqWTMqPW6qmo4z
         0U/ONVcqfyQHVPKzp50o1hY4jxePacGwa+OIQigiu8uBuIzR2ZxkBSzr3Tkzlfa6YPE1
         zzuYNZ6Rl83Xip9JADVa/0XF0RmYFeLV/DjFUDiZGclXpy56H+QHx6iafOFDMjnIQDw7
         S1GxQv7g78mioRV3pmslC2KWgoTkt5uYKyalL+JN+WI/dCAvNabpq59H4780F6dfYy5d
         xyM+A00mrX13GHZFf0ZQyQUyJMf6Z+4gmiq6z/nClNXS4x5nzAXEi/6NDNkV/FyZkd/Q
         O4gQ==
X-Gm-Message-State: APjAAAWHRysL90LUi4j24Fspvp7RTXTYXTql+FMC2j5RqOvTjc/TeDxQ
        4L50Q+JPXMshNRt9BhlRe96row==
X-Google-Smtp-Source: APXvYqzpBpaNw1HlOn1Jl1PNM6gfssXbj4UcMPr8NMqOQJ/Czl/iUduxSNiZP+V231WzJ3FtdGIAng==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr26198331wru.27.1566893668403;
        Tue, 27 Aug 2019 01:14:28 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f18sm11911792wrx.85.2019.08.27.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:14:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/8] drm/bridge: dw-hdmi: implement bus-format negotiation and YUV420 support
Date:   Tue, 27 Aug 2019 10:14:17 +0200
Message-Id: <20190827081425.15011-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Boris's v2 "drm: Add support for bus-format negotiation" at [1]
patchset to implement full bus-format negotiation for DW-HDMI, including YUV420 support and
10/12/16bit YUV444, YUV422 and RGB. The Color Space Converter support is already implemented.

And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
- basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
- YUV420 support when HDMI2.0 YUV420 modeset

This is a follow-up from the previous attempts :
- "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
- "drm/meson: Add support for HDMI2.0 4k60" at [3]

Changes since RFC v1 at [4]:
- Rewrote negociation using the v2 patchset, including full DW-HDMI fmt negociation

[1] https://patchwork.freedesktop.org/patch/msgid/20190826152649.13820-1-boris.brezillon@collabora.com
[2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
[3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com
[4] https://patchwork.freedesktop.org/patch/msgid/20190820084109.24616-1-narmstrong@baylibre.com

Neil Armstrong (8):
  drm/meson: venc: make drm_display_mode const
  drm/meson: meson_dw_hdmi: switch to drm_bridge_funcs
  drm/bridge: synopsys: dw-hdmi: add bus format negociation
  drm/meson: dw-hdmi: stop enforcing input_bus_format
  drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: venc: add support for YUV420 setup
  drm/meson: vclk: add support for YUV420 setup
  drm/meson: Add YUV420 output support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 251 +++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 164 +++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++--
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |  10 +-
 drivers/gpu/drm/meson/meson_venc.h        |   4 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 8 files changed, 466 insertions(+), 67 deletions(-)

-- 
2.22.0


Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43644C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0C20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wu/evQfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfETNh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:37:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfETNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:37:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so1696939wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6G0MyMU3h5OB0O4nHOQOZaH9nZxvNQnPCN8hItt310=;
        b=Wu/evQfLtHMDRV7nVLyUt9S+NgZOjI0Xpdpf7vk+eLfcfhsI4H8ZD8fg/9is2Heb83
         1iECSj30NX8xy9OQXoOApX7n+lsgz70UoK4txOLhlg2cWvAabO88f0mo/itWsp5Oo1Fo
         k25caGap24naJPEvMoSo1VfTPA6broJ53cy3iY0rnatOlDLOjH5554AZ3HLVlmiN+v+T
         ZEb4p9IPO/9/a+EPo9C7EAAvscMQnIeLCYseDB+rJWbqOf0kbvHXrSKDwbJt2YDDcv5p
         +JPVRDikhVtu9pGNIN/Zill4tpS+6swH5OKWVdyV3M1SGFo0V6NELkfibFcjUaJveo0b
         W+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6G0MyMU3h5OB0O4nHOQOZaH9nZxvNQnPCN8hItt310=;
        b=NTVhUl2OrxZt8Itbxrb18LVtze4I8ecCvyIga3fSMssihngIhKxxJlE/unUCQ0SkEm
         y8zG29DEPzAFWIQQzYZiMT3om18qL5/QCg9LD1fNU3oD/6DofoJPWn+e68sSeNruryLR
         xmv2fbrJUu2yOYFmhj07FHSeMFL29BTBBzk0ThIXkuIzpuFR4aOchOxMBl7axMJ2Zpsg
         LUJh+vxsD6RIYrhPsSt+6YEQjOP+Sg/snzVjW7mwvFXtW3GyyobipB9/oeck7ycRo9J8
         T/qMOVH5KuzElQNp/3auBLHZxab/Ga7s0P3+0fCW+b7BIBL5U6lOyWT6ZKkQzNUWrSwU
         6Ffw==
X-Gm-Message-State: APjAAAULnuEU1wki/61is9Vr4xMhV0KL8AE4tvO+i/X2eFxMdwmrA+mv
        AulH+3yAq6Ua3uYGwyinBVY86A==
X-Google-Smtp-Source: APXvYqyUsx6BWDMbs6M/qDpPzB1MW+xaQ5meKg2UcdD2zHeFLRipUXrqqBZ2pzKqNcgOvybYHGCFKA==
X-Received: by 2002:adf:e845:: with SMTP id d5mr18649788wrn.154.1558359476773;
        Mon, 20 May 2019 06:37:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t19sm12167059wmi.42.2019.05.20.06.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:37:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/meson: Add support for HDMI2.0 YUV420 4k60
Date:   Mon, 20 May 2019 15:37:48 +0200
Message-Id: <20190520133753.23871-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys DW-HDMI CSC does not support downsampling to YUV420, so
the encoder must downsamle before, feeding the controller with a YUV420
pixel stream.

The encoder must declare the new bus format enc encoding the bridge, in
order to take it in account.

To solve this, a new format_set() bridge op is added, permitting setting
a new input bus format and encoding to the bridge chain.

This solves YUV420 setup, but also solved setting 10bit, 12bit or 16bit
input bus format in order to support HDMI >8bit depths.

The DW-HDMI controller is updated to dynamically select a coherent output
bus format depending on the input bus format and on the internal CSC
supported modes.

The DW-HDMI is also updated to support the connector display_info bus_formats
entry to permit forcing a specific output bus format to force, for example,
an YUV444 output format instead of the default RGB output bus format.

Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
is expected here.

The remaining patches adds support for 4:2:0 output and clock setup for
the meson DW-HDMI glue, and how YUV444 output can be forced.

Changes since rfc:
* Fixed small logic error in drm_bridge_format_set()
* rebased on v5.2-rc1

Neil Armstrong (5):
  drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/bridge: add encoder support to specify bridge input format
  drm/bridge: dw-hdmi: Add support for dynamic output format setup
  drm/meson: Add YUV420 output support
  drm/meson: Output in YUV444 if sink supports it

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 127 ++++++++++++++++++++--
 drivers/gpu/drm/drm_bridge.c              |  35 ++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 111 ++++++++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++++++----
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |   6 +-
 drivers/gpu/drm/meson/meson_venc.h        |  11 ++
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 include/drm/drm_bridge.h                  |  19 ++++
 10 files changed, 358 insertions(+), 55 deletions(-)

-- 
2.21.0


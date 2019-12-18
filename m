Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F9120684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qn5PFyKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLRPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:43 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50548 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:43 -0500
Received: by mail-wm1-f47.google.com with SMTP id a5so2343725wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYOvH0H7ibv1Fa6fIrfwGLVBI8jr1NdK0W3XvJiQ49I=;
        b=qn5PFyKE3DoNYy2lkj45emUmQkf0FvtM3hIZDbyNAv6BIrMS9+Q5a7ZjD+eDdyGgK9
         mT6spRojz3xx/PkGBBbORTygEn1qyDpK+cPZx6tIQSa1v1i0UGrUPKV6iEKlgJF33woI
         IFw6VwqFrprWCXoY+k4c+SlRsefk4DsvzbFVTi0C7Z0dftniGS8/Ng4y3c4uLXgW/C2d
         WtwKQcCGci9AlmTR1A9jMn2mGeUY3r+CnLAtvOZsn4huMJeVVpArVJZF5nSCbur9dXWH
         J2V0ywVyLcLjKi3kGUN52iSvmEqwgq1zIV9UKhIHJj6zEJ6L+ntOZersakaqSO2G2TMR
         jEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYOvH0H7ibv1Fa6fIrfwGLVBI8jr1NdK0W3XvJiQ49I=;
        b=ub4HLLqf+F6PYPEdAln6QyLkv+VlIyuNqptJNk/8Fjn2HCmQ+H0sqT1vCy3x2NuVOZ
         S/8pf0JQwL3p9fav6oAk3zOx2N+sLE6pCByjKOAi67TNOSN2p7y6fNfrB71RDBms619+
         bUP48xjd0leVFoTHXLj1cKF7o4UomUYCVKQ3oq3tvOdmRYI5p4CHNjBad6hfDgR96rQR
         5I19j3pllg38fCL4Sf/i1I+Xh31KaWqhwljAE9b8l+hlM3uSFlWVD5IBMIQB07d5YBb0
         URH+k5uE3GVM4dt7erLg80IpBb637rnAwxk022mbigBkCDT0a5Na09aHDdIHdzljVBVY
         AGOA==
X-Gm-Message-State: APjAAAU1vhYTqWnEX8Yn4ZfG8dJxyijuRGt8zSbCaK5S/+ZJxwTxP1jW
        65Jf6ntMNNGQ+3R455CfPd5bHw==
X-Google-Smtp-Source: APXvYqynj1gVzQckDYJahebhiIXEraU4mydUqgfPMFSx/RvYApGRfUTi0R6a4jGnTRdhXKN439p/7A==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr4253923wmf.136.1576684000195;
        Wed, 18 Dec 2019 07:46:40 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] drm/bridge: dw-hdmi: implement bus-format negotiation and YUV420 support
Date:   Wed, 18 Dec 2019 16:46:27 +0100
Message-Id: <20191218154637.17509-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Boris's v4 "drm: Add support for bus-format negotiation" at [1]
patchset to implement full bus-format negotiation for DW-HDMI, including YUV420 support and
10/12/16bit YUV444, YUV422 and RGB. The Color Space Converter support is already implemented.

And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
- basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
- YUV420 support when HDMI2.0 YUV420 modeset

This is a follow-up from the previous attempts :
- "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
- "drm/meson: Add support for HDMI2.0 4k60" at [3]

Changes since RFC v2 at [5]:
- Added fixes from Jonas, who tested and integrated it for Rockchip SoCs
- Added support for 10/12/16bit tmds clock calculation
- Added support for max_bcp connector property
- Adapted to Boris's v4 patchset
- Fixed typos reported by boris

Changes since RFC v1 at [4]:
- Rewrote negociation using the v2 patchset, including full DW-HDMI fmt negociation

[1] https://patchwork.freedesktop.org/patch/msgid/20191203141515.3597631-1-boris.brezillon@collabora.com
[2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
[3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com
[4] https://patchwork.freedesktop.org/patch/msgid/20190820084109.24616-1-narmstrong@baylibre.com
[5] https://patchwork.freedesktop.org/patch/msgid/ 20190827081425.15011-1-narmstrong@baylibre.com

Jonas Karlman (2):
  drm/bridge: dw-hdmi: set mtmdsclock for deep color
  drm/bridge: dw-hdmi: add max bpc connector property

Neil Armstrong (8):
  drm/bridge: synopsys: dw-hdmi: add bus format negociation
  drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: venc: make drm_display_mode const
  drm/meson: meson_dw_hdmi: add bridge and switch to drm_bridge_funcs
  drm/meson: dw-hdmi: stop enforcing input_bus_format
  drm/meson: venc: add support for YUV420 setup
  drm/meson: vclk: add support for YUV420 setup
  drm/meson: Add YUV420 output support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 299 +++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 193 +++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 +++++--
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |  10 +-
 drivers/gpu/drm/meson/meson_venc.h        |   4 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 8 files changed, 538 insertions(+), 72 deletions(-)

-- 
2.22.0


Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C721523958
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bfTxW2jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfHTIlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:15 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46358 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfHTIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:15 -0400
Received: by mail-wr1-f51.google.com with SMTP id z1so11449566wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYkJZ7ygqpGVyziIAkPglTpFbYkqx1ZCclLUpHigUPc=;
        b=bfTxW2jv1ZNeSc5mHCdK2zcQw/vzn63re+UOQJv+x3SzSIXCNj48qza9cBPl33mDur
         fkd7FSvNI6j0nQOMXHlNy2RKNW/OAblqxe7e3Y9a9CD+6+mnxhINF4+inEG08sYdYli7
         yGUF1VmcEwSQh/uY/uOXHL9L0NQfcBmNFYSlnCmY8/bo+nDUXnnXlOpg40jRsU/FCGLY
         syOe1ZtHCv9HilqtHXRrilzK079KfD+/+7J1KnrufjX3RmwISfiIlMZ370rda3isfo//
         A5jasBfjs354i7zIkKR6IdINsDYQsn2ufZj5K52QXgETl25iF1t25rlKXgj7KdQ+QcwA
         TNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYkJZ7ygqpGVyziIAkPglTpFbYkqx1ZCclLUpHigUPc=;
        b=oZGjnivAcCg3SjGipEhvvnSWB1BdoLkaZWPl3H7UL+Bp9hrQcM+NNdLpB5SLcN0AFR
         4fO7HfmZ33hz6ZlxwV7b3knz46T20aZsNW8iuTf4EucIPglhY8HEgJiZAHuPaKtfOZ3m
         Gt2G/utaNSPri3DxbzyKLiR2YKOzQJxF7BcrNec9ui5ApyFuZm6GU5W/6870LsULSaOv
         4oVd2uGcWuqFL15fkb3tYF31967Z+24Pfgfnyn/4oP0Pwjj0kxB1NWHakkA1O9L0dgwG
         RxmmV0RSCr2FfbpAB5b0gGwel55sqWqWtvoKRqaoz1Aj16kRHYTgAqWh9IzvYIOGDZ53
         4uXg==
X-Gm-Message-State: APjAAAU7TT2gwhdh481t4+8AZn/q1RRz/orLPjf/cHpQsnySzol9kuGo
        LfAxPOTwdQPPjBhJcae22OrF2w==
X-Google-Smtp-Source: APXvYqx2KIAs3etJ5JAW81f4A9TpNQ2I/pe1woSnHDb8DN4a16tSMefBVnJ06dg+YaHBCRBfu4g3Uw==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr33798582wrs.88.1566290472758;
        Tue, 20 Aug 2019 01:41:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 00/11] drm/bridge: dw-hdmi: implement bus-format negotiation and YUV420 support
Date:   Tue, 20 Aug 2019 10:40:58 +0200
Message-Id: <20190820084109.24616-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Boris's "drm: Add support for bus-format negotiation" RFC at [1]
patchset to implement :
- basic bus-format negotiation for DW-HDMI
- advanced HDMI2.0 YUV420 bus-format negotiation for DW-HDMI

And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
- basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
- YUV420 support when HDMI2.0 YUV420 modeset

This is a follow-up from the previous attempts :
- "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
- "drm/meson: Add support for HDMI2.0 4k60" at [3]

[1] https://patchwork.freedesktop.org/patch/msgid/20190808151150.16336-1-boris.brezillon@collabora.com
[2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
[3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com

Neil Armstrong (11):
  fixup! drm/bridge: Add the necessary bits to support bus format
    negotiation
  drm/meson: venc: make drm_display_mode const
  drm/meson: meson_dw_hdmi: switch to drm_bridge_funcs
  drm/bridge: synopsys: dw-hdmi: add basic bridge_atomic_check
  drm/bridge: synopsys: dw-hdmi: use negociated bus formats
  drm/meson: dw-hdmi: stop enforcing input_bus_format
  drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/bridge: synopsys: dw-hdmi: add 420 mode format negociation
  drm/meson: venc: add support for YUV420 setup
  drm/meson: vclk: add support for YUV420 setup
  drm/meson: Add YUV420 output support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |  97 +++++++++++++++-
 drivers/gpu/drm/drm_bridge.c              |   6 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 135 +++++++++++++++++-----
 drivers/gpu/drm/meson/meson_vclk.c        |  93 +++++++++++----
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |   8 +-
 drivers/gpu/drm/meson/meson_venc.h        |  13 ++-
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 9 files changed, 295 insertions(+), 68 deletions(-)

-- 
2.22.0


Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1D720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jc5/ErcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfC2Kmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44415 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2Kmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so1951075wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjoUxT2gkADqHwB+nNuWWmWXvp2B9McV9Ra5Ovdxhsg=;
        b=jc5/ErcRbqTGWc9QbkN1Y6HPztAcnWwu8U9zfE/caCAKzasJm4w88E9CN1Ep9q/D7F
         InpIeAcNXTu8p8ceBfTR73GOpIAKg6NH+wd+8b21uPS0SJ29kuw6jgOvyU95ZzMXq67K
         k8WWBAeFjPH4iXY3mn4mQQs5Q//sjdqu589v43/75QBvSWYqcVhoVxIBONBAAITZIXLs
         nfDVO2XIdBZmfqM6uCBlUU+3lT0aiX8FJcd67eSqSNY2SsNPbycBCbkjTUyfySdgmxeZ
         lmxVaNtuCXdFG2/2D4k+Kbku48BUmCon4d3EW1CoJnz1SOj6kRtM1wquzdlziaBiftlm
         5lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjoUxT2gkADqHwB+nNuWWmWXvp2B9McV9Ra5Ovdxhsg=;
        b=XtfCC0PvoPFMn8UM8QIORbCqCLD+CKfxA1B4rLcG8rSRnMluYqboioV72xz0sDLHNs
         s78wdkUR8QFTk7yX8JVxRK9+sM3kDjHeMAa/sJVBk9yb/XE/HDmOwYxuVpKyFsYvXTm9
         iTpdEIUpNnF393Ms65zDTXt+dREDxgUArkpNAMrKzaQvsWnFo+y+MuHDkQKJaYYUr5pU
         XYxdqoBvfMtGnMvr9xQfPXPVXXfP8msCEJWyMUL3RDItteCN8q43QHcGSETxyf3Bl7gY
         dWNqlva0YASp8wXvJQj4wQLX0otx7Hv70db61Jf3Z1DzR7VnJ6hY5MFNkBN05Javez4g
         H1pA==
X-Gm-Message-State: APjAAAVeC9E1wAJOZJuFGNZtX622GylQZhNY8a/Tl9IA5ULD7TRzhoN7
        Du+h+YjvhPsq7/m3aHP4dCZ0Nw==
X-Google-Smtp-Source: APXvYqyWb9L4wJ7B4TwT3YXN62UrChbKBqVp9DXuulQ+v/QLIQ0nGS8u4lI1P+KeBfI8cUT3mZ8s3Q==
X-Received: by 2002:adf:ba81:: with SMTP id p1mr29266278wrg.192.1553856162947;
        Fri, 29 Mar 2019 03:42:42 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o15sm1632826wrj.59.2019.03.29.03.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 03:42:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] drm/meson: Add support for HDMI2.0 YUV420 4k60
Date:   Fri, 29 Mar 2019 11:42:35 +0100
Message-Id: <20190329104240.29585-1-narmstrong@baylibre.com>
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


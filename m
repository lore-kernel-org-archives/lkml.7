Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA86AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F9120651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZSHKMJha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfHLMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42397 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHLMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so7627497wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMduQLcYqJa9E1xoRdmMO8whZQuhJA1DUXAc3zPrO3g=;
        b=ZSHKMJha6yfzKyUtd06NcDFZ3gN6HThtYSZHVhI1dWDon6ToPzcz/3Own8XjxQ6mgY
         cNZxnu/TVZ+61qFCnUFdEJLOgky25gQCDhsH/+hNfvo1/tuwRFVAYIZ0rlF6tlIm0KyF
         iUCMnmfJERpt/DBw38nE6bUD0UhHm32KkD+TwpX8kS784VDRNuZ4zM0XGH1+eHhHNIGF
         rfG1P9vlqoj1SknmEStYhp/BpCNJvZPevmhinSS3o/GeDoPPCkItQDqi5o7p0o/Z19H4
         V/l1fiLnkQUc1tJTXSRA6hZMqewIKizbra1XnWkTwB1TSx5TgqY0slk6QhUZjZoyT3JS
         G5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMduQLcYqJa9E1xoRdmMO8whZQuhJA1DUXAc3zPrO3g=;
        b=cY1BkikArC17L+ilPJfXyOSOjvzTNQgnUOZAXsq9FleDFN/xO51cIOHufZrxL7r0jV
         Pf1BFl3qLEKbCIQ1yPay2KzQijxS+vd9sH1HDYjfaCJ36Z/4KX9I0fnMXR14ZBqZAl9i
         PMvOMP4ILFLjVcwl34vElzN+dAnPJrkVSNczptwfm4jSZlTp5so0GBC+4C+TjHaqQ3mq
         YIe9LLhGVvf0QI/8HrRWmUDiK0PiKR2ANDJL1mpRLkCH0SpItZU+ctphTDyhyoWo7ha9
         Gaguwn0eApLN+7vghLH9fIMyT8Z0gPoB9oHim/xa7lpK5mdd7nmmGSJgzNsu2WsrFc3i
         OEJw==
X-Gm-Message-State: APjAAAVik3IhjArCsApqcwyVWtRRgB0vFc3dnJZHUm1FIRTbq/YtNLmC
        IRAyyWbEj7FL6+fdfLhpOPf/Eg==
X-Google-Smtp-Source: APXvYqwBXFdcnSm3N9WSnk3H4/5r6eeqaMC73NAcum/+jEQe399Q3DLr4ex5iwjbxozzlPA6mgZt0w==
X-Received: by 2002:adf:e887:: with SMTP id d7mr24777870wrm.282.1565611649905;
        Mon, 12 Aug 2019 05:07:29 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/8] drm/bridge: dw-hdmi: improve i2s support
Date:   Mon, 12 Aug 2019 14:07:18 +0200
Message-Id: <20190812120726.1528-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to improve the support of the i2s
interface of the synopsys hdmi controller.

Once applied, the interface should support all the usual i2s bus formats,
8 channels playback and properly setup the channel number and allocation
in the infoframes.

Also, the dw-hdmi i2s interface will now provide the eld to the generic
hdmi-codec so it can expose the related controls to user space.

This work was inspired by Jonas Karlman's work, available here [0].

This was tested the Amlogic meson-g12a-sei510 platform.
For this specific platform, which uses codec2codec links, there is a
runtime dependency for patch 8 on this ASoC series [1].

Changes since v1 [2]:
 * Fix copy size in .get_eld()

[0]: https://github.com/Kwiboo/linux-rockchip/commits/rockchip-5.2-for-libreelec-v5.2.3
[1]: https://lkml.kernel.org/r/20190725165949.29699-1-jbrunet@baylibre.com
[2]: https://lkml.kernel.org/r/20190805134102.24173-1-jbrunet@baylibre.com

Jerome Brunet (8):
  drm/bridge: dw-hdmi-i2s: support more i2s format
  drm/bridge: dw-hdmi: move audio channel setup out of ahb
  drm/bridge: dw-hdmi: set channel count in the infoframes
  drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
  drm/bridge: dw-hdmi-i2s: set the channel allocation
  drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
  drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
  drm/bridge: dw-hdmi-i2s: add .get_eld support

 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   | 20 ++-----
 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  1 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 60 +++++++++++++++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 37 ++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     | 13 +++-
 include/drm/bridge/dw_hdmi.h                  |  2 +
 6 files changed, 108 insertions(+), 25 deletions(-)

-- 
2.21.0


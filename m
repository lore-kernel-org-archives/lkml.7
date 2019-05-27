Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5799C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9060D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pL7P5sxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE0NWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39597 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfE0NWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:04 -0400
Received: by mail-wr1-f46.google.com with SMTP id e2so8161837wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceESg/eKh3AFRTY/CoikatuHiURoMtYj1sjsEX9yO6U=;
        b=pL7P5sxdTymgRwuekufB2BnC0rYT3DA5TwwbEf7Pj1MjS8ySUQGGlE+2IdmRDj8R+K
         yBpY4NqNt+3Msd+CgPPjrf7Q1oLbHCckxKoh4q1jv7KwA4xkzZPaFtiYEYOt7My2ftZf
         /TUv+SjqfUwVOJcarvVJdCVI1IB6+UI5pe8Wak7Omns6Tx71a4PgnenCCuDZpuvkcPV2
         V+LBUzlwnv/Ax0WpMBhdda9KiIU0j8ojL87E4Vxvlk1aY6baJZXCeP2TTO7iMFsjg6MT
         GaLKGYJzenfzBUfJnsIuyeerxlrD5W120cwDGpwaoo9HU9ljDDH+6p3UPSaqeApeCSTU
         kMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceESg/eKh3AFRTY/CoikatuHiURoMtYj1sjsEX9yO6U=;
        b=ZnKmHcOpt1g/JAn/RtZ2njd0DpIbQ7kGKkd3POVyCTxt1N5bOJ4XffU+CJ5+UlCjjC
         HD3j09R/1/t8FilG6pbEePy0Mwg362OL6coHGkBcJqQWz61TLgbfgix03qn7lQAROHx9
         8CjHajjyoHJbZ+aOgOErIZW8Im0miuXmMnGwydGZcuxI4zAL5Xfm5yQ0M8QqfCgGLldN
         xO8UTnWG+nEi2UpBhnMqZZFFTEngLJeMDEL6iSYkqXVvMtZ71VCyiK+yZgGYojZlweed
         xwvseYpVesTAlZ7UXurRlKOi+dkhA1S/6jOAeHnoeshX0MdgWE01F8xEBfXtBEkJ+6R+
         sndw==
X-Gm-Message-State: APjAAAXITn9KoEQwt2nTtqX5jIb3XAobNPgy3LuK/LA24+IqDd5ktJZN
        C927EKeHcBEIFsBNkxFWxbgedg==
X-Google-Smtp-Source: APXvYqw8//NOue/uv53owng3Us+VdU/FIm6rd0GP8DuDacGdnKIg8lOUGR+mFyaTqXKuPGWsHwvI0w==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr2479722wrm.353.1558963322561;
        Mon, 27 May 2019 06:22:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] arm64: meson-gx: misc fixes
Date:   Mon, 27 May 2019 15:21:50 +0200
Message-Id: <20190527132200.17377-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- Fixes GPIO key DT on Khadas VIM2 board
- Fixes regulator naming on Vega S95 board
- Enable SARADC on Wetek and Vega S95 boards
- Enable/Fix Bluetooth on VIM2, Wetek and Vega S95 boards
- Enable CEC & HDMI on Vega S95 board
- Adds ethernet PHY interrupt on Vega S95 board

Christian Hewitt (4):
  arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled node
  arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
  arm64: dts: meson-gxbb-wetek: enable SARADC
  arm64: dts: meson-gxbb-wetek: enable bluetooth

Neil Armstrong (6):
  arm64: dts: meson-gxbb-vega-s95: fix regulators
  arm64: dts: meson-gxbb-vega-s95: add HDMI nodes
  arm64: dts: meson-gxbb-vega-s95: enable CEC
  arm64: dts: meson-gxbb-vega-s95: enable SARADC
  arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support
  arm64: dts: meson-gxbb-vega-s95: add ethernet PHY interrupt

 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 93 ++++++++++++++++---
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi    | 25 +++++
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 13 ++-
 3 files changed, 112 insertions(+), 19 deletions(-)

-- 
2.21.0


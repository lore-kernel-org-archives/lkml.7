Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E26C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7740822CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="InyAM+eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfH1OSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:18:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33888 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfH1OSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:18:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so4971312wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UzxOv9a1WpCmhrklx86JwpkfaDfvwrG6kiqiVDTvh8=;
        b=InyAM+eBxP789KoA4ZICBi+cmdeIndVhj47o4LSbHLn4Fbycg6rBCQCRhzjRwisFL2
         pRGD6mbfhSnQYdPQ3gsHGvDSlrVTrgGj8vggeQkCJnDQjQwc1Y3InouJKnMiiZigl1O6
         ohHtZmvF6HKUX5HXz9UCe0b9BI4bkDItjqAa67MUfNCf2JheMOZiKSIsxmKP5nVGFfEO
         HOrBtIlTYLHCwi8akzyAQESIgtLN4ecMEFQJPJQfMlCZRPH+GK4rkniEPKz+nmq6VQqn
         AVRxJfrhyLPpGl2BH7w21znbHR3yYW+qkDPbB6sgToExYp65aI23lB+/0orNQgrk1TF8
         BkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UzxOv9a1WpCmhrklx86JwpkfaDfvwrG6kiqiVDTvh8=;
        b=kqiQCA5U0KSkaGr5VqYP/A/a0ehZFT+WcaT4kaB/lzRd6Ib8iO4e8W5sWsirJSorjK
         bIf67GbJioiGCg+SxhNxkpXijQoTekNrJpn31YAzJO+8sqWqptLx+Uj8vcS1rs76Pwn4
         Wjz3a4BNBgIeiV6Txe4PCu5ZPkG9vkOYt8/k6DNOjx7tMlEOSUkewskVIQ/rQFV5u/Tm
         2wDpWkInKZyZVlspIi/h0jxGYFrUg+YWnziNTsiyFne7SwMWvjrdZEvatY3ABvC5Mnjx
         /EE+DT3a4uDwS5lUbvCC3FT6sWQKQwSaZCOXku9S2vEudibZQVe+gmmkz1oXSQyPHxnT
         qkpQ==
X-Gm-Message-State: APjAAAUa6bfI3kuR3ozgqmYnzRJ1mIXHXTUqnhs3AMjaye0RgM20WCI+
        u4grf4ddE8uqPXCcusYPNsSMFg==
X-Google-Smtp-Source: APXvYqzrySHRNxXc1/MJermkli4siDaCGLmKsgijOLkdZqypQgEKEf3uxKd1T4Y6b6UUSc1TCpEf5w==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr5430764wmh.116.1567001898683;
        Wed, 28 Aug 2019 07:18:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u8sm3022354wmj.3.2019.08.28.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:18:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: meson-sm1: add support for the SM1 based VIM3L
Date:   Wed, 28 Aug 2019 16:18:13 +0200
Message-Id: <20190828141816.16328-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Amlogic SM1 based Khadas VIM3L variant.

The S903D3 package variant of SM1 is pin-to-pin compatible with the
S922X and A311d, so only internal DT changes are needed :
- DVFS support is different
- Audio support not yet available for SM1

This patchset moved all the non-g12b nodes to meson-khadas-vim3.dtsi
and add the sm1 specific nodes into meson-sm1-khadas-vim3l.dts.

Display has a color conversion bug on SM1 by using a more recent vendor
bootloader on the SM1 based VIM3, this is out of scope of this patchset
and will be fixed in the drm/meson driver.

Dependencies:
- patch 1,2: None
- patch 3: Depends on the "arm64: meson-sm1: add support for DVFS" patchset at [1]

Changes since v2:
- fixed patch 2 subject

Changes since v1:
- renamed compatible to khadas,vim3l
- renamed DT file to meson-sm1-khadas-vim3l.dts

[1] https://patchwork.kernel.org/cover/11109411/

Neil Armstrong (3):
  arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi
  dt-bindings: arm: amlogic: add Amlogic SM1 based Khadas VIM3L bindings
  arm64: dts: khadas-vim3: add support for the SM1 based VIM3L

 .../devicetree/bindings/arm/amlogic.yaml      |   3 +-
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |   1 +
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 355 -----------------
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |   1 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 360 ++++++++++++++++++
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  70 ++++
 7 files changed, 435 insertions(+), 356 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts

-- 
2.22.0


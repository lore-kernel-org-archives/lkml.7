Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A4C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F89620882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cRqLzJK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfJNFcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:32:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45501 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNFcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:32:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so17987012wrm.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VV3IaZnskbUr1GiFO2X9yDGhA134LORR3NXQx0QiOlA=;
        b=cRqLzJK9lJrzLH1r4rNUMpRvPCQQKB5rPJ5QPg7YyDp8fMfycNYirondsQkTjFceJ6
         ioRTE6ZkDNPDXDmCf6sTrknQZiOwRWOksZXeJEd02Mj5bccyQkq3nMd1FAR3Pl2k2Uvg
         5g7rTSB/9hCW3YLuNKlwgkVri0Uu+3vwu3vLvtCSmmxV+PSAp4ZQFZHZNNx0tYJ+buAf
         Imgshxznob8AnLOBG/3Ks6qNfWlJ7S9sw3a6P9jk8Osn1lkzKvXDVCSSmzPoSP53bhON
         7QdhfrUpN14Rd9ujAvdrOuon50Yj8UUUEz0SsI9F2u1JCT8xgQLyOkQi8Vi9HTl2Qa+p
         pUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VV3IaZnskbUr1GiFO2X9yDGhA134LORR3NXQx0QiOlA=;
        b=cmZ3IM5Jr8WlcSR5m/AdZePW+RqgUj9hRePvILIIyxTmLacfeQOrqpLROlA7Tn99dl
         7jEDb7vKMy1dh3MKQDEjbURLCp0hsK7hl3sibsLyiRhSnjOQ/s56m2BfefuWivaLt6Ti
         Y9G9KqeXGFDMXLEwQI0S8PTRJzeGc/uyoUo8WK0MtujiqxB/FxlW6wMA8B6cpphudZVH
         feG61o9t5IO42agmv8Bs//DjPm0Nnt7MT4pbC6965SlmKpd4lCk70Xf3EpqsF8MJi5yq
         E3s6kINssOzABIttgr7tREOiKXDmw3KHT3lRzPOZIiFvoJJI/3LSPR/rjklG5H0EdniB
         qtCg==
X-Gm-Message-State: APjAAAUx69Zf8JMUa3SZd/EUDY4x0Mt9h5qCaoXTbgXh19THhlEjeBcb
        JO+ijyNn+9kvabQwtCNxEp0hy7JYJ7s=
X-Google-Smtp-Source: APXvYqwaGzOSKxB6TEqQpVVf3oyhcigvwBtITeEf+3ldzPzepGPpOShz3H63eqnPZOaXvDvtl9vrWQ==
X-Received: by 2002:a5d:5488:: with SMTP id h8mr24154767wrv.284.1571031124058;
        Sun, 13 Oct 2019 22:32:04 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id o18sm44238772wrw.90.2019.10.13.22.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 22:32:03 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/4] crypto: add amlogic crypto offloader driver
Date:   Mon, 14 Oct 2019 05:31:40 +0000
Message-Id: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This serie adds support for the crypto offloader present on amlogic GXL
SoCs.

Tested on meson-gxl-s905x-khadas-vim and meson-gxl-s905x-libretech-cc

Regards

Changes since v1:
- renamed files and algo with gxl
- removed unused reset handlings
- splited the probe functions
- splited meson_cipher fallback in need_fallback() and do_fallback()

Corentin Labbe (4):
  dt-bindings: crypto: Add DT bindings documentation for amlogic-crypto
  MAINTAINERS: Add myself as maintainer of amlogic crypto
  crypto: amlogic: Add crypto accelerator for amlogic GXL
  ARM64: dts: amlogic: adds crypto hardware node

 .../bindings/crypto/amlogic,gxl-crypto.yaml   |  52 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  10 +
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/amlogic/Kconfig                |  24 ++
 drivers/crypto/amlogic/Makefile               |   2 +
 drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 381 ++++++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl-core.c     | 333 +++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl.h          | 170 ++++++++
 10 files changed, 982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
 create mode 100644 drivers/crypto/amlogic/Kconfig
 create mode 100644 drivers/crypto/amlogic/Makefile
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-cipher.c
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-core.c
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl.h

-- 
2.21.0


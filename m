Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986F02189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pc2FgNUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1OMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:12:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:12:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so231489wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1KAv8pKi0AoAgvfh+n5R42Iglf6I+wQt55KJGFF0fM=;
        b=pc2FgNUQUjmKwzqDzFdyQRbg8Pz0IJ1f67uI8PAy3R+CZy+hUqM5zfcBwGGC0RoBeZ
         +R0k3wlkOb2mxbERi6LKxTZZzNQu4F02boiRkENQKTIvk9fBBLIYpfPbgaADkVqMgSCJ
         V1snUwxahhr3Mra0ax3jiesoRcDHZvl5OdK0wonGTm//SQCKQWwaX+n1REV0O+KdfyqD
         mn8DjWAWkOKYSfHlaRQ7tEDhtYXRekb7UhNMdiz86p8XFnanbwHRSK/wRzlX3zjD0yAi
         rSgrbYyRggylCIaxeMZ2SQxHL6BiJv3ReBDfNsga+HY/LeH7EXiW/l97aHRxzYH7MkP2
         j4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1KAv8pKi0AoAgvfh+n5R42Iglf6I+wQt55KJGFF0fM=;
        b=DUTCOiJnDSiVGkar2EYncXhc8GIUV3jYdeaQlXCuMRauUL9H2dGKXEoN0UZ9dd0uq3
         ii3YbuCnH6U2RCtRfEsUc4kGojS+AxL++dktSlISv7rVMC3ue2ifG9ackKWfyW2+eE4d
         6HGdJuWtr1dMz8b/GkLIhRXSa4Nl+SVUlATBBT/lH0KptJdeiylRbw4qzF1TZwAHnMDh
         ZDnFg0bu4xWRPFS3XMMPOSbAJfjjdH/AbpeZsJW5jnJaQnUffZxGYovwZJPrsnTmqwBT
         nnOs5wED3YqzXHqeJydw9z3WpiJ6T95wDo54B1KiQDVhWlF0adphDnpwCDXvDrqOCutg
         6hRQ==
X-Gm-Message-State: APjAAAX4S6K2AQyUEs2k53lBXasnbiu1/NegurToXOpzAAT7MJuwvKJt
        FkyGu0jnJzry8nw7BjrYExhMMayDWBOikQ==
X-Google-Smtp-Source: APXvYqz96TmPPVEmMTQIWd5o34VAawuoSnxOtUnJnMiSj9qw7YFhgfiDwSSFrKcnrJG3/uC29Gpqlg==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr4911436wme.37.1567001519544;
        Wed, 28 Aug 2019 07:11:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a11sm2774838wrx.59.2019.08.28.07.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:11:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: meson-sm1: add support for the SM1 based VIM3L
Date:   Wed, 28 Aug 2019 16:11:54 +0200
Message-Id: <20190828141157.15503-1-narmstrong@baylibre.com>
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

Changes since v1:
- renamed compatible to khadas,vim3l
- renamed DT file to meson-sm1-khadas-vim3l.dts

[1] https://patchwork.kernel.org/cover/11109411/

Neil Armstrong (3):
  arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi
  amlogic: arm: add Amlogic SM1 based Khadas VIM3L bindings
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


Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADEEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF30F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkCviyy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDHJWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35259 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so15477051wrp.2;
        Mon, 08 Apr 2019 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eglxzyi8Y0ExXgfag6n4PLYaCDFn1gb9oEeU6niqzYE=;
        b=lkCviyy5Y1vmd6Jw05AG1d7BLbOwZoXOFzI+LIxetFMOMG3zRDtl86V/6rABrrf9Zb
         b4lt6X9jiEDaNJWzOeZ9G83Tpu5wzCfQa3b9mjC4hn9GpX3bRqa55IILtJucfMu7ysel
         yMiqCzQK4Uv31Bvge+36BGAdm9hJ4s9I8+RXGOoDFHtLVFL3ZJkLmT+qfo3VopfH3Lac
         JHogT5WPTELZ2/Rwa7mfOi/9LZ9oYJPVGXLvDp61cTStRJxU0e+0XC+qI8lH4hh05wvy
         6Go2s4kcV1xlyOQbEr1xqbNFgcVJU0QglSJO3DwkPciJaBWsMaeXoytkgK4PDGPtimoo
         sGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eglxzyi8Y0ExXgfag6n4PLYaCDFn1gb9oEeU6niqzYE=;
        b=rPJEsdiDpM/9CjDWns9SQBnOEOA2Ja/3naF6Bd8Qgh8J5HkhwmxanKvyii1CYfJbrk
         oNVzPKv6Va4+ZCci1NZoWn2xwiKZ8ZL+pKgBKt6tNnCfL6NGK0BQ8n6IrPtJHg/k+ulc
         obAACakcHN43E/MHy9fhOXyRe3feIByLBedTvTvQC/1SOJrkVUGjPJeXA4yeiXrYNZUV
         DGSFmNl5Lyvju6ShVzij2AIQ5PcM5RLyMUVno2HZbbWq3tamGkGV3HJ2r2YmIiJHkhjt
         VsYW/cJDj9d9hG3GvRUU8Z+l+CROsQSmFd7PseWnhUT7O7y5osvSquBo2DhqkRkchER2
         XRRQ==
X-Gm-Message-State: APjAAAUzan8t4tapkQ/JHd5/OY0RqS3emV+awY1rXpr/GSCiMPIwvkt4
        s4OsFTca9e+aeW7iyECY25E=
X-Google-Smtp-Source: APXvYqxW5EMi1F/T9cXcFGv56ao93tFL/jGMS+VgU/NmMzPoqc25UjV3tvI7jC+I74uLgw+mfZ9nhQ==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr17430179wrj.0.1554715347661;
        Mon, 08 Apr 2019 02:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/6] Add Beelink GS1 Board
Date:   Mon,  8 Apr 2019 11:26:13 +0200
Message-Id: <20190408092619.23152-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Jagan and Icenowy, most of this device-tree is taken from their works on
the OrangePi One Plus and Pine H64.

PLEASE NOTE that I don't own an OrangePi nor a Pine H64 and PIO regualtors for these
board has not been tested !
Please add a tested-by on these commits 5 and 6 before merging it.

Changes in v3 (Thanks to Maxime Ripard):
 - remove PL regulator
 - separate patch for sunxi.yaml
 - collect reviewed-by

Changes in v2 (Thanks to Maxime Ripard):
 - move MMC pinctrl to SOC dtsi
 - add board to Sunxi YAML file
 - add PIO/R_PIO regulators
 - remove always_on from SDIO regulators

Clément Péron (6):
  arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
  dt-bindings: vendor-prefixes: add AZW
  ARM: dts: sun50i: h6: Introduce Beelink GS1 board
  dt-bindings: arm: sunxi: Add Beelink GS1 board
  arm64: allwinner: h6: orangepi: Add PIO regulators
  arm64: dts: allwinner: h6: pine64: Add PIO regulators

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 262 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  19 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  21 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
 7 files changed, 307 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts

-- 
2.17.1


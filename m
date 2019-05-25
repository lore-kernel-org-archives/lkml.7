Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22BC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACBD21734
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA1ETWwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEYSJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:09:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34991 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfEYSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:09:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so12958037wrv.2;
        Sat, 25 May 2019 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arTMrDnZfRr2oC1YgiWwIELzhnqDrvGvkslS7X+mMzM=;
        b=hA1ETWwq1RFBgDXp0XWT3rlQ3Bx3tpvsW2EE7raknAvoDXNzyoYA0j+i8HCVZmc6yi
         yEp9NzEFFne7+6R3HHR8IGwD7XunbJDXrKd+PXcPqGrU6ybNXKaK9ICB34zGJcd2Xv3M
         ahOUapJrs+00YIS4U3AdFwvYkfXQIrwjw0DCA8E3+O3WY+naic1C/czUPt0l6T5DlDrq
         VaLMLdLWeSaN40yxzmkZuBn6IPi7OsM7z7+xi0sAEjUp1A350K6iaCogHORkdVZqz279
         LYFNgNldW8dZCrqB9qkWLmGhngvEJsYCQOTgLKKzhQcwLaLEtGGPDCJWJOAylxklbx4/
         tieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arTMrDnZfRr2oC1YgiWwIELzhnqDrvGvkslS7X+mMzM=;
        b=jV3bAXHHgXq3/QUCgC/Q2x2SfZOWSrunjOLcJ6vlDvCW/OaO92zooSmdzHTTyOKjkY
         lR/EK0sbpo8+XaPxjvmzSLlFrNJpwvPxEFVu+jKwamDZdtYtEl4YG4Zejy4MXdNt53bA
         ikwwCHxODxh83o7aLNhuu9za4blaO7j60avnqxtI+gVpL26nEgX01L1BD087C3l/ZL4O
         MEXrJ8eb7zkkO5BkQbOk8R2wJ4PHHihGRfMhZlmaN/u7NsuIC3P2JBXzrzsmt6DIcDTE
         GgwLDd2mgNkVJLrHlALyWmSGExzPVPNjbE9LZBHxHHA5Xv6t5xMHPwBHXBQsrMblN9gL
         7vvw==
X-Gm-Message-State: APjAAAWz2clE90tKMhWMoz0iu6QL4oCAjB1smcDuVMIHWYjTtYIrZ/XD
        lkMz/i6u5Az4aeQtKwknQZLuol9Vm/Qppg==
X-Google-Smtp-Source: APXvYqzwGqeGwmwYPdmQPkcptYHBYFkXN5Iham1dBSArtqgGwT0omke9cxGVq8Sux1JvKcwJUpXPJg==
X-Received: by 2002:a5d:624c:: with SMTP id m12mr3990228wrv.354.1558807769625;
        Sat, 25 May 2019 11:09:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm5656914wmf.48.2019.05.25.11.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:09:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 00/10] Allwiner A64/H6 IR support
Date:   Sat, 25 May 2019 20:09:13 +0200
Message-Id: <20190525180923.6105-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A64 IR support series[1] pointed out that an A31 bindinds should be
introduced.

This series introduce the A31 compatible bindings, then switch it on
the already existing board.

Finally introduce A64 and H6 support.

Regards,
Clément

[1] https://lore.kernel.org/patchwork/patch/1031390/#1221464

Clément Péron (8):
  dt-bindings: media: A31 compatible
  media: rc: sunxi: Add A31 compatible
  ARM: dts: sunxi: prefer A31 instead of A13 for ir
  dt-bindings: media: sunxi-ir: Add A64 compatible
  dt-bindings: media: sunxi-ir: Add H6 compatible
  arm64: dts: allwiner: h6: Add IR receiver node
  arm64: dts: allwinner: h6: Enable IR on H6 boards
  arm64: defconfig: enable IR SUNXI option

Igors Makejevs (1):
  arm64: dts: allwinner: a64: Add IR node

Jernej Skrabec (1):
  arm64: dts: allwinner: a64: Enable IR on Orange Pi Win

 .../devicetree/bindings/media/sunxi-ir.txt    |  7 ++++++-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi              |  2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  2 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |  4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 18 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  4 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 19 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/media/rc/sunxi-cir.c                  |  1 +
 13 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECECC48BDC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB30206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmLySaHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGGNWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:22:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:22:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so13819736wmj.3;
        Sun, 07 Jul 2019 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=maw3v3SsxZvP2hs3eSVhueNHJP3NzyEzBgv+qOl/tFw=;
        b=FmLySaHSR8hDhMp0k/g/JHe8uE5E02ORynW/W9hbG4ZNmjzSpI6GCDwR0qaMThvQkl
         gvxZ8Tj0dmUyrGiE84lJFCOm6s7uIE4G5kSS6cKT7dr9Ytlm7zX/M5Rb5O5/qFRZpLEY
         /aX6ARcf3utafuCjDjbLK26GyDPnAY4t9jTYBLk0MEm0niGikRtm81Ve2Zcj6WfXKRyG
         w3oOHtYzlaE3SR3kbZdgshYvec0WFqNZrjQa/FjwCeJG1VZ3ro3X7rDMZN2VMcX5WCEV
         masYn9Zf7f6QzIwHIOO0Kl5hZyx42Cj2R29+xCWl9h6YJZXPop7mEANLG5Jdnk6P3bEW
         H6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=maw3v3SsxZvP2hs3eSVhueNHJP3NzyEzBgv+qOl/tFw=;
        b=E/jvsrJkbM+H0kXs2L6YLz4k3Rz3a9Pm8mUBTm8i82MaY4YzFy+c8p3cvIocxtpmv3
         k1d1+U2Lfp3z1lB5tqvj1xWLLjQf9LLZCSzhJTcFA0FXezrXZFjL8hP53ZX3u0gf/SQL
         3/KI56dFDb/Zk+os6yFrmJlzfH4x0jgM2kYnr+mmZjUx64nrNrDbSP4QF5+yBggcDIhi
         r2jrrk/9Mf9XH/rnc74CuHF1TSY/qYj6DUKF1apc24wqDPPtK4nDJdkTo3G3j1RGepWW
         gqixUATVkyYlSQYmiCoB5Xt8J+4Tof0ERLtThdDPox30pIg94Q01sk+hTmKGehNXnk3u
         o6BQ==
X-Gm-Message-State: APjAAAUcR1m8mS37Fh2LB32OVtfrqXHnqD666F0iZez5WmoYbfiFZAFo
        sluTvDhJVR+6bsAwozV8skcR21tNkho=
X-Google-Smtp-Source: APXvYqzIXdSfGGdUQKO93qhQl5ThP4h5LXbw+AQ5El8H6F2i1WPUTm8LvYOfXvmYXKWpS2pcPIfQ3A==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr11579030wma.36.1562505752416;
        Sun, 07 Jul 2019 06:22:32 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id a12sm13652465wrr.70.2019.07.07.06.22.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:22:31 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:22:23 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add Banana Pi BPI-W2 basic support
Message-ID: <20190707132223.GA13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds minimum support to boot a Banana Pi BPI-W2. This
board serial interface is muxed through a custom Realtek driver not
currently in mainline. Without the driver, it is only possible to
initialize a bootconsole, but init cannot be run. The datasheet of the
board's RTD1296 SoC is not publicly available and the procedure to
interface the interrupt controller registers is not completely known
yet, however, it works.

This patch is based on the official BPI-W2 downstream kernel driver [1]
and the last attempt of Andreas Färber [2] to support such driver.

Please, note that the board still requires a slightly modified version
of the downstreamed Realtek U-Boot to launch the Linux Kernel, which
essentially removes the need for some dts nodes not included in this
patch and reallocates u-boot before loading the kernel to avoid
overriding U-Boot code.

[1] - https://github.com/BPI-SINOVOIP/BPI-W2-bsp
[2] - https://patchwork.kernel.org/patch/10011891

Aleix Roca Nonell (6):
  dt-bindings: interrupt-controller: Document RTD129x
  irqchip: Add Realtek RTD129x intc driver
  arm64: dts: realtek: Move rtd1295 memreserve areas from the generic
    rtd129x to its specific dtsi
  arm64: dts: realtek: Add realtek intc to RTD129x
  dt-bindings: arm: Document RTD1296
  arm64: dts: realtek: Add bpi-w2 board support and its RTD1296 SoC

 .../devicetree/bindings/arm/realtek.txt       |  13 +
 .../realtek,rtd129x-intc.txt                  |  24 ++
 arch/arm64/boot/dts/realtek/Makefile          |   1 +
 arch/arm64/boot/dts/realtek/rtd1295.dtsi      |   3 +
 .../dts/realtek/rtd1296-bananapi-bpi-w2.dts   |  27 ++
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      |  77 ++++
 arch/arm64/boot/dts/realtek/rtd129x.dtsi      |  12 +-
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rtd129x.c                 | 371 ++++++++++++++++++
 9 files changed, 527 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-bananapi-bpi-w2.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi
 create mode 100644 drivers/irqchip/irq-rtd129x.c

-- 
2.21.0


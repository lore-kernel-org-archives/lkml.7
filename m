Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86620C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681D020637
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfLCHpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:45:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39374 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfLCHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:45:32 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB37jJbZ016008, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB37jJbZ016008
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Dec 2019 15:45:19 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Dec 2019 15:45:18 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>,
        Cheng-Yu Lee <cylee12@realtek.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/6] arm64: Realtek RTD1619 clock and reset controllers
Date:   Tue, 3 Dec 2019 15:45:07 +0800
Message-ID: <20191203074513.9416-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series adds clock and reset controllers for the Realtek RTD1619 SoC.

Cc: Andreas Färber <afaerber@suse.de>
Cc: Cheng-Yu Lee <cylee12@realtek.com>
Cc: devicetree@vger.kernel.org

cylee12 (6):
  dt-bindings: clock: add bindings for RTD1619 clocks
  dt-bindings: reset: add bindings for rtd1619 reset controls
  clk: realtek: add common clock support for Realtek SoCs
  clk: realtek: add reset controller support for Realtek SoCs
  clk: realtek: add rtd1619 controllers
  dt-bindings: clk: realtek: add rtd1619 clock controller bindings

 .../bindings/clock/realtek,clocks.txt         |  38 ++
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/realtek/Kconfig                   |  21 +
 drivers/clk/realtek/Makefile                  |  12 +
 drivers/clk/realtek/clk-pll-dif.c             |  81 +++
 drivers/clk/realtek/clk-pll-psaud.c           | 120 ++++
 drivers/clk/realtek/clk-pll.c                 | 400 +++++++++++++
 drivers/clk/realtek/clk-pll.h                 | 151 +++++
 drivers/clk/realtek/clk-regmap-gate.c         |  89 +++
 drivers/clk/realtek/clk-regmap-gate.h         |  26 +
 drivers/clk/realtek/clk-regmap-mux.c          |  63 ++
 drivers/clk/realtek/clk-regmap-mux.h          |  26 +
 drivers/clk/realtek/clk-rtd1619-cc.c          | 553 ++++++++++++++++++
 drivers/clk/realtek/clk-rtd1619-ic.c          | 112 ++++
 drivers/clk/realtek/common.c                  | 320 ++++++++++
 drivers/clk/realtek/common.h                  | 123 ++++
 drivers/clk/realtek/reset.c                   | 107 ++++
 drivers/clk/realtek/reset.h                   |  37 ++
 include/dt-bindings/clock/rtk,clock-rtd1619.h |  88 +++
 include/dt-bindings/reset/rtk,reset-rtd1619.h | 124 ++++
 21 files changed, 2493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/realtek,clocks.txt
 create mode 100644 drivers/clk/realtek/Kconfig
 create mode 100644 drivers/clk/realtek/Makefile
 create mode 100644 drivers/clk/realtek/clk-pll-dif.c
 create mode 100644 drivers/clk/realtek/clk-pll-psaud.c
 create mode 100644 drivers/clk/realtek/clk-pll.c
 create mode 100644 drivers/clk/realtek/clk-pll.h
 create mode 100644 drivers/clk/realtek/clk-regmap-gate.c
 create mode 100644 drivers/clk/realtek/clk-regmap-gate.h
 create mode 100644 drivers/clk/realtek/clk-regmap-mux.c
 create mode 100644 drivers/clk/realtek/clk-regmap-mux.h
 create mode 100644 drivers/clk/realtek/clk-rtd1619-cc.c
 create mode 100644 drivers/clk/realtek/clk-rtd1619-ic.c
 create mode 100644 drivers/clk/realtek/common.c
 create mode 100644 drivers/clk/realtek/common.h
 create mode 100644 drivers/clk/realtek/reset.c
 create mode 100644 drivers/clk/realtek/reset.h
 create mode 100644 include/dt-bindings/clock/rtk,clock-rtd1619.h
 create mode 100644 include/dt-bindings/reset/rtk,reset-rtd1619.h

-- 
2.24.0


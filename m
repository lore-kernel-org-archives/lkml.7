Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B846CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5020856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="XYbnHjp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393316AbfJXKzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:55:09 -0400
Received: from vps.xff.cz ([195.181.215.36]:33810 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbfJXKzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571914506; bh=1EYHhZa3jmmFFim3CNdXdWqGggwNarNck0+eiGZhSdU=;
        h=From:To:Cc:Subject:Date:From;
        b=XYbnHjp+wt4niF1BOdOuTn1CKEEUtjd5UaC6KAyEc4QWCXi7opj09D5URcrsrO1FN
         ZWo05sWeiM/7f+RrZBggguVUQUxmcEdQjNO0cAAWEkwILKQWyatoPCQH1UdMADM4wG
         t7ELJtQRA2B/wiAc5iU4Kc86XCJIFsJ3LevethF0=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ondrej Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] Add USB 3 support for H6 and Orange Pi 3
Date:   Thu, 24 Oct 2019 12:54:56 +0200
Message-Id: <20191024105500.2252707-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements USB 3 support for Xunlong Orange Pi 3 board.

This is a re-hash of the Icenowy's earlier USB3 work[1] without code
that caused controversy previously. Orange Pi 3 board doesn't need vbus
supply to be dynamically enabled, so that code is not needed to support
USB3 on this board.

Most of patches are already reviewed. I've converted dt-bindings to yaml
format, and added the Orange Pi 3 board modifications.

Hopefully with this series we can get USB3 support into mainline for
Orange Pi 3, and build on it later to support more boards, where
supporting them is more complicated.

Please take a look.

thank you and regards,
  Ondrej Jirman

[1] https://lore.kernel.org/patchwork/patch/1058919/

Changes in v2:
- Added Maxime's Acked-By's
- Fixed title of DT bindings file

Changes since Icenowy v5 series:
- use earlier patches that did not include VBUS regulator/connector
  code
- converted dt bindings to yaml
- added patch to enable usb3 on Orange Pi 3

Icenowy Zheng (2):
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  arm64: dts: allwinner: h6: add USB3 device nodes

Ondrej Jirman (2):
  dt-bindings: Add bindings for USB3 phy on Allwinner H6
  arm64: dts: allwinner: orange-pi-3: Enable USB 3.0 host support

 .../phy/allwinner,sun50i-h6-usb3-phy.yaml     |  47 +++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  32 +++
 drivers/phy/allwinner/Kconfig                 |  12 ++
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
 6 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.23.0


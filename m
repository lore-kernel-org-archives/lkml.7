Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84B9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79232190F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FbLKHFO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfIHNnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:43:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55834 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfIHNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:43:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so10916919wmg.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bhJiBihaPigA25kWimp1Wuk4duG+A/TW5bOjh0hx7qw=;
        b=FbLKHFO3sy/P0LsX5o7Lup+JKzur4H4kJ75gquUD3SHLGIczGl85/lWck6sGMnBYAg
         WuraeQeE84/NeiZuKBQAK7N9H1Tbzjb9ZahlQWMSgcqXezOev7edsEN/PnzMny+AYBbZ
         xB2juX0GUvpdh55ITRxxgbp9rNzidWkL4rgedFsVY26bwlrT4VdwHUgR1f4Z+IMjWVo8
         wfL/Xb1j8ivrQWg8m6S3A31KhBx7GmDA9r8KVefF5CBpC11SP2hf2m0wA3dIwsYM+DFx
         9HGyFtFgiGihd56srnRwjg1StrJz+0jGNE39tXzxd58RyOGF2vZCEGJhfbEsAhWknHlr
         l12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bhJiBihaPigA25kWimp1Wuk4duG+A/TW5bOjh0hx7qw=;
        b=ocL5tm505uePwOi8CEQa3iPUKfZH1VkW8O4/xW/NstfLJ1gRYYNvEqC3lx8ZLhsqTm
         2Vy71iq4CmpJf3crR9lgxRykX1CQ0rhx9H6PxlgYY41zxWMjUKXPkWdkGSIaDWjRrZma
         Of6ldc19LoaoNxWN5ALUw3KRQQ14dfBiqWIrpzCfhFrYJEuZZAIzBZKdPVs9uL7WmGo/
         atyJnBm04IJKqd4B3TD6VW231K5u3NesEudrbRw5J20aEov5REDRovnaNz0XbvbUAWFI
         2vN72pxfE5mYdrmUVq0SZDVwwFWjlw83U2Xrc4QKJjtB4jq3MWjdh1JxjI1K/L0OtUyu
         ppCQ==
X-Gm-Message-State: APjAAAWxNwJQsFzHHSu+IAaHJGyYBiJOdVYTvva1RSaPgCgw/VfUyUg2
        kP3rYx6LHzREnxNQuTwefDDBbA==
X-Google-Smtp-Source: APXvYqzZDOffIFpKH0a5IrjJM+OMLi4OoraM+UJVMqR7MJ3TEHLDVrjUVrj3tt8e4i0+UESY/zZsig==
X-Received: by 2002:a7b:cfd1:: with SMTP id f17mr14578586wmm.146.1567950184183;
        Sun, 08 Sep 2019 06:43:04 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: meson-g12: add support for PCIe
Date:   Sun,  8 Sep 2019 13:42:52 +0000
Message-Id: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- updates the Amlogic PCI bindings for G12A
- reworks the Amlogic PCIe driver to make use of the
G12a USB3+PCIe Combo PHY instead of directly writing in
the PHY register
- adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
- adds the PCIe Node for G12A, G12B and SM1 SoCs
- adds the commented support for the S922X, A311D and S905D3 based
VIM3 boards.

This patchset has been tested in a A311D VIM3 using a 128Go
TS128GMTE110S NVMe PCIe module.

For indication, here is a bonnie++ run as ext4 formatted:
     ------Sequential Output------ --Sequential Input- --Random-
     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
  4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++

Neil Armstrong (6):
  dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
  PCI: amlogic: Fix probed clock names
  PCI: amlogic: meson: Add support for G12A
  phy: meson-g12a-usb3-pcie: Add support for PCIe mode
  arm64: dts: meson-g12a: Add PCIe node
  arm64: dts: khadas-vim3: add commented support for PCIe

 .../bindings/pci/amlogic,meson-pcie.txt       |  12 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  33 ++++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  22 ++++
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |  22 ++++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   4 +
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  22 ++++
 drivers/pci/controller/dwc/pci-meson.c        | 105 ++++++++++++++----
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |  70 ++++++++++--
 8 files changed, 258 insertions(+), 32 deletions(-)

-- 
2.17.1


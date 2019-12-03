Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C2C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213A82080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575404991;
	bh=2fgZfqcM0kGQexZnIO7eCk6K1w6S5q4plw3dGykL7Sk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kWlBgqWkPfwE7+QwMVJUFdz/WaO0tPnShIKx1fKNRVsa8Fn+Uod4RWpn2nokhpRnj
	 CkA8mu2OtcmlH6QGjpij0v+ebRO/0HilnUyEsGoeEVPFmXyGjee1CTXggFm07Dv1Hi
	 MFHOnCUHJnUvs+Q5rKE5a9cQk8lGaJGxoZnY6ZEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfLCU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfLCU3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:29:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B448E20659;
        Tue,  3 Dec 2019 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575404988;
        bh=2fgZfqcM0kGQexZnIO7eCk6K1w6S5q4plw3dGykL7Sk=;
        h=Date:From:To:Cc:Subject:From;
        b=Xr5wD6F0m3BLh7BvpDsqNQ6pFMYBTy8rsOu5VGt+8+f/mAIQoWrCSSyUcscIIyxp6
         wKPRDH2Qeue68OStQbr6whf/zAAskCLlHMRTkxCgPWYYwKoCHSvgTzXDMNp38E4TiD
         kp4n5hKGDzTifCmoTIoZIrGZrVSgdYjOoAmTb7FA=
Date:   Tue, 3 Dec 2019 21:29:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 5.5-rc1
Message-ID: <20191203202946.GA3188593@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc1

for you to fetch changes up to 27ed14d0ecb38516b6f3c6fdcd62c25c9454f979:

  Revert "serial/8250: Add support for NI-Serial PXI/PXIe+485 devices" (2019-11-27 14:24:13 +0100)

----------------------------------------------------------------
TTY/Serial patches for 5.5-rc1

Here is the "big" tty and serial driver patches for 5.5-rc1.  It's a bit
later in the merge window than normal as I wanted to make sure some
last-minute patches applied to it were all sane.  They seem to be :)

There's a lot of little stuff in here, for the tty core, and for lots of
serial drivers:
	- reverts of uartlite serial driver patches that were wrong
	- msm-serial driver fixes
	- serial core updates and fixes
	- tty core fixes
	- serial driver dma mapping api changes
	- lots of other tiny fixes and updates for serial drivers

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akash Asthana (2):
      tty: serial: qcom_geni_serial: IRQ cleanup
      tty: serial: qcom_geni_serial: Wakeup over UART RX

Andrey Smirnov (1):
      dt-bindings: serial: lpuart: Drop unsupported RS485 bindings

Andy Shevchenko (3):
      serial: 8250_dw: Use devm_clk_get_optional() to get the input clock
      serial: 8250_exar: Move Exar pieces to custom ->startup()
      serial: 8250_dw: Avoid double error messaging when IRQ absent

Ben Dooks (1):
      serial: sirf: make register info static

Chuhong Yuan (2):
      tty: serial: uartlite: use clk_disable_unprepare to match clk_prepare_enable
      serial: ifx6x60: add missed pm_runtime_disable

Dmitry Torokhov (1):
      tty: vt: keyboard: reject invalid keycodes

Fabrice Gasnier (1):
      serial: stm32: fix clearing interrupt error flags

Felipe Balbi (1):
      serial: 8250_lpss: Switch over to MSI interrupts

Frank Wunderlich (1):
      serial: 8250-mtk: Use platform_get_irq_optional() for optional irq

Geert Uytterhoeven (1):
      dt-bindings: serial: sh-sci: Document r8a77961 bindings

Greg Kroah-Hartman (9):
      Merge 5.4-rc3 into tty-next
      Merge 5.4-rc5 into tty-next
      Revert "tty:n_gsm.c: destroy port by tty_port_destroy()"
      Revert "serial-uartlite: Use allocated structure instead of static ones"
      Revert "serial-uartlite: Change logic how console_port is setup"
      Revert "serial-uartlite: Add runtime support"
      Revert "serial-uartlite: Do not use static struct uart_driver out of probe()"
      Revert "serial-uartlite: Add get serial id if not provided"
      Revert "serial-uartlite: Move the uart register"

Heiko Schocher (1):
      tty: 8250_of: Use software emulated RS485 direction control

Je Yen Tam (1):
      Revert "serial/8250: Add support for NI-Serial PXI/PXIe+485 devices"

Jeffrey Hugo (1):
      tty: serial: msm_serial: Fix flow control

Jiangfeng Xiao (1):
      serial: serial_core: Perform NULL checks for break_ctl ops

Jiri Slaby (1):
      tty: don't crash in tty_init_dev when missing tty_port

Krzysztof Kozlowski (2):
      tty: Fix Kconfig indentation
      tty: Fix Kconfig indentation, continued

Lanqing Liu (1):
      serial: sprd: Add polling IO support

Maximilian Luz (1):
      serdev: Add ACPI devices by ResourceSource field

Michal Simek (3):
      serial: core: Use cons->index for preferred console registration
      hvc: dcc: Add earlycon support
      Revert "serial: core: Use cons->index for preferred console registration"

Nicolas Pitre (1):
      vcs: prevent write access to vcsu devices

Oskar Senft (3):
      drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity configurable
      dt-bindings: serial: 8250: Add aspeed,sirq-polarity-sense.
      arm: dts: aspeed: Add vuart aspeed,sirq-polarity-sense to aspeed-g5.dtsi

Pascal Terjan (1):
      Remove every trace of SERIAL_MAGIC

Pavel Machek (1):
      tty_ldisc: simplify tty_ldisc_autoload initialization

Peng Fan (3):
      tty: serial: fsl_lpuart: use the sg count from dma_map_sg
      tty: serial: imx: use the sg count from dma_map_sg
      tty: serial: pch_uart: correct usage of dma_unmap_sg

Peter Ujfalusi (3):
      tty: serial: amba-pl011: Use dma_request_chan() directly for channel request
      tty: serial: tegra: Use dma_request_chan() directly for channel request
      tty: serial: msm_serial: Use dma_request_chan() directly for channel request

Philipp Puschmann (1):
      serial: imx: adapt rx buffer and dma periods

Philippe Schenker (3):
      tty: serial: lpuart: Remove unnecessary code from set_mctrl
      tty: serial: lpuart: Use defines that correspond to correct register
      tty: serial: lpuart: Add RS485 support for 32-bit uart flavour

Qian Cai (1):
      tty/amba-pl011: fix a -Wunused-function warning

Shubhrajyoti Datta (2):
      serial-uartlite: Change logic how console_port is setup
      serial-uartlite: Use allocated structure instead of static ones

Stefan-Gabriel Mirea (1):
      serial: fsl_linflexuart: Be consistent with the name

Sudip Mukherjee (3):
      tty: rocket: reduce stack usage
      {tty: serial, nand: onenand}: samsung: rename to fix build warning
      tty: remove unused argument from tty_open_by_driver()

Vincent Whitchurch (1):
      serial: pl011: Fix DMA ->flush_buffer()

Xiaoming Ni (1):
      tty:n_gsm.c: destroy port by tty_port_destroy()

 Documentation/ABI/stable/sysfs-driver-aspeed-vuart |  11 +-
 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 Documentation/devicetree/bindings/serial/8250.txt  |   5 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   3 +-
 .../bindings/serial/renesas,sci-serial.txt         |   6 +-
 Documentation/process/magic-number.rst             |   1 -
 .../translations/it_IT/process/magic-number.rst    |   1 -
 .../translations/zh_CN/process/magic-number.rst    |   1 -
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   1 +
 drivers/mtd/nand/onenand/Makefile                  |   2 +-
 .../mtd/nand/onenand/{samsung.c => samsung_mtd.c}  |   0
 drivers/net/wan/z85230.h                           |   2 -
 drivers/tty/Kconfig                                |  40 +--
 drivers/tty/amiserial.c                            |  84 ------
 drivers/tty/hvc/Kconfig                            |  28 +-
 drivers/tty/hvc/hvc_dcc.c                          |  28 ++
 drivers/tty/rocket.c                               |  32 ++-
 drivers/tty/serdev/core.c                          | 111 +++++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  84 ++++++
 drivers/tty/serial/8250/8250_dw.c                  |  83 +++---
 drivers/tty/serial/8250/8250_exar.c                |  19 ++
 drivers/tty/serial/8250/8250_lpss.c                |  21 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   2 +-
 drivers/tty/serial/8250/8250_of.c                  |  31 +++
 drivers/tty/serial/8250/8250_pci.c                 | 292 +--------------------
 drivers/tty/serial/8250/8250_port.c                |  14 -
 drivers/tty/serial/8250/Kconfig                    |   3 +-
 drivers/tty/serial/Kconfig                         | 104 ++++----
 drivers/tty/serial/Makefile                        |   2 +-
 drivers/tty/serial/amba-pl011.c                    |  12 +-
 drivers/tty/serial/fsl_linflexuart.c               |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  84 ++++--
 drivers/tty/serial/ifx6x60.c                       |   3 +
 drivers/tty/serial/imx.c                           |   7 +-
 drivers/tty/serial/msm_serial.c                    |  10 +-
 drivers/tty/serial/pch_uart.c                      |   5 +-
 drivers/tty/serial/qcom_geni_serial.c              |  68 ++++-
 drivers/tty/serial/{samsung.c => samsung_tty.c}    |   0
 drivers/tty/serial/serial-tegra.c                  |   3 +-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/tty/serial/sirfsoc_uart.h                  |   5 +-
 drivers/tty/serial/sprd_serial.c                   |  33 +++
 drivers/tty/serial/stm32-usart.c                   |   6 +-
 drivers/tty/serial/uartlite.c                      |  97 ++-----
 drivers/tty/tty_io.c                               |  14 +-
 drivers/tty/tty_ldisc.c                            |   7 +-
 drivers/tty/vt/keyboard.c                          |   2 +-
 drivers/tty/vt/vc_screen.c                         |   3 +
 include/uapi/linux/serial_core.h                   |   2 +-
 49 files changed, 665 insertions(+), 715 deletions(-)
 rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
 rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)

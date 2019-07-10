Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DCBC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFDB20861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765572;
	bh=CN/+lm2bAXwB8zcKV1GczGxn63OCItepJ+k4mGIikCs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=H7ZG84jn41ZkQwqqTYYxZtiAHY0rXrUoSORd54MIaIx2YZvVhPywMSaRf0vmGiHsZ
	 vg3qMGdsdY03qMSsJnMGsX5cYuBAEL+YHUAWM4jfxEuCZA4/GZVHZdOmlFpK82HErw
	 n4YkOZPSpxUKj268duHqu4QMI6y3oDSpQloafEG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfGJNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:32:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062AF2084B;
        Wed, 10 Jul 2019 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765569;
        bh=CN/+lm2bAXwB8zcKV1GczGxn63OCItepJ+k4mGIikCs=;
        h=Date:From:To:Cc:Subject:From;
        b=z3mWakczOmmL4F3XmTTHdbG+YGxVUIUqOl+wvDl2K2/7K2/uKhUT+0TM6A/mp1Bvc
         JQtJM25QrKYaaC2W2a+Ugv/oh3friItzlAwsvIPrExeVj8+PdNX3qRLoT2h2N8Cd9s
         7DNQrC5Mx6VwSyuZNhjl87OJm96A3ke40nvXEeyA=
Date:   Wed, 10 Jul 2019 15:32:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 5.3-rc1
Message-ID: <20190710133247.GA24083@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc1

for you to fetch changes up to 35a4ed0164e992c9c7b82eb1370081a292131904:

  tty: serial: fsl_lpuart: add imx8qxp support (2019-07-04 15:53:45 +0200)

----------------------------------------------------------------
TTY / Serial driver updates for 5.3-rc1

Here is the "large" TTY and Serial driver update for 5.3-rc1.

It's in the negative number of lines overall as we removed an obsolete
serial driver that was causing problems for some people who were trying
to clean up some apis (the mpsc.c driver, which only worked for some
pre-production hardware that no one has anymore.)

Other than that, lots of tiny changes, cleaning up small things along
with some platform-specific serial driver updates.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_of: Use of_device_get_match_data()
      serial: 8250: factor out serial8250_{set,clear}_THRI() helpers

Ben Hutchings (1):
      Revert "consolemap: Fix a memory leaking bug in drivers/tty/vt/consolemap.c"

Bich Hemon (1):
      serial: stm32: select pinctrl state in each suspend/resume function

Borut Seljak (1):
      serial: stm32: fix a recursive locking in stm32_config_rs485

Christophe Leroy (1):
      tty: serial: cpm_uart - fix init when SMC is relocated

Claire Chang (1):
      uart: mediatek: support Rx in-band wakeup

Doug Berger (1):
      tty: amba-pl011: allow shared interrupt

Erwan Le Ray (12):
      serial: stm32: fix word length configuration
      serial: stm32: fix rx error handling
      serial: stm32: fix rx data length when parity enabled
      serial: stm32: fix transmit_chars when tx is stopped
      serial: stm32: Add support of TC bit status check
      serial: stm32: fix wakeup source initialization
      serial: stm32: fix the get_irq error case
      serial: stm32: add support of timeout interrupt for RX
      serial: stm32: update PIO transmission
      serial: stm32: add support of TX FIFO threshold
      serial: stm32: add support of RX FIFO threshold
      serial: stm32: add RX and TX FIFO flush

Fabio Estevam (3):
      serial: fsl_lpuart: Use dev_info() instead of printk()
      serial: imx: Use dev_info() instead of pr_info()
      serial: fsl_lpuart: Remove unneeded OOM error message

Fugang Duan (1):
      tty: serial: fsl_lpuart: add imx8qxp support

Geert Uytterhoeven (2):
      serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
      serial: sh-sci: Terminate TX DMA during buffer flushing

Gen Zhang (1):
      consolemap: Fix a memory leaking bug in drivers/tty/vt/consolemap.c

Greg Kroah-Hartman (2):
      Merge 5.2-rc3 into tty-next
      Revert "serial: stm32: select pinctrl state in each suspend/resume function"

Grzegorz Halat (1):
      vt/fbcon: deinitialize resources in visual_init() after failed memory allocation

Hao Lee (1):
      tty: serial: 8250: Fix type field in format string

Jay Dolan (1):
      serial: 8250: Add support for higher baud rates to Pericom chips

Johan Hovold (3):
      tty: simserial: drop unused iflag macro
      tty: ipoctal: drop unused iflag macro
      tty: cpm_uart: drop unused iflag macro

Jorge Ramirez-Ortiz (1):
      tty: serial: msm_serial: avoid system lockup condition

Kefeng Wang (1):
      tty/serial: digicolor: Fix digicolor-usart already registered warning

Lin Yi (1):
      tty: tty_io: fix driver refcount imbalance on error path

Long Cheng (1):
      serial: 8250-mtk: modify uart DMA rx

Mark Greer (1):
      serial: mpsc: Remove obsolete MPSC driver

Nava kishore Manne (5):
      serial: uartps: Use octal permission for module_param()
      serial: uartps: Fix multiple line dereference
      serial: uartps: Fix long line over 80 chars
      serial: uartps: Do not add a trailing semicolon to macro
      serial: uartps: Remove useless return from cdns_uart_poll_put_char

Oliver Barta (1):
      Revert "serial: 8250: Don't service RX FIFO if interrupts are disabled"

Rautkoski Kimmo EXT (1):
      serial: 8250: Fix TX interrupt handling condition

Serge Semin (8):
      tty: max310x: Simplify tx-work item code
      tty: max310x: Introduce max310x_one port macro-wrapper
      tty: max310x: Don't pass stacked buffers to SPI
      tty: max310x: Fix invalid baudrate divisors calculator
      tty: max310x: Add rx-during-tx rs485 flag support
      tty: max310x: Optionally enable rs485 on startup
      tty: max310x: Split uart characters insertion loop
      tty: serial_core: Set port active bit in uart_port_activate

Sergey Organov (4):
      serial: imx: fix locking in set_termios()
      serial: imx: set_termios(): factor-out 'ucr2' initial value
      serial: imx: set_termios(): clarify RTS/CTS bits calculation
      serial: imx: set_termios(): preserve RTS state

Shubhrajyoti Datta (3):
      serial: uartps: Move the spinlock after the read of the tx empty
      serial: uartps: Add a timeout to the tx empty wait
      serial: uartps: Use the same dynamic major number for all ports

Stefan Roese (2):
      serial: 8250: Add MSR/MCR TIOCM conversion wrapper functions
      serial: mctrl_gpio: Check if GPIO property exisits before requesting it

Thierry Reding (1):
      tty: serial: 8250-of: Do not warn on deferred probe

Wei Yongjun (1):
      serial: 8250: 8250_core: Fix missing unlock on error in serial8250_register_8250_port()

Yegor Yefremov (1):
      tty/serial/8250: use mctrl_gpio helpers

YueHaibing (1):
      serial: stm32: Make stm32_get_databits static

kbuild test robot (1):
      serial: 8250: pericom_do_set_divisor can be static

 Documentation/admin-guide/devices.txt             |    4 +-
 Documentation/devicetree/bindings/serial/8250.txt |   19 +
 arch/ia64/hp/sim/simserial.c                      |    2 -
 drivers/ipack/devices/ipoctal.h                   |    1 -
 drivers/tty/serial/8250/8250.h                    |   90 +-
 drivers/tty/serial/8250/8250_core.c               |   20 +
 drivers/tty/serial/8250/8250_dma.c                |   11 +-
 drivers/tty/serial/8250/8250_mtk.c                |   73 +-
 drivers/tty/serial/8250/8250_of.c                 |   14 +-
 drivers/tty/serial/8250/8250_omap.c               |   43 +-
 drivers/tty/serial/8250/8250_pci.c                |   97 +-
 drivers/tty/serial/8250/8250_pnp.c                |    4 +-
 drivers/tty/serial/8250/8250_port.c               |   50 +-
 drivers/tty/serial/8250/Kconfig                   |    1 +
 drivers/tty/serial/Kconfig                        |   14 -
 drivers/tty/serial/Makefile                       |    1 -
 drivers/tty/serial/amba-pl011.c                   |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c       |   19 +-
 drivers/tty/serial/digicolor-usart.c              |    6 +-
 drivers/tty/serial/fsl_lpuart.c                   |  114 +-
 drivers/tty/serial/imx.c                          |   82 +-
 drivers/tty/serial/max310x.c                      |  157 +-
 drivers/tty/serial/mpsc.c                         | 2138 ---------------------
 drivers/tty/serial/msm_serial.c                   |    4 +
 drivers/tty/serial/serial_core.c                  |    7 +-
 drivers/tty/serial/serial_mctrl_gpio.c            |   14 +
 drivers/tty/serial/sh-sci.c                       |   33 +-
 drivers/tty/serial/stm32-usart.c                  |  348 +++-
 drivers/tty/serial/stm32-usart.h                  |   33 +-
 drivers/tty/serial/xilinx_uartps.c                |   37 +-
 drivers/tty/tty_io.c                              |    4 +-
 include/linux/mv643xx.h                           |   46 -
 include/linux/serial_8250.h                       |    1 +
 include/uapi/linux/serial_core.h                  |    2 +-
 34 files changed, 887 insertions(+), 2604 deletions(-)
 delete mode 100644 drivers/tty/serial/mpsc.c

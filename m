Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA25C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B365A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557311512;
	bh=9eUZY7jfadnX2YStX8wBWIX1Tf2EjUvXvUm99JXeZF8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ovctEbdzAQmJkYTrPiQRrLs1AVnQZkaDxSqRjIwfZsABFivSBrHdazJ+1rK8nW5yu
	 HXORXn0CUtDeXdk9OMIZUFaeETCnuwNN4dGJsa3XPPmm4qdzKSQ/LeIN0/ZiwYT3RC
	 KPMh8b4SG/dv5LTdprKwm1omDVuFhr4oqyuvoaWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEHKbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfEHKbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:31:51 -0400
Received: from localhost (unknown [84.241.196.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C553421479;
        Wed,  8 May 2019 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557311509;
        bh=9eUZY7jfadnX2YStX8wBWIX1Tf2EjUvXvUm99JXeZF8=;
        h=Date:From:To:Cc:Subject:From;
        b=alzcUoqKE7l6P4s+q4Q/2V0rAt2CP1ay10OMj4ABPog/kl3TDhZzLz6FTadgvbsVe
         1J45T9vEoT3v9BDPEt6Pz+BCYhGe4lixQL5476aVtW56a03dkDgO7ylksY9Py1FVwC
         RMSzTp0tlfAs+PYJerwVmap5T5/DxBJMeXfAKCpk=
Date:   Wed, 8 May 2019 12:31:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 5.2-rc1
Message-ID: <20190508103146.GA14542@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc1

for you to fetch changes up to 45c054d0815b1530d7c7ff8441389a0421dd05e7:

  tty: serial: add driver for the SiFive UART (2019-04-29 16:30:59 +0200)

----------------------------------------------------------------
TTY/Serial patches for 5.2-rc1

Here is the "big" set of tty/serial driver patches for 5.2-rc1.

It's really pretty small, not much happening in this portion of the
kernel at the moment.  When the "highlight" is the movement of the
documentation from .txt to .rst files, it's a good merge window.

There's a number of small fixes and updates over the various serial
drivers, and a new "tty null" driver for those embedded systems that
like to make things even smaller and not break things.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (4):
      dt-bindings: sc16is7xx: Add alternative clock-frequency property
      serial: sc16is7xx: Respect clock-frequency property
      serial: sc16is7xx: Switch to use device_get_match_data()
      serial: sc16is7xx: Drop of_match_ptr() use

Bartlomiej Zolnierkiewicz (1):
      tty: remove redundant 'default n' from Kconfig-s

Colin Ian King (1):
      n_tty: check for negative and zero space return from tty_write_room

David Emett (1):
      tty: fix read of tty->pgrp outside of ctrl_lock

Fuqian Huang (2):
      tty: rocket: Remove RCPK_GET_STRUCT ioctl
      tty: rocket: deprecate the rp_ioctl

Greg Kroah-Hartman (5):
      Revert "tty: pty: Fix race condition between release_one_tty and pty_write"
      Merge 5.1-rc3 into tty-next
      tty: add SPDX identifiers to Kconfig and Makefiles
      tty: fix up a few remaining files without SPDX identifiers
      Merge 5.1-rc6 into tty-next

Hariprasad Kelam (1):
      tty:serial_core: Spelling mistake

Jakub Wilk (1):
      vt: use /dev/vcs (not /dev/vcs0) in comment

Jiri Slaby (1):
      TTY: serial_core, add ->install

Johan Hovold (2):
      Revert "tty: fix NULL pointer issue when tty_port ops is not set"
      tty: update obsolete termios comment

Julien Grall (1):
      tty/sysrq: Convert show_lock to raw_spinlock_t

Kangjie Lu (1):
      tty: ipwireless: fix missing checks for ioremap

Konstantin Khorenko (1):
      tty/vt: avoid high order pages allocation on GIO_UNIMAP ioctl

Lanqing Liu (4):
      dt-bindings: serial: sprd: Add clocks and clocks-names properties
      serial: sprd: Add power management for the Spreadtrum serial controller
      dt-bindings: serial: sprd: Add dma properties to support DMA mode
      serial: sprd: Add DMA mode support

Long Cheng (2):
      serial: 8250-mtk: add follow control
      serial: 8250-mtk: modify baudrate setting

Mauro Carvalho Chehab (1):
      docs: serial: convert docs to ReST and rename to *.rst

Pankaj Gupta (1):
      virtio_console: initialize vtermno value for ports

Paul Walmsley (2):
      dt-bindings: serial: add documentation for the SiFive UART driver
      tty: serial: add driver for the SiFive UART

Reinis Danne (1):
      tty: vt: keyboard: Allow Unicode compose base char

Sahara (1):
      tty: pty: Fix race condition between release_one_tty and pty_write

Sergei Trofimovich (1):
      tty/vt: fix write/write race in ioctl(KDSKBSENT) handler

Sergey Organov (1):
      tty: serial_core: fix error code returned by uart_register_driver()

Shubhrajyoti Datta (2):
      dt-bindings: xilinx-uartps: Add support for cts-override
      serial: uartps: Add support for cts-override

Su Bao Cheng (1):
      serial: 8250_exar: Adjust IOT2000 matching

Sugaya Taichi (2):
      serial: Add Milbeaut serial control
      serial: Fix using plain integer instead of Null pointer

Valdis Kletnieks (1):
      drivers/tty/tty_jobctrl.c - fix non-kerneldoc comment

Vincent Whitchurch (1):
      tty: Add NULL TTY driver

Wei Yongjun (1):
      serial: milbeaut_usio: Fix error handling in probe and remove

Yifeng Li (1):
      tty: vt.c: Fix TIOCL_BLANKSCREEN console blanking if blankinterval == 0

YueHaibing (2):
      serial: 8250_fintek: Make fintek_8250_set_termios static
      serial: sprd: Fix a copy-paste err in sprd_request_dma()

 .../devicetree/bindings/serial/cdns,uart.txt       |    5 +
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   |    2 +
 .../devicetree/bindings/serial/sifive-serial.txt   |   33 +
 .../devicetree/bindings/serial/sprd-uart.txt       |   17 +-
 .../serial/{README.cycladesZ => cyclades_z.rst}    |    5 +-
 Documentation/serial/{driver => driver.rst}        |  115 ++-
 Documentation/serial/index.rst                     |   32 +
 Documentation/serial/moxa-smartio                  |  523 ----------
 Documentation/serial/moxa-smartio.rst              |  615 ++++++++++++
 Documentation/serial/n_gsm.rst                     |  103 ++
 Documentation/serial/n_gsm.txt                     |   96 --
 Documentation/serial/{rocket.txt => rocket.rst}    |  152 ++-
 .../{serial-iso7816.txt => serial-iso7816.rst}     |   21 +-
 .../serial/{serial-rs485.txt => serial-rs485.rst}  |   22 +-
 Documentation/serial/{tty.txt => tty.rst}          |  111 +-
 MAINTAINERS                                        |    4 +-
 drivers/char/virtio_console.c                      |    3 +-
 drivers/tty/Kconfig                                |   22 +-
 drivers/tty/Makefile                               |    1 +
 drivers/tty/hvc/Kconfig                            |    3 +-
 drivers/tty/ipwireless/Makefile                    |    1 +
 drivers/tty/ipwireless/main.c                      |    8 +
 drivers/tty/n_tty.c                                |    4 +-
 drivers/tty/rocket.c                               |   14 +-
 drivers/tty/rocket.h                               |    1 -
 drivers/tty/serdev/Kconfig                         |    1 +
 drivers/tty/serdev/Makefile                        |    1 +
 drivers/tty/serial/8250/8250_exar.c                |    7 +-
 drivers/tty/serial/8250/8250_fintek.c              |    5 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |    1 +
 drivers/tty/serial/8250/8250_mtk.c                 |  162 ++-
 drivers/tty/serial/8250/Kconfig                    |    1 +
 drivers/tty/serial/Kconfig                         |   54 +-
 drivers/tty/serial/Makefile                        |    2 +
 drivers/tty/serial/cpm_uart/Makefile               |    1 +
 drivers/tty/serial/jsm/Makefile                    |    1 +
 drivers/tty/serial/milbeaut_usio.c                 |  614 ++++++++++++
 drivers/tty/serial/sc16is7xx.c                     |   34 +-
 drivers/tty/serial/serial_core.c                   |   30 +-
 drivers/tty/serial/sifive.c                        | 1056 ++++++++++++++++++++
 drivers/tty/serial/sn_console.c                    |    1 +
 drivers/tty/serial/sprd_serial.c                   |  501 +++++++++-
 drivers/tty/serial/ucc_uart.c                      |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 |   12 +
 drivers/tty/sysrq.c                                |    6 +-
 drivers/tty/tty_io.c                               |    2 +-
 drivers/tty/tty_jobctrl.c                          |    4 +-
 drivers/tty/tty_port.c                             |   10 +-
 drivers/tty/ttynull.c                              |  109 ++
 drivers/tty/vcc.c                                  |    1 +
 drivers/tty/vt/.gitignore                          |    1 +
 drivers/tty/vt/consolemap.c                        |    8 +-
 drivers/tty/vt/cp437.uni                           |    1 +
 drivers/tty/vt/defkeymap.c_shipped                 |    1 +
 drivers/tty/vt/defkeymap.map                       |    1 +
 drivers/tty/vt/keyboard.c                          |   35 +-
 drivers/tty/vt/vc_screen.c                         |    2 +-
 drivers/tty/vt/vt.c                                |    2 -
 include/linux/serial_core.h                        |    2 +-
 include/uapi/linux/serial_core.h                   |    6 +
 60 files changed, 3679 insertions(+), 911 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 rename Documentation/serial/{README.cycladesZ => cyclades_z.rst} (85%)
 rename Documentation/serial/{driver => driver.rst} (92%)
 create mode 100644 Documentation/serial/index.rst
 delete mode 100644 Documentation/serial/moxa-smartio
 create mode 100644 Documentation/serial/moxa-smartio.rst
 create mode 100644 Documentation/serial/n_gsm.rst
 delete mode 100644 Documentation/serial/n_gsm.txt
 rename Documentation/serial/{rocket.txt => rocket.rst} (68%)
 rename Documentation/serial/{serial-iso7816.txt => serial-iso7816.rst} (85%)
 rename Documentation/serial/{serial-rs485.txt => serial-rs485.rst} (89%)
 rename Documentation/serial/{tty.txt => tty.rst} (74%)
 create mode 100644 drivers/tty/serial/milbeaut_usio.c
 create mode 100644 drivers/tty/serial/sifive.c
 create mode 100644 drivers/tty/ttynull.c

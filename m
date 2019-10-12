Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A2C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786012087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570897086;
	bh=AKDf+1/UBiLw9gcUSQZHvu5one1mVr8HRT8Ag1TdzI8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qZ7GI44S6EoFEe6oCjWuNMVNrejew/41+vrQmBWBFTeEpekDQ+LX+AtDVkTPpArk6
	 +oqIfyqFKTrHOgVbqXRQZPVztoz+gd10O14M8utobYHGIDFF8WwgmKwrXmaRilsGJ6
	 B3fdFbs/aVfGk8mGCEKi9JFnGn1oaN2Y/a0yBq+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfJLQSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 12:16:03 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C1B2087E;
        Sat, 12 Oct 2019 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570896961;
        bh=AKDf+1/UBiLw9gcUSQZHvu5one1mVr8HRT8Ag1TdzI8=;
        h=Date:From:To:Cc:Subject:From;
        b=U/O8afeR9HqAPTFrVQZMBrGXf3rLf2AMdNF3m/c4gCIAYK7TX5ilwSYwLJqP5duOo
         Gn4jPFMLmGC+i9iR/lW+BJfhjq1RrFzhFVBhpihTkf1UX7mFF9sqskXucTE74mSGMP
         kpXXRG9hTtpVD2LsmILAfqiCwGUcACcc5KugrwY0=
Date:   Sat, 12 Oct 2019 18:15:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.4-rc3
Message-ID: <20191012161553.GA2191565@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc3

for you to fetch changes up to aafb00a977cf7d81821f7c9d12e04c558c22dc3c:

  USB: yurex: fix NULL-derefs on disconnect (2019-10-10 14:24:06 +0200)

----------------------------------------------------------------
USB fixes for 5.4-rc3

Here are a lot of small USB driver fixes for 5.4-rc3.

syzbot has stepped up its testing of the USB driver stack, now able to
trigger fun race conditions between disconnect and probe functions.
Because of that we have a lot of fixes in here from Johan and others
fixing these reported issues that have been around since almost all
time.

We also are just deleting the rio500 driver, making all of the syzbot
bugs found in it moot as it turns out no one has been using it for years
as there is a userspace version that is being used instead.

There are also a number of other small fixes in here, all resolving
reported issues or regressions.

All have been in linux-next without any reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: yurex: Don't retry on unexpected errors

Arnd Bergmann (1):
      udc: lpc32xx: fix 64-bit compiler warning

Bastien Nocera (1):
      USB: rio500: Remove Rio 500 kernel driver

Beni Mahler (1):
      USB: serial: ftdi_sio: add device IDs for Sienna and Echelon PL-20

Bill Kuzeja (1):
      xhci: Prevent deadlock when xhci adapter breaks during init

Dan Carpenter (2):
      usb: cdns3: Fix use after free in probe error handling
      usb: typec: tcpm: usb: typec: tcpm: Fix a signedness bug in tcpm_fw_get_caps()

Daniele Palmas (1):
      USB: serial: option: add Telit FN980 compositions

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.4-rc2' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Hans de Goede (3):
      driver core: platform: Add platform_get_irq_byname_optional()
      usb: dwc3: Switch to platform_get_irq_byname_optional()
      usb: dwc3: Remove dev_err() on platform_get_irq() failure

Heikki Krogerus (2):
      usb: typec: ucsi: ccg: Remove run_isr flag
      usb: typec: ucsi: displayport: Fix for the mode entering routine

Jacky.Cao@sony.com (1):
      USB: dummy-hcd: fix power budget for SuperSpeed mode

Jan Schmidt (1):
      xhci: Check all endpoints for LPM timeout

Johan Hovold (30):
      USB: serial: keyspan: fix NULL-derefs on open() and write()
      USB: microtek: fix info-leak at probe
      USB: adutux: fix use-after-free on disconnect
      USB: adutux: fix NULL-derefs on disconnect
      USB: usblcd: fix I/O after disconnect
      USB: usblcd: drop redundant disconnect mutex
      USB: usblcd: drop redundant lcd mutex
      USB: usblcd: use pr_err()
      USB: legousbtower: fix slab info leak at probe
      USB: legousbtower: fix deadlock on disconnect
      USB: legousbtower: fix potential NULL-deref on disconnect
      USB: legousbtower: fix open after failed reset request
      USB: usb-skeleton: fix runtime PM after driver unbind
      USB: usblp: fix runtime PM after driver unbind
      USB: serial: fix runtime PM after driver unbind
      media: stkwebcam: fix runtime PM after driver unbind
      USB: usb-skeleton: fix NULL-deref on disconnect
      USB: usb-skeleton: fix use-after-free after driver unbind
      USB: usb-skeleton: drop redundant in-urb check
      USB: legousbtower: fix use-after-free on release
      USB: ldusb: fix NULL-derefs on driver unbind
      USB: adutux: fix use-after-free on release
      USB: chaoskey: fix use-after-free on release
      USB: iowarrior: fix use-after-free on disconnect
      USB: iowarrior: fix use-after-free on release
      USB: iowarrior: fix use-after-free after driver unbind
      USB: iowarrior: drop redundant disconnect mutex
      USB: iowarrior: drop redundant iowarrior mutex
      USB: iowarrior: use pr_err()
      USB: yurex: fix NULL-derefs on disconnect

Jonathan Neuschäfer (1):
      dt-bindings: usb: Fix references to usb-hcd.yaml

Kai-Heng Feng (1):
      xhci: Increase STS_SAVE timeout in xhci_suspend()

Mao Wenan (1):
      usbip: vhci_hcd indicate failed message

Mathias Nyman (4):
      xhci: Fix false warning message about wrong bounce buffer write length
      xhci: Prevent device initiated U1/U2 link pm if exit latency is too long
      xhci: Fix USB 3.1 capability detection on early xHCI 1.1 spec based hosts
      xhci: Fix NULL pointer dereference in xhci_clear_tt_buffer_complete()

Mauro Carvalho Chehab (1):
      bindings: rename links to mason USB2/USB3 DT files

Maxime Ripard (2):
      ARM: dts: sunxi: Revert phy-names removal for ECHI and OHCI
      dt-bindings: usb: Bring back phy-names

Pawel Laszczak (3):
      usb: cdns3: Fix sheduling with locks held.
      usb:cdns3: Fix for CV CH9 running with g_zero driver.
      usb: cdns3: Fix for incorrect DMA mask.

Reinhard Speyerer (1):
      USB: serial: option: add support for Cinterion CLS8 devices

Rick Tseng (1):
      usb: xhci: wait for CNR controller not ready bit in xhci resume

Roger Quadros (2):
      usb: cdns3: gadget: Fix full-speed mode
      usb: cdns3: fix cdns3_core_init_role()

Wei Yongjun (1):
      xhci-ext-caps.c: Add missing platform_device_put() on error in xhci_create_intel_xhci_sw_pdev()

Yoshihiro Shimoda (2):
      usb: renesas_usbhs: gadget: Do not discard queues in usb_ep_set_{halt,wedge}()
      usb: renesas_usbhs: gadget: Fix usb_ep_set_{halt,wedge}() behavior

 .../devicetree/bindings/usb/amlogic,dwc3.txt       |   4 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   7 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   7 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |   4 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   4 +-
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |   5 +
 Documentation/devicetree/bindings/usb/usb-uhci.txt |   2 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   4 +-
 Documentation/usb/rio.rst                          | 109 ----
 MAINTAINERS                                        |   7 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   4 +
 arch/arm/boot/dts/sun5i.dtsi                       |   2 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   4 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   4 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   2 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   3 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   4 +
 arch/arm/boot/dts/sun9i-a80.dtsi                   |   5 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   6 +
 arch/arm/configs/badge4_defconfig                  |   1 -
 arch/arm/configs/corgi_defconfig                   |   1 -
 arch/arm/configs/pxa_defconfig                     |   1 -
 arch/arm/configs/s3c2410_defconfig                 |   1 -
 arch/arm/configs/spitz_defconfig                   |   1 -
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   2 +
 arch/mips/configs/mtx1_defconfig                   |   1 -
 arch/mips/configs/rm200_defconfig                  |   1 -
 drivers/base/platform.c                            |  46 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |   3 +-
 drivers/usb/cdns3/cdns3-pci-wrap.c                 |   3 +-
 drivers/usb/cdns3/core.c                           |  20 +-
 drivers/usb/cdns3/ep0.c                            |  12 +-
 drivers/usb/cdns3/gadget.c                         |   8 +
 drivers/usb/class/usblp.c                          |   8 +-
 drivers/usb/dwc3/drd.c                             |   7 +-
 drivers/usb/dwc3/gadget.c                          |   7 +-
 drivers/usb/dwc3/host.c                            |   7 +-
 drivers/usb/gadget/udc/Kconfig                     |   2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   3 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   4 +-
 drivers/usb/host/xhci-ext-caps.c                   |   1 +
 drivers/usb/host/xhci-ring.c                       |   4 +-
 drivers/usb/host/xhci.c                            |  78 ++-
 drivers/usb/image/microtek.c                       |   4 +
 drivers/usb/misc/Kconfig                           |  10 -
 drivers/usb/misc/Makefile                          |   1 -
 drivers/usb/misc/adutux.c                          |  24 +-
 drivers/usb/misc/chaoskey.c                        |   5 +-
 drivers/usb/misc/iowarrior.c                       |  48 +-
 drivers/usb/misc/ldusb.c                           |  24 +-
 drivers/usb/misc/legousbtower.c                    |  58 +--
 drivers/usb/misc/rio500.c                          | 554 ---------------------
 drivers/usb/misc/rio500_usb.h                      |  20 -
 drivers/usb/misc/usblcd.c                          |  60 ++-
 drivers/usb/misc/yurex.c                           |  18 +-
 drivers/usb/renesas_usbhs/common.h                 |   1 +
 drivers/usb/renesas_usbhs/fifo.c                   |   2 +-
 drivers/usb/renesas_usbhs/fifo.h                   |   1 +
 drivers/usb/renesas_usbhs/mod_gadget.c             |  18 +-
 drivers/usb/renesas_usbhs/pipe.c                   |  15 +
 drivers/usb/renesas_usbhs/pipe.h                   |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   9 +
 drivers/usb/serial/keyspan.c                       |   4 +-
 drivers/usb/serial/option.c                        |  11 +
 drivers/usb/serial/usb-serial.c                    |   5 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  14 +-
 drivers/usb/typec/ucsi/displayport.c               |   2 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |  42 +-
 drivers/usb/usb-skeleton.c                         |  19 +-
 drivers/usb/usbip/vhci_hcd.c                       |   4 +-
 include/linux/platform_device.h                    |   2 +
 74 files changed, 431 insertions(+), 961 deletions(-)
 delete mode 100644 Documentation/usb/rio.rst
 delete mode 100644 drivers/usb/misc/rio500.c
 delete mode 100644 drivers/usb/misc/rio500_usb.h

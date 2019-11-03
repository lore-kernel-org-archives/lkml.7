Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B3DCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 14:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C1620663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572790541;
	bh=KwKea9wG7NCc77KWgSF90cuPCTzxWH/G6MaeQJtW3t0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EBtvbCblFOwdLGXA5lDiJW9ItdxEa/PQEZ2CcBVhlFmu7Op/cara381oqDe/2+Crm
	 /dEjiEhzXs71MTvAjhRiMFX+9o5cN/OQXEf0ZDlLiz2kbyNuSqzTt8lkvBe5q9tw9t
	 sAowfOQnGvtOHrvlfIqscwFq2z6KGW0GH9GkfiSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKCOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 09:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfKCOPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 09:15:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFE420663;
        Sun,  3 Nov 2019 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572790536;
        bh=KwKea9wG7NCc77KWgSF90cuPCTzxWH/G6MaeQJtW3t0=;
        h=Date:From:To:Cc:Subject:From;
        b=oAoxmB3sIQIJd2HkxbMJ8wmf+NLBHr1KO0klRV1eDtEGUqQdGi9HFpRG18CQCSlW/
         am1qPgEupkyl6M08e8yECsEJlbq+nabgHiV1yXMe1DxMklL+RNVTQ+iLqkCpSpq5VC
         +ZecbpBbtAsMbV5nsZ6QkFRVAobgt4iYaT20LaMA=
Date:   Sun, 3 Nov 2019 15:15:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.4-rc6
Message-ID: <20191103141534.GA661190@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc6

for you to fetch changes up to d8eca64eec7103ab1fbabc0a187dbf6acfb2af93:

  usb: dwc3: gadget: fix race when disabling ep with cancelled xfers (2019-10-31 18:57:54 +0100)

----------------------------------------------------------------
USB fixes for 5.4-rc6

The USB sub-maintainers woke up this past week and sent a bunch of tiny
fixes.  Here are a lot of small patches that that resolve a bunch of
reported issues in the USB core, drivers, serial drivers, gadget
drivers, and of course, xhci :)

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (4):
      USB: Skip endpoints with 0 maxpacket length
      usb-storage: Revert commit 747668dbc061 ("usb-storage: Set virt_boundary_mask to avoid SG overflows")
      UAS: Revert commit 3ae62a42090f ("UAS: fix alignment of scatter/gather segments")
      USB: gadget: Reject endpoints with 0 maxpacket value

Arnd Bergmann (1):
      usb: dwc3: select CONFIG_REGMAP_MMIO

Ben Dooks (Codethink) (5):
      usb: mtu3: fix missing include of mtu3_dr.h
      usb: cdns3: include host-export,h for cdns3_host_init
      usb: renesas_usbhs: fix __le16 warnings
      usb: renesas_usbhs: fix type of buf
      usb: xhci: fix __le32/__le64 accessors in debugfs code

Chandana Kishori Chiluveru (1):
      usb: gadget: composite: Fix possible double free memory bug

Cristian Birsan (1):
      usb: gadget: udc: atmel: Fix interrupt storm in FIFO mode.

Felipe Balbi (1):
      usb: dwc3: gadget: fix race when disabling ep with cancelled xfers

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v5.4-rc5' of git://git.kernel.org/.../balbi/usb into usb-linus

GwanYeong Kim (1):
      usbip: tools: Fix read_usb_vudc_device() error path handling

Johan Hovold (5):
      USB: ldusb: fix ring-buffer locking
      USB: ldusb: use unsigned size format specifiers
      USB: ldusb: fix control-message timeout
      USB: serial: whiteheat: fix potential slab corruption
      USB: serial: whiteheat: fix line-speed endianness

Mathias Nyman (1):
      xhci: Fix use-after-free regression in xhci clear hub TT implementation

Navid Emamdoost (1):
      usb: dwc3: pci: prevent memory leak in dwc3_pci_probe

Nikhil Badola (1):
      usb: fsl: Check memory resource before releasing it

Peter Chen (1):
      usb: gadget: configfs: fix concurrent issue between composite APIs

Roger Quadros (2):
      usb: cdns3: gadget: Don't manage pullups
      usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host

Samuel Holland (1):
      usb: xhci: fix Immediate Data Transfer endianness

Sanket Parmar (1):
      usb: cdns3: gadget: reset EP_CLAIMED flag while unloading

Suwan Kim (1):
      usbip: Fix free of unallocated memory in vhci tx

Yinbo Zhu (1):
      usb: dwc3: remove the call trace of USBx_GFLADJ

Yoshihiro Shimoda (2):
      usb: gadget: udc: renesas_usb3: Fix __le16 warnings
      usb: renesas_usbhs: Fix warnings in usbhsg_recip_handler_std_set_device()

 drivers/usb/cdns3/gadget.c                   |  37 ++++++---
 drivers/usb/cdns3/host-export.h              |   1 -
 drivers/usb/cdns3/host.c                     |   1 +
 drivers/usb/core/config.c                    |   5 ++
 drivers/usb/dwc3/Kconfig                     |   1 +
 drivers/usb/dwc3/core.c                      |   3 +-
 drivers/usb/dwc3/dwc3-pci.c                  |   2 +-
 drivers/usb/dwc3/gadget.c                    |   6 ++
 drivers/usb/gadget/composite.c               |   4 +
 drivers/usb/gadget/configfs.c                | 110 +++++++++++++++++++++++++--
 drivers/usb/gadget/udc/atmel_usba_udc.c      |   6 +-
 drivers/usb/gadget/udc/core.c                |  11 +++
 drivers/usb/gadget/udc/fsl_udc_core.c        |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c        |  11 +--
 drivers/usb/host/xhci-debugfs.c              |  24 +++---
 drivers/usb/host/xhci-ring.c                 |   2 +
 drivers/usb/host/xhci.c                      |  54 ++++++++++---
 drivers/usb/misc/ldusb.c                     |  13 ++--
 drivers/usb/mtu3/mtu3_core.c                 |   1 +
 drivers/usb/renesas_usbhs/common.c           |  12 +--
 drivers/usb/renesas_usbhs/mod_gadget.c       |   4 +-
 drivers/usb/serial/whiteheat.c               |  13 +++-
 drivers/usb/serial/whiteheat.h               |   2 +-
 drivers/usb/storage/scsiglue.c               |  10 ---
 drivers/usb/storage/uas.c                    |  20 -----
 drivers/usb/usbip/vhci_tx.c                  |   3 +
 tools/usb/usbip/libsrc/usbip_device_driver.c |   6 +-
 27 files changed, 267 insertions(+), 97 deletions(-)

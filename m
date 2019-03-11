Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0559C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1072084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfCKQiz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:38:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46926 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:38:54 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id ADE59CF2C9;
        Mon, 11 Mar 2019 17:46:50 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1 2/2] Bluetooth: mediatek: add support for MediaTek
 MT7663S and MT7668S SDIO devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <89776e11d742196e50e2d5f3ccc4336dc5aee134.1552007059.git.sean.wang@mediatek.com>
Date:   Mon, 11 Mar 2019 17:38:51 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71123002-4772-4BDC-BFEF-4C520F4459FE@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
 <89776e11d742196e50e2d5f3ccc4336dc5aee134.1552007059.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> This adds the support of enabling MT7663S and MT7668S SDIO-based
> Bluetooth function.
> 
> There are quite many differences between MT766[3,8]S and standard
> Bluetooth SDIO devices such as Type-A and Type-B devices. For example,
> MT766[3,8]S have its own SDIO registers layout, definition, SDIO packet
> format, and the specific flow should be programmed on them to complete
> the device initialization and low power control and so on.
> 
> Currently, there are many independent programming sequences from the
> transport which are exactly the same as the ones in btusb.c about MediaTek
> support [1] and btmtkuart.c. We can try to split the transport independent
> Bluetooth setups on the advance, place them into the common files and allow
> varous transport drivers to reuse them in the future.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/Kconfig     |  11 +
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btmtksdio.c | 979 ++++++++++++++++++++++++++++++++++
> 3 files changed, 991 insertions(+)
> create mode 100644 drivers/bluetooth/btmtksdio.c

patch has been applied to bluetooth-next tree.

You also need to send an extra patch providing a fix for this:

  CC      drivers/bluetooth/btmtksdio.o
drivers/bluetooth/btmtksdio.c: In function ‘btmtksdio_interrupt’:
drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
  unsigned int old_len;
               ^~~~~~~
drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
  unsigned char *old_data;
                 ^~~~~~~~

And can we actually introduce module_sdio_driver similar to module_usb_driver.

Regards

Marcel


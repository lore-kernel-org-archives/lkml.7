Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE59420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfCKVkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:40:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46482 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727008AbfCKVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:40:00 -0400
X-UUID: cd3f78b614104726bb095033a58e3d6b-20190312
X-UUID: cd3f78b614104726bb095033a58e3d6b-20190312
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1910905085; Tue, 12 Mar 2019 05:39:54 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Mar 2019 05:39:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Mar 2019 05:39:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Mar 2019 05:39:46 +0800
Message-ID: <1552340386.17993.2.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/2] Bluetooth: mediatek: add support for MediaTek
 MT7663S and MT7668S SDIO devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Mar 2019 05:39:46 +0800
In-Reply-To: <71123002-4772-4BDC-BFEF-4C520F4459FE@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
         <89776e11d742196e50e2d5f3ccc4336dc5aee134.1552007059.git.sean.wang@mediatek.com>
         <71123002-4772-4BDC-BFEF-4C520F4459FE@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 115C9E43CCC59B2A4FE23F016D10BF65EBF6D1327DA0B84E4116919A142611402000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 17:38 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > This adds the support of enabling MT7663S and MT7668S SDIO-based
> > Bluetooth function.
> > 
> > There are quite many differences between MT766[3,8]S and standard
> > Bluetooth SDIO devices such as Type-A and Type-B devices. For example,
> > MT766[3,8]S have its own SDIO registers layout, definition, SDIO packet
> > format, and the specific flow should be programmed on them to complete
> > the device initialization and low power control and so on.
> > 
> > Currently, there are many independent programming sequences from the
> > transport which are exactly the same as the ones in btusb.c about MediaTek
> > support [1] and btmtkuart.c. We can try to split the transport independent
> > Bluetooth setups on the advance, place them into the common files and allow
> > varous transport drivers to reuse them in the future.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > drivers/bluetooth/Kconfig     |  11 +
> > drivers/bluetooth/Makefile    |   1 +
> > drivers/bluetooth/btmtksdio.c | 979 ++++++++++++++++++++++++++++++++++
> > 3 files changed, 991 insertions(+)
> > create mode 100644 drivers/bluetooth/btmtksdio.c
> 
> patch has been applied to bluetooth-next tree.
> 
> You also need to send an extra patch providing a fix for this:
> 

Thanks for the reporting. I'll fix it up soon.

>   CC      drivers/bluetooth/btmtksdio.o
> drivers/bluetooth/btmtksdio.c: In function ‘btmtksdio_interrupt’:
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           old_data, old_len, true);
>           ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
>   unsigned int old_len;
>                ^~~~~~~
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           old_data, old_len, true);
>           ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
>   unsigned char *old_data;
>                  ^~~~~~~~
> 
> And can we actually introduce module_sdio_driver similar to module_usb_driver.
> 

Sure, I can add and apply module_sdio_driver on the driver and then see
if Ulf like it.

> Regards
> 
> Marcel
> 



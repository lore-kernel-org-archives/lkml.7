Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00919C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C226F2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfC0G43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:56:29 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11401 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731583AbfC0G43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:56:29 -0400
X-UUID: 1f02f4ece1374a00959cf2311857a537-20190327
X-UUID: 1f02f4ece1374a00959cf2311857a537-20190327
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1029117115; Wed, 27 Mar 2019 14:56:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Mar
 2019 14:56:19 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:56:19 +0800
Message-ID: <1553669779.10179.172.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: mtu3: fix EXTCON dependency
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Mar 2019 14:56:19 +0800
In-Reply-To: <20190325135440.2166315-1-arnd@arndb.de>
References: <20190325135440.2166315-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 651F7988FCF2C72B0EB449E36F2D4F2E03D516550D08353FFCD6E2834597AC0C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 2019-03-25 at 14:54 +0100, Arnd Bergmann wrote:
> When EXTCON is a loadable module, mtu3 fails to link as built-in:
> 
> drivers/usb/mtu3/mtu3_plat.o: In function `mtu3_probe':
> mtu3_plat.c:(.text+0x690): undefined reference to `extcon_get_edev_by_phandle'
> 
> Add a Kconfig dependency to force mtu3 also to be a loadable module
> if extconn is, but still allow it to be built without extcon.
     ^^ extcon

> 
> Fixes: d0ed062a8b75 ("usb: mtu3: dual-role mode support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/mtu3/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
> index bcc23486c4ed..928c2cd6fc00 100644
> --- a/drivers/usb/mtu3/Kconfig
> +++ b/drivers/usb/mtu3/Kconfig
> @@ -6,6 +6,7 @@ config USB_MTU3
>  	tristate "MediaTek USB3 Dual Role controller"
>  	depends on USB || USB_GADGET
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on EXTCON || !EXTCON
>  	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
>  	help
>  	  Say Y or M here if your system runs on MediaTek SoCs with

Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thank you!




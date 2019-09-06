Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8048206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391915AbfIFBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:43:21 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64711 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727411AbfIFBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:43:21 -0400
X-UUID: 416b913ac2624eb89f6c6c896ecff1b3-20190906
X-UUID: 416b913ac2624eb89f6c6c896ecff1b3-20190906
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 589645460; Fri, 06 Sep 2019 09:43:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 6 Sep
 2019 09:43:13 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 09:43:09 +0800
Message-ID: <1567734192.7317.68.camel@mhfsdcap03>
Subject: Re: [Patch V8 7/8] usb: gadget: Add UDC driver for tegra XUSB
 device mode controller
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Fri, 6 Sep 2019 09:43:12 +0800
In-Reply-To: <36447248-1ddb-ff1d-a731-de6afb445a9d@nvidia.com>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
         <1567585440-13751-8-git-send-email-nkristam@nvidia.com>
         <1567593053.7317.64.camel@mhfsdcap03>
         <36447248-1ddb-ff1d-a731-de6afb445a9d@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 74304609C9695D046C28449A67793BF212AAF7C3B9AC8A92D4992BCB9FBBF8632000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 09:57 +0530, Nagarjuna Kristam wrote:
> 
> On 04-09-2019 16:00, Chunfeng Yun wrote:
> > On Wed, 2019-09-04 at 13:53 +0530, Nagarjuna Kristam wrote:
> >> This patch adds UDC driver for tegra XUSB 3.0 device mode controller.
> >> XUSB device mode controller supports SS, HS and FS modes
> >>
> >> Based on work by:
> >>   Mark Kuo <mkuo@nvidia.com>
> >>   Hui Fu <hfu@nvidia.com>
> >>   Andrew Bresticker <abrestic@chromium.org>
> >>
> >> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> >> Acked-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>  drivers/usb/gadget/udc/Kconfig      |   12 +
> >>  drivers/usb/gadget/udc/Makefile     |    1 +
> >>  drivers/usb/gadget/udc/tegra-xudc.c | 3791 +++++++++++++++++++++++++++++++++++
> >>  3 files changed, 3804 insertions(+)
> >>  create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c
> >>
> >> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> >> index d354036..0fe7577 100644
> >> --- a/drivers/usb/gadget/udc/Kconfig
> >> +++ b/drivers/usb/gadget/udc/Kconfig
> >> @@ -441,6 +441,18 @@ config USB_GADGET_XILINX
> >>  	  dynamically linked module called "udc-xilinx" and force all
> >>  	  gadget drivers to also be dynamically linked.
> >>  
> >> +config USB_TEGRA_XUDC
> >> +	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
> >> +	depends on ARCH_TEGRA || COMPILE_TEST
> >> +	depends on PHY_TEGRA_XUSB
> >> +	select USB_CONN_GPIO
> > To me, needn't select this driver, without it, the driver still build
> > pass
> > 
> Yes compilation passes with out this. Added select for getting USB_CONN_GPIO
> driver functionality.
We can enable it in defconfig, think about one day use type-c to do
dual-role switch, or other ways, will needn't select it then.

> 
> >> +	help
> >> +	 Enables NVIDIA Tegra USB 3.0 device mode controller driver.
> >> +
> >> +	 Say "y" to link the driver statically, or "m" to build a
> >> +	 dynamically linked module called "tegra_xudc" and force all
> >> +	 gadget drivers to also be dynamically linked.
> >> +
> >>  source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
> >>  



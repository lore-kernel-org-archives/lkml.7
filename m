Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F310C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D810C2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCDMPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:15:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfCDMPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:15:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92451A78;
        Mon,  4 Mar 2019 04:15:24 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5A43F575;
        Mon,  4 Mar 2019 04:15:21 -0800 (PST)
Subject: Re: [PATCH v3 00/12] Add support for usb on Hikey960
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com
References: <20190302090505.65542-1-chenyu56@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <14470535-0101-bdc9-17ca-52025c42fd4c@arm.com>
Date:   Mon, 4 Mar 2019 12:15:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190302090505.65542-1-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/2019 09:04, Yu Chen wrote:
> The patchset adds support for usb functionality of Hikey960, includes:
> - dwc3 driver for Hisilicon Kirin Soc hi3660
> - usb driver for HiKey960 board
> - some adjustment in dwc3, usb gadget and typec driver
> - dts for support usb of HiKey960
> 
> This patchset based on patchset https://lkml.org/lkml/2019/1/25/344
> of Heikki Krogerus
> 

Works fine on my board, thanks for keeping this up.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Yu Chen (12):
>   dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
>   dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
>     switch functionality on HiKey960
>   usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc
>     Platform
>   usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc
>   usb: dwc3: Execute GCTL Core Soft Reset while switch mdoe for
>     Hisilicon Kirin Soc
>   usb: dwc3: Increase timeout for CmdAct cleared by device controller
>   phy: Add usb phy support for hi3660 Soc of Hisilicon
>   usb: roles: Add usb role switch notifier.
>   usb: dwc3: Registering a role switch in the DRD code.
>   hikey960: Support usb functionality of Hikey960
>   usb: gadget: Add configfs attribuite for controling
>     match_existing_only
>   dts: hi3660: Add support for usb on Hikey960
> 
>  .../bindings/misc/hisilicon-hikey-usb.txt          |  52 +++++
>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  28 +++
>  MAINTAINERS                                        |   8 +
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  53 +++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  74 +++++++
>  drivers/misc/Kconfig                               |   6 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/hisi_hikey_usb.c                      | 167 +++++++++++++++
>  drivers/phy/hisilicon/Kconfig                      |  10 +
>  drivers/phy/hisilicon/Makefile                     |   1 +
>  drivers/phy/hisilicon/phy-hi3660-usb3.c            | 232 +++++++++++++++++++++
>  drivers/usb/dwc3/Kconfig                           |   1 +
>  drivers/usb/dwc3/core.c                            |  43 ++++
>  drivers/usb/dwc3/core.h                            |  10 +
>  drivers/usb/dwc3/drd.c                             |  58 +++++-
>  drivers/usb/dwc3/dwc3-of-simple.c                  |   4 +-
>  drivers/usb/dwc3/gadget.c                          |   2 +-
>  drivers/usb/gadget/configfs.c                      |  32 +++
>  drivers/usb/roles/class.c                          |  20 +-
>  include/linux/usb/role.h                           |  46 ++++
>  20 files changed, 844 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>  create mode 100644 drivers/misc/hisi_hikey_usb.c
>  create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
> 

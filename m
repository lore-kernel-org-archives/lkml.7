Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5711ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC32E2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbfJPAzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:55:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfJPAzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:55:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0656E38D07370F6AE70;
        Wed, 16 Oct 2019 08:55:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 08:54:57 +0800
Subject: Re: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <biju.das@bp.renesas.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20191009014707.38716-1-maowenan@huawei.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <ff1837bd-d6eb-a296-f7d9-f2988d5d2256@huawei.com>
Date:   Wed, 16 Oct 2019 08:54:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191009014707.38716-1-maowenan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping.

On 2019/10/9 9:47, Mao Wenan wrote:
> If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below errors
> can be found:
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch_get'
> hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
> make: *** [vmlinux] Error 1
> 
> This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.
> 
> Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index aceb2af..b4f2aac 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  config TYPEC_HD3SS3220
>  	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
>  	depends on I2C
> +	depends on USB_ROLE_SWITCH
>  	help
>  	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
>  	  controller driver.
> 


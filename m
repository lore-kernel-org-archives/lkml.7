Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3427C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NH+xDUnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfDBLB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:01:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56932 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:01:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32B1lNv027810;
        Tue, 2 Apr 2019 06:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554202907;
        bh=2J8KQu8yjS5ZtPeCDJllDx33ES+eCEH6qt0qOJc6BBc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NH+xDUnCZRuYNrskDtOSrLyXs10E0CBBT3PxayCCJWM0rpD1ozOsqty4zBM3YjxiH
         In+W3JzymCvmBh6rmb9zRMTZjn/JD6Za0ILJMnOc/lkiia3kbX85jbJoWahYZ25/sO
         vjSjMEJ78tbmMAb3CaUmUwuy3Fa9LY3gUJErJ19o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32B1laa008029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 06:01:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 06:01:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 06:01:47 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32B1hq3024444;
        Tue, 2 Apr 2019 06:01:44 -0500
Subject: Re: [PATCH v2 4/6] ARM: davinci: omapl138-hawk: add a fixed regulator
 for ohci-da8xx
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190329093334.3885-1-brgl@bgdev.pl>
 <20190329093334.3885-5-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <8346cd90-3558-479b-2129-8ae7915b3bda@ti.com>
Date:   Tue, 2 Apr 2019 16:31:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329093334.3885-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 29/03/19 3:03 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Instead of directly using the vbus GPIO we should model it as a fixed
> regulator. Add all necessary fix-ups for the regulator to be registered
> and configure the vbus GPIO as its enable pin.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 49 +++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index e244c8648594..0039b4d4c935 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_data/mtd-davinci.h>
>  #include <linux/platform_data/mtd-davinci-aemif.h>
>  #include <linux/platform_data/ti-aemif.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
> @@ -298,15 +299,50 @@ static const short da850_hawk_usb11_pins[] = {
>  	-1
>  };
>  
> -static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
> +static struct regulator_consumer_supply hawk_usb_supplies[] = {
> +	REGULATOR_SUPPLY("vbus", NULL),
> +};
> +
> +static struct regulator_init_data hawk_usb_vbus_data = {
> +	.consumer_supplies	= hawk_usb_supplies,
> +	.num_consumer_supplies	= ARRAY_SIZE(hawk_usb_supplies),
> +};
> +
> +static struct fixed_voltage_config hawk_usb_vbus = {
> +	.supply_name		= "vbus",
> +	.microvolts		= 3300000,
> +	.init_data		= &hawk_usb_vbus_data,
> +};
> +
> +static struct platform_device hawk_usb_vbus_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,

Can you explain choice of of 1 for id here? Its the first fixed
regulator being registered. Shouldn't it be 0?

Thanks,
Sekhar

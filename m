Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E2x9mucD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCRKrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:47:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:60167 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfCRKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:47:31 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190318104728epoutp03812b999659ec05ff4659df6d4fe89f15~NB9LelAMR2660926609epoutp037
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190318104728epoutp03812b999659ec05ff4659df6d4fe89f15~NB9LelAMR2660926609epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552906048;
        bh=m0G1c0jdSOjeB5uZa7VrErfIFAKoaNVPPLN2gCAWPSw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E2x9mucDttl+XJXDLhJj8bkVEOz+AedH7IkyGs3pR07Q53aGdxwnpRFMqXLkKrrhx
         ncGXdwu/Jgz/jitVT2ABeSlGFedQNLyZJQu8m1uH5Rq0EGvdSGOtAS/iWNsfB0LPc7
         U17k+7WkT/oGNOLUyMCoq8rif6JWQ1a3TzRHNY2g=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190318104725epcas1p184d78d4a32cdd166f6ffa3d8ae05f6a7~NB9IuJ_wv1232312323epcas1p1t;
        Mon, 18 Mar 2019 10:47:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.6D.04257.D377F8C5; Mon, 18 Mar 2019 19:47:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190318104725epcas1p20e2d54f14949130f15fbd8d0a2c7a5fd~NB9ISw2wU2738227382epcas1p2P;
        Mon, 18 Mar 2019 10:47:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190318104725epsmtrp1e614cbaef31571a7f6da4f2067c7f467~NB9IR_Op81356513565epsmtrp1_;
        Mon, 18 Mar 2019 10:47:25 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-05-5c8f773d870f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.62.03692.D377F8C5; Mon, 18 Mar 2019 19:47:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190318104725epsmtip1f99112a5ecbb40a8352a809890f153e3~NB9IEcwh21604616046epsmtip1q;
        Mon, 18 Mar 2019 10:47:25 +0000 (GMT)
Subject: Re: [PATCH 2/2] extcon: Add fsa9480 extcon driver
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        myungjoo.ham@samsung.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cf4b529c-2c04-96fc-3d83-289dea3bd7eb@samsung.com>
Date:   Mon, 18 Mar 2019 19:47:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225165822.2770-3-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmvq5teX+Mwd8mLYv5R86xWlzeNYfN
        Yun1i0wWtxtXsFn8ON7HbNG69wi7xapdfxgtLk68y+LA4bFm3hpGj52z7rJ7bFrVyeax6OYP
        Fo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQnXF+53O2gtddjBVTr05kb2Ccn93FyMkhIWAiMX3OBXYQW0hgB6PEqVl+
        EPYnRok/l/Mh7G+MEpMXacPU71u/jbGLkQsovpdRYtO15VDOe0aJvasvsoFUCQtYSdxd+gDM
        FhGIk5jXNpkFpIhZYAujxP+t3SwgCTYBLYn9L26AFfELKEpc/fGYEcTmFbCT2PPqFFANBweL
        gKrE3S5lkLCoQITE+6e7WSBKBCVOznwCZnMKOEv8mXCLCcRmFhCXuPVkPpQtL9G8dTYzyF4J
        gXZ2iV1LnjJCvOAisWnLWihbWOLV8S3sELaUxMv+Nii7WmLlySNsEM0djBJb9l9ghUgYS+xf
        OpkJ5DhmAU2J9bv0IZbxSbz72sMKEpYQ4JXoaBOCqFaWuPzgLhOELSmxuL2TDcL2kNh1bz/7
        BEbFWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwIT5MjexAhOq1oWOxj3nPM5xCjAwajE
        w9swpS9GiDWxrLgy9xCjBAezkgivvWd/jBBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3OB6b8
        vJJ4Q1MjY2NjCxNDM1NDQyVx3vUOzjFCAumJJanZqakFqUUwfUwcnFINjF0v8lvNmX6KhKVq
        75GLs9rvV7skrXtXtfGjyWpCPRtqVI9ncWzznl0okW929NTi6LkCz1f3s/2dEXbz0MLlHz7/
        FfhsLxOerNk+4fmK5hNZ6zLeG0h/FUj3SUvmeN/M0/t2Af9KXwGP2BBf9p0cLXG5cs86eFZ4
        H9obdjv7Wcya8KelH/c2KrEUZyQaajEXFScCAFxdJy/BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK5teX+MwcMnvBbzj5xjtbi8aw6b
        xdLrF5ksbjeuYLP4cbyP2aJ17xF2i1W7/jBaXJx4l8WBw2PNvDWMHjtn3WX32LSqk81j0c0f
        LB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcX7nc7aC112MFVOvTmRvYJyf3cXIySEhYCKx
        b/02xi5GLg4hgd2MEnP7nrJBJCQlpl08ytzFyAFkC0scPlwMUfOWUeLJnafsIDXCAlYSd5c+
        AKsXEYiTmLhlPytIEbPAFkaJ3q2fmCA6zjNK3Nx8hgWkik1AS2L/ixtgHfwCihJXfzxmBLF5
        Bewk9rw6xQKyjUVAVeJulzJIWFQgQuLuxRcsECWCEidnPgGzOQWcJf5MuMUEYjMLqEv8mXeJ
        GcIWl7j1ZD5UXF6ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIER5mW5g7Gy0viDzEKcDAq8fDemNYXI8SaWFZcmXuIUYKDWUmE196zP0aI
        NyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRnUFwzLHYvvZ
        r2/J9x04fsTnyK1Xd0uPXNrIrNb1UuXLBKHQD1M4dilcXGw844zL4+3JX9j+/dV+cTdp8+0f
        ay55NP08tK5kmbWCsEfIsqWMH+xvi052Wz9B/Vmwf2l/iPudB5XBf7wuNDLYW11edOj4sxyp
        57u4fi47fM7UZO6WWNaSMLMrsZFKLMUZiYZazEXFiQBNXk+irgIAAA==
X-CMS-MailID: 20190318104725epcas1p20e2d54f14949130f15fbd8d0a2c7a5fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190225165927epcas1p20f92e499ff33ecc53d6978fab9593fe3
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
        <CGME20190225165927epcas1p20f92e499ff33ecc53d6978fab9593fe3@epcas1p2.samsung.com>
        <20190225165822.2770-3-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for late reply.

On 19. 2. 26. 오전 1:58, Paweł Chmiel wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch adds extcon driver for Fairchild Semiconductor FSA9480
> microUSB switch.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/extcon/Kconfig          |  10 +
>  drivers/extcon/Makefile         |   1 +
>  drivers/extcon/extcon-fsa9480.c | 473 ++++++++++++++++++++++++++++++++
>  3 files changed, 484 insertions(+)
>  create mode 100644 drivers/extcon/extcon-fsa9480.c
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index de15bf55895b..9904f993d39a 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -36,6 +36,16 @@ config EXTCON_AXP288
>  	  Say Y here to enable support for USB peripheral detection
>  	  and USB MUX switching by X-Power AXP288 PMIC.
>  
> +config EXTCON_FSA9480
> +	tristate "FSA9480 EXTCON Support"
> +	depends on INPUT

I add the comment about I2C interface. If you use the REGMAP_I2C,
please add the proper dependency to prevent the build error.

> +	help
> +	  If you say yes here you get support for the Fairchild Semiconductor
> +	  FSA9480 microUSB switch and accessory detector chip. The FSA9480 is a USB
> +	  port accessory detector and switch. The FSA9480 is fully controlled using
> +	  I2C and enables USB data, stereo and mono audio, video, microphone
> +	  and UART data to use a common connector port.
> +
>  config EXTCON_GPIO
>  	tristate "GPIO extcon support"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 0888fdeded72..0a3a96d92a28 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -8,6 +8,7 @@ extcon-core-objs		+= extcon.o devres.o
>  obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
>  obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
>  obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
> +obj-$(CONFIG_EXTCON_FSA9480)	+= extcon-fsa9480.o
>  obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
>  obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
>  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
> new file mode 100644
> index 000000000000..5c58f3e3f0e4
> --- /dev/null
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * extcon-fsa9480.c - Fairchild Semiconductor FSA9480 extcon driver
> + *
> + * Copyright (c) 2014 Tomasz Figa <tomasz.figa@gmail.com>
> + *
> + * Loosely based on old fsa9480 misc-device driver.
> + *

This driver keep the 'SPDX' license rule. So, you don't need
following license sentences. Please remove them.

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/kobject.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/irqdomain.h>
> +
> +/* FSA9480 I2C registers */
> +#define FSA9480_REG_DEVID               0x01
> +#define FSA9480_REG_CTRL                0x02
> +#define FSA9480_REG_INT1                0x03
> +#define FSA9480_REG_INT2                0x04
> +#define FSA9480_REG_INT1_MASK           0x05
> +#define FSA9480_REG_INT2_MASK           0x06
> +#define FSA9480_REG_ADC                 0x07
> +#define FSA9480_REG_TIMING1             0x08
> +#define FSA9480_REG_TIMING2             0x09
> +#define FSA9480_REG_DEV_T1              0x0a
> +#define FSA9480_REG_DEV_T2              0x0b
> +#define FSA9480_REG_BTN1                0x0c
> +#define FSA9480_REG_BTN2                0x0d
> +#define FSA9480_REG_CK                  0x0e
> +#define FSA9480_REG_CK_INT1             0x0f
> +#define FSA9480_REG_CK_INT2             0x10
> +#define FSA9480_REG_CK_INTMASK1         0x11
> +#define FSA9480_REG_CK_INTMASK2         0x12
> +#define FSA9480_REG_MANSW1              0x13
> +#define FSA9480_REG_MANSW2              0x14
> +
> +/* Control */
> +#define CON_SWITCH_OPEN         (1 << 4)
> +#define CON_RAW_DATA            (1 << 3)
> +#define CON_MANUAL_SW           (1 << 2)
> +#define CON_WAIT                (1 << 1)
> +#define CON_INT_MASK            (1 << 0)
> +#define CON_MASK                (CON_SWITCH_OPEN | CON_RAW_DATA | \
> +				 CON_MANUAL_SW | CON_WAIT)
> +
> +/* Device Type 1 */
> +#define DEV_USB_OTG             7
> +#define DEV_DEDICATED_CHG       6
> +#define DEV_USB_CHG             5
> +#define DEV_CAR_KIT             4
> +#define DEV_UART                3
> +#define DEV_USB                 2
> +#define DEV_AUDIO_2             1
> +#define DEV_AUDIO_1             0
> +
> +#define DEV_T1_USB_MASK         (DEV_USB_OTG | DEV_USB)
> +#define DEV_T1_UART_MASK        (DEV_UART)
> +#define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
> +
> +/* Device Type 2 */
> +#define DEV_AV                  14
> +#define DEV_TTY                 13
> +#define DEV_PPD                 12
> +#define DEV_JIG_UART_OFF        11
> +#define DEV_JIG_UART_ON         10
> +#define DEV_JIG_USB_OFF         9
> +#define DEV_JIG_USB_ON          8
> +
> +#define DEV_T2_USB_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON)
> +#define DEV_T2_UART_MASK        (DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> +#define DEV_T2_JIG_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON | \
> +				 DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> +
> +/*
> + * Manual Switch
> + * D- [7:5] / D+ [4:2]
> + * 000: Open all / 001: USB / 010: AUDIO / 011: UART / 100: V_AUDIO
> + */
> +#define SW_VAUDIO               ((4 << 5) | (4 << 2))
> +#define SW_UART                 ((3 << 5) | (3 << 2))
> +#define SW_AUDIO                ((2 << 5) | (2 << 2))
> +#define SW_DHOST                ((1 << 5) | (1 << 2))
> +#define SW_AUTO                 ((0 << 5) | (0 << 2))
> +
> +/* Interrupt 1 */
> +#define INT1_MASK               (0xff << 0)
> +#define INT_DETACH              (1 << 1)
> +#define INT_ATTACH              (1 << 0)
> +
> +/* Interrupt 2 mask */
> +#define INT2_MASK               (0x1f << 0)
> +
> +/* Timing Set 1 */
> +#define TIMING1_ADC_500MS       (0x6 << 0)
> +
> +struct fsa9480_usbsw {
> +	struct i2c_client *client;

Usually, many device drivers uses the REGMAP_I2C instead of
using the i2c API directly. I recommend you use regmap interface.


> +	struct extcon_dev *edev;
> +	u16 dev;
> +	u16 mansw;
> +};
> +
> +static const unsigned int fsa9480_extcon_cable[] = {
> +	EXTCON_USB_HOST,
> +	EXTCON_USB,
> +	EXTCON_CHG_USB_DCP,
> +	EXTCON_CHG_USB_SDP,
> +	EXTCON_CHG_USB_ACA,
> +	EXTCON_JACK_LINE_OUT,
> +	EXTCON_JACK_VIDEO_OUT,
> +	EXTCON_JIG,
> +
> +	EXTCON_NONE,
> +};
> +
> +static const u64 cable_types[] = {
> +	[DEV_USB_OTG] = BIT_ULL(EXTCON_USB_HOST),
> +	[DEV_DEDICATED_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_DCP),
> +	[DEV_USB_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
> +	[DEV_CAR_KIT] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP)
> +			| BIT_ULL(EXTCON_JACK_LINE_OUT),
> +	[DEV_UART] = BIT_ULL(EXTCON_JIG),
> +	[DEV_USB] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
> +	[DEV_AUDIO_2] = BIT_ULL(EXTCON_JACK_LINE_OUT),
> +	[DEV_AUDIO_1] = BIT_ULL(EXTCON_JACK_LINE_OUT),
> +	[DEV_AV] = BIT_ULL(EXTCON_JACK_LINE_OUT)
> +		   | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
> +	[DEV_TTY] = BIT_ULL(EXTCON_JIG),
> +	[DEV_PPD] = BIT_ULL(EXTCON_JACK_LINE_OUT) | BIT_ULL(EXTCON_CHG_USB_ACA),
> +	[DEV_JIG_UART_OFF] = BIT_ULL(EXTCON_JIG),
> +	[DEV_JIG_UART_ON] = BIT_ULL(EXTCON_JIG),
> +	[DEV_JIG_USB_OFF] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
> +	[DEV_JIG_USB_ON] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
> +};
> +
> +static int fsa9480_write_reg(struct i2c_client *client, int reg, int value)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, reg, value);
> +	if (ret < 0)
> +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int fsa9480_read_reg(struct i2c_client *client, int reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret < 0)
> +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int fsa9480_read_irq(struct i2c_client *client, int *value)
> +{
> +	u8 regs[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, FSA9480_REG_INT1, 2, regs);
> +	if (ret < 0)
> +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +
> +	*value = regs[1] << 8 | regs[0];
> +	return ret;
> +}
> +
> +static void fsa9480_set_switch(struct i2c_client *client, const char *buf)
> +{
> +	struct  fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
> +	unsigned int value;
> +	unsigned int path = 0;
> +
> +	value = fsa9480_read_reg(client, FSA9480_REG_CTRL);
> +
> +	if (!strncmp(buf, "VAUDIO", 6)) {
> +		path = SW_VAUDIO;
> +		value &= ~CON_MANUAL_SW;
> +	} else if (!strncmp(buf, "UART", 4)) {
> +		path = SW_UART;
> +		value &= ~CON_MANUAL_SW;
> +	} else if (!strncmp(buf, "AUDIO", 5)) {
> +		path = SW_AUDIO;
> +		value &= ~CON_MANUAL_SW;
> +	} else if (!strncmp(buf, "DHOST", 5)) {
> +		path = SW_DHOST;
> +		value &= ~CON_MANUAL_SW;
> +	} else if (!strncmp(buf, "AUTO", 4)) {
> +		path = SW_AUTO;
> +		value |= CON_MANUAL_SW;
> +	} else {
> +		dev_err(&client->dev, "Wrong command\n");
> +		return;
> +	}
> +
> +	usbsw->mansw = path;
> +	fsa9480_write_reg(client, FSA9480_REG_MANSW1, path);
> +	fsa9480_write_reg(client, FSA9480_REG_CTRL, value);
> +}
> +
> +static ssize_t fsa9480_get_switch(struct i2c_client *client, char *buf)
> +{
> +	unsigned int value;
> +
> +	value = fsa9480_read_reg(client, FSA9480_REG_MANSW1);
> +
> +	if (value == SW_VAUDIO)
> +		return sprintf(buf, "VAUDIO\n");
> +	else if (value == SW_UART)
> +		return sprintf(buf, "UART\n");
> +	else if (value == SW_AUDIO)
> +		return sprintf(buf, "AUDIO\n");
> +	else if (value == SW_DHOST)
> +		return sprintf(buf, "DHOST\n");
> +	else if (value == SW_AUTO)
> +		return sprintf(buf, "AUTO\n");
> +	else
> +		return sprintf(buf, "%x", value);
> +}
> +
> +static ssize_t fsa9480_manualsw_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return fsa9480_get_switch(client, buf);
> +
> +}
> +
> +static ssize_t fsa9480_manualsw_set(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	fsa9480_set_switch(client, buf);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(switch, 0644,
> +		   fsa9480_manualsw_show, fsa9480_manualsw_set);
> +
> +static struct attribute *fsa9480_attributes[] = {
> +	&dev_attr_switch.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group fsa9480_group = {
> +	.attrs	= fsa9480_attributes,
> +};

Unfortunately, we have to export the some attribute
from linux framework. I think that it is not proper
to add the specific sysfs entry for only one device driver.

If you want to add the new sysfs entry, please contribue
the extcon framework for all extcon device drivers.

Please remove it.

> +
> +static void fsa9480_handle_change(struct fsa9480_usbsw *usbsw,
> +				  u16 mask, bool attached)
> +{
> +	while (mask) {
> +		int dev = fls64(mask) - 1;
> +		u64 cables = cable_types[dev];
> +
> +		while (cables) {
> +			int cable = fls64(cables) - 1;
> +
> +			extcon_set_state_sync(usbsw->edev, cable, attached);
> +			cables &= ~BIT_ULL(cable);
> +		}
> +
> +		mask &= ~BIT_ULL(dev);
> +	}
> +}
> +
> +static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw)
> +{
> +	struct i2c_client *client = usbsw->client;
> +	int val1, val2;
> +	u16 val;
> +
> +	val1 = fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
> +	val2 = fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
> +	if (val1 < 0 || val2 < 0) {
> +		dev_err(&client->dev, "%s: failed to read registers", __func__);
> +		return;
> +	}
> +	val = val2 << 8 | val1;
> +
> +	dev_info(&client->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
> +
> +	if (usbsw->mansw && (val1 & DEV_T1_USB_MASK || val2 & DEV_T2_USB_MASK))
> +		fsa9480_write_reg(client, FSA9480_REG_MANSW1, usbsw->mansw);
> +
> +	/* handle detached cables first */
> +	fsa9480_handle_change(usbsw, usbsw->dev & ~val, false);
> +
> +	/* then handle attached ones */
> +	fsa9480_handle_change(usbsw, val & ~usbsw->dev, true);
> +
> +	usbsw->dev = val;
> +}
> +
> +static irqreturn_t fsa9480_irq_handler(int irq, void *data)
> +{
> +	struct fsa9480_usbsw *usbsw = data;
> +	struct i2c_client *client = usbsw->client;
> +	int intr = 0;
> +
> +	/* clear interrupt */
> +	fsa9480_read_irq(client, &intr);
> +	if (!intr)
> +		return IRQ_NONE;
> +
> +	/* device detection */
> +	fsa9480_detect_dev(usbsw);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int fsa9480_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct fsa9480_usbsw *info;
> +	int ret;
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "no interrupt provided\n");
> +		return -EINVAL;
> +	}
> +
> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	info->client = client;
> +
> +	i2c_set_clientdata(client, info);
> +
> +	/* External connector */
> +	info->edev = devm_extcon_dev_allocate(&client->dev,
> +					      fsa9480_extcon_cable);
> +	if (IS_ERR(info->edev)) {
> +		dev_err(&client->dev, "failed to allocate memory for extcon\n");
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = devm_extcon_dev_register(&client->dev, info->edev);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	/* ADC Detect Time: 500ms */
> +	fsa9480_write_reg(client, FSA9480_REG_TIMING1, TIMING1_ADC_500MS);
> +
> +	/* configure automatic switching */
> +	fsa9480_write_reg(client, FSA9480_REG_CTRL, CON_MASK);
> +
> +	/* unmask interrupt (attach/detach only) */
> +	fsa9480_write_reg(client, FSA9480_REG_INT1_MASK,
> +			  INT1_MASK & ~(INT_ATTACH | INT_DETACH));
> +	fsa9480_write_reg(client, FSA9480_REG_INT2_MASK, INT2_MASK);
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					fsa9480_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"fsa9480", info);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	device_init_wakeup(&client->dev, true);
> +	fsa9480_detect_dev(info);
> +
> +	ret = sysfs_create_group(&client->dev.kobj, &fsa9480_group);

Please remove it.

> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed to create fsa9480 attribute group\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsa9480_remove(struct i2c_client *client)
> +{
> +	sysfs_remove_group(&client->dev.kobj, &fsa9480_group);

Please remove it.

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int fsa9480_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev) && client->irq)
> +		enable_irq_wake(client->irq);
> +
> +	return 0;
> +}
> +
> +static int fsa9480_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev) && client->irq)
> +		disable_irq_wake(client->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops fsa9480_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(fsa9480_suspend, fsa9480_resume)
> +};
> +
> +static const struct i2c_device_id fsa9480_id[] = {
> +	{ "fsa9480", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, fsa9480_id);
> +
> +static const struct of_device_id fsa9480_of_match[] = {
> +	{ .compatible = "fcs,fsa9480", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, fsa9480_of_match);
> +
> +static struct i2c_driver fsa9480_i2c_driver = {
> +	.driver			= {
> +		.name		= "fsa9480",
> +		.pm		= &fsa9480_pm_ops,
> +		.of_match_table = fsa9480_of_match,
> +	},
> +	.probe			= fsa9480_probe,
> +	.remove			= fsa9480_remove,
> +	.id_table		= fsa9480_id,
> +};
> +
> +static int __init fsa9480_module_init(void)
> +{
> +	return i2c_add_driver(&fsa9480_i2c_driver);
> +}
> +subsys_initcall(fsa9480_module_init);
> +
> +static void __exit fsa9480_module_exit(void)
> +{
> +	i2c_del_driver(&fsa9480_i2c_driver);
> +}
> +module_exit(fsa9480_module_exit);
> +
> +MODULE_DESCRIPTION("Fairchild Semiconductor FSA9480 extcon driver");
> +MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
> +MODULE_LICENSE("GPL");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

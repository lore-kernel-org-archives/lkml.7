Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86152C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6241F217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfHGVDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:03:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44122 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfHGVDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:03:04 -0400
Received: from ip5f5a6044.dynamic.kabel-deutschland.de ([95.90.96.68] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hvT5G-0003Vr-GS; Wed, 07 Aug 2019 23:02:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "kernelci . org bot" <bot@kernelci.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] phy-rockchip-inno-hdmi: Fix RK3328_TERM_RESISTOR_CALIB_SPEED_7_0's third value
Date:   Wed, 07 Aug 2019 23:02:57 +0200
Message-ID: <5866399.zOWMQKR7fF@diego>
In-Reply-To: <20190807192305.6604-1-natechancellor@gmail.com>
References: <20190807192305.6604-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. August 2019, 21:23:05 CEST schrieb Nathan Chancellor:
> After commit "linux/bits.h: Add compile time sanity check of GENMASK
> inputs" [1], arm64 defconfig builds started failing:
> 
> In file included from ../include/linux/bits.h:22,
>                  from ../include/linux/bitops.h:5,
>                  from ../include/linux/kernel.h:12,
>                  from ../include/linux/clk.h:13,
>                  from ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:9:
> ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c: In function 'inno_hdmi_phy_rk3328_power_on':
> ../include/linux/build_bug.h:16:45: error: negative width in bit-field '<anonymous>'
>    16 | #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>       |                                             ^
> ../include/linux/bits.h:24:18: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>    24 |  ((unsigned long)BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>       |                  ^~~~~~~~~~~~~~~~~
> ../include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>    39 |  (GENMASK_INPUT_CHECK(high, low) + __GENMASK(high, low))
>       |   ^~~~~~~~~~~~~~~~~~~
> ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:24:42: note: in expansion of macro 'GENMASK'
>    24 | #define UPDATE(x, h, l)  (((x) << (l)) & GENMASK((h), (l)))
>       |                                          ^~~~~~~
> ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:201:50: note: in expansion of macro 'UPDATE'
>   201 | #define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)  UPDATE(x, 7, 9)
>       |                                                  ^~~~~~
> ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:1046:26: note: in expansion of macro 'RK3328_TERM_RESISTOR_CALIB_SPEED_7_0'
>  1046 |   inno_write(inno, 0xc6, RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(v));
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As pointed out by Robin and Guenter, inno_write's val argument is an
> 8-bit value so having a mask larger than that doesn't make sense. This
> also matches the rest of the *_7_0 macros in this driver.
> 
> [1]: https://lore.kernel.org/lkml/20190801230358.4193-2-rikard.falkeborn@gmail.com/
> 
> Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

on a rk3328-rock64 hdmi output still works
Tested-by: Heiko Stuebner <heiko@sntech.de>

@Kishon: Would probably be good to get this fast into 5.3-rc.


Heiko


>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> index b10a84cab4a7..2b97fb1185a0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> @@ -198,7 +198,7 @@
>  #define RK3328_BYPASS_TERM_RESISTOR_CALIB		BIT(7)
>  #define RK3328_TERM_RESISTOR_CALIB_SPEED_14_8(x)	UPDATE((x) >> 8, 6, 0)
>  /* REG:0xc6 */
> -#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)		UPDATE(x, 7, 9)
> +#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)		UPDATE(x, 7, 0)
>  /* REG:0xc7 */
>  #define RK3328_TERM_RESISTOR_50				UPDATE(0, 2, 1)
>  #define RK3328_TERM_RESISTOR_62_5			UPDATE(1, 2, 1)
> 





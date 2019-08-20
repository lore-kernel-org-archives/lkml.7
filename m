Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B76020644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2LXp92Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfHTSM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:12:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35588 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:12:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so3483689wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FxKwOAn/bUsUWgRowkck4x6MWefDgHztdSAMXvVqDc0=;
        b=C2LXp92QlDuVNzD9WsNVwRF5z2Ir9q5pM35LYSr2Uy1GcE02jymh9xqpwVtSPfK/Mm
         cMf6dzWT6/q8GkVp0JnPWfDJVrDvHRPkTUBYBLClvSFtrb+A4XOuUfHKYQkOrjujQ5YM
         QmFzBRdcLEB9hij+eMYi21VnO0BzwRUxKJkr3lBTtEtMIh5nxlvdKYa0kZ9LrwtAnj2z
         agua7X77Y6vZDJBcyPScv+tk/Wd4U8C0AVU3rpJcxvMkwPRarak5te8THIBxqZz+I7Bq
         isX8fPkG51Mkmip0yRYn6hi2DU5W3iXDQif4lfn7TahKeyylThnRwx6SDUg86QsDm/5g
         bkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxKwOAn/bUsUWgRowkck4x6MWefDgHztdSAMXvVqDc0=;
        b=QLLUjWCTQx92C30/3nQbM8IoeKjnu+REAeBlEY5ZAjfhByCDohpnUF2TXnEMkaepkw
         Me0lLKA3RkwSYpOCyVd3aE552g5QONrVIcGBRAsyC39es1YsZ5sKQgLsS5GOJQNZoDHQ
         C2JfrLAtaIO+NdMpeYvQsPKc2sZXYYx7O873aXfUslzh0OeHeF/fVzAvur0Th/vM9DFb
         WF6V0fbtSK5Rra8rRE0wtr7SX9LY2sW2ugAwn6SMljzr2PJ5PxoydMsV6u9/Hs2HIunq
         Rsuw14M6/SEInrVDkhVCZDvLnFBGRpol4u1ISRpkXs5sK4Agulu6S5o2MUn2iOvyzM7J
         X6Lw==
X-Gm-Message-State: APjAAAUP/YDxeRSFFBwkms1UpdH2FZJfrxyu7yyRqH8noXBA+Ib9oO8f
        Dn3UVh76z3j935pHzyjdA6Y=
X-Google-Smtp-Source: APXvYqyeLMNmmA1lMPXgj5s+QpeAfTTIWF/iih0d5R1Rs73sIEnxk2A9i+tveajNCyO05H7Ddgq1JQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr1355632wmh.63.1566324742781;
        Tue, 20 Aug 2019 11:12:22 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f192sm543369wmg.30.2019.08.20.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 11:12:22 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:12:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "kernelci . org bot" <bot@kernelci.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] phy-rockchip-inno-hdmi: Fix
 RK3328_TERM_RESISTOR_CALIB_SPEED_7_0's third value
Message-ID: <20190820181220.GD9420@archlinux-threadripper>
References: <20190807192305.6604-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807192305.6604-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:23:05PM -0700, Nathan Chancellor wrote:
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
> -- 
> 2.23.0.rc1
> 

There was a v3 of linux/bits.h: Add compile time sanity check of GENMASK
inputs sent and this needs to be picked up to avoid build breakage when
that is applied. Could someone please pick this up?

Cheers,
Nathan

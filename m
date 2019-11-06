Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF28FC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013A217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573080188;
	bh=sIJIhyS0MXsdS5o5wl8jxauoavtoO6HaIcCyLg5qR2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-ID:From;
	b=OHrgZFMWEe8BctSCyX8bCvzVkWGLSVJpF5YgvpFeZ39MmMf/W3mkol1XGlCLWLA2L
	 pcto5iLQ/oXaIOCZYLUgzW/ADrBpWkoGuxtLzbchw4fdtpPoAnNO6NRxf0FBKUfhpB
	 IXzAjDoEcLAdeq4FJrWdHjSCErJXK2nOJmp/hpMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfKFWnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKFWnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:43:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85342173E;
        Wed,  6 Nov 2019 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573080186;
        bh=sIJIhyS0MXsdS5o5wl8jxauoavtoO6HaIcCyLg5qR2A=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=OD88XhMD/Q/B3vEuWJ+r36+i67KZcYpPXGr9PLTb0wb+AoHAYEudOiF6ZgX1F2uBT
         6ltkC+OsIobNsreQFPLQuhrXgvcZvUAklfQ++ovnM1P/yaAHZQcLluFFGakhbrHAih
         VUQWs8glJ4k5gV5c1kO8RHLrZPwGpX6hj4ScnIz8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106113551.5557-1-alexandru.ardelean@analog.com>
References: <20191106113551.5557-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to parent
From:   Stephen Boyd <sboyd@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, jsarha@ti.com, ce3a@gmx.de,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 14:43:05 -0800
Message-Id: <20191106224306.A85342173E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Ardelean (2019-11-06 03:35:51)
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> For certain setups/boards it's useful to propagate the rate change of the
> clock up one level to the parent clock.
>=20
> This change implements this by defining a `clk-set-rate-parent` device-tr=
ee
> property which sets the `CLK_SET_RATE_PARENT` flag to the clock (when set=
).
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/clk-gpio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 9d930edd6516..6dfbc4b952fe 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -241,6 +241,7 @@ static int gpio_clk_driver_probe(struct platform_devi=
ce *pdev)
>         struct device_node *node =3D pdev->dev.of_node;
>         const char **parent_names, *gpio_name;
>         unsigned int num_parents;
> +       unsigned long clk_flags;
>         struct gpio_desc *gpiod;
>         struct clk *clk;
>         bool is_mux;
> @@ -274,13 +275,16 @@ static int gpio_clk_driver_probe(struct platform_de=
vice *pdev)
>                 return ret;
>         }
> =20
> +       clk_flags =3D of_property_read_bool(node, "clk-set-rate-parent") ?
> +                       CLK_SET_RATE_PARENT : 0;

Is there a DT binding update somewhere? It looks like a linux-ism from
the DT perspective. I wonder if we can somehow figure out that it's OK
to call clk_set_rate() on the parent here? Or is it safe to assume that
we can just always call set rate on the parent? I think for a gate it's
good and we can just do so, but for a mux maybe not. Care to describe
your scenario a little more so we can understand why you want to set
this flag? Is it for a mux or a gate type gpio?


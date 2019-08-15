Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903902067D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565841745;
	bh=P+AYYRu1UVFmoNeSvYyImLFAmUghU+0Zz4UPzpG2Yy0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vLLOvX8FoSMOF+RwpRnZZbQwwsnwmMmNNlSyh6vgq7+eCwco+Rly20YraAr5wJAYU
	 lvjzUJ0IwttohY/iThKshQ8CrWLTGJCTCANmyPXfSytNFPIddL+PGyLwgSBhlm262H
	 Ml9+toxup7/SejrTdGmZp0p1+1fVNX8ArnosMESo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfHOECX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfHOECX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:02:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE28F2067D;
        Thu, 15 Aug 2019 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565841742;
        bh=P+AYYRu1UVFmoNeSvYyImLFAmUghU+0Zz4UPzpG2Yy0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e1esrKmYIiJzxrpLActgaq5kTqqHosEEE5O3zWfF5A/SK9lUYoFAkmC+usBwQi6zk
         YcxWMX39kb5NmTyMZldXm+fDEBjJ9m7oHhOZe58BVf7uyEXTTSRRKNMtTuC3rS/iGf
         As0VOLToNZBxig9tGM/OY204iEYEY8KWBDlnZa9w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com>
References: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com>
Subject: Re: clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libretech-all-h3-cc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "kernelci.org bot" <bot@kernelci.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        broonie@kernel.org, enric.balletbo@collabora.com,
        guillaume.tucker@collabora.com, khilman@baylibre.com,
        matthew.hart@linaro.org, mgalka@collabora.com,
        tomeu.vizoso@collabora.com, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 21:02:20 -0700
Message-Id: <20190815040221.DE28F2067D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernelci.org bot (2019-08-14 20:35:25)
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libret=
ech-all-h3-cc

If this is the only board that failed, great! Must be something in a
sun8i driver that uses the init structure after registration.

>=20
> Summary:
>   Start:      31f58d2f58cb Merge branch 'clk-meson' into clk-next
>   Details:    https://kernelci.org/boot/id/5d54b9d159b514324cf1226e
>   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.3-rc1-79-g31f=
58d2f58cb/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun=
8i-h3-libretech-all-h3-cc.txt
>   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.3-rc1-79-g31f=
58d2f58cb/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun=
8i-h3-libretech-all-h3-cc.html
>   Result:     c82987e740d1 clk: Overwrite clk_hw::init with NULL during c=
lk_register()
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       clk
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.g=
it
>   Branch:     clk-next
>   Target:     sun8i-h3-libretech-all-h3-cc
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
>   Test suite: boot
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit c82987e740d12be98b8ae8aa9221b8b9e2541271
> Author: Stephen Boyd <sboyd@kernel.org>
> Date:   Wed Jul 31 12:35:17 2019 -0700
>=20
>     clk: Overwrite clk_hw::init with NULL during clk_register()
>    =20
>     We don't want clk provider drivers to use the init structure after clk
>     registration time, but we leave a dangling reference to it by means of
>     clk_hw::init. Let's overwrite the member with NULL during clk_registe=
r()
>     so that this can't be used anymore after registration time.
>    =20
>     Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>     Cc: Doug Anderson <dianders@chromium.org>
>     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>     Link: https://lkml.kernel.org/r/20190731193517.237136-10-sboyd@kernel=
.org
>     Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..efac620264a2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3484,9 +3484,9 @@ static int clk_cpy_name(const char **dst_p, const c=
har *src, bool must_exist)
>         return 0;
>  }
> =20
> -static int clk_core_populate_parent_map(struct clk_core *core)
> +static int clk_core_populate_parent_map(struct clk_core *core,
> +                                       const struct clk_init_data *init)
>  {
> -       const struct clk_init_data *init =3D core->hw->init;
>         u8 num_parents =3D init->num_parents;
>         const char * const *parent_names =3D init->parent_names;
>         const struct clk_hw **parent_hws =3D init->parent_hws;
> @@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device_n=
ode *np, struct clk_hw *hw)
>  {
>         int ret;
>         struct clk_core *core;
> +       const struct clk_init_data *init =3D hw->init;
> +
> +       /*
> +        * The init data is not supposed to be used outside of registrati=
on path.
> +        * Set it to NULL so that provider drivers can't use it either an=
d so that
> +        * we catch use of hw->init early on in the core.
> +        */
> +       hw->init =3D NULL;
> =20
>         core =3D kzalloc(sizeof(*core), GFP_KERNEL);
>         if (!core) {
> @@ -3573,17 +3581,17 @@ __clk_register(struct device *dev, struct device_=
node *np, struct clk_hw *hw)
>                 goto fail_out;
>         }
> =20
> -       core->name =3D kstrdup_const(hw->init->name, GFP_KERNEL);
> +       core->name =3D kstrdup_const(init->name, GFP_KERNEL);
>         if (!core->name) {
>                 ret =3D -ENOMEM;
>                 goto fail_name;
>         }
> =20
> -       if (WARN_ON(!hw->init->ops)) {
> +       if (WARN_ON(!init->ops)) {
>                 ret =3D -EINVAL;
>                 goto fail_ops;
>         }
> -       core->ops =3D hw->init->ops;
> +       core->ops =3D init->ops;
> =20
>         if (dev && pm_runtime_enabled(dev))
>                 core->rpm_enabled =3D true;
> @@ -3592,13 +3600,13 @@ __clk_register(struct device *dev, struct device_=
node *np, struct clk_hw *hw)
>         if (dev && dev->driver)
>                 core->owner =3D dev->driver->owner;
>         core->hw =3D hw;
> -       core->flags =3D hw->init->flags;
> -       core->num_parents =3D hw->init->num_parents;
> +       core->flags =3D init->flags;
> +       core->num_parents =3D init->num_parents;
>         core->min_rate =3D 0;
>         core->max_rate =3D ULONG_MAX;
>         hw->core =3D core;
> =20
> -       ret =3D clk_core_populate_parent_map(core);
> +       ret =3D clk_core_populate_parent_map(core, init);
>         if (ret)
>                 goto fail_parents;
> =20
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2ae7604783dd..214c75ed62ae 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -299,7 +299,8 @@ struct clk_init_data {
>   * into the clk API
>   *
>   * @init: pointer to struct clk_init_data that contains the init data sh=
ared
> - * with the common clock framework.
> + * with the common clock framework. This pointer will be set to NULL once
> + * a clk_register() variant is called on this clk_hw pointer.
>   */
>  struct clk_hw {
>         struct clk_core *core;
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [21a2f76849f16d5a48d205b68e923694bc93aaf3] Merge branch 'clk-fixe=
s' into clk-next
> git bisect good 21a2f76849f16d5a48d205b68e923694bc93aaf3
> # bad: [31f58d2f58cb0a8fbf58af88b6a5133bed23bf9b] Merge branch 'clk-meson=
' into clk-next
> git bisect bad 31f58d2f58cb0a8fbf58af88b6a5133bed23bf9b
> # good: [1d97657a4794ab23b47bd9921978ddd82569fcf4] Merge branch 'v5.4/dt'=
 into v5.4/drivers
> git bisect good 1d97657a4794ab23b47bd9921978ddd82569fcf4
> # bad: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overwrite clk_hw::=
init with NULL during clk_register()
> git bisect bad c82987e740d12be98b8ae8aa9221b8b9e2541271
> # good: [e22cce5f419f3c5aa07c8b0d2f8860d49980dbae] clk: qcom: Don't refer=
ence clk_init_data after registration
> git bisect good e22cce5f419f3c5aa07c8b0d2f8860d49980dbae
> # good: [3445b1287ac6cf410ecd4536b880172b98e6133d] clk: socfpga: Don't re=
ference clk_init_data after registration
> git bisect good 3445b1287ac6cf410ecd4536b880172b98e6133d
> # good: [735822a8b114f73289679178ff075b73facd4571] phy: ti: am654-serdes:=
 Don't reference clk_init_data after registration
> git bisect good 735822a8b114f73289679178ff075b73facd4571
> # first bad commit: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overw=
rite clk_hw::init with NULL during clk_register()
> -------------------------------------------------------------------------=
------

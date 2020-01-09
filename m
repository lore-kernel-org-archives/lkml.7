Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4897C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB29206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyJZFdTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbgAIPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:19:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45034 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:19:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so2678698plb.11;
        Thu, 09 Jan 2020 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaoDmnIv7fq2bK3Pw8FgyMWXUExVVooadbufCm0vA28=;
        b=lyJZFdTEmsR9yvYDQNZzfGSP/2DugXvk4aOPsCFKrQT9EZ/FM87d4Iyefb8hCBmCYY
         BxBESnnvF2jCUGboub4ZrzhLzxkGFInZn0UxfZ/rL0ncnEVhSkeAswDKaZkYNi21b2rv
         G+v8QpvJrB14eRmtbcprQi0mr2IwaQ2GiG8MTj7dSBSukpdNHX5Wd0b7dwwKFfPJffsL
         8CnBoNXjca8eQ88Mi++1dqJ3Fjh7q+UYjDTQRxxwpY+x3JbyMeq2VmeGEOJdN9QVCwo8
         H0Ge/orqiM8/imsKOvVVKiOjz4/yL0moBTrorDHigUsxOnFAEBOJWZbCQOTcKS0AN4vW
         XzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaoDmnIv7fq2bK3Pw8FgyMWXUExVVooadbufCm0vA28=;
        b=IqYeraTib9ykZLx30PH+fMomL3rpK8e9Pi8Y9EE8gxtKofM38M8E1Hmlq5NA/mWPoS
         I8qliRgJvZ7BL7XD+ZAn+p/D0ROcAqKm35WB264HwhAbgsb7GSjDukgbDaXlZ8vlMTT4
         xpuf0mk1NAjXQG++KOfz2LJuHdce/iDv8cZTjWa0vjlrUQo/pMhBAE6s/P7VPSnBFJFn
         IS4ResM/1E1/tkHIa5+dRoTbA1Bi5HSmUNMxPvbIrS7akvWWtss+GCGNnnWiL/I3ATZ0
         /GPYKqD7+RW+hpB9DiiSG2n2NdjcO3fiP1vMY35SjH7BYv+i33wZunGNTKViBwMfAAcj
         3uNA==
X-Gm-Message-State: APjAAAWARmleGdKzyPBCq9OxiBGyvF/f38Wx+kZODtjQc3A0UwJ/ApgT
        Ce1bYA+P6dm5XAyWxPxFdLiQK5TpXcCR6VOhBVs=
X-Google-Smtp-Source: APXvYqxhuE5QNaRo6ld2eSQ3WmfothXr4TxMa54D/0je9favVr1ekS9+70FUrtMomTf69mLcXfdQV46lBGB7QucFG+w=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr6005030pjq.132.1578583197418;
 Thu, 09 Jan 2020 07:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20191231102917.24181-1-vadimp@mellanox.com> <20191231102917.24181-6-vadimp@mellanox.com>
In-Reply-To: <20191231102917.24181-6-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jan 2020 17:19:48 +0200
Message-ID: <CAHp75VfYzy9jq3c2YjszJpCb33EWYh-fvuZv_vAenfKLGDEY0A@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 5/9] platform/x86: mlx-platform: Set
 system mux configuration based on system type
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 12:29 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Separate assignment for systems mux configuration based on system type,
> instead of setting the same configuration for the all.
> The motivation is to allow introduction of new systems types with the
> different mux topology.
>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  drivers/platform/x86/mlx-platform.c | 46 ++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
> index 7e92dc52071f..0a41668b1587 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -219,7 +219,7 @@ static const int mlxplat_default_channels[][MLXPLAT_CPLD_GRP_CHNL_NUM] = {
>  static const int mlxplat_msn21xx_channels[] = { 1, 2, 3, 4, 5, 6, 7, 8 };
>
>  /* Platform mux data */
> -static struct i2c_mux_reg_platform_data mlxplat_mux_data[] = {
> +static struct i2c_mux_reg_platform_data mlxplat_default_mux_data[] = {
>         {
>                 .parent = 1,
>                 .base_nr = MLXPLAT_CPLD_CH1,
> @@ -239,6 +239,11 @@ static struct i2c_mux_reg_platform_data mlxplat_mux_data[] = {
>
>  };
>
> +/* Platform mux configuration variables */
> +static int mlxplat_max_adap_num;
> +static int mlxplat_mux_num;
> +static struct i2c_mux_reg_platform_data *mlxplat_mux_data;
> +
>  /* Platform hotplug devices */
>  static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
>         {
> @@ -1905,7 +1910,10 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
> +       mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
> +       mlxplat_mux_data = mlxplat_default_mux_data;
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 mlxplat_mux_data[i].values = mlxplat_default_channels[i];
>                 mlxplat_mux_data[i].n_values =
>                                 ARRAY_SIZE(mlxplat_default_channels[i]);
> @@ -1924,7 +1932,10 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
> +       mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
> +       mlxplat_mux_data = mlxplat_default_mux_data;
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
>                 mlxplat_mux_data[i].n_values =
>                                 ARRAY_SIZE(mlxplat_msn21xx_channels);
> @@ -1943,7 +1954,10 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
> +       mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
> +       mlxplat_mux_data = mlxplat_default_mux_data;
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
>                 mlxplat_mux_data[i].n_values =
>                                 ARRAY_SIZE(mlxplat_msn21xx_channels);
> @@ -1962,7 +1976,10 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
> +       mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
> +       mlxplat_mux_data = mlxplat_default_mux_data;
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
>                 mlxplat_mux_data[i].n_values =
>                                 ARRAY_SIZE(mlxplat_msn21xx_channels);
> @@ -1981,7 +1998,10 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
> +       mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
> +       mlxplat_mux_data = mlxplat_default_mux_data;
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
>                 mlxplat_mux_data[i].n_values =
>                                 ARRAY_SIZE(mlxplat_msn21xx_channels);
> @@ -1998,7 +2018,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
>         mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
>
>         return 1;
> -}
> +};

And this, how does it happen?

>
>  static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
>         {
> @@ -2127,7 +2147,7 @@ static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
>         /* Scan adapters from expected id to verify it is free. */
>         *nr = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR;
>         for (i = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR; i <

> -            MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM; i++) {
> +            mlxplat_max_adap_num; i++) {

I'm wondering why 'i <; is left on previous line, or, otherwise, the
limit is on next one.

>                 search_adap = i2c_get_adapter(i);
>                 if (search_adap) {
>                         i2c_put_adapter(search_adap);
> @@ -2141,12 +2161,12 @@ static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
>         }
>
>         /* Return with error if free id for adapter is not found. */
> -       if (i == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM)
> +       if (i == mlxplat_max_adap_num)
>                 return -ENODEV;
>
>         /* Shift adapter ids, since expected parent adapter is not free. */
>         *nr = i;
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 shift = *nr - mlxplat_mux_data[i].parent;
>                 mlxplat_mux_data[i].parent = *nr;
>                 mlxplat_mux_data[i].base_nr += shift;
> @@ -2202,7 +2222,7 @@ static int __init mlxplat_init(void)
>         if (nr < 0)
>                 goto fail_alloc;
>
> -       nr = (nr == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM) ? -1 : nr;
> +       nr = (nr == mlxplat_max_adap_num) ? -1 : nr;
>         if (mlxplat_i2c)
>                 mlxplat_i2c->regmap = priv->regmap;
>         priv->pdev_i2c = platform_device_register_resndata(
> @@ -2215,7 +2235,7 @@ static int __init mlxplat_init(void)
>                 goto fail_alloc;
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
> +       for (i = 0; i < mlxplat_mux_num; i++) {
>                 priv->pdev_mux[i] = platform_device_register_resndata(
>                                                 &priv->pdev_i2c->dev,
>                                                 "i2c-mux-reg", i, NULL,
> @@ -2349,7 +2369,7 @@ static void __exit mlxplat_exit(void)
>         platform_device_unregister(priv->pdev_led);
>         platform_device_unregister(priv->pdev_hotplug);
>
> -       for (i = ARRAY_SIZE(mlxplat_mux_data) - 1; i >= 0 ; i--)

> +       for (i = mlxplat_mux_num - 1; i >= 0 ; i--)

It is basically
  while (i--)

>                 platform_device_unregister(priv->pdev_mux[i]);
>
>         platform_device_unregister(priv->pdev_i2c);
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko

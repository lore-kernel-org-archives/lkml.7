Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B00DC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1881206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYiS+9Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfLOSwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:52:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40897 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:52:05 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so4636743iop.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++SuXPbeJ8HW/JTgrnYki41wnpjCIWM0WgXunOlEX7k=;
        b=mYiS+9CnqxC+9BHQ+xrob3lut2K9Kaa4lQADI+64wCUWSoj6Rww9Br8GIFc6NwaNRc
         Uc0h/21rVPStoUqk3tiELHRKHtBpNDjAtsQ2wUTEdAHweASUFY2+le6lpi94wjUf5Yi2
         B+e+iCpyg3wY7WDMzwMgci4b4XrzWTnecUQ4TwNWCcOBOenbs28IjmEbHYRZhRWGb6Tg
         vvWRWxsrKhzbj1485dNt7H4YCK3RFlKM2jz+a0vLoIRvIDeJQ1E3YOQsFnwNCPZ9/acm
         TZSayrNOmYoRc/JBwmICnp6w2U6BR+mabsD2wfplhGoWa/aN2D1TGyXvhLCIkkWJkJVs
         BMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++SuXPbeJ8HW/JTgrnYki41wnpjCIWM0WgXunOlEX7k=;
        b=gGslQqyVxUCOVh2Szy0dfL3CWeDi56kUpAucHSl+q7lTV4zhUGnfZBSfrM4jXbJkxw
         MCYdgvLOs6y8XdFmkeZAiptlD71BMzF2dG9L4Dkhc9h1j/eXgxSzIL/9kvEgQpG9wV2p
         NWeEO1vRHRYx1j7xYDN4lezI9JbMVPvFaZicvObMoPlVJKt6ptnyTLPRW5YU4/kPpN8v
         AzKHnneuRRfx3CGTzyYoQu9BD7QodNMHM12xjOk52/iBWIk7Za0LjN7k7z/3xDrBjYgF
         8U6EQqgLisCOCsuyr+E6a8DCQr9MHLr/VCaFlvJBTvcU/nNkWgj8ucaqfRVKFjwhJ4ye
         jXdA==
X-Gm-Message-State: APjAAAVSJhif6pQ1tMB7Cma11X1VUE/2xC18fkgMJXF1zouae0XAIt2r
        dPH1ZHbGexKYQhRy7uK3ShDZKsTb4USXaFihe94=
X-Google-Smtp-Source: APXvYqx6vaHHB+YvwrXYvMgA1CNMQ6SU9HLtubdKaBsY7EXiHjqe3Eo/svLz6iEm7bJuMSY+KlZkIPgH6y+Rn6xxAAI=
X-Received: by 2002:a02:8817:: with SMTP id r23mr9223515jai.120.1576435922826;
 Sun, 15 Dec 2019 10:52:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575932654.git.robin.murphy@arm.com> <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
In-Reply-To: <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 16 Dec 2019 00:21:50 +0530
Message-ID: <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Soeren Moch <smoch@web.de>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin

On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wrote:
>
> RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK817,
> so it makes little sense for the driver to have to have two completely
> different mechanisms to handle essentially the same thing. Bring RK805
> in line with the RK809/RK817 flow to clean things up.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c       | 58 +++++++++++++++++----------------------
>  include/linux/mfd/rk808.h |  1 -
>  2 files changed, 25 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 657b8baa3b8a..e88bdb889d3a 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -186,7 +186,6 @@ static const struct rk808_reg_data rk805_pre_init_reg[] = {
>         {RK805_BUCK4_CONFIG_REG, RK805_BUCK3_4_ILMAX_MASK,
>                                  RK805_BUCK4_ILMAX_3500MA},
>         {RK805_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK, BUCK_ILMIN_400MA},
> -       {RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SLEEP_FUN},
>         {RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
>  };
>
> @@ -449,21 +448,6 @@ static const struct regmap_irq_chip rk818_irq_chip = {
>
>  static struct i2c_client *rk808_i2c_client;
>
> -static void rk805_device_shutdown_prepare(void)
> -{
> -       int ret;
> -       struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> -
> -       if (!rk808)
> -               return;
> -
> -       ret = regmap_update_bits(rk808->regmap,
> -                                RK805_GPIO_IO_POL_REG,
> -                                SLP_SD_MSK, SHUTDOWN_FUN);
> -       if (ret)
> -               dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
> -}
> -
>  static void rk808_device_shutdown(void)
>  {
>         int ret;
> @@ -499,17 +483,29 @@ static void rk8xx_syscore_shutdown(void)
>         struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>         int ret;
>
> -       if (system_state == SYSTEM_POWER_OFF &&
> -           (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
> +       if (system_state != SYSTEM_POWER_OFF)
> +              return;
> +
> +       switch (rk808->variant) {
> +       case RK805_ID:
> +               ret = regmap_update_bits(rk808->regmap,
> +                                        RK805_GPIO_IO_POL_REG,
> +                                        SLP_SD_MSK,
> +                                        SHUTDOWN_FUN);
> +               break;
> +       case RK809_ID:
> +       case RK817_ID:
>                 ret = regmap_update_bits(rk808->regmap,
>                                          RK817_SYS_CFG(3),
>                                          RK817_SLPPIN_FUNC_MSK,
>                                          SLPPIN_DN_FUN);
> -               if (ret) {
> -                       dev_warn(&rk808_i2c_client->dev,
> -                                "Cannot switch to power down function\n");
> -               }
> +               break;
> +       default:
> +               return;
>         }
> +       if (ret)
> +               dev_warn(&rk808_i2c_client->dev,
> +                        "Cannot switch to power down function\n");
>  }
>
>  static struct syscore_ops rk808_syscore_ops = {
> @@ -579,7 +575,6 @@ static int rk808_probe(struct i2c_client *client,
>                 nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
>                 cells = rk805s;
>                 nr_cells = ARRAY_SIZE(rk805s);
> -               rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
>                 break;
>         case RK808_ID:
>                 rk808->regmap_cfg = &rk808_regmap_config;
> @@ -658,10 +653,8 @@ static int rk808_probe(struct i2c_client *client,
>                 goto err_irq;
>         }
>
> -       if (of_property_read_bool(np, "rockchip,system-power-controller")) {
> +       if (of_property_read_bool(np, "rockchip,system-power-controller"))
>                 pm_power_off = rk808_device_shutdown;
> -               pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
> -       }
>
>         return 0;
>
> @@ -686,13 +679,6 @@ static int rk808_remove(struct i2c_client *client)
>         if (pm_power_off == rk808_device_shutdown)
>                 pm_power_off = NULL;
>
> -       /**
> -        * As above, check if the pointer is set by us before overwrite.
> -        */
> -       if (rk808->pm_pwroff_prep_fn &&
> -           pm_power_off_prepare == rk808->pm_pwroff_prep_fn)
> -               pm_power_off_prepare = NULL;
> -
>         return 0;
>  }
>
> @@ -702,6 +688,12 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
>         int ret = 0;
>
>         switch (rk808->variant) {
> +       case RK805_ID:
> +               ret = regmap_update_bits(rk808->regmap,
> +                                        RK805_GPIO_IO_POL_REG,
> +                                        SLP_SD_MSK,
> +                                        SLEEP_FUN);
> +               break;
>         case RK809_ID:
>         case RK817_ID:
>                 ret = regmap_update_bits(rk808->regmap,
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index b038653fa87e..e07f6e61cd38 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -620,6 +620,5 @@ struct rk808 {
>         long                            variant;
>         const struct regmap_config      *regmap_cfg;
>         const struct regmap_irq_chip    *regmap_irq_chip;
> -       void                            (*pm_pwroff_prep_fn)(void);
>  };
>  #endif /* __LINUX_REGULATOR_RK808_H */
> --
> 2.17.1
>

I am sill getting the kernel warning on issue poweroff see below.
on my Rock960 Model A
I feel the reason for this is we now have two poweroff callback
1  pm_power_off = rk808_device_shutdown
2  rk8xx_syscore_shutdown

In my investigation earlier common function for shutdown solve
the issue of clean shutdown.

for *rockchip,system-power-controller* dts property
we can used flags if check if this property support clean shutdown
for that device.

[  565.009291] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
[  565.010179] reboot: Power down
[  565.010536] ------------[ cut here ]------------
[  565.010940] No atomic I2C transfer handler for 'i2c-0'
[  565.011437] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:40
i2c_transfer+0xe4/0xf8
[  565.012126] Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_audio
rockchipdrm nvme analogix_dp nvme_core brcmfmac hci_uart dw_mipi_dsi
dw_hdmi btbcm cec panfrost bluetooth drm_kms_helper brcmutil gpu_sched
cfg80211 crct10dif_ce snd_soc_rockchip_i2s snd_soc_simple_card drm
ecdh_generic snd_soc_rockchip_pcm snd_soc_simple_card_utils
phy_rockchip_pcie ecc rtc_rk808 rfkill rockchip_thermal
pcie_rockchip_host ip_tables x_tables ipv6 nf_defrag_ipv6
[  565.015578] CPU: 0 PID: 1 Comm: shutdown Not tainted
5.5.0-rc1-00292-gd46dd6369c55 #7
[  565.016260] Hardware name: 96boards Rock960 (DT)
[  565.016666] pstate: 60000085 (nZCv daIf -PAN -UAO)
[  565.017087] pc : i2c_transfer+0xe4/0xf8
[  565.017425] lr : i2c_transfer+0xe4/0xf8
[  565.017762] sp : ffff80001004baf0
[  565.018052] x29: ffff80001004baf0 x28: ffff00007d208000
[  565.018517] x27: 0000000000000000 x26: 0000000000000000
[  565.018982] x25: 0000000000000008 x24: 0000000000000000
[  565.019447] x23: ffff00007d208000 x22: ffff80001004bc64
[  565.019912] x21: ffff80001004bb48 x20: 0000000000000002
[  565.020377] x19: ffff000078502080 x18: 0000000000000010
[  565.020842] x17: 0000000000000001 x16: 0000000000000019
[  565.021307] x15: ffff00007d208470 x14: ffffffffffffffff
[  565.021772] x13: ffff80009004b857 x12: ffff80001004b860
[  565.022237] x11: ffff800011841000 x10: ffff800011a10658
[  565.022702] x9 : 0000000000000000 x8 : ffff800011a11000
[  565.023167] x7 : ffff800010697c78 x6 : 0000000000000262
[  565.023632] x5 : 0000000000000000 x4 : 0000000000000000
[  565.024096] x3 : 00000000ffffffff x2 : ffff800011841ab8
[  565.024561] x1 : 7b11701b0ae78800 x0 : 0000000000000000
[  565.025027] Call trace:
[  565.025246]  i2c_transfer+0xe4/0xf8
[  565.025556]  regmap_i2c_read+0x5c/0xa0
[  565.025886]  _regmap_raw_read+0xcc/0x138
[  565.026230]  _regmap_bus_read+0x3c/0x70
[  565.026568]  _regmap_read+0x60/0xe0
[  565.026875]  _regmap_update_bits+0xc8/0x108
[  565.027241]  regmap_update_bits_base+0x60/0x90
[  565.027633]  rk808_device_shutdown+0x6c/0x88
[  565.028010]  machine_power_off+0x24/0x30
[  565.028356]  kernel_power_off+0x64/0x70
[  565.028693]  __do_sys_reboot+0x15c/0x240
[  565.029038]  __arm64_sys_reboot+0x20/0x28
[  565.029390]  el0_svc_common.constprop.0+0x68/0x160
[  565.029811]  el0_svc_handler+0x20/0x80
[  565.030141]  el0_sync_handler+0x10c/0x180
[  565.030493]  el0_sync+0x140/0x180
[  565.030785] ---[ end trace 5167e842ce15f686 ]---

-Anand

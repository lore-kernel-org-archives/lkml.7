Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4917A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc8+WJ7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLKCA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:00:28 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46120 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLKCA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:00:28 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so17951873ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KPuoiuDNoBypEAM8Lz9cHX9/+wFHQgQuzldUjfKUDfU=;
        b=Hc8+WJ7I5SkbhfyyJ1GG9HanLO2qTGWVPrbxgqsX1v+pNfYx13yWRVsKlYBw1BN9po
         ymyGxs2o27HAo+NjD4QVmVQF6PB4hM8lPALOguzJDRO343lWcHs+/LdF44PECDcldWTk
         JjapM1p/BsjTSCd2mTywgbsa4pSjZ+R6kmowrPT4V/HTOmK0oxWLok8JIRSeY61EfKuR
         AxxfMZDu2/K416bxmqM3fDDZXT4/XWbS7WoKuzLSvChxtQ4weCiGVBFsDFctMPYlIG3R
         R0L40npXRAaCN+6d83Y/Oi1ALJ2SiqE3t/wUpHBsncDWPV8G09/xmPzhWdAQxpN1azeZ
         KiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KPuoiuDNoBypEAM8Lz9cHX9/+wFHQgQuzldUjfKUDfU=;
        b=olFIdpY8DCPZpOK5hLpsHxh6EgDKIISzm7FYTAnw3Bk63SOsR+iml1RP/BjFHYBHEW
         uJ1y/DnK8+xPnwZOUJ8WsxWFhogVN/2CYrn2vnFkwqjaFsO9+2WXBmGYOuJFQzFKNKfa
         Myhjyfs+/GhpoAm/s/SZSf1PmYrLyu52+TjTX5bF7scxMf93r7TPpAFpR/4NJZXDjNz1
         Ug8NSwA3LjwgSxJgkaDHcspt3B+p0Mhl5EBvzDgX1zjy/wS0BlTanlCUwnTuV6UTlx1V
         prAtmDP776zGems9XDIbE9lRz0VoqzktaGvQ5gaf21qBPAvg94G8HT/4ONevrhW6N/ae
         aueg==
X-Gm-Message-State: APjAAAX7p4CzTQheAU9WUs8oMq8P9GUeFpNvzsaqnVPF2WTUpjkysIZd
        7a8TTaEnykAgTok8vbcw/irEbjKyS2b+8aYElNI=
X-Google-Smtp-Source: APXvYqylaGqxl3kuUUGeA/LM6tIleUnS7lkYsGc2qrtlbxfaSliAIXHMcgnoSIKSORsU/xc/hzwyPUpbTpUlqWR44h4=
X-Received: by 2002:a92:5d92:: with SMTP id e18mr746775ilg.75.1576029627000;
 Tue, 10 Dec 2019 18:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20191209115746.12953-1-smoch@web.de> <CANAwSgS9ixhyOE2QYQ3CetA=BUVebMan2=9xBKF=U3YXAwCHNQ@mail.gmail.com>
 <6e380c0a-007d-22db-af26-19defaf1ae83@fivetechno.de> <8377b8d6-8b4d-0605-4c61-fb61b4aebf91@web.de>
In-Reply-To: <8377b8d6-8b4d-0605-4c61-fb61b4aebf91@web.de>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 11 Dec 2019 07:30:15 +0530
Message-ID: <CANAwSgQhPtBy-npPJgOAqieF7doGmaX3U35m95ktR2qAWVbf5w@mail.gmail.com>
Subject: Re: [PATCH] mfd: rk808: Always use poweroff when requested
To:     Soeren Moch <smoch@web.de>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Soeren,

On Tue, 10 Dec 2019 at 22:10, Soeren Moch <smoch@web.de> wrote:
>
>
>
> On 10.12.19 13:55, Markus Reichl wrote:
> > Hi Anand,
> >
> > Am 10.12.19 um 13:42 schrieb Anand Moon:
> >> Hi Soeren,
> >>
> >> On Mon, 9 Dec 2019 at 17:28, Soeren Moch <smoch@web.de> wrote:
> >>>
> >>> With the device tree property "rockchip,system-power-controller" we
> >>> explicitly request to use this PMIC to power off the system. So alway=
s
> >>> register our poweroff function, even if some other handler (probably
> >>> PSCI poweroff) was registered before.
> >>>
> >>> Signed-off-by: Soeren Moch <smoch@web.de>
> >>> ---
> >>> Cc: Lee Jones <lee.jones@linaro.org>
> >>> Cc: Heiko Stuebner <heiko@sntech.de>
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> Cc: linux-rockchip@lists.infradead.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> ---
> >>>  drivers/mfd/rk808.c | 11 ++---------
> >>>  1 file changed, 2 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> >>> index a69a6742ecdc..616e44e7ef98 100644
> >>> --- a/drivers/mfd/rk808.c
> >>> +++ b/drivers/mfd/rk808.c
> >>> @@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
> >>>         const struct mfd_cell *cells;
> >>>         int nr_pre_init_regs;
> >>>         int nr_cells;
> >>> -       int pm_off =3D 0, msb, lsb;
> >>> +       int msb, lsb;
> >>>         unsigned char pmic_id_msb, pmic_id_lsb;
> >>>         int ret;
> >>>         int i;
> >>> @@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client=
,
> >>>                 goto err_irq;
> >>>         }
> >>>
> >>> -       pm_off =3D of_property_read_bool(np,
> >>> -                               "rockchip,system-power-controller");
> >>> -       if (pm_off && !pm_power_off) {
> >>> +       if (of_property_read_bool(np,
> >>> "rockchip,system-power-controller")) {
> >>>                 rk808_i2c_client =3D client;
> >>>                 pm_power_off =3D rk808->pm_pwroff_fn;
> >>> -       }
> >>> -
> >>> -       if (pm_off && !pm_power_off_prepare) {
> >>> -               if (!rk808_i2c_client)
> >>> -                       rk808_i2c_client =3D client;
> >>>                 pm_power_off_prepare =3D rk808->pm_pwroff_prep_fn;
> >>>         }
> >>>
> >>
> >> I gave this a try on my Rock960 and Odroid N1
> >> both got kernel panic below.
> >
> > I see the same on rk3399-roc-pc.
> This is no panic, it's a harmless warning.

Ok but my device do not come up cleanly after that, it get stuck in
u-boot in next boot.

> The i2c core nowadays expects a specially marked i2c transfer function
> late in the powerdown cycle:

You can look into similar commit.
d785334a0d5deff30a487c74324b842d2179553d (mfd: s2mps11: Add manual
shutdown method for Odroid XU3)

>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.=
c
> index 1a33007b03e9..cec115e0afa4 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1126,6 +1126,7 @@ static u32 rk3x_i2c_func(struct i2c_adapter *adap)
>
>  static const struct i2c_algorithm rk3x_i2c_algorithm =3D {
>      .master_xfer        =3D rk3x_i2c_xfer,
> +    .master_xfer_atomic    =3D rk3x_i2c_xfer, /* usable for PMIC powerof=
f */
>      .functionality        =3D rk3x_i2c_func,
>  };
>
> ---
> It is only used for powerdown. The regular i2c xfer function works.
>
> Heiko, should I send a formal patch for that?
>
> Soeren
>
> >
> >>
> >> [   58.305868] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
> >> [   58.306747] reboot: Power down
> >> [   58.307106] ------------[ cut here ]------------
> >> [   58.307510] No atomic I2C transfer handler for 'i2c-0'
> >> [   58.308007] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:41
> >> i2c_transfer+0xe4/0xf8
> >> [   58.308696] Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_audio
> >> rockchipdrm analogix_dp brcmfmac nvme dw_mipi_dsi nvme_core dw_hdmi
> >> panfrost cec brcmutil drm_kms_helper gpu_sched cfg80211 hci_uart drm
> >> btbcm crct10dif_ce snd_soc_simple_card bluetooth snd_soc_rockchip_i2s
> >> snd_soc_simple_card_utils snd_soc_rockchip_pcm phy_rockchip_pcie
> >> ecdh_generic rtc_rk808 ecc pcie_rockchip_host rfkill rockchip_thermal
> >> ip_tables x_tables ipv6 nf_defrag_ipv6
> >> [   58.312150] CPU: 0 PID: 1 Comm: shutdown Not tainted
> >> 5.5.0-rc1-dirty #1
> >> [   58.312725] Hardware name: 96boards Rock960 (DT)
> >> [   58.313131] pstate: 60000085 (nZCv daIf -PAN -UAO)
> >> [   58.313551] pc : i2c_transfer+0xe4/0xf8
> >> [   58.313889] lr : i2c_transfer+0xe4/0xf8
> >> [   58.314225] sp : ffff80001004bb00
> >> [   58.314516] x29: ffff80001004bb00 x28: ffff00007d208000
> >> [   58.314981] x27: 0000000000000000 x26: 0000000000000000
> >> [   58.315446] x25: 0000000000000000 x24: 0000000000000008
> >> [   58.315910] x23: 0000000000000000 x22: ffff80001004bc74
> >> [   58.316375] x21: 0000000000000002 x20: ffff80001004bb58
> >> [   58.316841] x19: ffff0000784f0880 x18: 0000000000000010
> >> [   58.317305] x17: 0000000000000001 x16: 0000000000000019
> >> [   58.317770] x15: ffffffffffffffff x14: ffff8000118398c8
> >> [   58.318236] x13: ffff80009004b867 x12: ffff80001004b86f
> >> [   58.318701] x11: ffff800011851000 x10: ffff80001004b7f0
> >> [   58.319166] x9 : 00000000ffffffd0 x8 : ffff800010699ad8
> >> [   58.319631] x7 : 0000000000000265 x6 : ffff800011a20be9
> >> [   58.320096] x5 : 0000000000000000 x4 : 0000000000000000
> >> [   58.320561] x3 : 00000000ffffffff x2 : ffff800011851ab8
> >> [   58.321026] x1 : d375c0d4f4751f00 x0 : 0000000000000000
> >> [   58.321491] Call trace:
> >> [   58.321710]  i2c_transfer+0xe4/0xf8
> >> [   58.322020]  regmap_i2c_read+0x5c/0x98
> >> [   58.322350]  _regmap_raw_read+0xcc/0x138
> >> [   58.322694]  _regmap_bus_read+0x3c/0x70
> >> [   58.323034]  _regmap_read+0x60/0xe0
> >> [   58.323341]  _regmap_update_bits+0xc8/0x108
> >> [   58.323707]  regmap_update_bits_base+0x60/0x90
> >> [   58.324099]  rk808_device_shutdown+0x38/0x50
> >> [   58.324476]  machine_power_off+0x24/0x30
> >> [   58.324823]  kernel_power_off+0x64/0x70
> >> [   58.325159]  __do_sys_reboot+0x15c/0x240
> >> [   58.325504]  __arm64_sys_reboot+0x20/0x28
> >> [   58.325858]  el0_svc_common.constprop.2+0x88/0x150
> >> [   58.326279]  el0_svc_handler+0x20/0x80
> >> [   58.326607]  el0_sync_handler+0x118/0x188
> >> [   58.326960]  el0_sync+0x140/0x180
> >> [   58.327251] ---[ end trace b1de39d03d724d01 ]---
> >>
> >> -Anand
> >>
> >> _______________________________________________
> >> Linux-rockchip mailing list
> >> Linux-rockchip@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >>
> >
> > Gru=C3=9F,
>
-Anand

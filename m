Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F5C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCC62073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="S/JI/j73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfLKKzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:55:39 -0500
Received: from mout.web.de ([212.227.17.11]:46909 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfLKKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576061722;
        bh=qUkEqyozqakSIZMb6sQbu2kxLtJODzvqWpEHLHr47Ms=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S/JI/j73c3QcQdg4Hqr1W5gyW8LQo7j3UFzOmVUd2t2I5jmgwXfpIy5mgC2lCQTl2
         KJzV17Tv4L/BgMdSI7yoDqi3Oz5bZeXkEqIMH2iIQgvAT6wdu2UeufCA8seFTHiH4e
         tpjw0TXvRCq+w2UbYIUqsupPE4FR+YHed7O8TPnY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.97]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5Oct-1hnj4H0Z5T-00zZKa; Wed, 11
 Dec 2019 11:55:22 +0100
Subject: Re: [PATCH] mfd: rk808: Always use poweroff when requested
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20191209115746.12953-1-smoch@web.de>
 <CANAwSgS9ixhyOE2QYQ3CetA=BUVebMan2=9xBKF=U3YXAwCHNQ@mail.gmail.com>
 <6e380c0a-007d-22db-af26-19defaf1ae83@fivetechno.de>
 <8377b8d6-8b4d-0605-4c61-fb61b4aebf91@web.de>
 <CANAwSgQhPtBy-npPJgOAqieF7doGmaX3U35m95ktR2qAWVbf5w@mail.gmail.com>
From:   Soeren Moch <smoch@web.de>
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d743fb6b-74ab-b72b-3b68-e0acd03987f8@web.de>
Date:   Wed, 11 Dec 2019 11:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CANAwSgQhPtBy-npPJgOAqieF7doGmaX3U35m95ktR2qAWVbf5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:cpOH+2/RFSD9bmBKDG9AhZZHpAtStSBZBD++A4vSMI97lW1bO+Y
 bzmVmcVWPQu6VlL6LBpCo9/f6ghpUoOdsckrveg6LkqQFqbuP/Vu5noqk6bq1WyWfFIYv6S
 PJsc0sfyXYHqTQPXogsbmfuZJOsBaeBZIRmEAeQ7DEqZ93BfS8y/ev1LNbFCcKVP7qGSNTC
 RU2yGvuIav7aVunLyhrwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uMdms4wHem0=:R2k+SCtx5YTl3fLDUGrWw5
 OWT04+1+3/J1EDyi0O6LR8tkcIWcuflWcRT616Rky1pWu6wE1DSaCLOOiEcb9zORjGrdP0tjt
 zqbAJerDylox/EJi7UpHY8NZUgLAb1ZguIWZ36IQFV/QZVOODLNrX8LS4nb74rjSYQRXbza1j
 G/b0eMgg/uszJEdnZ8I0b7zcnnnaN/h5zV6Kj4yS9JugB5xfQcxQcyP/L3lPI1fxr8thlmg5s
 pGwNGQYPTOaOX4rSNy1GoPvmZQuL/qPI0DqWGkqefYKpz0bYGu519DQyWr56c+1gr5SjDysBu
 e1r8prlNf+gY9TlyPyHUIGpyjeAX1lH3ftfPiaUbklw7QdghG6Gp9wLYnzFoShlnYa0v1MhKN
 iQWjAt/OkP510WOpEzXFE4t2tJKNd8d7XO76UhfTeUAGVGajaML1iNizFXh4emf43c86NR4NF
 mA8zO0j9Xe1vP8rA1I5FpN8GDYWojVyoZCseFyd7Aur5WAtJax8MBqIXm3WxtFjiJsRTVY5Sn
 ejL7Jq0QkXigoZ8fjx2jDEB5Bi7q3uF9TcEQaG1ESLDYB/iX5fzOQ4gcCk2XpQANrUYK9IXZK
 b/IHxOv6YBsodiwOcW/fnZnkb6IaBbejNnMic6a/O/rjPfsX2XHT77/nqIj7bAgbeTjWu3Rbl
 +QoSxTZxo4qr4dAFbUD/jUqdr/j91e4XvDInsx+ZhCNu7AqYvo5PDwIstrh38X0EPrANq1Jic
 lLw/QzOxYwnsEC4VDloeULrYTXg0CbBQWV3508OWKJGMBJVu04s+iHOnvXmMx6H2Ad1m36yXq
 TydQBznWsOw3yOk+4afP/Q+f4+vOm9fp6llPnzxBqxyAdqoFV8StT6Xb8r5uxNj3VYy8Q3FHA
 pGbotumnHsxo/8ZqJ71gfOtKX3h3VbOYh4eS/Deq9e6AD1Ik4aYFlwroUvWhWUqzxXGHOOSsT
 6S7CjlsAkkmuqRcuJGARUoevCe71pmLsnNWi+9aRLlyA9w6qGBIOQnZjdD976ODXY8Ih5IVv2
 4tl7omWExTT1FR96/Xm9kMIyC0Hs77Hs8ri2NY+OBlP+Lrs3vpO9P4o3g2CBcmieJBzp1qWrE
 pDYm6GvPGlWh/eLfSTU8y0B572sWCKYb+fy3H9jNub7+ASJNKbaCtDD/lpQsfpjvKuOBM9zOQ
 o43Wh03xG9p4AHZxKqCoSiD9N0I4nnwY8CKTItG5wL5a5bDTmobqvX79Gqu5HynLMIPuTc+C9
 0fROnGSzNHx7vHnSVHlokgSYfa9YbzNdpK/eEZsggzF1olZlR7mLdPgi91Ew=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.19 03:00, Anand Moon wrote:
> hi Soeren,
>
> On Tue, 10 Dec 2019 at 22:10, Soeren Moch <smoch@web.de> wrote:
>>
>>
>> On 10.12.19 13:55, Markus Reichl wrote:
>>> Hi Anand,
>>>
>>> Am 10.12.19 um 13:42 schrieb Anand Moon:
>>>> Hi Soeren,
>>>>
>>>> On Mon, 9 Dec 2019 at 17:28, Soeren Moch <smoch@web.de> wrote:
>>>>> With the device tree property "rockchip,system-power-controller" we=

>>>>> explicitly request to use this PMIC to power off the system. So alw=
ays
>>>>> register our poweroff function, even if some other handler (probabl=
y
>>>>> PSCI poweroff) was registered before.
>>>>>
>>>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>>>> ---
>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-rockchip@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> ---
>>>>>  drivers/mfd/rk808.c | 11 ++---------
>>>>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>>>> index a69a6742ecdc..616e44e7ef98 100644
>>>>> --- a/drivers/mfd/rk808.c
>>>>> +++ b/drivers/mfd/rk808.c
>>>>> @@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *clien=
t,
>>>>>         const struct mfd_cell *cells;
>>>>>         int nr_pre_init_regs;
>>>>>         int nr_cells;
>>>>> -       int pm_off =3D 0, msb, lsb;
>>>>> +       int msb, lsb;
>>>>>         unsigned char pmic_id_msb, pmic_id_lsb;
>>>>>         int ret;
>>>>>         int i;
>>>>> @@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *clie=
nt,
>>>>>                 goto err_irq;
>>>>>         }
>>>>>
>>>>> -       pm_off =3D of_property_read_bool(np,
>>>>> -                               "rockchip,system-power-controller")=
;
>>>>> -       if (pm_off && !pm_power_off) {
>>>>> +       if (of_property_read_bool(np,
>>>>> "rockchip,system-power-controller")) {
>>>>>                 rk808_i2c_client =3D client;
>>>>>                 pm_power_off =3D rk808->pm_pwroff_fn;
>>>>> -       }
>>>>> -
>>>>> -       if (pm_off && !pm_power_off_prepare) {
>>>>> -               if (!rk808_i2c_client)
>>>>> -                       rk808_i2c_client =3D client;
>>>>>                 pm_power_off_prepare =3D rk808->pm_pwroff_prep_fn;
>>>>>         }
>>>>>
>>>> I gave this a try on my Rock960 and Odroid N1
>>>> both got kernel panic below.
>>> I see the same on rk3399-roc-pc.
>> This is no panic, it's a harmless warning.
> Ok but my device do not come up cleanly after that, it get stuck in
> u-boot in next boot.=20
I do not know Rock960 and Odroid N1, so unfortunately I cannot debug
your u-boot problem on these boards. From what you wrote the poweroff
apparently works with this patch, I have no idea what could be a
problem. After a complete power-off I would expect a clean cold boot.
And that 's what I see on my RockPro64 board.

This patch is about doing a PMIC poweroff when this method is requested
in the devicetree. If this method does not work for your boards, you
probably should remove the "rockchip,system-power-controller" property
and use PSCI poweroff or whatever is desired on your boards. This patch
does not change _how_ PMIC poweroff is done, only _that_ this method is
used when explicitly requested.
>
>> The i2c core nowadays expects a specially marked i2c transfer function=

>> late in the powerdown cycle:
> You can look into similar commit.
> d785334a0d5deff30a487c74324b842d2179553d (mfd: s2mps11: Add manual
> shutdown method for Odroid XU3)
I cannot see what should be similar in this patch. This patch is about a
totally different PMIC and how this needs to be programmed to work
properly on another different board.

Soeren
>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk=
3x.c
>> index 1a33007b03e9..cec115e0afa4 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -1126,6 +1126,7 @@ static u32 rk3x_i2c_func(struct i2c_adapter *ada=
p)
>>
>>  static const struct i2c_algorithm rk3x_i2c_algorithm =3D {
>>      .master_xfer        =3D rk3x_i2c_xfer,
>> +    .master_xfer_atomic    =3D rk3x_i2c_xfer, /* usable for PMIC powe=
roff */
>>      .functionality        =3D rk3x_i2c_func,
>>  };
>>
>> ---
>> It is only used for powerdown. The regular i2c xfer function works.
>>
>> Heiko, should I send a formal patch for that?
>>
>> Soeren
>>
>>>> [   58.305868] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
>>>> [   58.306747] reboot: Power down
>>>> [   58.307106] ------------[ cut here ]------------
>>>> [   58.307510] No atomic I2C transfer handler for 'i2c-0'
>>>> [   58.308007] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:41
>>>> i2c_transfer+0xe4/0xf8
>>>> [   58.308696] Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_aud=
io
>>>> rockchipdrm analogix_dp brcmfmac nvme dw_mipi_dsi nvme_core dw_hdmi
>>>> panfrost cec brcmutil drm_kms_helper gpu_sched cfg80211 hci_uart drm=

>>>> btbcm crct10dif_ce snd_soc_simple_card bluetooth snd_soc_rockchip_i2=
s
>>>> snd_soc_simple_card_utils snd_soc_rockchip_pcm phy_rockchip_pcie
>>>> ecdh_generic rtc_rk808 ecc pcie_rockchip_host rfkill rockchip_therma=
l
>>>> ip_tables x_tables ipv6 nf_defrag_ipv6
>>>> [   58.312150] CPU: 0 PID: 1 Comm: shutdown Not tainted
>>>> 5.5.0-rc1-dirty #1
>>>> [   58.312725] Hardware name: 96boards Rock960 (DT)
>>>> [   58.313131] pstate: 60000085 (nZCv daIf -PAN -UAO)
>>>> [   58.313551] pc : i2c_transfer+0xe4/0xf8
>>>> [   58.313889] lr : i2c_transfer+0xe4/0xf8
>>>> [   58.314225] sp : ffff80001004bb00
>>>> [   58.314516] x29: ffff80001004bb00 x28: ffff00007d208000
>>>> [   58.314981] x27: 0000000000000000 x26: 0000000000000000
>>>> [   58.315446] x25: 0000000000000000 x24: 0000000000000008
>>>> [   58.315910] x23: 0000000000000000 x22: ffff80001004bc74
>>>> [   58.316375] x21: 0000000000000002 x20: ffff80001004bb58
>>>> [   58.316841] x19: ffff0000784f0880 x18: 0000000000000010
>>>> [   58.317305] x17: 0000000000000001 x16: 0000000000000019
>>>> [   58.317770] x15: ffffffffffffffff x14: ffff8000118398c8
>>>> [   58.318236] x13: ffff80009004b867 x12: ffff80001004b86f
>>>> [   58.318701] x11: ffff800011851000 x10: ffff80001004b7f0
>>>> [   58.319166] x9 : 00000000ffffffd0 x8 : ffff800010699ad8
>>>> [   58.319631] x7 : 0000000000000265 x6 : ffff800011a20be9
>>>> [   58.320096] x5 : 0000000000000000 x4 : 0000000000000000
>>>> [   58.320561] x3 : 00000000ffffffff x2 : ffff800011851ab8
>>>> [   58.321026] x1 : d375c0d4f4751f00 x0 : 0000000000000000
>>>> [   58.321491] Call trace:
>>>> [   58.321710]  i2c_transfer+0xe4/0xf8
>>>> [   58.322020]  regmap_i2c_read+0x5c/0x98
>>>> [   58.322350]  _regmap_raw_read+0xcc/0x138
>>>> [   58.322694]  _regmap_bus_read+0x3c/0x70
>>>> [   58.323034]  _regmap_read+0x60/0xe0
>>>> [   58.323341]  _regmap_update_bits+0xc8/0x108
>>>> [   58.323707]  regmap_update_bits_base+0x60/0x90
>>>> [   58.324099]  rk808_device_shutdown+0x38/0x50
>>>> [   58.324476]  machine_power_off+0x24/0x30
>>>> [   58.324823]  kernel_power_off+0x64/0x70
>>>> [   58.325159]  __do_sys_reboot+0x15c/0x240
>>>> [   58.325504]  __arm64_sys_reboot+0x20/0x28
>>>> [   58.325858]  el0_svc_common.constprop.2+0x88/0x150
>>>> [   58.326279]  el0_svc_handler+0x20/0x80
>>>> [   58.326607]  el0_sync_handler+0x118/0x188
>>>> [   58.326960]  el0_sync+0x140/0x180
>>>> [   58.327251] ---[ end trace b1de39d03d724d01 ]---
>>>>
>>>> -Anand
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>>
>>> Gru=C3=9F,
> -Anand



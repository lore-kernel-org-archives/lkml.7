Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18854C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF42520836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UDDkrkcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLJQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:40:44 -0500
Received: from mout.web.de ([212.227.17.12]:45961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfLJQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575996028;
        bh=jvBxKea/ywk876Ln2ZWd62u/vI+Q343YD2tWSrxYKzo=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=UDDkrkcqOe82YGqnL8KMAliw3/RAYRM8kL7Vb2cZwYv4wFp1oUxXtigj+DnDTeNuy
         ity8UB/0HQJ7z50igmjBQXoc+t7jhLgzE5SNjT8jdGYv5gy5bcYxfWIuKKWtH2fZeZ
         BJ2pI0mtcmvPFRngmfZ62AElsvvRRFsDWBOImfQ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.58.50] ([80.130.119.216]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoHTx-1i7JkD19hJ-00gFDK; Tue, 10
 Dec 2019 17:40:28 +0100
From:   Soeren Moch <smoch@web.de>
Subject: Re: [PATCH] mfd: rk808: Always use poweroff when requested
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20191209115746.12953-1-smoch@web.de>
 <CANAwSgS9ixhyOE2QYQ3CetA=BUVebMan2=9xBKF=U3YXAwCHNQ@mail.gmail.com>
 <6e380c0a-007d-22db-af26-19defaf1ae83@fivetechno.de>
Message-ID: <8377b8d6-8b4d-0605-4c61-fb61b4aebf91@web.de>
Date:   Tue, 10 Dec 2019 17:40:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6e380c0a-007d-22db-af26-19defaf1ae83@fivetechno.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:Z7alPqcTNnZPzmAqXbSiNaJsfhw/zO+XCpFIPrik5MOlI9lE4+y
 WjG2xzstnsVWIGNcww2X19uNcaPUkG8rpQzFDl7jiBZF3F1A1PN4MkUHAnULynA948vc8Px
 pm9qjIYnlJC+FO8e96jXrfHvZlfD6Z7JiUWmSUblT2mv/M7r+7ePDwIWMZG4BY3eYzri4MT
 qDrD2FxMiNj1uW1YmSs0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rya/UKPottQ=:9ljsoHZATbr6EpFHf6Q9Ej
 t8V3aNaSA3nxzvUo9aWLxAUOUUEf5UdMx8sjW7vwGYVxfS2n45NqPwuR/F7CTz97m9r8KKovB
 OYcVk8WXtBcbO7TInZn8P4YiBwOErP19LIpVCCopvZYqzelM4XgsUZnNe9nncTLLGZ5NJUr3k
 O0jDTCDJ8a5LLOuZ01GBlTuWFQif3ZOJpoX7t8q0Z/MPxFIspBEk//iLcAPYMh1btAUt6Z8gK
 AaCJIRDmd1BF1DoFeUIU1JCDe/WBYUCyQbr/37+Xufz1QWQygJICt5BbSFeQEPydmtQFe8lVS
 R7hlSuWOubKVZjnUySgJeqoFkYbXf6eLtln4SDXBIqxFyQZGq0E0pY4Ne42mIwUtce7aLm0d4
 osKfwHGGC9RWxqJEBvOHI3J0wegaw7iI+1T0HNOQBcgFEW2lVCneoAMC2xFx1RT/Zo4cBoxbz
 ricLl8nt9tMn4XvhNpVx5yXsRw8TK3fs3mNumiEou3zXerh6V7rdmfXyclza7GC0JsrtsUBMf
 GFzyEcI/2FR4xQczarEeA6+BXIu+IdeqFEboKLzJ8tGdIscgH6vQtic97WWLFfeR8/DM+LySt
 jqGVCyiDw1aBzgwsBbg+BbyMXL7O9pADPno4Fldejsn6h21/xbUteqqQ5gdsh0/rOUC+/bpFL
 2bXLKHOMGtcoCj4D4hZYCsNZ5dSXsPAcZBulRnjTbRK3jIaqVYTIPpIC5aoyeRwvj50DbuDTk
 EhCRvX6kIgPYvv2XWM7tQaAcrEerCNUAw/HyRQf/0CB+ILYlm5JoSBn9We+6p9w6zsbU7tF95
 R1mDM1ypBMkdvA9AWe1tHhQXewuXet5tA4DygLv7R0f3oE1H2APRkducp02KNV4GTm56fCr7J
 oG3+bXpmJzzeJv2spp2jObRANP2hjcsNT1Jg1JAtr8cLyNlVwEZZmAdcHNvUl59sPrIPmyDlN
 X3gEDB7b0QAdkkMhBD15eG0PJ3vEfwIeMf+jU3ck/Ulh4bdTVwJqNm29UWh92bJtrXpBjCsYM
 i8xHO1veQZ8Wqpo+1aoGSmhAzToRG6+r7B7iN8Y9ylk62kZEIgW/m3H52fDWrfCvnJPEYhg53
 E38XnTYvZBRvCfnOLMq/TbUAznuXYCK85jQ406IpG4aJaHWKZ/r3BIbGsE6rytzi4DbF6D9tv
 pa/t9jQyuBGUUp9sMKaDVPWlL+Aq+0OS5Vku4Gg+zclqJ2eWkUh69sPJujmAs3z0KtaxiygFR
 8xQgEfTAjARTww1XeoK24OsV34fqJ8ec0hah/Xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.19 13:55, Markus Reichl wrote:
> Hi Anand,
>
> Am 10.12.19 um 13:42 schrieb Anand Moon:
>> Hi Soeren,
>>
>> On Mon, 9 Dec 2019 at 17:28, Soeren Moch <smoch@web.de> wrote:
>>>
>>> With the device tree property "rockchip,system-power-controller" we
>>> explicitly request to use this PMIC to power off the system. So always
>>> register our poweroff function, even if some other handler (probably
>>> PSCI poweroff) was registered before.
>>>
>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>> ---
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-rockchip@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>> =C2=A0drivers/mfd/rk808.c | 11 ++---------
>>> =C2=A01 file changed, 2 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>> index a69a6742ecdc..616e44e7ef98 100644
>>> --- a/drivers/mfd/rk808.c
>>> +++ b/drivers/mfd/rk808.c
>>> @@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct mfd_cell *cell=
s;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nr_pre_init_regs;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nr_cells;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int pm_off =3D 0, msb, lsb;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int msb, lsb;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char pmic_id_msb, =
pmic_id_lsb;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> @@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_irq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_off =3D of_property_read_bool=
(np,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rockchip,system-power-controller"=
);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_off && !pm_power_off) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (of_property_read_bool(np,
>>> "rockchip,system-power-controller")) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rk808_i2c_client =3D client;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pm_power_off =3D rk808->pm_pwroff_fn;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_off && !pm_power_off_prep=
are) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!rk808_i2c_client)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rk808_i2c_=
client =3D client;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pm_power_off_prepare =3D rk808->pm_pwroff_prep_fn;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>> I gave this a try on my Rock960 and Odroid N1
>> both got kernel panic below.
>
> I see the same on rk3399-roc-pc.
This is no panic, it's a harmless warning.
The i2c core nowadays expects a specially marked i2c transfer function
late in the powerdown cycle:

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1a33007b03e9..cec115e0afa4 100644
=2D-- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1126,6 +1126,7 @@ static u32 rk3x_i2c_func(struct i2c_adapter *adap)
=C2=A0
=C2=A0static const struct i2c_algorithm rk3x_i2c_algorithm =3D {
=C2=A0=C2=A0=C2=A0=C2=A0 .master_xfer=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =3D rk3x_i2c_xfer,
+=C2=A0=C2=A0=C2=A0 .master_xfer_atomic=C2=A0=C2=A0=C2=A0 =3D rk3x_i2c_xfe=
r, /* usable for PMIC poweroff */
=C2=A0=C2=A0=C2=A0=C2=A0 .functionality=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =3D rk3x_i2c_func,
=C2=A0};
=C2=A0
=2D--
It is only used for powerdown. The regular i2c xfer function works.

Heiko, should I send a formal patch for that?

Soeren

>
>>
>> [=C2=A0=C2=A0 58.305868] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregister=
ed
>> [=C2=A0=C2=A0 58.306747] reboot: Power down
>> [=C2=A0=C2=A0 58.307106] ------------[ cut here ]------------
>> [=C2=A0=C2=A0 58.307510] No atomic I2C transfer handler for 'i2c-0'
>> [=C2=A0=C2=A0 58.308007] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core=
.h:41
>> i2c_transfer+0xe4/0xf8
>> [=C2=A0=C2=A0 58.308696] Modules linked in: snd_soc_hdmi_codec dw_hdmi_=
i2s_audio
>> rockchipdrm analogix_dp brcmfmac nvme dw_mipi_dsi nvme_core dw_hdmi
>> panfrost cec brcmutil drm_kms_helper gpu_sched cfg80211 hci_uart drm
>> btbcm crct10dif_ce snd_soc_simple_card bluetooth snd_soc_rockchip_i2s
>> snd_soc_simple_card_utils snd_soc_rockchip_pcm phy_rockchip_pcie
>> ecdh_generic rtc_rk808 ecc pcie_rockchip_host rfkill rockchip_thermal
>> ip_tables x_tables ipv6 nf_defrag_ipv6
>> [=C2=A0=C2=A0 58.312150] CPU: 0 PID: 1 Comm: shutdown Not tainted
>> 5.5.0-rc1-dirty #1
>> [=C2=A0=C2=A0 58.312725] Hardware name: 96boards Rock960 (DT)
>> [=C2=A0=C2=A0 58.313131] pstate: 60000085 (nZCv daIf -PAN -UAO)
>> [=C2=A0=C2=A0 58.313551] pc : i2c_transfer+0xe4/0xf8
>> [=C2=A0=C2=A0 58.313889] lr : i2c_transfer+0xe4/0xf8
>> [=C2=A0=C2=A0 58.314225] sp : ffff80001004bb00
>> [=C2=A0=C2=A0 58.314516] x29: ffff80001004bb00 x28: ffff00007d208000
>> [=C2=A0=C2=A0 58.314981] x27: 0000000000000000 x26: 0000000000000000
>> [=C2=A0=C2=A0 58.315446] x25: 0000000000000000 x24: 0000000000000008
>> [=C2=A0=C2=A0 58.315910] x23: 0000000000000000 x22: ffff80001004bc74
>> [=C2=A0=C2=A0 58.316375] x21: 0000000000000002 x20: ffff80001004bb58
>> [=C2=A0=C2=A0 58.316841] x19: ffff0000784f0880 x18: 0000000000000010
>> [=C2=A0=C2=A0 58.317305] x17: 0000000000000001 x16: 0000000000000019
>> [=C2=A0=C2=A0 58.317770] x15: ffffffffffffffff x14: ffff8000118398c8
>> [=C2=A0=C2=A0 58.318236] x13: ffff80009004b867 x12: ffff80001004b86f
>> [=C2=A0=C2=A0 58.318701] x11: ffff800011851000 x10: ffff80001004b7f0
>> [=C2=A0=C2=A0 58.319166] x9 : 00000000ffffffd0 x8 : ffff800010699ad8
>> [=C2=A0=C2=A0 58.319631] x7 : 0000000000000265 x6 : ffff800011a20be9
>> [=C2=A0=C2=A0 58.320096] x5 : 0000000000000000 x4 : 0000000000000000
>> [=C2=A0=C2=A0 58.320561] x3 : 00000000ffffffff x2 : ffff800011851ab8
>> [=C2=A0=C2=A0 58.321026] x1 : d375c0d4f4751f00 x0 : 0000000000000000
>> [=C2=A0=C2=A0 58.321491] Call trace:
>> [=C2=A0=C2=A0 58.321710]=C2=A0 i2c_transfer+0xe4/0xf8
>> [=C2=A0=C2=A0 58.322020]=C2=A0 regmap_i2c_read+0x5c/0x98
>> [=C2=A0=C2=A0 58.322350]=C2=A0 _regmap_raw_read+0xcc/0x138
>> [=C2=A0=C2=A0 58.322694]=C2=A0 _regmap_bus_read+0x3c/0x70
>> [=C2=A0=C2=A0 58.323034]=C2=A0 _regmap_read+0x60/0xe0
>> [=C2=A0=C2=A0 58.323341]=C2=A0 _regmap_update_bits+0xc8/0x108
>> [=C2=A0=C2=A0 58.323707]=C2=A0 regmap_update_bits_base+0x60/0x90
>> [=C2=A0=C2=A0 58.324099]=C2=A0 rk808_device_shutdown+0x38/0x50
>> [=C2=A0=C2=A0 58.324476]=C2=A0 machine_power_off+0x24/0x30
>> [=C2=A0=C2=A0 58.324823]=C2=A0 kernel_power_off+0x64/0x70
>> [=C2=A0=C2=A0 58.325159]=C2=A0 __do_sys_reboot+0x15c/0x240
>> [=C2=A0=C2=A0 58.325504]=C2=A0 __arm64_sys_reboot+0x20/0x28
>> [=C2=A0=C2=A0 58.325858]=C2=A0 el0_svc_common.constprop.2+0x88/0x150
>> [=C2=A0=C2=A0 58.326279]=C2=A0 el0_svc_handler+0x20/0x80
>> [=C2=A0=C2=A0 58.326607]=C2=A0 el0_sync_handler+0x118/0x188
>> [=C2=A0=C2=A0 58.326960]=C2=A0 el0_sync+0x140/0x180
>> [=C2=A0=C2=A0 58.327251] ---[ end trace b1de39d03d724d01 ]---
>>
>> -Anand
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>
> Gru=C3=9F,


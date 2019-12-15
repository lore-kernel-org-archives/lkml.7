Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C5C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116D2467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PGFiczl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLOVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:13:47 -0500
Received: from mout.web.de ([212.227.15.3]:54833 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfLOVNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 16:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576444416;
        bh=xOWzP9Gln5b1oRl6klarBFIKtlakp0sGWp8BUl3lAIo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PGFiczl85OwMUJBb0uhXnxkL+UuAW5101PT88pMVGRzkvaw1lhtg7cgM4stFYbzKv
         ogtUnnWGQaDhPc5TusEWgs6XnA+tijcFQaBVfXV1ssHaluGJWLEkqJDZo4l6duI+pg
         zRbzwE68qEhVnq5arsBxs1V3wNBrsmeNshWshe04=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.206]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ63n-1ibwVA3sLz-005JlB; Sun, 15
 Dec 2019 22:13:36 +0100
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <cover.1575932654.git.robin.murphy@arm.com>
 <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
 <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
 <2681192.H4ySjFOPB8@diego>
From:   Soeren Moch <smoch@web.de>
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96384fa0-e1c0-85c2-4851-e5bbbb0cc6a7@web.de>
Date:   Sun, 15 Dec 2019 22:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2681192.H4ySjFOPB8@diego>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:wTgrkWWE4LS/k1z6lM8mW4sR8CfSAsGe2RIS+NTVDsU5riYhg/C
 t9Fz6+i7CEocVHNBCEUCxCo58sF2rGJFosdTuUf65gajnWW7vvNr+1PWdGkL8fSAir3bfgW
 3oHCccaullRyF0OhjYS4pCITHuyd/gpaM5MEZ4nktx1TRAi3wO30byjoYrT/Mbweo+23pMW
 NNKi1PE5YiZVENg+u9H6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wYJjH93+FVU=:5vF4Jj6ELMbjfDbRF9ANdL
 HebGo4+Z+F26WwBX+CTZEffZo9JTHl/AqucpTn+8dxES3EerjdAKb7oGUDAL3/X0tGsX4ZIrT
 9vkVaamiK2eCRNHjiMZk1CAwts3VCQHPZyh2vXG9ORbl3X6uaRkcuMLHK9d5QKmAnhgzKFwT0
 F0fOetv44xgzmZ3Sv2/E4rnQv2fDPJFX6T1B1VdYbgm8G3/vwyoMoGxmObmtTukXgyJLhkPqW
 bkdW7QgX9aphTjneD1oxMU8KIvhogc6iEv4I3Z70F53GsihYBDZSWkjyzZ8FzpW8cfic6lf/X
 zCRV74mrBvAs6TwImJzK2IkZaZ2i0rrgIxithHEr4Re3Bi6dUwQCOpYLtas+gMDFmU8zYvp7D
 oMZns6hgn/xTjkS+f3jBj9AfjVgclKuQS9NI4wEPsI5j0sd3WfoCQfL6MgC27sNPnF2XB90lx
 Z1v4J3LX0dproiR+iWM3V9a3orUh5DY+vpo4NowNo1Tfz5fGmyIkEEj/Z7RBbq0Bfn7IRaGKk
 ToIrIm6Am9hLFSgiJ3Tl57wB5msRwdTnBBYLtr1qZq/w6jWPVbeOATP0bHzW22NQwG8ubWNuk
 ITb0Goo4b9woAD6utluGTRel3OTy6pNrdwcGaAMPRIV6kh4H67P4731MiVPl1L0Xm8fJ32ATq
 N2gqB/BCj5eLk9ez5lfpd7PYS8QR3zRHvmVafWIpU4DWsb9S5WZtUxen/Az5WuWA3pT7GGae0
 E3RsLJuvHwjTCDu0NvzVT3cSMpYjEv9ROz3HJ2/zBq5lisvTcbiEepj9cqnG167Uy9xgiL5ZW
 8S1xEdVCxZLElkYbTk7x03jQxzxbCJtPwSQay0TaE7qsxqUcG+n3K8NDcCBs1NpkV88JTokv+
 1CL2P1SXKRNHkE89hypCzYQDYnUXEUmdsKqKMlDo3aDBzt+WwZpNYTjFO2ln9G3Xjd8oqAxMe
 CyW5L5O8q8kTkj8ZfVjQbsbTnye27dsD5vuLWR1bT2y3RGnN/d+M3dcXC0RTl3uLg4HHS4Wm9
 4oZ2iSkukZfssWtiZ9F8nnQ6UGo+O7881BqVu3cVVtcHi4gpAHUoXZmLqutFrXv0WkOtzlfk/
 r+4s0HBYDTAAT2gScRT133IXjp8k2i1ID2Xfm3K1b4jq1A4n9YRtcS9kgYatyAG4I94X4ItRY
 fsX5p00XGidzRcRhGAo7gVAAlUVhj/nA6XWVQ/QHB6kX1jlnLH/E1+zEuBXudDZOkCazGZGpx
 ELuSNVDR2tkfNV+T4tvzV2LnWZi49wf4Db6YW5EZ5+jy/EKc+rNNU3gbI3XRy+gV6b5gwCfKy
 Ze21PFysdjmcwnPWevwxVm0JhyPd2jqgIBMawsGkSsKYS4zFZcm2vzu0AFvWE9ebLg+q1ANv6
 7fUaMNuJlVQB4W2u6Ipvma9d6wY9biTdnoVbCZ9yJo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.19 21:27, Heiko St=C3=BCbner wrote:
> Hi Anand,
>
> Am Sonntag, 15. Dezember 2019, 19:51:50 CET schrieb Anand Moon:
>> On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wrot=
e:
>>> RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK81=
7,
>>> so it makes little sense for the driver to have to have two completel=
y
>>> different mechanisms to handle essentially the same thing. Bring RK80=
5
>>> in line with the RK809/RK817 flow to clean things up.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
> [...]
>
>> I am sill getting the kernel warning on issue poweroff see below.
>> on my Rock960 Model A
>> I feel the reason for this is we now have two poweroff callback
>> 1  pm_power_off =3D rk808_device_shutdown
>> 2  rk8xx_syscore_shutdown
> Nope, the issue is just the i2c subsystem complaining that the
> Rocckhip i2c drives does not provide an atomic-transfer function, see
> 	"No atomic I2C transfer handler for 'i2c-0'"
> in your warning.
>
> Somewhere it was suggested that the current transfer function just
> works as atomic as well.
I suggested to declare this function as "atomic" in a sense that it can
be used for power-off (this is what the i2c core expects from atomic
xfer functions, they are not used for anything else).
The current transfer function is not strictly atomic, since it expects
to get a completion interrupt. But nobody cares about the delivery of
such interrupt when the board is already switched off.

So the naming xfer_atomic is disadvantageous, if it had be named
xfer_poweroff instead there would be no doubt that the existing function
can be marked this way.
>> In my investigation earlier common function for shutdown solve
>> the issue of clean shutdown.
> This is simply a result of your syscore-shutdown function running way t=
o
> early, before the i2c subsystem switched to using atomic transfers.
>
> This also indicates that this would really be way to early, as other pa=
rts
> of the kernel could also still be running.
Exactly. So I still think that my simple patch does the right thing, and
this warning can be safely ignored.

Soeren
>
> Heiko
>
>
>> for *rockchip,system-power-controller* dts property
>> we can used flags if check if this property support clean shutdown
>> for that device.
>>
>> [  565.009291] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
>> [  565.010179] reboot: Power down
>> [  565.010536] ------------[ cut here ]------------
>> [  565.010940] No atomic I2C transfer handler for 'i2c-0'
>> [  565.011437] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:40
>> i2c_transfer+0xe4/0xf8
>> [  565.012126] Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_audio=

>> rockchipdrm nvme analogix_dp nvme_core brcmfmac hci_uart dw_mipi_dsi
>> dw_hdmi btbcm cec panfrost bluetooth drm_kms_helper brcmutil gpu_sched=

>> cfg80211 crct10dif_ce snd_soc_rockchip_i2s snd_soc_simple_card drm
>> ecdh_generic snd_soc_rockchip_pcm snd_soc_simple_card_utils
>> phy_rockchip_pcie ecc rtc_rk808 rfkill rockchip_thermal
>> pcie_rockchip_host ip_tables x_tables ipv6 nf_defrag_ipv6
>> [  565.015578] CPU: 0 PID: 1 Comm: shutdown Not tainted
>> 5.5.0-rc1-00292-gd46dd6369c55 #7
>> [  565.016260] Hardware name: 96boards Rock960 (DT)
>> [  565.016666] pstate: 60000085 (nZCv daIf -PAN -UAO)
>> [  565.017087] pc : i2c_transfer+0xe4/0xf8
>> [  565.017425] lr : i2c_transfer+0xe4/0xf8
>> [  565.017762] sp : ffff80001004baf0
>> [  565.018052] x29: ffff80001004baf0 x28: ffff00007d208000
>> [  565.018517] x27: 0000000000000000 x26: 0000000000000000
>> [  565.018982] x25: 0000000000000008 x24: 0000000000000000
>> [  565.019447] x23: ffff00007d208000 x22: ffff80001004bc64
>> [  565.019912] x21: ffff80001004bb48 x20: 0000000000000002
>> [  565.020377] x19: ffff000078502080 x18: 0000000000000010
>> [  565.020842] x17: 0000000000000001 x16: 0000000000000019
>> [  565.021307] x15: ffff00007d208470 x14: ffffffffffffffff
>> [  565.021772] x13: ffff80009004b857 x12: ffff80001004b860
>> [  565.022237] x11: ffff800011841000 x10: ffff800011a10658
>> [  565.022702] x9 : 0000000000000000 x8 : ffff800011a11000
>> [  565.023167] x7 : ffff800010697c78 x6 : 0000000000000262
>> [  565.023632] x5 : 0000000000000000 x4 : 0000000000000000
>> [  565.024096] x3 : 00000000ffffffff x2 : ffff800011841ab8
>> [  565.024561] x1 : 7b11701b0ae78800 x0 : 0000000000000000
>> [  565.025027] Call trace:
>> [  565.025246]  i2c_transfer+0xe4/0xf8
>> [  565.025556]  regmap_i2c_read+0x5c/0xa0
>> [  565.025886]  _regmap_raw_read+0xcc/0x138
>> [  565.026230]  _regmap_bus_read+0x3c/0x70
>> [  565.026568]  _regmap_read+0x60/0xe0
>> [  565.026875]  _regmap_update_bits+0xc8/0x108
>> [  565.027241]  regmap_update_bits_base+0x60/0x90
>> [  565.027633]  rk808_device_shutdown+0x6c/0x88
>> [  565.028010]  machine_power_off+0x24/0x30
>> [  565.028356]  kernel_power_off+0x64/0x70
>> [  565.028693]  __do_sys_reboot+0x15c/0x240
>> [  565.029038]  __arm64_sys_reboot+0x20/0x28
>> [  565.029390]  el0_svc_common.constprop.0+0x68/0x160
>> [  565.029811]  el0_svc_handler+0x20/0x80
>> [  565.030141]  el0_sync_handler+0x10c/0x180
>> [  565.030493]  el0_sync+0x140/0x180
>> [  565.030785] ---[ end trace 5167e842ce15f686 ]---
>>
>> -Anand
>>
>
>
>



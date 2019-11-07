Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C52C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3C720869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="aQ8qNvpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfKGUeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:34:37 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1573158875; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJiKD5MmcTiIe1wb1zWL7mjWCfksb22EL4zcfEfScos=;
        b=aQ8qNvpMHfH1MfVhS06EzPmmol+HJAIY+1h1J0f41aB73sTykAgZ5rzo+mYF8oC8wNJ2Ex
        32HUekDeDNtgV1TW6Se/nv3TwROaop1II1S2u8fSCBOTus2A20oBn/OLzfJjPIQXONiqZB
        lqf021pT7QMpJQQaDrXUeAvOaV+pynk=
Date:   Thu, 07 Nov 2019 21:34:29 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1573158869.3.2@crapouillou.net>
In-Reply-To: <78a8e3f2-c608-a2a1-4fd4-f379866726b5@linaro.org>
References: <20190809123824.26025-1-paul@crapouillou.net>
        <e8f1bd28-e8fe-926b-6741-3ab328f7815b@linaro.org>
        <54210a015f148218e11e7f3c1d107192@crapouillou.net>
        <a7aa0b0d-e52f-564f-11ef-a8b74f9f1ac8@linaro.org>
        <1573156678.3.0@crapouillou.net>
        <78a8e3f2-c608-a2a1-4fd4-f379866726b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu., nov. 7, 2019 at 21:22, Daniel Lezcano=20
<daniel.lezcano@linaro.org> a =C3=A9crit :
> On 07/11/2019 20:57, Paul Cercueil wrote:
>>=20
>>=20
>>  Le jeu., nov. 7, 2019 at 20:39, Daniel Lezcano
>>  <daniel.lezcano@linaro.org> a =C3=A9crit :
>>>  On 07/11/2019 16:56, Paul Cercueil wrote:
>>>>   Hi Daniel,
>>>>=20
>>>>   On 2019-08-16 16:54, Daniel Lezcano wrote:
>>>>>   On 09/08/2019 14:38, Paul Cercueil wrote:
>>>>>>   From: Maarten ter Huurne <maarten@treewalker.org>
>>>>>>=20
>>>>>>   OST is the OS Timer, a 64-bit timer/counter with buffered=20
>>>>>> reading.
>>>>>>=20
>>>>>>   SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770=20
>>>>>> and
>>>>>>   JZ4780 have a 64-bit OST.
>>>>>>=20
>>>>>>   This driver will register both a clocksource and a sched_clock=20
>>>>>> to the
>>>>>>   system.
>>>>>>=20
>>>>>>   Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>>>>>   Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>   Tested-by: Mathieu Malaterre <malat@debian.org>
>>>>>>   Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>>>>>   ---
>>>>>>=20
>>>>>=20
>>>>>   [ ... ]
>>>>>=20
>>>>>>   +    err =3D clocksource_register_hz(cs, rate);
>>>>>>   +    if (err) {
>>>>>>   +        dev_err(dev, "clocksource registration failed: %d\n",=20
>>>>>> err);
>>>>>>   +        clk_disable_unprepare(ost->clk);
>>>>>>   +        return err;
>>>>>>   +    }
>>>>>>   +
>>>>>>   +    /* Cannot register a sched_clock with interrupts on */
>>>>>=20
>>>>>   Aren't they already disabled?
>>>>=20
>>>>   Sorry for the late reply.
>>>>=20
>>>>   No, they are not already disabled; this is what I get if I=20
>>>> comment out
>>>>   the local_irq_save()/local_irq_restore():
>>>>=20
>>>>   [    0.361014] clocksource: ingenic-ost: mask: 0xffffffff=20
>>>> max_cycles:
>>>>   0xffffffff, max_idle_ns: 159271703898 ns
>>>>   [    0.361515] clocksource: Switched to clocksource ingenic-ost
>>>>   [    0.361686] ------------[ cut here ]------------
>>>>   [    0.361893] WARNING: CPU: 0 PID: 1 at=20
>>>> kernel/time/sched_clock.c:179
>>>>   sched_clock_register+0x7c/0x2e4
>>>>   [    0.362174] CPU: 0 PID: 1 Comm: swapper Not tainted=20
>>>> 5.4.0-rc5+ #461
>>>>   [    0.362330] Stack : 80744558 80069b44 80770000 00000000=20
>>>> 00000000
>>>>   00dfd7a7 806e6db4 8106bb74
>>>>   [    0.362619]         806f0000 81067ca4 806f31c7 80769478=20
>>>> 00000020
>>>>   10000400 8106bb20 00dfd7a7
>>>>   [    0.362906]         00000000 00000000 80780000 00000000=20
>>>> 00000007
>>>>   00000001 00000049 3563722d
>>>>   [    0.363191]         8106ba61 00000000 ffffffff 00000010=20
>>>> 806f0000
>>>>   00000000 00000000 806f0000
>>>>   [    0.363477]         00000020 00000000 80714534 80770000=20
>>>> 00000002
>>>>   80319154 00000000 80770000
>>>>   [    0.363762]         ...
>>>>   [    0.363906] Call Trace:
>>>>   [    0.364087] [<8001af14>] show_stack+0x40/0x128
>>>>   [    0.364289] [<8002fd88>] __warn+0xb8/0xe0
>>>>   [    0.364478] [<8002fe14>] warn_slowpath_fmt+0x64/0xc0
>>>>   [    0.364678] [<8072b1c8>] sched_clock_register+0x7c/0x2e4
>>>>   [    0.364895] [<8073c874>] ingenic_ost_probe+0x224/0x248
>>>>   [    0.365090] [<803d5394>] platform_drv_probe+0x40/0x94
>>>>   [    0.365526] [<803d362c>] really_probe+0x104/0x374
>>>>   [    0.365743] [<803d3ff0>] device_driver_attach+0x78/0x80
>>>>   [    0.365938] [<803d4070>] __driver_attach+0x78/0x118
>>>>   [    0.366129] [<803d1700>] bus_for_each_dev+0x7c/0xc8
>>>>   [    0.366318] [<803d226c>] bus_add_driver+0x1bc/0x204
>>>>   [    0.366513] [<803d4878>] driver_register+0x84/0x14c
>>>>   [    0.366717] [<8073a144>] __platform_driver_probe+0x98/0x140
>>>>   [    0.366931] [<80724e38>] do_one_initcall+0x84/0x1b4
>>>>   [    0.367126] [<807250cc>] kernel_init_freeable+0x164/0x240
>>>>   [    0.367318] [<805df75c>] kernel_init+0x10/0xf8
>>>>   [    0.367510] [<8001542c>] ret_from_kernel_thread+0x14/0x1c
>>>>   [    0.367722] ---[ end trace 7fedf00408fa3bed ]---
>>>>   [    0.367985] sched_clock: 32 bits at 12MHz, resolution 83ns,=20
>>>> wraps
>>>>   every 178956970966ns
>>>>=20
>>>>   At kernel/time/sched_clock.c:179 there is:
>>>>   WARN_ON(!irqs_disabled());
>>>=20
>>>  That is strange, no drivers is doing that and no warning is=20
>>> appearing.
>>>=20
>>>  Isn't missing a local_irq_disable in the code path in the stack=20
>>> above?
>>=20
>>  I think it comes to the fact that the other drivers are probed much
>>  earlier in the boot process, while this one is probed as a regular
>>  platform device driver.
>=20
>=20
> There are other drivers doing and nobody is disabling the interrupt:
>=20
> em_sti.c:static struct platform_driver em_sti_device_driver =3D {
> ingenic-timer.c:static struct platform_driver ingenic_tcu_driver =3D {
> sh_cmt.c:static struct platform_driver sh_cmt_device_driver =3D {
> sh_mtu2.c:static struct platform_driver sh_mtu2_device_driver =3D {
> sh_tmu.c:static struct platform_driver sh_tmu_device_driver =3D {
> timer-ti-dm.c:static struct platform_driver omap_dm_timer_driver =3D {

Yes, but they don't register a sched_clock at all (except for=20
ingenic-timer, but it does probe using TIMER_OF_DECLARE), and this=20
warning is in sched_clock_register().

>=20
>>>>>>   +    local_irq_save(flags);
>>>>>>   +    if (soc_info->is64bit)
>>>>>>   +        sched_clock_register(ingenic_ost_read_cntl, 32, rate);
>>>>>>   +    else
>>>>>>   +        sched_clock_register(ingenic_ost_read_cnth, 32, rate);
>>>>>>   +    local_irq_restore(flags);
>>>>>>   +
>>>>>>   +    return 0;
>>>>>>   +}
>>>>>>   +
>>>=20
>>>=20
>>>  --
>>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r=20
>>> ARM SoCs
>>>=20
>>>  Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>  <http://twitter.com/#!/linaroorg> Twitter |
>>>  <http://www.linaro.org/linaro-blog/> Blog
>>>=20
>>=20
>>=20
>=20
>=20
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM=20
> SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

=


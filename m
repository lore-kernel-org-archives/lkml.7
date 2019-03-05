Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C732087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="nHNE59YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfCEP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:27:37 -0500
Received: from office2.cesnet.cz ([195.113.144.244]:49650 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCEP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:27:37 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 10:27:34 EST
Received: from localhost (unknown [IPv6:2001:718:1:2e:9077:1a3:d51f:f1d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id DB8B5400063;
        Tue,  5 Mar 2019 16:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1551799184;
        bh=jWrhbhwsttQzS+I6d/Qh9+WmZ1uml6w0QJ82oRZEveU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nHNE59YYoBgPH44c1TovphTG3MDVMr18Jo+ZndOJqQG2+XoAQwzHsvN5Nlzo9Hsrj
         lV2GDUr3ukRyWwQTQIG673bB1gRz/IkMyR9+xzzkPEprmNPo5OpA+blU518qP4JvII
         tqyDBGSbOpeBVHLb2khCgYJZRSpJCdFbgOpauz38=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Allocate =?iso-8859-1?Q?irq=5Fchip_dynamic?=
Date:   Tue, 05 Mar 2019 16:19:43 +0100
MIME-Version: 1.0
Message-ID: <7ce47f34-ed9f-44ac-b966-68e3bbf3b052@cesnet.cz>
In-Reply-To: <CACRpkdZFFu=wgHw0BqXUHiC5euGwWuYbr5bH60zDvFr+q394=w@mail.gmail.com>
References: <20190111162516.28197-1-poeschel@lemonage.de>
 <CACRpkdZFFu=wgHw0BqXUHiC5euGwWuYbr5bH60zDvFr+q394=w@mail.gmail.com>
Organization: CESNET
User-Agent: Trojita/v0.7-377-g27bf90aa; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pond=C4=9Bl=C3=AD 21. ledna 2019 14:19:49 CET, Linus Walleij wrote:
> On Fri, Jan 11, 2019 at 4:16 PM Lars Poeschel <poeschel@lemonage.de> wrote:=

>
>> Keeping the irq_chip definition static shares it with multiple instances
>> of the mcp23s08 gpiochip in the system. This is bad and now we get this
>> warning from gpiolib core:
>>=20
>> "detected irqchip that is shared with multiple gpiochips: please fix the
>> driver."
>>=20
>> Hence, move the irq_chip definition from being driver static into the
>> struct mcp23s08. So a unique irq_chip is used for each gpiochip
>> instance.
>>=20
>> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
>
> Patch applied.

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Fixes: 171948ea33e14 (gpiolib: check if irqchip already has the irq hook=20
replacements)

This commit should probably go to 5.0-stable and 4.20-stable as well=20
because commit 171948ea33e14 first appeared in 4.20. I have been using 4.19=20=

previsouly, which works, but 5.0 oopses on boot for me with two MCP23S17=20
chips (sorry, I just don't know how to get more than 10 lines of stack=20
trace in this oops):

[    1.011926] gpio gpiochip3: (mcp23s17.1): detected irqchip that is=20
shared with multiple gpiochips: please fix the driver.
[    1.022936] GPIO line 486 (I2C XOR ready) hogged as input
[    1.028550] Unable to handle kernel NULL pointer dereference at virtual=20=

address 00000054
[    1.036675] pgd =3D (ptrval)
[    1.039388] [00000054] *pgd=3D00000000
[    1.042980] Internal error: Oops: 5 [#1] SMP ARM
[    1.047613] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0 #1
[    1.053460] Hardware name: Marvell Armada 380/385 (Device Tree)
[    1.059401] PC is at __dev_printk+0x10/0x84
[    1.063595] LR is at _dev_info+0x44/0x68
[    1.067528] pc : [<c0435b50>]    lr : [<c0436764>]    psr: 20000013
[    1.073811] sp : ef4afbb4  ip : ef4afbbc  fp : eed0a040
[    1.079048] r10: 00000000  r9 : c0b32834  r8 : 00000000
[    1.084286] r7 : c016f8cc  r6 : 00000000  r5 : ef9f7ba0  r4 : c0b07bc8
[    1.090829] r3 : ef4afbd8  r2 : ef4afbbc  r1 : 00000008  r0 : c08cf6fc
[    1.097374] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=20=

none
[    1.104528] Control: 10c5387d  Table: 0000404a  DAC: 00000051
[    1.110289] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
[    1.116311] Stack: (0xef4afbb4 to 0xef4b0000)
[    1.120679] fba0:                                              c0436764=20=

ef4afbd8 c08f7134
[    1.128881] fbc0: ef4afbb8 36415da1 c0bbc194 eed0a08c c03bce58 c08f7134=20=

ef714c40 00000000
[    1.137082] fbe0: eed0a08c 00000002 eecf9840 eed0a064 c0b07bc8 eed0a400=20=

eed0a08c 00000002
[    1.145283] fc00: eecf9840 c03b9484 00000000 00000001 00000000 00000000=20=

00004c4c 36415da1
[    1.153485] fc20: 00000000 00000003 eed0a400 00000002 00000000 c09019b8=20=

ef4afc5c c03b97ac
[    1.161686] fc40: 00000001 ffffffff 00000010 00000001 0000010c c0b07bc8=20=

00000002 00000006
[    1.169887] fc60: ffffffff 36415da1 00000000 eed0a400 00000000 c0b32768=20=

00000000 00000000
[    1.178088] fc80: c0b32778 00000000 00000000 c04d0218 c0bb8590 eed0a400=20=

c0bb859c c04391e8
[    1.186290] fca0: eed0a400 c0b32778 ef4afd1c c0439848 00000001 00000000=20=

00000000 c043965c
[    1.194491] fcc0: eed0a400 c0b32778 c0b32768 00000000 c0b07bc8 ef4afd1c=20=

c0439848 00000001
[    1.202692] fce0: 00000000 00000000 00000000 c0437ca4 00000000 ef54cc6c=20=

ef5c8938 36415da1
[    1.210894] fd00: eed0a400 eed0a400 c0b07bc8 eed0a434 eee79c00 c04394c4=20=

c093b958 eed0a400
[    1.219095] fd20: 00000001 36415da1 eed0a408 eed0a400 c0b43fd4 eee79c00=20=

eed0a400 c0437e60
[    1.227296] fd40: eed0a408 c0b07bc8 00000000 c0436244 00000006 c04d56f8=20=

00000000 eed0a400
[    1.235497] fd60: 000001be 36415da1 eed0a400 eee79c00 00000000 ef575410=20=

00000001 ef9f7bec
[    1.243699] fd80: c0b07bc8 c04d2620 eee79c00 ef9f7ba0 eed0a400 00000000=20=

00000001 c04d2e4c
[    1.251900] fda0: 00000000 c05cff48 c0901258 c0913c9c c0913ca8 c0913dd4=20=

00989680 36415da1
[    1.260102] fdc0: eee79f48 eee79c00 ef575400 eee79f48 ef575410 00000002=20=

c0b07bc8 f0997680
[    1.268303] fde0: c08d00d8 c04d618c 00000000 c02ab604 c08f7a40 c09141b8=20=

eee79c00 c0b07bc8
[    1.276504] fe00: 00000003 36415da1 c08fed94 ef575410 00000000 c0b449bc=20=

00000000 00000000
[    1.284706] fe20: c0b449bc 00000000 c0a5185c c043a8c4 c0bb8590 ef575410=20=

c0bb859c 00000000
[    1.292907] fe40: 00000000 c04391e8 ef575410 c0b449bc ef575444 c0439768=20=

00000000 c0a5183c
[    1.301108] fe60: c0a004a8 c043965c ef9f7144 c0439768 00000000 ef575410=20=

c0b449bc ef575444
[    1.309310] fe80: c0439768 00000000 c0a5183c c0a004a8 c0a5185c c0439844=20=

ef579a34 c0b07bc8
[    1.317511] fea0: c0b449bc c043771c 00000000 ef484d58 ef579a34 36415da1=20=

c0b3b638 c0b449bc
[    1.325712] fec0: ef737c80 c0b3b638 00000000 c0438114 c0914250 c0439fa8=20=

c0b449bc c0b449bc
[    1.333914] fee0: c0b07bc8 c0a2f38c ffffe000 c0439f78 c0b62260 c0b07bc8=20=

c0a2f38c c0a0101c
[    1.342115] ff00: efffcdb7 c013dd34 c0941a58 c0921800 00000000 00000006=20=

00000006 c08d5294
[    1.350316] ff20: 00000000 c0b07bc8 c08e2294 c08d5308 c0b64e00 efffcda4=20=

efffcdb2 36415da1
[    1.358518] ff40: c0a51840 c0b62260 c0a60a80 36415da1 c0b62260 c0a60c44=20=

00000007 c0b64e00
[    1.366719] ff60: c0b64e00 c0a0139c 00000006 00000006 00000000 c0a004a8=20=

000000b8 00000000
[    1.374920] ff80: 00000000 00000000 c071f84c 00000000 00000000 00000000=20=

00000000 00000000
[    1.383121] ffa0: 00000000 c071f854 00000000 c01010e8 00000000 00000000=20=

00000000 00000000
[    1.391322] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000=20=

00000000 00000000
[    1.399523] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000=20=

00000000 00000000
[    1.407729] [<c0435b50>] (__dev_printk) from [<ef4afbb8>] (0xef4afbb8)
[    1.414276] Code: e3510000 0a00001a e52de004 e1a0c002 (e591304c)=20
[    1.420405] ---[ end trace 1243f20a0e53cc41 ]---
[    1.425040] Kernel panic - not syncing: Fatal exception
[    1.430282] CPU1: stopping
[    1.433000] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D          =20
5.0.0 #1
[    1.440242] Hardware name: Marvell Armada 380/385 (Device Tree)
[    1.446188] [<c01103ac>] (unwind_backtrace) from [<c010c1e4>]=20
(show_stack+0x10/0x14)
[    1.453958] [<c010c1e4>] (show_stack) from [<c0708af0>]=20
(dump_stack+0x88/0x9c)
[    1.461205] [<c0708af0>] (dump_stack) from [<c010f0b8>]=20
(handle_IPI+0x348/0x380)
[    1.468626] [<c010f0b8>] (handle_IPI) from [<c03af568>]=20
(gic_handle_irq+0x8c/0x90)
[    1.476220] [<c03af568>] (gic_handle_irq) from [<c0101a0c>]=20
(__irq_svc+0x6c/0x90)
[    1.483723] Exception stack(0xef4cdf60 to 0xef4cdfa8)
[    1.488789] df60: 00000000 00002418 ef9e4de0 c0118940 ffffe000 c0b07bf0=20=

c0b07c30 00000002
[    1.496991] df80: 00000000 c0b07bc8 c0a69a00 c0b61f0c 00000000 ef4cdfb0=20=

c0108c94 c0108c98
[    1.505191] dfa0: 60000013 ffffffff
[    1.508693] [<c0101a0c>] (__irq_svc) from [<c0108c98>]=20
(arch_cpu_idle+0x38/0x3c)
[    1.516113] [<c0108c98>] (arch_cpu_idle) from [<c014ccd4>]=20
(do_idle+0x1c4/0x1fc)
[    1.523533] [<c014ccd4>] (do_idle) from [<c014cfa8>]=20
(cpu_startup_entry+0x18/0x20)
[    1.531124] [<c014cfa8>] (cpu_startup_entry) from [<0010252c>]=20
(0x10252c)
[    1.537933] Rebooting in 10 seconds..

If I cherry-pick the following two commits to my 5.0, my board boots once=20
again:

16f4372fd7a5 pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
19ab5ca9b77d pinctrl: mcp23s08: Allocate irq_chip dynamic

While I am not getting a complete stack trace, it seems likely that the=20
culprit is indeed 171948ea33e14. It does not add a mere warning, it also=20
changes behavior so that a chip's irq_enable and irq_disable are not=20
properly initialized. There's no error code in this function, so the rest=20
of the code cannot reasonably catch this new behavior. My recommendation=20
would be to actually get rid of that early return, but if the point is to=20
*really* get people to notice, well, I noticed :).

As on "why am I hitting this while nobody else did", my board has a shared=20=

IRQ line which is active during bootup, perhaps that might have something=20
to do with this -- I don't know.

Thanks for this fixup, Lars.

Cheers,
Jan

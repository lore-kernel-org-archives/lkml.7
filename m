Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA0FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42E02067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IOujnRLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406440AbfJPRJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:09:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37996 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389169AbfJPRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:09:28 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so54737558iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwCxUUjV/WWtVtkLQrc81XbqHdJCi8kT6J04rR+JzSM=;
        b=IOujnRLxlKPoaPWR75FGkvjgqSoRhSb1XG7qPwi3oy3neKNnsG6g2iJm9mdC62eG4U
         w9Or/1Ew0E2GNtQTdbkImrBBSm8RvvxlvH8sSZVfxvELKEkTZze0AP10e8yZkf4usEJS
         sB1xMEfJpP+x4bnwk93isNxCW8UXRsHu1jlTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwCxUUjV/WWtVtkLQrc81XbqHdJCi8kT6J04rR+JzSM=;
        b=jSB4a7oarEuCh+kbG/6La3feSUB+d9JIqpqfF6n/qAXJ42ST/m/ojYFTJf9oTfseYv
         OjnP06u4J06URz/RRpKl8waqItyXNmTJ2/+v6qtXmpvoeKPV1ILa3HLgmw2hUljhYE2A
         g/AfWfEnEGmKC/fc9ggi5y6IDS5yLzGchAoHJmE1rAKy+0HofH7fT73zp49bWiO5fND2
         yoyllMokcunJQJapYM4fKayFV2uK5oc4pRPyqfBzOz6PnMQcp0SRqnAGT4Lnzobzqvx4
         l+P3XAJPrBinzL9zBis9tgl9/ZUoQwNfy619w9mA+/AHnolTyXaNB+SZFf2BmiHvUy2F
         +KJw==
X-Gm-Message-State: APjAAAWK3y/xuKcAHwFpp1uG2AFH0iJ24sXNzOKNJhP55n7O3t70kEoo
        Xpg2ELT/I/Mfbuvn9KLqbYpdBKGyi/Gr50kTkvkw9Q==
X-Google-Smtp-Source: APXvYqwXM3D0W4/cfzsffh3JxHhnLGUHpZUbiwTI1st0K2tHjwZubNj/ZOkYEMgrbKiSdWBeO5xsKgO/UZEqnX4WX2o=
X-Received: by 2002:a02:9a15:: with SMTP id b21mr3854078jal.103.1571245765494;
 Wed, 16 Oct 2019 10:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
 <20190919052822.10403-2-jagan@amarulasolutions.com> <6797961.eJj5WIFbM9@phil>
 <CAMty3ZDKaywoPxCSD-5N2pLjtGmZ-dZ7ZgUOJqiB1V_9rfR26A@mail.gmail.com> <87eezolynl.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <87eezolynl.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Oct 2019 22:39:13 +0530
Message-ID: <CAMty3ZD8uHsj0Jzs08sKG0JXfC6MU0MHdKs=kw4m5rupnoTtqg@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
To:     Levin Du <djw@t-chip.com.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Da Xue <da@lessconfused.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

On Tue, Oct 8, 2019 at 8:42 AM <djw@t-chip.com.cn> wrote:
>
> Jagan Teki <jagan@amarulasolutions.com> writes:
>
> > Hi Heiko,
> >
> > On Mon, Sep 30, 2019 at 2:51 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >>
> >> Hi Jagan,
> >>
> >> Am Donnerstag, 19. September 2019, 07:28:17 CEST schrieb Jagan Teki:
> >> > ROC-PC is not able to boot linux console if PWM2_d is
> >> > unattached to any pinctrl logic.
> >> >
> >> > To be precise the linux boot hang with last logs as,
> >> > ...
> >> > .....
> >> > [    0.003367] Console: colour dummy device 80x25
> >> > [    0.003788] printk: console [tty0] enabled
> >> > [    0.004178] printk: bootconsole [uart8250] disabled
> >> >
> >> > In ROC-PC the PWM2_d pin is connected to LOG_DVS_PWM of
> >> > VDD_LOG. So, for normal working operations this needs to
> >> > active and pull-down.
> >> >
> >> > This patch fix, by attaching pinctrl active and pull-down
> >> > the pwm2.
> >>
> >> This looks highly dubious on first glance. The pwm subsystem nor
> >> the Rockchip pwm driver do not do any pinctrl handling.
> >>
> >> So I don't really see where that "active" pinctrl state is supposed
> >> to come from.
> >>
> >> Comparing with the pwm driver in the vendor tree I see that there
> >> is such a state defined there. But that code there also looks strange
> >> as that driver never again leaves this active state after entering it.
> >>
> >> Also for example all the Gru devices run with quite a number of pwm-
> >> regulators without needing additional fiddling with the pwm itself, so
> >> I don't really see why that should be different here.
> >
> > I deed, I was supposed to think the same. but the vendor kernel dts
> > from firefly do follow the pwm2 pinctrl [1]. I wouldn't find any
> > information other than this vensor information, ie one of the reason I
> > have marked "Levin Du" who initially supported this board.
> >
> > One, think I have seen was this pinctrl active fixed the boot hang.
> > any inputs from would be very helpful.
> >
> > Levin Du, any inputs?
> >
> > [1] https://github.com/FireflyTeam/kernel/blob/stable-4.4-rk3399-linux/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi#L1184
> >
>
> A grep of the `pwm2` shows that there's such block in rk3399-nanopi4.dtsi:
>
>     &pwm2 {
>             pinctrl-names = "active";
>             pinctrl-0 = <&pwm2_pin_pull_down>;
>             status = "okay";
>     };
>
> But last time I checked, using the mainline U-Boot (the roc-rk3399-pc is
> in mainline now) with mainline linux v5.2-rc7, no such setting is
> necessary, and the board boots happily.
>
> I cannot find the use of "active" pinctrl state in the
> `drivers/pwm/pwm-rockchip.c`. If the pinctrl state needs to be setup as
> default, the `pinctrl-names` needs to be "default" or "init" (see
> `drivers/base/pinctrl.c`) .
>
> Jagan, what version of board do you use? I checked with
> "ROC-RK3399-PC-V1.0-A 2018-07-12".

I have ROC-RK3399-PC-V1.A 2018.09.25 and powering with TYPE-C0 port.

And here the boot log

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.4.0-rc3-next-20191016
(jagan@jagan-XPS-13-9350) (gcc version 6.3.1 20170109 (Linaro GCC
6.3-2017.02)) #1 SMP PREEMPT Wed Oct 16 21:17:23 IST 2019
[    0.000000] Machine model: Firefly ROC-RK3399-PC Board
[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff1a0000 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x000000003e000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000000200000-0x00000000f7ffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xf77ef100-0xf77f0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000f7ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 22 pages/cpu s52952 r8192 d28968 u90112
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 999432
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line:
earlycon=uart8250,mmio32,0xff1a0000 root=/dev/mmcblk1p1 rootwait
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3a000000-0x3e000000] (64MB)
[    0.000000] Memory: 3856004K/4061184K available (12028K kernel
code, 1870K rwdata, 6440K rodata, 5056K init, 451K bss, 172412K
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
[    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
[    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices
@f6880000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x00000000f6840000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x00000000f6850000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] {
/cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] {
/cpus/cpu@100[4] /cpus/cpu@101[5] }
[    0.000000] random: get_random_bytes called from
start_kernel+0x2b8/0x454 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns
[    0.003201] Console: colour dummy device 80x25
[    0.003624] printk: console [tty0] enabled
[    0.004020] printk: bootconsole [uart8250] disabled

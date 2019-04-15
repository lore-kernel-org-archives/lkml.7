Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD299C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17E32064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtwJMsqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfDOMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:24:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36191 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:24:41 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so14369938iop.3;
        Mon, 15 Apr 2019 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8WdueF34ID5kFNRTxdR9hTEpTonVJ/TQmUtZwBJ3jU=;
        b=GtwJMsqK37CRd0EDk89Li7cpJOeHpGWSbSOyLWqrxTLKcotHry9JFTNHFd6XEGRjGW
         9YPq9vHyUf6T+/YdFs0H8tPFqX/Lv7GR9X1/NLgXHgfYxmgJhxmztYEMZ2V4ww0q/G7p
         EBIHQ7DCiDQEmF/5frCJ7N9wp7/vdovmW3l2tFObHltBvg0flO5AYVCopjWSQnKCWvJ0
         QIE4deAF9c5CZRuiurjfLpEnk3I9FwdXHAomI55pr8OiHxcS/73oTYKBdlvLw9gsYYRs
         NBJS78QOTD4aJcxfQ7uZzFmv6B9kO6SuCB8hesDn5o2UHTdczoj7JvBFo3ow+amZWViK
         i0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8WdueF34ID5kFNRTxdR9hTEpTonVJ/TQmUtZwBJ3jU=;
        b=tF8lt6Ao59cq6dAaVYxAUzecrcySjIv8wR9l8cW3WoTp9/cLcJ5pyCisevyOS1EBx4
         v6ifB4PQdXNXpX+Rv186PctwPMSjWAkZtFZP944puHGP5dwMlKFivp0IdLx68DvHbGLi
         x0+DdDjVfEr1jimoa1mG46sRdfBGI3BC5hnnjlvU3cx1mc7j7UTtCgqcAOaTrYloiGYJ
         xPgd2Imp4Px8gLlcMS38kA2c73ZHm9FlpEL9wW0pwD7ljcJaMZFitdNM9SbOjsJ0H6Ha
         ghmRk5nnLySWMrw0eC1cjz8Zi/ELtnSrPn1I9D1HztRd3KvYhKZtrtq5gRTzz2f4apy1
         jejA==
X-Gm-Message-State: APjAAAXuYU9jC43EVDuNf4a5wayuHoqD7haStT6Whfq7lLBV6QD2MbXJ
        Nyd1RWDLsHkULrcUDGdkdnlIAj+XGsH6yu6A1ks=
X-Google-Smtp-Source: APXvYqzV4AvDsutmOH5hvWlAxDPeR510VuVHy6eUudWI4HOYyYeDfBLlS+Jl/uYzCiQFrpGvCCzX41XAc/AsL++OI44=
X-Received: by 2002:a5e:dd44:: with SMTP id u4mr8684277iop.44.1555331080712;
 Mon, 15 Apr 2019 05:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
In-Reply-To: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 15 Apr 2019 17:54:31 +0530
Message-ID: <CANAwSgSX6q4M2EcWvEA3B6zQuY0DBrh-0_r3v__R--p7dzjs7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Fri, 12 Apr 2019 at 22:55, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> Add device tree entries for PMU of ARM CCI-400.
>
> $ sudo ./perf stat -a -C 0 -e CCI_400/config=0xff,name=cycles/ sleep 1
>
>  Performance counter stats for 'system wide':
>
>        420,303,619      cycles
>
>        1.019058775 seconds time elapsed
>
> Tested on Odroid-xu3 and 4.
>
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff15880761..be58650aca35 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -158,7 +158,7 @@
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         reg = <0x10d20000 0x1000>;
> -                       ranges = <0x0 0x10d20000 0x6000>;
> +                       ranges = <0x0 0x10d20000 0x10000>;
>
>                         cci_control0: slave-if@4000 {
>                                 compatible = "arm,cci-400-ctrl-if";
> @@ -170,6 +170,16 @@
>                                 interface-type = "ace";
>                                 reg = <0x5000 0x1000>;
>                         };
> +
> +                       pmu@9000 {
> +                               compatible = "arm,cci-400-pmu,r0";
> +                               reg = <0x9000 0x5000>;

As per Exynos 5422 user manual below interrupts should be as follow.

+                               interrupts = <GIC_SPI 176
IRQ_TYPE_LEVEL_HIGH>, /* CCI_N_EVENT_CNT0_OVF */
+                                       <GIC_SPI 177
IRQ_TYPE_LEVEL_HIGH>, /* CCI_N_EVENT_CNT1_OVF */
+                                       <GIC_SPI 178
IRQ_TYPE_LEVEL_HIGH>, /* CCI_N_EVENT_CNT2_OVF */
+                                       <GIC_SPI 179
IRQ_TYPE_LEVEL_HIGH>, /* CCI_N_EVENT_CNT3_OVF */
+                                       <GIC_SPI 180
IRQ_TYPE_LEVEL_HIGH>, /* CCI_N_EVENT_CNT4_OVF */
+                                       <GIC_SPI 181
IRQ_TYPE_LEVEL_HIGH>; /* CCI_NERR */

> +                               interrupts = <0 105 4>,
> +                                            <0 101 4>,
> +                                            <0 102 4>,
> +                                            <0 103 4>,
> +                                            <0 104 4>;
> +                       };
>                 };
>
>                 clock: clock-controller@10010000 {
> --
> 2.11.0
>

But I am observing follow kernel warning after I enable
CONFIG_ARM_CCI_PMU + exynos_defconfig.

[    4.557701]  mmcblk0: p1
[    4.561036] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:908
[    4.568075] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[    4.574656] 1 lock held by swapper/0/1:
[    4.578397]  #0: (ptrval) (&dev->mutex){....}, at:
device_driver_attach+0x18/0x60
[    4.585900] Preemption disabled at:
[    4.585909] [<c077eca8>] cci_pmu_probe+0x1cc/0x4a0
[    4.594122] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc5-dirty #11
[    4.600853] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    4.606928] [<c011255c>] (unwind_backtrace) from [<c010de98>]
(show_stack+0x10/0x14)
[    4.614642] [<c010de98>] (show_stack) from [<c0a6ee0c>]
(dump_stack+0x98/0xc4)
[    4.621832] [<c0a6ee0c>] (dump_stack) from [<c0156e68>]
(___might_sleep+0x20c/0x2c0)
[    4.629545] [<c0156e68>] (___might_sleep) from [<c0a8a470>]
(__mutex_lock+0x3c/0xa34)
[    4.637343] [<c0a8a470>] (__mutex_lock) from [<c0a8ae84>]
(mutex_lock_nested+0x1c/0x24)
[    4.645318] [<c0a8ae84>] (mutex_lock_nested) from [<c021b498>]
(perf_pmu_register+0x20/0x40c)
[    4.653812] [<c021b498>] (perf_pmu_register) from [<c077edd0>]
(cci_pmu_probe+0x2f4/0x4a0)
[    4.662044] [<c077edd0>] (cci_pmu_probe) from [<c0591880>]
(platform_drv_probe+0x48/0x98)
[    4.670186] [<c0591880>] (platform_drv_probe) from [<c058f1b8>]
(really_probe+0x24c/0x410)
[    4.678418] [<c058f1b8>] (really_probe) from [<c058f530>]
(driver_probe_device+0x78/0x1c0)
[    4.686651] [<c058f530>] (driver_probe_device) from [<c058f8d4>]
(device_driver_attach+0x58/0x60)
[    4.695492] [<c058f8d4>] (device_driver_attach) from [<c058f994>]
(__driver_attach+0xb8/0x158)
[    4.704070] [<c058f994>] (__driver_attach) from [<c058d1f4>]
(bus_for_each_dev+0x74/0xb4)
[    4.712213] [<c058d1f4>] (bus_for_each_dev) from [<c058e398>]
(bus_add_driver+0x1c0/0x200)
[    4.720446] [<c058e398>] (bus_add_driver) from [<c0590850>]
(driver_register+0x74/0x108)
[    4.728507] [<c0590850>] (driver_register) from [<c010315c>]
(do_one_initcall+0x90/0x434)
[    4.736655] [<c010315c>] (do_one_initcall) from [<c0f0131c>]
(kernel_init_freeable+0x448/0x4ec)
[    4.745319] [<c0f0131c>] (kernel_init_freeable) from [<c0a87c44>]
(kernel_init+0x8/0x110)
[    4.753460] [<c0a87c44>] (kernel_init) from [<c01010b4>]
(ret_from_fork+0x14/0x20)
[    4.760995] Exception stack(0xe88e1fb0 to 0xe88e1ff8)
[    4.766011] 1fa0:                                     00000000
00000000 00000000 00000000
[    4.774170] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.782315] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.789337] ARM CCI_400 PMU driver probed
[    4.797261] NET: Registered protocol family 10

Hi Krzysztof,

Cache Coherent Interface (CCI) among Cortex-A15 and Cortex-A7, G2D, G3D and SSS

Level 0 > CPU blocks such as Cortex-A15 (CA15), Cortex-A7 (CA7) are
joined as the member of Level 0 CCI bus

Level 1 > Display engine block (DISP) and 2D graphic engines (G2D) are
directly connected to Level 1.
  DISP, MDMA, SSS.

Level 2 > While all the other IP is connected to Level 1 bus via Level 2 bus
   G3D, MSCL, MFC, ISP, JPEG/Rotator/DMA/PERI, NAND/SD/EMMC.

So my question is the mapped with the cci ip block correct.
Level 0 (cci_control0)
Level 1 (cci_control1)
Level 2 (cci_control1)

Best Regards

-Anand

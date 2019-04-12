Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E463C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3173D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDLQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:13:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfDLQNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:13:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83AA215AB;
        Fri, 12 Apr 2019 09:13:03 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AC563F718;
        Fri, 12 Apr 2019 09:13:01 -0700 (PDT)
Subject: Re: about cci400 pmu
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190412160153.edbbe7mrwm7xsewa@macpro-scc.lancs.ac.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d03136bc-1a05-0df0-f91e-46fbac269d4a@arm.com>
Date:   Fri, 12 Apr 2019 17:12:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412160153.edbbe7mrwm7xsewa@macpro-scc.lancs.ac.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 17:01, Willy Wolff wrote:
> Hi,
> 
> I'm trying to add pmu support for CCI400 on an Odroid-XU3/4.
> Following https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cci.txt,
> and other dtsi, I end up with this patch:
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index f4e8c5823bc2..8432f01fb463 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -170,6 +170,16 @@
>                                  interface-type = "ace";
>                                  reg = <0x5000 0x1000>;
>                          };
> +
> +                       pmu@9000 {
> +                               compatible = "arm,cci-400-pmu,r0";
> +                               reg = <0x9000 0x5000>;
> +                               interrupts = <0 105 4>,
> +                                            <0 101 4>,
> +                                            <0 102 4>,
> +                                            <0 103 4>,
> +                                            <0 104 4>;
> +                       };
>                  };
>   
>                  clock: clock-controller@10010000 {
> 		
> Saddly, I got:
> [    5.375913] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource

That message looks to come from devm_ioremap_resource(), which implies 
that platform_get_resource() is returning NULL in cci_pmu_probe(). 
Looking at the DT, you have a thing at offset 0x9000 under a parent 
"ranges" which is only 0x6000 long, so I'd guess the OF platform layer 
probably gave up on creating the resources when it couldn't translate 
the address.

Robin.

> [    5.389595] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12
> 
> By pluging some printk here and there in arm-cci.c in init and probe functions,
> all return 0. I assume that the driver initialisation is succesful.
> 
> I trace a bit more in really_probe function, however, I can't find the real
> cause of this error.
> 
> $ dmesg | grep cci
> [    0.070299] drivers/bus/arm-cci.c:569:cci_init()
> [    0.071484] drivers/bus/arm-cci.c:580:cci_init() cci_init_status = 0
> [    0.071610] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
> [    0.113575] drivers/bus/arm-cci.c:569:cci_init()
> [    0.113684] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
> [    0.770287] drivers/bus/arm-cci.c:94:cci_platform_init() 0
> [    0.811655] drivers/base/dd.c:516:really_probe() ARM-CCI 10d20000.cci try probe drv = c1058908, drv->probe = c0593498, dev = e8b2f010
> [    0.811788] drivers/bus/arm-cci.c:72:cci_platform_probe()
> [    0.811866] drivers/bus/arm-cci.c:569:cci_init()
> [    0.811937] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
> [    0.812023] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
> [    0.814718] drivers/bus/arm-cci.c:79:cci_platform_probe() 0
> [    6.738502] drivers/base/dd.c:516:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 try probe drv = c10859f4, drv->probe = c0593498, dev = e8b2fc10
> [    6.747909] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource
> [    6.753711] drivers/base/dd.c:522:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 fail probe
> [    6.762416] drivers/base/dd.c:561:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 probe_failed
> [    6.770940] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12
> 
> I don't know if the provided values for dtsi is correct either.
> 
> I would be very happy to have some help to make these pmu working.
> Many thanks in advance.
> 
> Best Regards,
> Willy
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

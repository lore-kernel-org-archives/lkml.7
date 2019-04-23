Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36539C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ED2206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Na3GguJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfDWM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:58:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39947 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:58:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190423125838euoutp012e7b2472f58ad257d97667c812819b03~YG9_Yv64g1084010840euoutp01s
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:58:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190423125838euoutp012e7b2472f58ad257d97667c812819b03~YG9_Yv64g1084010840euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556024318;
        bh=wMQBTQ2XFkKC+eLnJjtRbq97hOKFaqbvyGPReHle408=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=Na3GguJk5n03zu45qdpFkUfgt43ny2mpWieZ7auzDPgA5xHTlrnzgNE/knyaPOTN9
         /G9gF8Z1KDAjXfVy+6GvXR88yqU9qhMlkyvoe06PTgekKE6i9s79qmUA5+u1jpYn9q
         cKea5tH5eaEIf/nBLkgty+KEu6UvsFKxnUf2Hivg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190423125837eucas1p1fc32d9ae0c1e8c15962d0dbe7b01a266~YG99oc0Kc0635306353eucas1p1o;
        Tue, 23 Apr 2019 12:58:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 35.5D.04325.DFB0FBC5; Tue, 23
        Apr 2019 13:58:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190423125836eucas1p19aed2bbe54f4c20b926ef454c067df81~YG98q4lns1593115931eucas1p1_;
        Tue, 23 Apr 2019 12:58:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190423125836eusmtrp21acfe61ff7dbce1f67c12c5e1b45ee21~YG98bKIDn1172811728eusmtrp2E;
        Tue, 23 Apr 2019 12:58:36 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-9c-5cbf0bfd16f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.B6.04140.CFB0FBC5; Tue, 23
        Apr 2019 13:58:36 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190423125835eusmtip1919aefcc11fb0fc352b8342f5309ce20~YG970NYZT2481224812eusmtip1q;
        Tue, 23 Apr 2019 12:58:35 +0000 (GMT)
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Move pmu and timer nodes out of
 soc
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d236bbff-4f99-d492-7591-5f5ca05f4949@samsung.com>
Date:   Tue, 23 Apr 2019 14:58:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415180510.6044-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7p/uffHGHzdL2Rxa905VouNM9az
        Wlz/8pzVYv4RILf/8Wtmi/PnN7BbbHp8jdXi8q45bBYzzu9jslh6/SKTReveI+wWh9+0szrw
        eKyZt4bRY9OqTjaPzUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStj2aYHrAXTjSo+vfvO
        2MD4SbWLkZNDQsBEYu3p2SxdjFwcQgIrGCX+z7vGBuF8YZTY1XiOCcL5zChxZPtGNpiWp0cv
        QyWWM0r0dbYzgSSEBN4ySrQ+TAWxhQUCJJ58n8MKUiQicIZZYs//F2DdbAKGEl1vu8BsXgE7
        ie+zvrCC2CwCqhJz53wFOoSDQ1QgRmLRZ6gSQYmTM5+wgNicQIsXb13ACGIzC8hLbH87hxnC
        Fpe49WQ+2EESAqfYJSY/ns0EcamLxKO30xkhbGGJV8e3sEPYMhL/d8I0NDNKPDy3lh3C6WGU
        uNw0A6rDWuLw8YusIBcxC2hKrN+lDxF2lDg4s40ZJCwhwCdx460gxBF8EpO2TYcK80p0tAlB
        VKtJzDq+Dm7twQuXmCFsD4kl77+xTGBUnIXkzVlIXpuF5LVZCDcsYGRZxSieWlqcm55abJyX
        Wq5XnJhbXJqXrpecn7uJEZi0Tv87/nUH474/SYcYBTgYlXh4PW7ujRFiTSwrrsw9xCjBwawk
        wvsrbU+MEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkbp
        X4myv4Tt2nZ/WiMat6Yo03+Ge7e7RqvcOb3mEN8FDz1m7Otsy7+3bav6ku3bZxy5zvA/I/Gr
        mNG8ttgqJhHfF/fmnNslEbAuIYTfrrXRrnq6vHJ4+y7RSws6/j49e+PzeT0OZvZ9TsElO8r5
        Nf4KXphUIRiV+MXH1mV6ul3v5HxNJkVGMyWW4oxEQy3mouJEADpBGIlWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7p/uPfHGDT95LO4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtNj2+xmpxedccNosZ5/cxWSy9fpHJonXvEXaLw2/aWR14
        PNbMW8PosWlVJ5vH5iX1Hn1bVjF6fN4kF8AapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
        Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJexbNMD1oLpRhWf3n1nbGD8pNrFyMkhIWAi8fToZaYu
        Ri4OIYGljBLP901lgUjISJyc1sAKYQtL/LnWxQZR9JpR4trpZ0wgCWEBP4lr/c+ZQRIiAmeY
        Jd78mMICUdXOKLGx7SU7SBWbgKFE11uQdk4OXgE7ie+zvoCNZRFQlZg75yvYOlGBGIkTU7ew
        Q9QISpyc+QQszgl03+KtCxhBbGYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRcBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwIjcduznlh2MXe+CDzEKcDAq8fB6
        3NwbI8SaWFZcmXuIUYKDWUmE91fanhgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmi7yS
        eENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYy8SZPm6sj+F7vhocRq
        EyMsv9BGu7rkWLBzya3/szRmz4vO/DRB0srasm5G1ozzcX2vfZM1v6e6lm9jflS/sZj5Zr2A
        Qftxv9DDq1dcUFV/Lqnrf1Tig+JeA0Wjr7pCirbPLFbxG++78vn6i6sLLv/X9n3SWnYy7du7
        FzuM5y08mcSxWeLD42tKLMUZiYZazEXFiQCul4QC3gIAAA==
X-CMS-MailID: 20190423125836eucas1p19aed2bbe54f4c20b926ef454c067df81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190415180530epcas3p4ad1a7ac12f7d7ac3175735995b21d48e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190415180530epcas3p4ad1a7ac12f7d7ac3175735995b21d48e
References: <CGME20190415180530epcas3p4ad1a7ac12f7d7ac3175735995b21d48e@epcas3p4.samsung.com>
        <20190415180510.6044-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-04-15 20:05, Krzysztof Kozlowski wrote:
> The ARM PMU and ARM architected timer nodes are part of ARM CPU design
> therefore they should not be inside the soc node.  This also fixes DTC
> W=1 warnings like:
>
>      arch/arm/boot/dts/exynos3250.dtsi:106.21-135.5:
>          Warning (simple_bus_reg): /soc/fixed-rate-clocks: missing or empty reg/ranges property
>      arch/arm/boot/dts/exynos3250.dtsi:676.7-680.5:
>          Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/boot/dts/exynos3250.dtsi | 12 +++++-----
>   arch/arm/boot/dts/exynos4.dtsi    | 12 +++++-----
>   arch/arm/boot/dts/exynos5250.dtsi | 40 +++++++++++++++----------------
>   arch/arm/boot/dts/exynos54xx.dtsi | 38 ++++++++++++++---------------
>   4 files changed, 51 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 5892a9f7622f..af54b306204b 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -97,6 +97,12 @@
>   		};
>   	};
>   
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>   	soc: soc {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
> @@ -673,12 +679,6 @@
>   			status = "disabled";
>   		};
>   
> -		pmu {
> -			compatible = "arm,cortex-a7-pmu";
> -			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -
>   		ppmu_dmc0: ppmu_dmc0@106a0000 {
>   			compatible = "samsung,exynos-ppmu";
>   			reg = <0x106a0000 0x2000>;
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 6085e92ac2d7..1c21627e3c3c 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -51,6 +51,12 @@
>   		serial3 = &serial_3;
>   	};
>   
> +	pmu: pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>;
> +	};
> +
>   	soc: soc {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
> @@ -169,12 +175,6 @@
>   			reg = <0x10440000 0x1000>;
>   		};
>   
> -		pmu: pmu {
> -			compatible = "arm,cortex-a9-pmu";
> -			interrupt-parent = <&combiner>;
> -			interrupts = <2 2>, <3 2>;
> -		};
> -
>   		sys_reg: syscon@10010000 {
>   			compatible = "samsung,exynos4-sysreg", "syscon";
>   			reg = <0x10010000 0x400>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 80986b97dfe5..96ace6a5e2f9 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -157,6 +157,26 @@
>   		};
>   	};
>   
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <1 2>, <22 4>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		/*
> +		 * Unfortunately we need this since some versions
> +		 * of U-Boot on Exynos don't set the CNTFRQ register,
> +		 * so we need the value from DT.
> +		 */
> +		clock-frequency = <24000000>;
> +	};
> +
>   	soc: soc {
>   		sysram@2020000 {
>   			compatible = "mmio-sram";
> @@ -227,20 +247,6 @@
>   			power-domains = <&pd_mau>;
>   		};
>   
> -		timer {
> -			compatible = "arm,armv7-timer";
> -			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> -			/*
> -			 * Unfortunately we need this since some versions
> -			 * of U-Boot on Exynos don't set the CNTFRQ register,
> -			 * so we need the value from DT.
> -			 */
> -			clock-frequency = <24000000>;
> -		};
> -
>   		mct@101c0000 {
>   			compatible = "samsung,exynos4210-mct";
>   			reg = <0x101C0000 0x800>;
> @@ -265,12 +271,6 @@
>   			};
>   		};
>   
> -		pmu {
> -			compatible = "arm,cortex-a15-pmu";
> -			interrupt-parent = <&combiner>;
> -			interrupts = <1 2>, <22 4>;
> -		};
> -
>   		pinctrl_0: pinctrl@11400000 {
>   			compatible = "samsung,exynos5250-pinctrl";
>   			reg = <0x11400000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> index de26e5ee0d2d..ae866bcc30c4 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -25,27 +25,27 @@
>   		usbdrdphy1 = &usbdrd_phy1;
>   	};
>   
> -	soc: soc {
> -		arm_a7_pmu: arm-a7-pmu {
> -			compatible = "arm,cortex-a7-pmu";
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> -			status = "disabled";
> -		};
> +	arm_a7_pmu: arm-a7-pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
>   
> -		arm_a15_pmu: arm-a15-pmu {
> -			compatible = "arm,cortex-a15-pmu";
> -			interrupt-parent = <&combiner>;
> -			interrupts = <1 2>,
> -				     <7 0>,
> -				     <16 6>,
> -				     <19 2>;
> -			status = "disabled";
> -		};
> +	arm_a15_pmu: arm-a15-pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <1 2>,
> +			     <7 0>,
> +			     <16 6>,
> +			     <19 2>;
> +		status = "disabled";
> +	};
>   
> +	soc: soc {
>   		sysram@2020000 {
>   			compatible = "mmio-sram";
>   			reg = <0x02020000 0x54000>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


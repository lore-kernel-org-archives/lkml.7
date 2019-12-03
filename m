Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA652C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1D2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLCD5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:57:05 -0500
Received: from regular1.263xmail.com ([211.150.70.198]:57056 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCD5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:57:05 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 099C026F;
        Tue,  3 Dec 2019 11:56:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P29215T140217218479872S1575345404246238_;
        Tue, 03 Dec 2019 11:56:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4be8404cf90eb1e5f1c309438c807949>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] ARM: dts: rockchip: Add missing cpu operating points for
 rk3288-tinker
To:     Jack Chen <redchenjs@foxmail.com>, heiko@sntech.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, Jack Chen <redchenjs@live.com>,
        linux-arm-kernel@lists.infradead.org
References: <20191202153540.26143-1-redchenjs@foxmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <e94676c8-b759-6a30-8ef3-285fc0ba10a4@rock-chips.com>
Date:   Tue, 3 Dec 2019 11:56:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202153540.26143-1-redchenjs@foxmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On 2019/12/2 下午11:35, Jack Chen wrote:
> From: Jack Chen <redchenjs@live.com>
>
> The Tinker Board / S devices use a special chip variant called rk3288-c
> and use different operating points with a higher max frequency.
>
> So add the missing operating points for Tinker Board / S devices, also
> increase the vdd_cpu regulator-max-microvolt to 1400000 uV so that the
> cpu can operate at 1.8 GHz.
>
> Signed-off-by: Jack Chen <redchenjs@live.com>

This patch looks good to me,


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/boot/dts/rk3288-tinker.dtsi | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 81e4e953d4a4..09e83b3d5e7d 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -113,6 +113,17 @@
>   	cpu0-supply = <&vdd_cpu>;
>   };
>   
> +&cpu_opp_table {
> +	opp-1704000000 {
> +		opp-hz = /bits/ 64 <1704000000>;
> +		opp-microvolt = <1350000>;
> +	};
> +	opp-1800000000 {
> +		opp-hz = /bits/ 64 <1800000000>;
> +		opp-microvolt = <1400000>;
> +	};
> +};
> +
>   &gmac {
>   	assigned-clocks = <&cru SCLK_MAC>;
>   	assigned-clock-parents = <&ext_gmac>;
> @@ -175,7 +186,7 @@
>   				regulator-always-on;
>   				regulator-boot-on;
>   				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> +				regulator-max-microvolt = <1400000>;
>   				regulator-name = "vdd_arm";
>   				regulator-ramp-delay = <6000>;
>   				regulator-state-mem {



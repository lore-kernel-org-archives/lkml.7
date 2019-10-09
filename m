Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F90EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F920640
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfJIOkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:40:03 -0400
Received: from foss.arm.com ([217.140.110.172]:35802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfJIOkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:40:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEA1337;
        Wed,  9 Oct 2019 07:40:02 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725A43F71A;
        Wed,  9 Oct 2019 07:40:01 -0700 (PDT)
Subject: Re: [PATCH] dts: Disable DMA support on the BK4 vf610 device's
 fsl_lpuart driver
To:     Lukasz Majewski <lukma@denx.de>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20191009143032.9261-1-lukma@denx.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b39b6860-9e9b-5cee-a07e-7b430c2e5119@arm.com>
Date:   Wed, 9 Oct 2019 15:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191009143032.9261-1-lukma@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 15:30, Lukasz Majewski wrote:
> This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
> driver - the PIO mode is used instead. This change is necessary for better
> robustness of BK4's device use cases with many potentially interrupted
> short serial transfers.
> 
> Without it the driver hangs when some distortion happens on UART lines.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>   arch/arm/boot/dts/vf610-bk4.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> index 0f3870d3b099..ad20f3442d40 100644
> --- a/arch/arm/boot/dts/vf610-bk4.dts
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -259,24 +259,28 @@
>   &uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart0>;
> +	dma-names = "","";

This looks like a horrible hack - is there any reason not to just strip 
things at compile-time, i.e. "/delete-property/ dmas;"?

Robin.

>   	status = "okay";
>   };
>   
>   &uart1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart1>;
> +	dma-names = "","";
>   	status = "okay";
>   };
>   
>   &uart2 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart2>;
> +	dma-names = "","";
>   	status = "okay";
>   };
>   
>   &uart3 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart3>;
> +	dma-names = "","";
>   	status = "okay";
>   };
>   
> 

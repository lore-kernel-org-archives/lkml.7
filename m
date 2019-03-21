Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E73218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCUQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:14:07 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:58503 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfCUQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:14:06 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2LGDkvC016507;
        Fri, 22 Mar 2019 01:13:47 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 22 Mar 2019 01:13:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2LGDk8J016504
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 22 Mar 2019 01:13:46 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add rk3399 UART DMAs
To:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190321144058.16918-1-katsuhiro@katsuster.net>
 <d49f9b76-902a-5393-c983-cdef850c7a9c@arm.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <5cb5878b-dc91-764e-1000-66c87024880c@katsuster.net>
Date:   Fri, 22 Mar 2019 01:13:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <d49f9b76-902a-5393-c983-cdef850c7a9c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin,

On 2019/03/22 0:21, Robin Murphy wrote:
> On 21/03/2019 14:40, Katsuhiro Suzuki wrote:
>> Add UART dma channels as specified by the rk3399 TRM.
> 
> No UART4? That's arguably one of the more useful ones, since 1 and 3 
> often end up muxed to ethernet instead.
> 

Oops... I forgot to add for UART4. Thank you for pointing out.


> Also, does UART DMA actually work yet? I guess I can try for myself once 
> I get home, but I remember last time I looked it was bailing out because 
> the 8250 driver wanted a dmaengine feature that the pl330 driver didn't 
> implement.
> 

I think it works correctly. Because pl330_irq_handler() that is
IRQ handler of PL330 is called when my patch applied and handler
is not called if not applied.


Best Regards,
Katsuhiro Suzuki

> Robin.
> 
>> Refer:
>> RK3399 TRM V1.4: Chapter 12 DMA Controller
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 0301e3e01b38..4eed7aae6989 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -635,6 +635,8 @@
>>           clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
>>           clock-names = "baudclk", "apb_pclk";
>>           interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        dmas = <&dmac_peri 0>, <&dmac_peri 1>;
>> +        dma-names = "tx", "rx";
>>           reg-shift = <2>;
>>           reg-io-width = <4>;
>>           pinctrl-names = "default";
>> @@ -648,6 +650,8 @@
>>           clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
>>           clock-names = "baudclk", "apb_pclk";
>>           interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        dmas = <&dmac_peri 2>, <&dmac_peri 3>;
>> +        dma-names = "tx", "rx";
>>           reg-shift = <2>;
>>           reg-io-width = <4>;
>>           pinctrl-names = "default";
>> @@ -661,6 +665,8 @@
>>           clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
>>           clock-names = "baudclk", "apb_pclk";
>>           interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        dmas = <&dmac_peri 4>, <&dmac_peri 5>;
>> +        dma-names = "tx", "rx";
>>           reg-shift = <2>;
>>           reg-io-width = <4>;
>>           pinctrl-names = "default";
>> @@ -674,6 +680,8 @@
>>           clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
>>           clock-names = "baudclk", "apb_pclk";
>>           interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        dmas = <&dmac_peri 6>, <&dmac_peri 7>;
>> +        dma-names = "tx", "rx";
>>           reg-shift = <2>;
>>           reg-io-width = <4>;
>>           pinctrl-names = "default";
>>
> 


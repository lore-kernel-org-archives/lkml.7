Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D4ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB102053B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfJIPPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:15:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfJIPPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:15:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68C2337;
        Wed,  9 Oct 2019 08:15:41 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 870A63F68E;
        Wed,  9 Oct 2019 08:15:40 -0700 (PDT)
Subject: Re: [PATCH] dts: Disable DMA support on the BK4 vf610 device's
 fsl_lpuart driver
To:     Lukasz Majewski <lukma@denx.de>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20191009143032.9261-1-lukma@denx.de>
 <b39b6860-9e9b-5cee-a07e-7b430c2e5119@arm.com> <20191009164442.51f27b9d@jawa>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <34d5f652-57e5-168e-0025-38b897e88fff@arm.com>
Date:   Wed, 9 Oct 2019 16:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191009164442.51f27b9d@jawa>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 15:44, Lukasz Majewski wrote:
> Hi Robin,
> 
>> On 09/10/2019 15:30, Lukasz Majewski wrote:
>>> This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
>>> driver - the PIO mode is used instead. This change is necessary for
>>> better robustness of BK4's device use cases with many potentially
>>> interrupted short serial transfers.
>>>
>>> Without it the driver hangs when some distortion happens on UART
>>> lines.
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>> ---
>>>    arch/arm/boot/dts/vf610-bk4.dts | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/vf610-bk4.dts
>>> b/arch/arm/boot/dts/vf610-bk4.dts index 0f3870d3b099..ad20f3442d40
>>> 100644 --- a/arch/arm/boot/dts/vf610-bk4.dts
>>> +++ b/arch/arm/boot/dts/vf610-bk4.dts
>>> @@ -259,24 +259,28 @@
>>>    &uart0 {
>>>    	pinctrl-names = "default";
>>>    	pinctrl-0 = <&pinctrl_uart0>;
>>> +	dma-names = "","";
>>
>> This looks like a horrible hack - is there any reason not to just
>> strip things at compile-time, i.e. "/delete-property/ dmas;"?
> 
> I don't want to strip the dma-names property globally. I just want to
> adjust this particular driver mode from DMA to PIO.

What do you mean by "globally"? The /delete-property/ operator just 
removes a previously-defined property from the node in which it appears.
> For my use cases - as written in the commit message - the PIO mode is
> more suitable (and reliable).

Right, and having invalid "dma-names" properties for this board is what 
happens to trick Linux into not using DMA mode via 
of_dma_request_slave_channel() failing, yes? What I'm saying is that if 
the underlying justification is that it's not worth using DMA mode at 
all on this board, then suppressing the actual "dmas" property it its 
DTS such that there's no dependency on a particular driver behaviour is 
a lot more robust.

Robin.

>>>    	status = "okay";
>>>    };
>>>    
>>>    &uart1 {
>>>    	pinctrl-names = "default";
>>>    	pinctrl-0 = <&pinctrl_uart1>;
>>> +	dma-names = "","";
>>>    	status = "okay";
>>>    };
>>>    
>>>    &uart2 {
>>>    	pinctrl-names = "default";
>>>    	pinctrl-0 = <&pinctrl_uart2>;
>>> +	dma-names = "","";
>>>    	status = "okay";
>>>    };
>>>    
>>>    &uart3 {
>>>    	pinctrl-names = "default";
>>>    	pinctrl-0 = <&pinctrl_uart3>;
>>> +	dma-names = "","";
>>>    	status = "okay";
>>>    };
>>>    
>>>    
> 
> 
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
> 

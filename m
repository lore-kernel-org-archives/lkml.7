Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F55C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3252067D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfHOLJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:09:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbfHOLJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:09:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866DC28;
        Thu, 15 Aug 2019 04:09:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5AD3F694;
        Thu, 15 Aug 2019 04:09:27 -0700 (PDT)
Subject: Re: kexec on rk3399
To:     Felipe Balbi <balbi@kernel.org>, Vicente Bergas <vicencb@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com>
 <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com>
 <0408cb6c-1b16-eacb-d47e-17f4ff89e2b8@arm.com>
 <59055782-7fc2-4b16-af8b-a56fb845a43f@gmail.com> <87pnl7t12t.fsf@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4d18d4f7-a00e-bd60-6361-51054eba3bca@arm.com>
Date:   Thu, 15 Aug 2019 12:09:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87pnl7t12t.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2019 07:06, Felipe Balbi wrote:
> 
> Hi,
> 
> Vicente Bergas <vicencb@gmail.com> writes:
> 
>> On Wednesday, August 14, 2019 3:12:26 PM CEST, Robin Murphy wrote:
>>> On 14/08/2019 13:53, Vicente Bergas wrote:
>>>> On Monday, July 22, 2019 4:31:27 PM CEST, Vicente Bergas wrote: ...
>>>
>>> This particular change looks like it's implicitly specific to
>>> RK3399, which wouldn't be ideal. Presumably if the core dwc3
>>> driver implemented shutdown correctly (echoing parts of
>>> dwc3_remove(), I guess) then the glue layers shouldn't need
>>> anything special anyway.
>>>
>>> Robin.
>>
>> I just checked simple->resets from dwc3-of-simple.c and it is an array
>> with multiple resets whereas dwc->reset from core.c is NULL.
>> So the reset seems specific to the glue layers.
>> Is there another way than resetting the thing that is
>> generic enough to go to core.c and allows kexec?
> 
> This is a really odd 'failure'. We do full soft reset during driver
> initialization on dwc3. We shouldn't need to assert reset on shutdown,
> really.

Probing/initialisation has never been the problem. The issue for the 
kexec case is that when the first kernel shuts down, there is currently 
nothing to quiesce the controller (since only driver->shutdown gets 
called, not driver->remove), and thus (presumably) external USB activity 
causes it to keep writing back over the memory where the 
descriptors/command ring used to be while the second kernel boots. The 
second kernel will eventually probe and reset it appropriately, but by 
that time the damage is already done.

Yanking on a hardware reset line when the first kernel shuts down is 
certainly one way to stop any memory accesses if such a control is 
available, but presumably there's a general software way to gracefully 
disable the controller's DMA functions until a subsequent probe can 
fully reset it again - I think that would be the preferable solution.

Robin.

> I think the problem is here:
> 
> 	if (simple->pulse_resets) {
> 		ret = reset_control_reset(simple->resets);
> 		if (ret)
> 			goto err_resetc_put;
> 	} else {
> 		ret = reset_control_deassert(simple->resets);
> 		if (ret)
> 			goto err_resetc_put;
> 	}
> 
> Note that if pulse_resets is set, we will run a reset. But if
> pulse_resets is false and need_reset is true, we deassert the reset.
> 
> I think below patch is enough:
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index bdac3e7d7b18..9a2f3e09aa2e 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -72,7 +72,15 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>   		ret = reset_control_reset(simple->resets);
>   		if (ret)
>   			goto err_resetc_put;
> -	} else {
> +	}
> +
> +	if (simple->need_reset) {
> +		ret = reset_control_assert(simple->resets);
> +		if (ret)
> +			goto err_resetc_put;
> +
> +		usleep_range(1000, 2000);
> +
>   		ret = reset_control_deassert(simple->resets);
>   		if (ret)
>   			goto err_resetc_put;
> @@ -121,9 +129,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
>   	clk_bulk_put_all(simple->num_clocks, simple->clks);
>   	simple->num_clocks = 0;
>   
> -	if (!simple->pulse_resets)
> -		reset_control_assert(simple->resets);
> -
>   	reset_control_put(simple->resets);
>   
>   	pm_runtime_disable(dev);
> 
> Can you test?
> 

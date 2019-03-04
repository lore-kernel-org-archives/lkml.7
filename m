Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4142070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfCDR30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:29:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDR30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:29:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CFA6A78;
        Mon,  4 Mar 2019 09:29:25 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988703F703;
        Mon,  4 Mar 2019 09:29:23 -0800 (PST)
Subject: Re: [PATCH v2] dts: arm64: add CoreSight trace support for hi3660
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org
Cc:     shiwanglai@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
        john.stultz@linaro.org, xuwei5@huawei.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzhuangluan@hisilicon.com
References: <6496F4728C09F6479CFF21A8E67D33D568F32660@dggema525-mbx.china.huawei.com>
 <20190302125955.GA11385@leoy-ThinkPad-X240s>
 <CANLsYkzakXjuMR+=ncVpcohE8n-uF60Qa6EAN+Xh=FKBoJtrgg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9109e498-0cd9-0b81-15a0-2208d4282359@arm.com>
Date:   Mon, 4 Mar 2019 17:29:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkzakXjuMR+=ncVpcohE8n-uF60Qa6EAN+Xh=FKBoJtrgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/03/2019 17:18, Mathieu Poirier wrote:
> On Sat, 2 Mar 2019 at 06:00, Leo Yan <leo.yan@linaro.org> wrote:
>>
>> On Sat, Mar 02, 2019 at 09:45:22AM +0000, Shiwanglai wrote:
>>
>> [...]
>>
>>>> +           /* Top internals */
>>>> +           funnel@ec031000 {
>>>> +                   compatible = "arm,coresight-funnel", "arm,primecell";
>>>> +                   reg = <0 0xec031000 0 0x1000>;
>>>> +                   clocks = <&crg_ctrl HI3660_PCLK>;
>>>> +                   clock-names = "apb_pclk";
>>>> +
>>>> +                   out-ports {
>>>> +                           port {
>>>> +                                   top_funnel_out: endpoint {
>>>> +                                           remote-endpoint =
>>>> +                                                   <&top_etf_in>;
>>>> +                                   };
>>>> +                           };
>>>> +                   };
>>>> +
>>>> +                   in-ports {
>>>> +                           #address-cells = <1>;
>>>> +                           #size-cells = <0>;
>>>> +
>>>> +                           port@0 {
>>>> +                                   reg = <0>;
>>>> +                                   top_funnel_in0: endpoint {
>>>> +                                           remote-endpoint =
>>>> +                                                   <&cluster0_etf_out>;
>>>> +                                   };
>>>> +                           };
>>>> +
>>>> +                           port@1 {
>>>> +                                   reg = <0>;
>>>
>>> Here should s/<0>/<1>; otherwise DTC will complain warning for mismatching between 'port@1' and 'reg = <0>'.
>>
>>> -- if reg set to 1, then there's no data output from cluster 1 to top.
>>
>> Thanks for the info, Wanglai.  Now I see why write as it is.
>>
>> I can confirm if directly use your patch with perf with mainline
>> kernel I can capture CoreSight trace data successfully on Hikey960
>> board.
>>
>> But since this DT binding will introduce DTC warning, I personally
>> think we can improve for this with below method:
>>
>> We can create a funnel node named "funnel_combo", and we don't need to
>> specify register address range for it; and cluster 0 and cluster 1 will
>> output to "funnel_combo" and "funnel_combo" will output to the top
>> funnel.  Thus the DT binding will write as below.
>>
>> To support for a funnel without any register address range (we have
>> support replicator like this mode), we also need to extend the driver
>> drivers/hwtracing/coresight/coresight-funnel.c.
>>
>> Mathieu, Mike, Suzuki, could you help confirm this is the right
>> direction we should move forward to?
> 
> Leo, thanks for testing this out.  Shiwanglai, please add Suzuki and
> myself to future revision of this set - this will help you getting a
> timely response for your work.
> 
> As Leo pointed out we already have support for replicators that don't
> have a register map and the same thing should be done in this case.
> But contrary to what was done for replicators, I think we should keep
> the drivers in the same file as Russell did here[1].  That way we can
> keep all things funnel at the same place and reduce the amount of
> kernel configuration options.

I back that. I have already merged the static and programmable replicators
into one and this should be out here soon. So, I back the single driver
approach for funnels.

Cheers
Suzuki


> 
> Regards,
> Mathieu
> 
> [1]. https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/amba-pl011.c#L2819
> 
>>

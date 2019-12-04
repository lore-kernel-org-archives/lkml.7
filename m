Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABBC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E7206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLDLUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:20:22 -0500
Received: from foss.arm.com ([217.140.110.172]:54538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfLDLUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:20:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B02D31B;
        Wed,  4 Dec 2019 03:20:20 -0800 (PST)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28093F68E;
        Wed,  4 Dec 2019 03:20:18 -0800 (PST)
Subject: Re: perf record doesn't work on rtd129x SoC
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Wang YanQing <udknight@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-realtek-soc@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191204045559.GA10458@udknight>
 <f90748d0-8112-3aa8-0c88-e35a8d6e72d3@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1b2d2bc3-afcf-02c3-ccd6-e2a227c23fd3@arm.com>
Date:   Wed, 4 Dec 2019 11:20:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f90748d0-8112-3aa8-0c88-e35a8d6e72d3@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-04 7:28 am, Andreas Färber wrote:
> Hi YanQing,
> 
> + LAKML + Mark + Will
> 
> Am 04.12.19 um 05:55 schrieb Wang YanQing:
>> I use "perf record" to debug performance issue on RTD1296 SOC, it does't work, but
>> the "perf stat" is ok!
> 
> Thanks for the report - which board, branch and (base) tag are you
> testing against? And are you building perf yourself from kernel sources,
> or are you using some distro package?
> 
> I only have Busybox in my initrd on DS418; I have not tested perf.
> 
>> After some dig in the kernel, I find the reason is no pmu overflow interrupt, I think
>> below pmu configuration isn't right for RTD1296:
>> "
>>          arm_pmu: arm-pmu {
>>                  compatible = "arm,cortex-a53-pmu";
>>                  interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>>          };
>> "
>>
>> We need 4 PMU SPI for RTD1296 (4 cores), and I guess the 48 isn't right too.
> 
> Note that above rtd129x.dtsi snippet is not complete. See rtd1296.dtsi:
> 
> &arm_pmu {
> 	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> };

That doesn't help much, since 4 affinities for one SPI is rather 
nonsensical.

> 48 and high/4 match what I see in the latest BSP:
> 
> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm64/boot/dts/realtek/rtd129x/rtd-1296.dtsi#L116
> 
>> Any suggestion is welcome.
>>
>> Thanks!
> 
> The only difference I see is "arm,cortex-a53-pmu" vs. "arm,armv8-pmuv3".
> By my reading of arch/arm64/kernel/perf_event.c the only difference
> between the two should be the name and an extra cache_map. You could try
> the other compatible string in your .dts, but I doubt it'll help.
> 
> Hopefully the Realtek or Arm guys can shed some light.

If the SoC really has all 4 overflow interrupts combined into a single 
SPI line, then sampling just isn't going to be supported - it's 
unreasonably difficult to handle overflow when the IRQ may be taken on 
the wrong CPU.

Robin.

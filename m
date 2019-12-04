Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35860C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A6215F2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfLDH23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:28:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:42342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfLDH23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:28:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 349DBACA5;
        Wed,  4 Dec 2019 07:28:27 +0000 (UTC)
Subject: Re: perf record doesn't work on rtd129x SoC
To:     Wang YanQing <udknight@gmail.com>
References: <20191204045559.GA10458@udknight>
Cc:     linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <f90748d0-8112-3aa8-0c88-e35a8d6e72d3@suse.de>
Date:   Wed, 4 Dec 2019 08:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204045559.GA10458@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YanQing,

+ LAKML + Mark + Will

Am 04.12.19 um 05:55 schrieb Wang YanQing:
> I use "perf record" to debug performance issue on RTD1296 SOC, it does't work, but
> the "perf stat" is ok!

Thanks for the report - which board, branch and (base) tag are you
testing against? And are you building perf yourself from kernel sources,
or are you using some distro package?

I only have Busybox in my initrd on DS418; I have not tested perf.

> After some dig in the kernel, I find the reason is no pmu overflow interrupt, I think
> below pmu configuration isn't right for RTD1296:
> "
>         arm_pmu: arm-pmu {
>                 compatible = "arm,cortex-a53-pmu";
>                 interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>         };
> "
> 
> We need 4 PMU SPI for RTD1296 (4 cores), and I guess the 48 isn't right too.

Note that above rtd129x.dtsi snippet is not complete. See rtd1296.dtsi:

&arm_pmu {
	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
};

48 and high/4 match what I see in the latest BSP:

https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm64/boot/dts/realtek/rtd129x/rtd-1296.dtsi#L116

> Any suggestion is welcome.
> 
> Thanks!

The only difference I see is "arm,cortex-a53-pmu" vs. "arm,armv8-pmuv3".
By my reading of arch/arm64/kernel/perf_event.c the only difference
between the two should be the name and an extra cache_map. You could try
the other compatible string in your .dts, but I doubt it'll help.

Hopefully the Realtek or Arm guys can shed some light.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA2C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74C208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDSVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:18:07 -0400
Received: from foss.arm.com ([217.140.101.70]:51908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfDSVSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A338B15A2;
        Fri, 19 Apr 2019 14:18:05 -0700 (PDT)
Received: from [192.168.1.105] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52AF43F68F;
        Fri, 19 Apr 2019 14:18:03 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
 <CACfOrNdEpC2vNgCOBXtrW-HjGHNG_6iLAFUCtVoZstGASPtcsA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <38dee054-19ce-a545-fb62-dea4d0036c94@arm.com>
Date:   Fri, 19 Apr 2019 22:18:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACfOrNdEpC2vNgCOBXtrW-HjGHNG_6iLAFUCtVoZstGASPtcsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-19 6:53 pm, Willy Wolff wrote:
> Hi,
> 
> This patch can be dropped, as it needs more work.
> 
> In fact, the interrupts seems to be wrong. The interrupts suggested by
> Anand Moon gave the same following results.
> 
> export CCI_DEV=CCI_400
> export OMP_NUM_THREADS=2
> sudo --preserve-env ./perf stat -a \
>    -e armv7_cortex_a7/config=0x11,name=a7_cycles/ \
>    -e armv7_cortex_a15/config=0x11,name=a15_cycles/ \
>    -e armv7_cortex_a7/config=0x19,name=a7_bus/ \
>    -e armv7_cortex_a15/config=0x19,name=a15_bus/ \
>    -e ${CCI_DEV}/config=0xff,name=cci400_cycles/ \
>    -e ${CCI_DEV}/config=0x0,name=cci400_si_rrq_hs_any/ \
>    -e ${CCI_DEV}/config=0xc,name=cci400_si_wrq_hs_any/ \

 From the look of those configs, you'll be counting events on slave 
interface 0, which may not even have anything connected anyway. The CPU 
clusters on a CCI-400 will be on slave interfaces 3 and 4, so try 
something like '-e CCI_400/cci400_si_rrq_hs_any,source=4/'.

The interrupts only matter for counter overflow, so confirming those 
could be done by picking a sufficiently frequent event, counting for 
long enough to capture slightly more than 2^32 of those, then seeing 
whether the overflow accumulates correctly or the count appears to go 
backwards (and/or checking what fired in /proc/interrupts). I believe 
the cycle counter is also 32-bit on CCI, so that should be relatively 
easy; for the other counters beyond the first one it should be feasible 
to schedule additional dummy events before the event of interest in 
order to trick pmu_get_event_idx() into allocating the desired counter 
for it.

Robin.

>    taskset -c 0,7 /home/user/cg.x.A 1
> 
> [..]
> 
>   Performance counter stats for 'system wide':
> 
>       9,362,850,550      a7_cycles
>       1,682,125,760      a15_cycles
>          68,920,347      a7_bus
>          61,484,352      a15_bus
>       3,789,936,935      cci400_cycles
>                   0      cci400_si_rrq_hs_any
>                   0      cci400_si_wrq_hs_any
> 
>         9.541340558 seconds time elapsed
> 
> cg.x.A comes from NAS benchmark suite, compiled with fopenmp support, setup
> to run 2 threads and taskmapped to ran on both a7 and a15 clusters.
> a7_bus and a15_bus report main memory accesses.
> 
> Only cci400_cycles seems to be correct. However, all pmcs from the master
> interface are reported as unsupported and all pmcs from the slave interface
> return 0, which is probably not correct.
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0470f/CJHICFBF.html
> 
> Would it be possible that someone from Samsung provide the right
> interrupts values?
> Many thanks.
> 
> Regards,
> Willy
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

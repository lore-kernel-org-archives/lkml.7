Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01126C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AF92082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFHZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:25:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfEFHZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:25:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B43233A4564CE369C6FA;
        Mon,  6 May 2019 15:25:33 +0800 (CST)
Received: from [127.0.0.1] (10.210.168.180) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 May 2019
 15:25:30 +0800
Subject: Re: [PATCH v2] perf vendor events arm64: Add Cortex-A57 and
 Cortex-A72 events
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20190502234704.7663-1-f.fainelli@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5c04ebac-3e3c-fa53-d287-3a602a350091@huawei.com>
Date:   Mon, 6 May 2019 08:25:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190502234704.7663-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2019 00:47, Florian Fainelli wrote:
> The Cortex-A57 and Cortex-A72 both support all ARMv8 recommended events
> up to the RC_ST_SPEC (0x91) event with the exception of:
>
> - L1D_CACHE_REFILL_INNER (0x44)
> - L1D_CACHE_REFILL_OUTER (0x45)
> - L1D_TLB_RD (0x4E)
> - L1D_TLB_WR (0x4F)
> - L2D_TLB_REFILL_RD (0x5C)
> - L2D_TLB_REFILL_WR (0x5D)
> - L2D_TLB_RD (0x5E)
> - L2D_TLB_WR (0x5F)
> - STREX_SPEC (0x6F)
>
> Create an appropriate JSON file for mapping those events and update the
> mapfile.csv for matching the Cortex-A57 and Cortex-A72 MIDR to that
> file.

I suppose you could have also created separate a72 and a57 folders, and 
used a symbolic link for the json. That would have kept the folder 
structure consistent and neat.

>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Apart from the above:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
> Changes in v2:
>
> - added a shared directory for both Cortex-A57 and A72 (Will)
> - removed unsupported ARMv8 v3 events (John)
>
>  .../arm/cortex-a57-a72/core-imp-def.json      | 179 ++++++++++++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>  2 files changed, 181 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
>
> diff --git a/tools/perf/pmu-even


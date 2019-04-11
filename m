Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A37C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADF02184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:01:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfDKNBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:01:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0BAB0734007E5641CC4D;
        Thu, 11 Apr 2019 21:01:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 21:01:19 +0800
Subject: Re: [PATCH] perf vendor events arm64: Add Cortex-A72 events
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20190407213422.19059-1-f.fainelli@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1a7b28b0-3fee-f3b9-0e83-61a2759c0555@huawei.com>
Date:   Thu, 11 Apr 2019 14:01:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190407213422.19059-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2019 22:34, Florian Fainelli wrote:
> The Cortex-A72 supports all ARMv8 recommended events up to the
> RC_ST_SPEC (0x91) event, create an appropriate JSON file for mapping
> those events and update the mapfile.csv for matching the Cortex-A72 MIDR
> to that file.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../arm64/arm/cortex-a72/core-imp-def.json    | 206 ++++++++++++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>  2 files changed, 207 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
> new file mode 100644
> index 000000000000..eb82fc8529c6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
> @@ -0,0 +1,206 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",

I'm just checking the A72 TRM, and this does not seem to be included, 
that being event number 0x44.

> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +    },

Or this.

> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +    },
> +    {

Please check this.

Thanks,
John



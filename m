Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE4C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E3421738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfGXNLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:11:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:15144 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfGXNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:11:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="174879397"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2019 06:11:03 -0700
Received: from [10.251.5.204] (kliang2-mobl.ccr.corp.intel.com [10.251.5.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C4FA05803EA;
        Wed, 24 Jul 2019 06:11:01 -0700 (PDT)
Subject: Re: [PATCH RESEND] perf/x86/intel: Bit 13 is valid for Icelake
 MSR_OFFCORE_RSP_x register
To:     Yunying Sun <yunying.sun@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, ak@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20190724073911.12177-1-yunying.sun@intel.com>
 <20190724082932.12833-1-yunying.sun@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1022fe65-0f9a-52d3-2765-25aa2a326848@linux.intel.com>
Date:   Wed, 24 Jul 2019 09:11:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724082932.12833-1-yunying.sun@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2019 4:29 AM, Yunying Sun wrote:
>  From Intel SDM, bit 13 of Icelake MSR_OFFCORE_RSP_x register is valid for
> counting hardware generated prefetches of L3 cache. But current bitmasks
> in driver takes bit 13 as invalid. Here to fix it.
> 
> Before:
> $ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
>   Performance counter stats for 'sleep 3':
>     <not supported>      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u
> 
> After:
> $ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
>   Performance counter stats for 'sleep 3':
>               9,293      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u
> 
> Signed-off-by: Yunying Sun <yunying.sun@intel.com>

Thanks Yunying.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Kan
> ---
>   arch/x86/events/intel/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 9e911a96972b..b35519cbc8b4 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -263,8 +263,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
>   };
>   
>   static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
> -	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
> -	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
> +	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffbfffull, RSP_0),
> +	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffffbfffull, RSP_1),
>   	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
>   	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
>   	EVENT_EXTRA_END
> 

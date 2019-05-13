Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DA9216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfEMV3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:29:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:28396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfEMV3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:29:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 14:29:32 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2019 14:29:32 -0700
Received: from [10.251.13.252] (kliang2-mobl.ccr.corp.intel.com [10.251.13.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A807B5804BA;
        Mon, 13 May 2019 14:29:31 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events intel: Add uncore_upi JSON support
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
Date:   Mon, 13 May 2019 17:29:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Could you please apply this fix?

Thanks,
Kan

On 5/7/2019 9:16 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf cannot parse UPI events.
> 
>      #perf stat -e UPI_DATA_BANDWIDTH_TX
>      event syntax error: 'UPI_DATA_BANDWIDTH_TX'
>                       \___ parser error
>      Run 'perf list' for a list of valid events
> 
> The JSON lists call the box UPI LL, while perf calls it upi.
> Add conversion support to json to convert the unit properly.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   tools/perf/pmu-events/jevents.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 68c92bb..daaea50 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -235,6 +235,7 @@ static struct map {
>   	{ "iMPH-U", "uncore_arb" },
>   	{ "CPU-M-CF", "cpum_cf" },
>   	{ "CPU-M-SF", "cpum_sf" },
> +	{ "UPI LL", "uncore_upi" },
>   	{}
>   };
>   
> 

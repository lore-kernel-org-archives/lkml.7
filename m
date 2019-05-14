Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF96C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304632085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:42:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:35442 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:42:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:42:24 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2019 07:42:24 -0700
Received: from [10.254.90.245] (kliang2-mobl.ccr.corp.intel.com [10.254.90.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0163B580414;
        Tue, 14 May 2019 07:42:23 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events intel: Add uncore_upi JSON support
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
 <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
 <20190514125956.GG3198@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4e90cdd5-62a4-fea2-c437-a9675b4f8be5@linux.intel.com>
Date:   Tue, 14 May 2019 10:42:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514125956.GG3198@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2019 8:59 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 13, 2019 at 05:29:30PM -0400, Liang, Kan escreveu:
>> Hi Arnaldo,
>>
>> Could you please apply this fix?
> 
> Sure, please next time specify which arch this should be tested on, as I
> tried it here on a skylake notebook (lenovo t480s) before your patch and
> got:
> 
> [root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
> event syntax error: 'UPI_DATA_BANDWIDTH_TX'
>                       \___ parser error
> Run 'perf list' for a list of valid events
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
> [root@quaco ~]#
> 
> Then, looking at 'perf list' /UPI I got just these:
> 
> Pipeline:
> <SNIP>
>    UPI
>         [Uops Per Instruction]
> 
> Which already probably told me a bit about what this is about, its under
> the "METRIC groups" header
> 
> After your patch applied I get:
> 
> [root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
> event syntax error: 'UPI_DATA_BANDWIDTH_TX'
>                       \___ parser error
> Run 'perf list' for a list of valid events
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
> [root@quaco ~]#
> 
> I.e. nothing seem to have changed, but then, to further look at this I
> tried:
> 
> # strings ~/bin/perf | grep -i upi
> <SNIP>
> Data Response packets that go direct to Intel UPI. Unit: uncore_upi
> Counts Data Response (DRS) packets that attempted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA
> Cycles Intel UPI is in L1 power mode (shutdown). Unit: uncore_upi
> Counts cycles when the Intel Ultra Path Interconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down the UPI link.  Link power states are per link and per direction, so for example the Tx direction could be in one state while Rx was in another, this event only coutns when both links are shutdown
> Cycles the Rx of the Intel UPI is in L0p power mode. Unit: uncore_upi
> Counts cycles when the the receive side (Rx) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode where we disable 60% of the UPI lanes, decreasing our bandwidth in order to save power
> FLITs received which bypassed the Slot0 Receive Buffer. Unit: uncore_upi
> Valid data FLITs received from any slot. Unit: uncore_upi
> <SNIP>
> 
> So this "UPI" TLA, here, should not mean "UOPS per instruction", but
> Intel's "Ultra Path Interconnect", right? Lemme update the changelog...
>

Right.

> /me googles... https://en.wikipedia.org/wiki/Intel_Ultra_Path_Interconnect
> 
> So I'd need a Skylake-SP test machine to test this...
> 
> Please add such notes in the future, helps reviewing and testing this.
>

Sorry for the inconvenience.


> At some point I'd like to have 'perf test' test such stuff with a
> Requires_cpuid/arch, etc.

We will improve our internal test to cover this issue.
I will think about how to enhance the 'perf test'.

Thanks,
Kan

> 
> - Arnaldo
>   
>> Thanks,
>> Kan
>>
>> On 5/7/2019 9:16 AM, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Perf cannot parse UPI events.
>>>
>>>       #perf stat -e UPI_DATA_BANDWIDTH_TX
>>>       event syntax error: 'UPI_DATA_BANDWIDTH_TX'
>>>                        \___ parser error
>>>       Run 'perf list' for a list of valid events
>>>
>>> The JSON lists call the box UPI LL, while perf calls it upi.
>>> Add conversion support to json to convert the unit properly.
>>>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>    tools/perf/pmu-events/jevents.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>>> index 68c92bb..daaea50 100644
>>> --- a/tools/perf/pmu-events/jevents.c
>>> +++ b/tools/perf/pmu-events/jevents.c
>>> @@ -235,6 +235,7 @@ static struct map {
>>>    	{ "iMPH-U", "uncore_arb" },
>>>    	{ "CPU-M-CF", "cpum_cf" },
>>>    	{ "CPU-M-SF", "cpum_sf" },
>>> +	{ "UPI LL", "uncore_upi" },
>>>    	{}
>>>    };
>>>
> 

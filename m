Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78056C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5739521530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfFTOdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:33:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:13820 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfFTOdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:33:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 07:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="311674808"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 07:33:50 -0700
Received: from [10.252.134.4] (kliang2-mobl.ccr.corp.intel.com [10.252.134.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7A30058040E;
        Thu, 20 Jun 2019 07:33:49 -0700 (PDT)
Subject: Re: [PATCH] perf/rapl: restart perf rapl counter after resume
To:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de,
        "Liang, Kan" <kan.liang@intel.com>
References: <1560778897.10723.6.camel@intel.com>
 <20190620125059.GZ3436@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d663757d-8395-bab8-cde3-e6b1ecab0cda@linux.intel.com>
Date:   Thu, 20 Jun 2019 10:33:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620125059.GZ3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/2019 8:50 AM, Peter Zijlstra wrote:
> On Mon, Jun 17, 2019 at 09:41:37PM +0800, Zhang Rui wrote:
> 
>> After S3 suspend/resume, "perf stat -I 1000 -e power/energy-pkg/ -a"
>> reports an insane value for the very first sampling period after resume
>> as shown below.
>>
>>      19.278989977               2.16 Joules power/energy-pkg/
>>      20.279373569               1.96 Joules power/energy-pkg/
>>      21.279765481               2.09 Joules power/energy-pkg/
>>      22.280305420               2.10 Joules power/energy-pkg/
>>      25.504782277   4,294,966,686.01 Joules power/energy-pkg/
>>      26.505114993               3.58 Joules power/energy-pkg/
>>      27.505471758               1.66 Joules power/energy-pkg/
>>
>> Fix this by resetting the counter right after resume.
> 
> Cute...
> 
> 
>> +#ifdef CONFIG_PM
>> +
>> +static int perf_rapl_suspend(void)
>> +{
>> +	int i;
>> +
>> +	get_online_cpus();
>> +	for (i = 0; i < rapl_pmus->maxpkg; i++)
>> +		rapl_pmu_update_all(rapl_pmus->pmus[i]);
>> +	put_online_cpus();
>> +	return 0;
>> +}
>> +
>> +static void perf_rapl_resume(void)
>> +{
>> +	int i;
>> +
>> +	get_online_cpus();
>> +	for (i = 0; i < rapl_pmus->maxpkg; i++)
>> +		rapl_pmu_restart_all(rapl_pmus->pmus[i]);
>> +	put_online_cpus();
>> +}
> 
> What's the reason for that get/put_online_cpus() here ?
>

It looks like syscore_* functions are executed with one CPU on-line.
If so, they may not be the right place for the rapl callback.

Rapl is per socket. The driver manipulates the registers on the first 
CPU of each socket. I think we need to update/restart the counters on 
all sockets. That's the reason I add get/put_online_cpus() in the 
original patch.

Besides, I think we also need to call rapl_pmu_restart/update_all() on 
the target cpu.


Thanks,
Kan


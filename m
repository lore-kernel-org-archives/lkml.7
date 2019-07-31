Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B256520693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGaCmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:42:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:7466 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfGaCmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:42:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 19:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,328,1559545200"; 
   d="scan'208";a="180086832"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2019 19:42:16 -0700
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
Date:   Wed, 31 Jul 2019 10:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190726152101.GA27884@sinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/26 23:21, Julien Desfossez wrote:
> On 25-Jul-2019 10:30:03 PM, Aaron Lu wrote:
>>
>> I tried a different approach based on vruntime with 3 patches following.
> [...]
> 
> We have experimented with this new patchset and indeed the fairness is
> now much better. Interactive tasks with v3 were complete starving when
> there were cpu-intensive tasks running, now they can run consistently.

Yeah, the fairness is much better now.

For two cgroups created, I limited the cpuset to be one core(two siblings)
of these two cgroups, I still run gemmbench and sysbench-mysql, and here
is the mysql result:

Latency:
.----------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |
|----------------------------------------------------------------------------------------------|
|  1/1	        6.7	[13.8%/ 1.4%]	  2.1% |          6.4	[14.6%/ 1.5%]	  4.0%	  2.0% |
|  2/2	        9.1	[ 5.0%/ 0.5%]	  4.0% |         11.4	[ 6.8%/ 0.7%]	-24.9%	  3.9% |
'----------------------------------------------------------------------------------------------'

Throughput:
.----------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |
|----------------------------------------------------------------------------------------------|
|  1/1	      310.2	[ 4.1%/ 0.4%]	  2.1% |        296.2	[ 5.0%/ 0.5%]	 -4.5%	  2.0% | 
|  2/2	      547.7	[ 3.6%/ 0.4%]	  4.0% |        368.3	[ 4.8%/ 0.5%]	-32.8%	  3.9% | 
'----------------------------------------------------------------------------------------------'

Note: 2/2 case means 4 threads run on one core, which is overloaded.(cpu% is overall system report)

Though the latency/throughput has regressions, but standard deviation is much better now.

> With my initial test of TPC-C running in large VMs with a lot of
> background noise VMs, the results are pretty similar to v3, I will run
> more thorough tests and report the results back here.

I see something similar. I guess task placement could be another problem.
We don't check cookie matching in load balance and task wakeup, so
- if tasks with different cookie happen to be dispatched onto different cores,
The result should be good
- if tasks with different cookie are unfortunately dispatched onto the same
core, the result should be bad.

This problem is bypassed in my testing setup above, but may be one cause
of my other scenarios, need a while to sort out.

Thanks,
-Aubrey

Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C45BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C28020640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLBRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:42:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:65448 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfLBRmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:42:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 09:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="262288999"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2019 09:42:22 -0800
Received: from [10.125.253.1] (abudanko-mobl.ccr.corp.intel.com [10.125.253.1])
        by linux.intel.com (Postfix) with ESMTP id 257075800FF;
        Mon,  2 Dec 2019 09:42:19 -0800 (PST)
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, vitaly.slobodskoy@intel.com
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <79138ea7-2249-b7e0-3541-8569e593c6e8@linux.intel.com>
 <20191202164313.GM2844@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b55f0797-72d3-7638-7494-3dc9f1583ba8@linux.intel.com>
Date:   Mon, 2 Dec 2019 20:42:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202164313.GM2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.12.2019 19:43, Peter Zijlstra wrote:
> On Mon, Dec 02, 2019 at 07:38:00PM +0300, Alexey Budankov wrote:
>>
>> On 02.12.2019 17:59, Andi Kleen wrote:
>>>>
>>>> This is atricous crap. Also it is completely broken for -RT.
>>>
>>> Well can you please suggest how you would implement it instead?
>>
>> FWIW,
>> An alternative could probably be to make task_ctx_data allocations
>> on the nearest context switch in, and obvious drawback is slowdown on
>> this critical path, but it could be amortized by static branches.
> 
> Context switch is under a raw_spinlock_t too.

Indeed, under rq->lock (some of runqueue locks, I suppose), but 
as far locking order is not violated a thread shouldn't deadlock.
On the other side it could probably hurt concurrency and 
it is more preferable to have task_ctx_data memory pre-allocated 
by the time it is assigned on a context switch in.

What if we would create some pool of preallocated task_ctx_data 
objects on the first system wide perf_event_open() syscall
and after that:
- already existing threads would take task_ctx_data objects from
  the pool without additional locking on the nearest
  context switch in;
- newly created threads would allocate task_ctx_data themselves,
  atomically checking some global state, possibly at PMU object
- task_ctx_data deallocation would be performed by threads
  themselves, at some safe points in time;

Thanks,
Alexey

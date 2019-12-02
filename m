Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72118205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:44:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:58706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfLBUoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:44:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 12:44:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="200746726"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2019 12:44:36 -0800
Received: from [10.251.15.70] (kliang2-mobl.ccr.corp.intel.com [10.251.15.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 65F7E5800FF;
        Mon,  2 Dec 2019 12:44:35 -0800 (PST)
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <20191202162152.GG2827@hirez.programming.kicks-ass.net>
 <20191202191519.GN84886@tassilo.jf.intel.com>
 <8612523d-f035-b2aa-28f5-e4122ef59901@linux.intel.com>
 <20191202202535.GO84886@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3d981134-24b0-c079-3b4a-7ffe434324d5@linux.intel.com>
Date:   Mon, 2 Dec 2019 15:44:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202202535.GO84886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2019 3:25 PM, Andi Kleen wrote:
> 
> Looks reasonable to me.
> 
>> //get current number of threads
>> read_lock(&tasklist_lock);
>> for_each_process_thread(g, p)
>> 	num_thread++;
>> read_unlock(&tasklist_lock);
> 
> I'm sure we have that count somewhere.
>

It looks like we can get the number from global variable "nr_threads"
I will use it in v2.

>>
>> //allocate the space for them
>> for (i = 0; i < num_thread; i++)
>> 	data[i] = kzalloc(ctx_size, flags);
>> i = 0;
>>
>> /*
>>   * Assign the space to tasks
>>   * There may be some new threads created when we allocate space.
>>   * new_task will track its number.
>>   */
>> raw_spin_lock_irqsave(&task_data_events_lock, flags);
>>
>> if (atomic_inc_return(&nr_task_data_events) > 1)
>> 	goto unlock;
>>
>> for_each_process_thread(g, p) {
>> 	if (i < num_thread)
>> 		p->perf_ctx_data = data[i++];
>> 	else
>> 		new_task++;
>> }
>> raw_spin_unlock_irqrestore(&task_data_events_lock, flags);
> 
> Is that lock taken in the context switch? >
> If not could be a normal spinlock, thus be more RT friendly.
> 

It's not in context switch. I will use the normal spinlock to instead.

Thanks,
Kan

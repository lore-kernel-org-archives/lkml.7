Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E4C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2B721537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGICxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:53:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:44565 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGICxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:53:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 19:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="364443279"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jul 2019 19:53:16 -0700
Message-ID: <5D2402E6.7060104@intel.com>
Date:   Tue, 09 Jul 2019 10:58:46 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 07/12] perf/x86: no counter allocation support
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com> <1562548999-37095-8-git-send-email-wei.w.wang@intel.com> <20190708142947.GM3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190708142947.GM3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2019 10:29 PM, Peter Zijlstra wrote:

Thanks for the comments.

>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 0ab99c7..19e6593 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -528,6 +528,7 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
>>    */
>>   #define PERF_EV_CAP_SOFTWARE		BIT(0)
>>   #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
>> +#define PERF_EV_CAP_NO_COUNTER		BIT(2)
>>   
>>   #define SWEVENT_HLIST_BITS		8
>>   #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
>> @@ -895,6 +896,13 @@ extern int perf_event_refresh(struct perf_event *event, int refresh);
>>   extern void perf_event_update_userpage(struct perf_event *event);
>>   extern int perf_event_release_kernel(struct perf_event *event);
>>   extern struct perf_event *
>> +perf_event_create(struct perf_event_attr *attr,
>> +		  int cpu,
>> +		  struct task_struct *task,
>> +		  perf_overflow_handler_t overflow_handler,
>> +		  void *context,
>> +		  bool counter_assignment);
>> +extern struct perf_event *
>>   perf_event_create_kernel_counter(struct perf_event_attr *attr,
>>   				int cpu,
>>   				struct task_struct *task,
> Why the heck are you creating this wrapper nonsense?

(please see early discussions: https://lkml.org/lkml/2018/9/20/868)
I thought we agreed that the perf event created here don't need to consume
an extra counter.

In the previous version, we added a "no_counter" bit to perf_event_attr, and
that will be exposed to user ABI, which seems not good.
(https://lkml.org/lkml/2019/2/14/791)
So we wrap a new kernel API above to support this.

Do you have a different suggestion to do this?
(exclude host/guest just clears the enable bit when on VM-exit/entry,
still consumes the counter)

Best,
Wei

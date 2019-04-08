Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C4C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDHIro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:47:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfDHIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:47:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x388jWXK109762
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 04:47:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rr1nrms41-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:47:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 8 Apr 2019 09:47:39 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 09:47:36 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x388lZ7B59048018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 08:47:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B322252054;
        Mon,  8 Apr 2019 08:47:35 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7FFD05204E;
        Mon,  8 Apr 2019 08:47:35 +0000 (GMT)
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
 <20190408082229.GI4038@hirez.programming.kicks-ass.net>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 8 Apr 2019 10:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190408082229.GI4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040808-0016-0000-0000-0000026C6AB1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040808-0017-0000-0000-000032C88C70
Message-Id: <03ef774b-aa6a-e5ea-6eeb-2457d404d3c7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 10:22 AM, Peter Zijlstra wrote:
> On Mon, Apr 08, 2019 at 09:12:28AM +0200, Thomas-Mich Richter wrote:
>>> Does the below cure things? It's not exactly pretty, but it could just
>>> do the trick.
>>>
>>> ---
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index dfc4bab0b02b..d496e6911442 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2009,8 +2009,8 @@ event_sched_out(struct perf_event *event,
>>>  	event->pmu->del(event, 0);
>>>  	event->oncpu = -1;
>>>  
>>> -	if (event->pending_disable) {
>>> -		event->pending_disable = 0;
>>> +	if (event->pending_disable == smp_processor_id()) {
>>> +		event->pending_disable = -1;
>>>  		state = PERF_EVENT_STATE_OFF;
>>>  	}
>>>  	perf_event_set_state(event, state);
>>> @@ -2198,7 +2198,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
>>>  
>>>  void perf_event_disable_inatomic(struct perf_event *event)
>>>  {
>>> -	event->pending_disable = 1;
>>> +	event->pending_disable = smp_processor_id();
>>>  	irq_work_queue(&event->pending);
>>>  }
>>>  
>>> @@ -5822,8 +5822,8 @@ static void perf_pending_event(struct irq_work *entry)
>>>  	 * and we won't recurse 'further'.
>>>  	 */
>>>  
>>> -	if (event->pending_disable) {
>>> -		event->pending_disable = 0;
>>> +	if (event->pending_disable == smp_processor_id()) {
>>> +		event->pending_disable = -1;
>>>  		perf_event_disable_local(event);
>>>  	}
>>>  
>>> @@ -10236,6 +10236,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>>  
>>>  
>>>  	init_waitqueue_head(&event->waitq);
>>> +	event->pending_disable = -1;
>>>  	init_irq_work(&event->pending, perf_pending_event);
>>>  
>>>  	mutex_init(&event->mmap_mutex);
>>>
>>
>> Peter,
>>
>> very good news, your fix ran over the weekend without any hit!!!
>>
>> Thanks very much for your help. Do you submit this patch to the kernel mailing list?
> 
> Most excellent, let me go write a Changelog.
> 
> Could I convince you to implement arch_irq_work_raise() for s390?
> 

Yes, I am convinced, however I need to discuss this with the s390 maintainers
Martin Schwidesfky and Heiko Carstens first.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


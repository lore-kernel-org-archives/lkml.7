Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52FC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419A20449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfDDJ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:26:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729574AbfDDJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:26:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x349OedV135250
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 05:26:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rncb29yd1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:26:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 4 Apr 2019 10:15:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 10:15:40 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x349Fdx052035736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 09:15:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E0BB52052;
        Thu,  4 Apr 2019 09:15:39 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5B22452050;
        Thu,  4 Apr 2019 09:15:39 +0000 (GMT)
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Thu, 4 Apr 2019 11:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190403104103.GE4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040409-0008-0000-0000-000002D627C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040409-0009-0000-0000-000022423603
Message-Id: <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 12:41 PM, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 11:47:00AM +0200, Thomas-Mich Richter wrote:
>> I use linux 5.1.0-rc3 on s390 and got this WARN_ON_ONCE message:
>>
>> WARNING: CPU: 15 PID: 0 at kernel/events/core.c:330
>>                 event_function_local.constprop.79+0xe2/0xe8
>>
>> which was introduced with
>>    commit cca2094605ef ("perf/core: Fix event_function_local()").
>> ..snip.... 
>>
>> Any ideas or hints who to avoid/fix this warning?
> 
> Some thoughts here:
> 
>   https://lkml.kernel.org/r/20190213101644.GN32534@hirez.programming.kicks-ass.net
> 
> tl;dr, I've no frigging clue.
> 

I have read this thread and at the end you mentioned:

    Humm, but in that case:

   context_switch()
    prepare_task_switch()
      perf_event_task_sched_out()
        __perf_event_task_sched_out()
	  perf_event_context_sched_out()
	    task_ctx_sched_out()
	      ctx_sched_out()
	        group_sched_out()
		  event_sched_out()
		    if (event->pending_disable)

   Would have already cleared the pending_disable state, so the IPI would
   not have ran perf_event_disable_local() in the first place.

Our test system is configured to panic in WARN_ON_ONCE(). I looked
at the dump. The event triggering WARN_ON_ONCE:

crash> struct perf_event.oncpu 0x1f9b24800
  oncpu = 0
crash> struct perf_event.state 0x1f9b24800
  state = PERF_EVENT_STATE_ACTIVE
crash> 

This means the code in 
static void event_sched_out(....)
{
        ....
        event->pmu->del(event, 0);
        event->oncpu = -1;

        if (event->pending_disable) {
                event->pending_disable = 0;
                state = PERF_EVENT_STATE_OFF;
        }
        perf_event_set_state(event, state);
        ...
}

has not finished and returned from this function. So the task was not completely context-switched
out from CPU 0 while the interrupt handler was executing on CPU 15:

static void perf_pending_event(...)
{
        ....
        if (event->pending_disable) {
                event->pending_disable = 0;
                perf_event_disable_local(event);  <--- Causes the WARN_ON_ONCE()
        }
        .....
}

I think there is a race, especially when the interrupt handler on CPU 15
was invoked via timer interrupt an runs on a different CPU.

> 
> Does it reproduce on x86 without virt on? I don't have a PPC LPAR to
> test things on.
> 

s390 LPARs run under hipervisor control, no chance to run any OS without it.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


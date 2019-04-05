Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D867A20645
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfDEKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:19:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730283AbfDEKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:19:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35ADUtb094854
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 06:19:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rp430b6as-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 06:19:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 5 Apr 2019 11:18:57 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Apr 2019 11:18:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x35AIshp44302338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Apr 2019 10:18:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB9CAE056;
        Fri,  5 Apr 2019 10:18:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE20AE057;
        Fri,  5 Apr 2019 10:18:54 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Apr 2019 10:18:54 +0000 (GMT)
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
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 5 Apr 2019 12:18:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190404130300.GF14281@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040510-0020-0000-0000-0000032C979D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040510-0021-0000-0000-0000217EAF49
Message-Id: <05164ef1-418f-1c66-21f8-2c8ef3242218@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 3:03 PM, Peter Zijlstra wrote:
> On Thu, Apr 04, 2019 at 01:09:09PM +0200, Peter Zijlstra wrote:
> 
>> That is not entirely the scenario I talked about, but *groan*.
>>
>> So what I meant was:
>>
>> 	CPU-0							CPU-n
>>
>> 	__schedule()
>> 	  local_irq_disable()
>>
>> 	  ...
>> 	    deactivate_task(prev);
>>
>> 								try_to_wake_up(@p)
>> 								  ...
>> 								  smp_cond_load_acquire(&p->on_cpu, !VAL);
>>
>> 	  <PMI>
>> 	    ..
>> 	    perf_event_disable_inatomic()
>> 	      event->pending_disable = 1;
>> 	      irq_work_queue() /* self-IPI */
>> 	  </PMI>
>>
>> 	  context_switch()
>> 	    prepare_task_switch()
>> 	      perf_event_task_sched_out()
>> 	        // the above chain that clears pending_disable
>>
>> 	    finish_task_switch()
>> 	      finish_task()
>> 	        smp_store_release(prev->on_cpu, 0);
>> 								  /* finally.... */
>> 								// take woken
>> 								// context_switch to @p
>> 	      finish_lock_switch()
>> 	        raw_spin_unlock_irq()
>> 		/* w00t, IRQs enabled, self-IPI time */
>> 	        <self-IPI>
>> 		  perf_pending_event()
>> 		    // event->pending_disable == 0
>> 		</self-IPI>
>>
>>
>> What you're suggesting, is that the time between:
>>
>>   smp_store_release(prev->on_cpu, 0);
>>
>> and
>>
>>   <self-IPI>
>>
>> on CPU-0 is sufficient for CPU-n to context switch to the task, enable
>> the event there, trigger a PMI that calls perf_event_disable_inatomic()
>> _again_ (this would mean irq_work_queue() failing, which we don't check)
>> (and schedule out again, although that's not required).
>>
>> This being virt that might actually be possible if (v)CPU-0 takes a nap
>> I suppose.
>>
>> Let me think about this a little more...
> 
> Does the below cure things? It's not exactly pretty, but it could just
> do the trick.
> 

Thanks a lot for the patch, I have built a new kernel and let it run over the week end.

s390 does not have a PMI, all interrupts (including the measurement interrupts from 
the PMU) are normal, maskable interrupts.


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


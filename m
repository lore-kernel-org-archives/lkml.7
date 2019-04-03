Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71589C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B83420830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:26:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfDCL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:26:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33BPo8v025435
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 07:26:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rmsts6jrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:26:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 3 Apr 2019 12:26:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 12:26:32 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33BQVxK42402046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 11:26:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D43BB4C04A;
        Wed,  3 Apr 2019 11:26:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1CB14C046;
        Wed,  3 Apr 2019 11:26:31 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 11:26:31 +0000 (GMT)
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Wed, 3 Apr 2019 13:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190403104103.GE4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040311-4275-0000-0000-00000323C76B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040311-4276-0000-0000-00003832CE12
Message-Id: <b8fa0710-de01-06f7-96c3-32daec3702ae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030079
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
>>
>> This is the WARN_ON_ONCE message, which sometimes shows up in the kernel
>> log:
>>  [ 4598.316519] WARNING: CPU: 15 PID: 0 at kernel/events/core.c:330
>>                 event_function_local.constprop.79+0xe2/0xe8
>>  [ 4598.316524] Kernel panic - not syncing: panic_on_warn set ...
>>  [ 4598.316527] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G           OE
>>                 5.1.0-20190402.rc3.git0.5e7a8ca31926.300.fc29.s390x+git #1
>>  [ 4598.316529] Hardware name: IBM 2964 NC9 712 (LPAR)
>>  [ 4598.316531] Call Trace:
>>  [ 4598.316534] ([<0000000000112eb8>] show_stack+0x58/0x70)
>>  [ 4598.316538]  [<0000000000a820aa>] dump_stack+0x7a/0xa8
>>  [ 4598.316541]  [<0000000000143b52>] panic+0x11a/0x2d0
>>  [ 4598.316543]  [<00000000001439b0>] __warn+0xf8/0x118
>>  [ 4598.316545]  [<0000000000a811a8>] report_bug+0xd8/0x150
>>  [ 4598.316547]  [<00000000001014ac>] do_report_trap+0xc4/0xe0
>>  [ 4598.316549]  [<0000000000101680>] illegal_op+0x138/0x150
>>  [ 4598.316552]  [<0000000000aa233c>] pgm_check_handler+0x1cc/0x220
>>  [ 4598.316554]  [<00000000002a6d02>] event_function_local.constprop.79+
>>                                                 0xe2/0xe8
>>  [ 4598.316556] ([<00000000002a6c7a>] event_function_local.constprop.79+
>>                                                 0x5a/0xe8)
>>  [ 4598.316559]  [<00000000002aa400>] perf_pending_event+0x88/0xb0
>>  [ 4598.316561]  [<0000000000271a8c>] irq_work_run_list+0x8c/0xb8
>>  [ 4598.316563]  [<0000000000271d78>] irq_work_tick+0x48/0x68
>>  [ 4598.316566]  [<00000000001d6058>] update_process_times+0x68/0x80
>>  [ 4598.316568]  [<00000000001e6c10>] tick_sched_handle.isra.6+0x50/0x60
>>  [ 4598.316570]  [<00000000001e6c7e>] tick_sched_timer+0x5e/0xb8
>>  [ 4598.316573]  [<00000000001d6b6a>] __hrtimer_run_queues+0x10a/0x2c0
>>  [ 4598.316575]  [<00000000001d7a88>] hrtimer_interrupt+0x138/0x2a8
>>  [ 4598.316577]  [<000000000010c3e4>] do_IRQ+0xac/0xb0
>>  [ 4598.316597]  [<0000000000aa2744>] ext_int_handler+0x128/0x12c
>>  [ 4598.316600]  [<00000000001034f6>] enabled_wait+0x46/0xd0
>>  [ 4598.316602] ([<000003e000d2fe10>] 0x3e000d2fe10)
>>  [ 4598.316604]  [<0000000000103842>] arch_cpu_idle+0x3a/0x50
>>  [ 4598.316606]  [<000000000017b808>] do_idle+0x180/0x1b0
>>  [ 4598.316608]  [<000000000017ba06>] cpu_startup_entry+0x36/0x40
>>  [ 4598.316611]  [<0000000000115d16>] smp_init_secondary+0xd6/0xf0
>>  [ 4598.316613]  [<000000000011521e>] smp_start_secondary+0x86/0x98
>>
>> Any ideas or hints who to avoid/fix this warning?
> 
> Some thoughts here:
> 
>   https://lkml.kernel.org/r/20190213101644.GN32534@hirez.programming.kicks-ass.net
> 
> tl;dr, I've no frigging clue.
> 
>> I ran a user space program which uses
>>
>>   1. perf_event_open() system call with type HARDWARE
>>      and PERF_COUNT_HW_CPU_CYCLES in sampling mode.
>>   2. Assigns signal SIGIO to the file descriptor returned from
>>      perf_event_open() using:
>>        rc = fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
>>        rc |= fcntl(fd, F_SETSIG, signo);
>>        rc |= fcntl(fd, F_SETOWN, getpid());
>>
>>   3. The signal handler increments some variables and issues
>>        ioctl(fd, PERF_EVENT_IOC_REFRESH, 1);
>>      to restart signal delivery.
>>
>> I can send you the test program if needed.
> 
> Does it reproduce on x86 without virt on? I don't have a PPC LPAR to
> test things on.
> 

It happens on an s390 mainframe (not PowerPC) without KVM or z/VM virtualisation.
I'll try to repro it on x86.

PS: Put my team members Heiko and Hendrik on cc.
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


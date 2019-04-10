Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38378C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C18A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDJCgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:36:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:5143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:36:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 19:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="162914730"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2019 19:36:36 -0700
Subject: Re: [PATCH v14 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, aubrey.li@intel.com,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190410015326.24500-1-aubrey.li@linux.intel.com>
 <CALCETrWV9SVDGQmzvZuub4aOPGyVqx7gPdk6D0s2_7j471jT_g@mail.gmail.com>
 <89957461-ec42-f041-a7e9-2452b2e83d39@linux.intel.com>
 <CALCETrWD4H8zZVD+Mk+=1VWmYNWx=aC7w+LOi8KqoSpAFgD--Q@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d9e9f68e-e8bb-7e53-9909-d86f5f73f617@linux.intel.com>
Date:   Wed, 10 Apr 2019 10:36:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWD4H8zZVD+Mk+=1VWmYNWx=aC7w+LOi8KqoSpAFgD--Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/10 10:25, Andy Lutomirski wrote:
> On Tue, Apr 9, 2019 at 7:20 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2019/4/10 9:58, Andy Lutomirski wrote:
>>> On Tue, Apr 9, 2019 at 6:55 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>>>
>>>> The architecture specific information of the running processes could
>>>> be useful to the userland. Add support to examine process architecture
>>>> specific information externally.
>>>>
>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>> Cc: Arjan van de Ven <arjan@linux.intel.com>
>>>> Cc: Linux API <linux-api@vger.kernel.org>
>>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> ---
>>>>  fs/proc/array.c         | 5 +++++
>>>>  include/linux/proc_fs.h | 2 ++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/proc/array.c b/fs/proc/array.c
>>>> index 2edbb657f859..331592a61718 100644
>>>> --- a/fs/proc/array.c
>>>> +++ b/fs/proc/array.c
>>>> @@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>>>>         seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>>>>  }
>>>>
>>>> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
>>>> +{
>>>> +}
>>>
>>> This pointlessly bloats other architectures.  Do this instead in an
>>> appropriate header:
>>>
>>> #ifndef arch_proc_pid_status
>>> static inline void arch_proc_pid_status(...)
>>> {
>>> }
>>> #endif
>>>
>>
>> I saw a bunch of similar weak functions, is it not acceptable?
>>
>> fs/proc$ grep weak *.c
>> cpuinfo.c:__weak void arch_freq_prepare_all(void)
>> meminfo.c:void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
>> vmcore.c:int __weak elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
>> vmcore.c:void __weak elfcorehdr_free(unsigned long long addr)
>> vmcore.c:ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>> vmcore.c:ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>> vmcore.c:int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>> vmcore.c:ssize_t __weak
> 
> I think they're acceptable, but I don't personally like them.
> 

okay, let me try to see if I can refine it in an appropriate way.

>>
>>> Or add /proc/PID/x86_status, which sounds better in most respects to me.
>>>
>>
>> I didn't figure out how to make /proc/PID/x86_status invisible to other
>> architectures in an appropriate way, do you have any suggestions?
> 
> #ifdef CONFIG_X86?
> 

I'm not sure if everyone like adding an arch #ifdef in a common file,
please allow me to wait a while to see if there are other comments.

Thanks,
-Aubrey

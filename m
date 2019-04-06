Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6EAC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C43020863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDFPmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:42:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:48496 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDFPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 11:42:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Apr 2019 08:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,317,1549958400"; 
   d="scan'208";a="162007689"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2019 08:42:00 -0700
Subject: Re: [PATCH v13 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        tim.c.chen@linux.intel.com, Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        aubrey.li@intel.com, kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <20190224044400.34975-2-aubrey.li@linux.intel.com>
 <CAG48ez2hJvjRD-immEJ9uJAY1WRth3pMf0Qz8bApRke05kC+2Q@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d118f16e-0d8c-956f-9057-26e463ce3e60@linux.intel.com>
Date:   Sat, 6 Apr 2019 23:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez2hJvjRD-immEJ9uJAY1WRth3pMf0Qz8bApRke05kC+2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/6 4:27, Jann Horn wrote:
> On Fri, Apr 5, 2019 at 10:02 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
>> AVX-512 components use could cause core turbo frequency drop. So
>> it's useful to expose AVX-512 usage elapsed time as a heuristic hint
>> for the user space job scheduler to cluster the AVX-512 using tasks
>> together.
>>
>> Tensorflow example:
>> $ while [ 1 ]; do cat /proc/pid/status | grep AVX; sleep 1; done
>> AVX512_elapsed_ms:      4
>> AVX512_elapsed_ms:      8
>> AVX512_elapsed_ms:      4
>>
>> This means that 4 milliseconds have elapsed since the AVX512 usage
>> of tensorflow task was detected when the task was scheduled out.
>>
>> Or:
>> $ cat /proc/pid/status | grep AVX512_elapsed_ms
>> AVX512_elapsed_ms:      -1
> 
> (Very nitpicky, feel free to ignore: If you change the /proc/pid to
> /proc/tid in the commit message, it becomes clearer that this status
> is really per-task/thread, not per-process/threadgroup.)

Thanks, I'll refine.

> 
> [...]
>> +
>> +/*
>> + * Report the amount of time elapsed in millisecond since last AVX512
>> + * use in the task.
>> + */
>> +static void avx512_status(struct seq_file *m, struct task_struct *task)
>> +{
>> +       unsigned long timestamp = task->thread.fpu.avx512_timestamp;
> 
> This is theoretically a data race, right? Should this have a READ_ONCE() on it?

Thanks, I'll refine.

> 
> Is there something that zeroes out the avx512_timestamp on
> fork()/clone(), or will every child inherit the avx512 timestamp? As
> far as I can tell, the timestamp is inherited; I think it would be
> nicer to zero it out at that point. Either way, It might be worth
> documenting this decision.
> 

This timestamp is not inherited, see below:

_do_fork()
->copy_process()
-->dup_task_struct()
--->arch_dup_task_struct()
---->fpu__copy()

Thanks,
-Aubrey

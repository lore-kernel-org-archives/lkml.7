Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802602083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCAXAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:00:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42515 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCAXAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:00:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so15325044qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NCIX/43FE8u7QVkPRu8lMcjtW87sMpYmpGvTDgosx1g=;
        b=CIhYEwpw4ffBrmlWVBpuWxNNEi8MFPBQr1bGsHSWLRENDyk3SO4a9j3I8/axPpsRGo
         9XHdHGXvDbFLZlEqpWjG4HWjfqvf/wQz60upQ5aCGfyxEspr09S5p7bc64rD3Ldm7pIU
         wZj3Cve68ri+yOxZO5157r/4iqhf2WYsTf1NxZeurbQV1tkTJR+8qzLzH/s6FPOBmAO3
         dfa0COxS4KCfd+UjiiJshzPYEMTeNM3pJ+IeeES8qp7l9mcoU1O2ueLA+VVmMkQRnW97
         neIjgB1A3JPglBzxwOAn7HMxh4k+UiZLdWqkF1IZijUzxSHiaN8yj91TLl/ssY4N5NrG
         RF4Q==
X-Gm-Message-State: APjAAAUkfNfOvrL9KdOnFyLmhS9AnNLCjWO/Tv9iKRmk91sZ6AOJmSDF
        59xnu6GJ1roZkkiACnZS8uNZEw==
X-Google-Smtp-Source: APXvYqwUBDbutsz/7xBk6ONr2/RbZxUK/QesF+fQH5xMvb+3BOcq6aw3eZ5PaHk76C05DglV6qtixg==
X-Received: by 2002:a37:4b49:: with SMTP id y70mr5727861qka.134.1551481223084;
        Fri, 01 Mar 2019 15:00:23 -0800 (PST)
Received: from localhost.localdomain (h69-128-230-203.cntcnh.dsl.dynamic.tds.net. [69.128.230.203])
        by smtp.gmail.com with ESMTPSA id n66sm9061255qkl.38.2019.03.01.15.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 15:00:22 -0800 (PST)
Subject: Re: [RFC] kprobes: Fix locking in recycle_rp_inst
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Srinivasa D S <srinivasa@in.ibm.com>,
        Hien Nguyen <hien@us.ibm.com>, stable@vger.kernel.org
References: <20190226161036.10680-1-jolsa@kernel.org>
 <20190227173846.397e2a66da37e0385d3fc383@kernel.org>
 <20190227133309.GL18893@krava>
 <20190228155032.87b2a87926318744b64eee89@kernel.org>
From:   David Valin <dvalin@redhat.com>
Message-ID: <7f02944d-b859-4716-c786-d0dee6feab20@redhat.com>
Date:   Fri, 1 Mar 2019 18:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228155032.87b2a87926318744b64eee89@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got around to testing it.  Verified the issue was still 
present.  Then install Jiri's fix.  Cleared the issue out.  So at least 
from the standpoint of fixing the hang, the change is good.

Dave

On 2/28/19 1:50 AM, Masami Hiramatsu wrote:
> On Wed, 27 Feb 2019 14:33:09 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
>
>> On Wed, Feb 27, 2019 at 05:38:46PM +0900, Masami Hiramatsu wrote:
>>
>> SNIP
>>
>>>> When we switch it to raw_spin_lock_irqsave the return probe
>>>> on _raw_spin_lock starts working.
>>> Yes, there can be a race between probes and probe on irq handler.
>>>
>>> kretprobe_hash_lock()/kretprobe_hash_unlock() are safe because
>>> those disables irqs. Only recycle_rp_inst() has this problem.
>>>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>
>>> And this is one of the oldest bug in kprobe.
>>>
>>> commit ef53d9c5e4da ("kprobes: improve kretprobe scalability with hashed locking")
>>>
>>> introduced the spin_lock(&rp->lock) in recycle_rp_inst() but forgot to disable irqs.
>>> And
>>>
>>> commit c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
>> ok, so I'll add:
>>
>> Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
>>
>>> introduced assembly-based trampoline which didn't disable irq.
>>>
>>> Could you add Cc:stable to this patch too?
>> sure, attaching patch with updated changelog
> Thank you Jiri,
>
> Ingo, could you pick this patch? (and my kretprobe fixup series?)
>
> Thank you,
>
>> thanks,
>> jirka
>>
>>
>> ---
>> We can call recycle_rp_inst from both task and irq contexts,
>> so we should irqsave/irqrestore locking functions.
>>
>> I wasn't able to hit this particular lockup, but I found it
>> while checking on why return probe on _raw_spin_lock locks
>> the system, reported by David by using bpftrace on simple
>> script, like:
>>
>>    kprobe:_raw_spin_lock
>>    {
>>        @time[tid] = nsecs;
>>        @symb[tid] = arg0;
>>    }
>>
>>    kretprobe:_raw_spin_lock
>>        / @time[tid] /
>>    {
>>        delete(@time[tid]);
>>        delete(@symb[tid]);
>>    }
>>
>> or by perf tool:
>>
>>    # perf probe -a _raw_spin_lock:%return
>>    # perf record -e probe:_raw_spin_lock__return -a
>>
>> The thing is that the _raw_spin_lock call in recycle_rp_inst,
>> is the only one that return probe code paths call and it will
>> trigger another kprobe instance while already processing one
>> and lock up on kretprobe_table_lock lock:
>>
>>    #12 [ffff99c337403d28] queued_spin_lock_slowpath at ffffffff9712693b
>>    #13 [ffff99c337403d28] _raw_spin_lock_irqsave at ffffffff9794c100
>>    #14 [ffff99c337403d38] pre_handler_kretprobe at ffffffff9719435c
>>    #15 [ffff99c337403d68] kprobe_ftrace_handler at ffffffff97059f12
>>    #16 [ffff99c337403d98] ftrace_ops_assist_func at ffffffff971a0421
>>    #17 [ffff99c337403dd8] handle_edge_irq at ffffffff97139f55
>>    #18 [ffff99c337403df0] handle_edge_irq at ffffffff97139f55
>>    #19 [ffff99c337403e58] _raw_spin_lock at ffffffff9794c111
>>    #20 [ffff99c337403e88] _raw_spin_lock at ffffffff9794c115
>>    #21 [ffff99c337403ea8] trampoline_handler at ffffffff97058a8f
>>    #22 [ffff99c337403f00] kretprobe_trampoline at ffffffff970586d5
>>    #23 [ffff99c337403fb0] handle_irq at ffffffff97027b1f
>>    #24 [ffff99c337403fc0] do_IRQ at ffffffff97a01bc9
>>    --- <IRQ stack> ---
>>    #25 [ffffa5c3c1f9fb38] ret_from_intr at ffffffff97a0098f
>>        [exception RIP: smp_call_function_many+460]
>>        RIP: ffffffff9716685c  RSP: ffffa5c3c1f9fbe0  RFLAGS: 00000202
>>        RAX: 0000000000000005  RBX: ffff99c337421c80  RCX: ffff99c337566260
>>        RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff99c337421c88
>>        RBP: ffff99c337421c88   R8: 0000000000000001   R9: ffffffff98352940
>>        R10: ffff99c33703c910  R11: ffffffff9794c110  R12: ffffffff97055680
>>        R13: 0000000000000000  R14: 0000000000000001  R15: 0000000000000040
>>        ORIG_RAX: ffffffffffffffde  CS: 0010  SS: 0018
>>    #26 [ffffa5c3c1f9fc20] on_each_cpu at ffffffff97166918
>>    #27 [ffffa5c3c1f9fc40] ftrace_replace_code at ffffffff97055a34
>>    #28 [ffffa5c3c1f9fc88] ftrace_modify_all_code at ffffffff971a3552
>>    #29 [ffffa5c3c1f9fca8] arch_ftrace_update_code at ffffffff97055a6c
>>    #30 [ffffa5c3c1f9fcb0] ftrace_run_update_code at ffffffff971a3683
>>    #31 [ffffa5c3c1f9fcc0] ftrace_startup at ffffffff971a6638
>>    #32 [ffffa5c3c1f9fce8] register_ftrace_function at ffffffff971a66a0
>>
>> When we switch it to raw_spin_lock_irqsave the return probe
>> on _raw_spin_lock starts working.
>>
>> Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
>> Cc: stable@vger.kernel.org
>> Reported-by: David Valin <dvalin@redhat.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>   kernel/kprobes.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index c83e54727131..c82056b354cc 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1154,9 +1154,11 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
>>   	hlist_del(&ri->hlist);
>>   	INIT_HLIST_NODE(&ri->hlist);
>>   	if (likely(rp)) {
>> -		raw_spin_lock(&rp->lock);
>> +		unsigned long flags;
>> +
>> +		raw_spin_lock_irqsave(&rp->lock, flags);
>>   		hlist_add_head(&ri->hlist, &rp->free_instances);
>> -		raw_spin_unlock(&rp->lock);
>> +		raw_spin_unlock_irqrestore(&rp->lock, flags);
>>   	} else
>>   		/* Unregistering */
>>   		hlist_add_head(&ri->hlist, head);
>> -- 
>> 2.17.2
>>
>

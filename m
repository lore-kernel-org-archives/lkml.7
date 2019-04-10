Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7741CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A5720693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554908087;
	bh=Xm7zs/m75bYZi4PimHClru1GSw3OltcW13YinV1GWko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jRcKSXlPOZPNyQkdmyZyH1g+iqTdlboNV7jNIUEmNGVg4pePK/XzOZZ/7NiJ351FT
	 00UD6t4p1Vq+eq/YjBgqUloi5BwGNhJ3V5tptR7AzSpMvFX1gTpEGuNiUihW1q9Zlc
	 ruupu48dW3fAB7sLhM6h2i5hadR66ct3LT7aFWaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfDJOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732779AbfDJOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:54:45 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8AB2183E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554908084;
        bh=Xm7zs/m75bYZi4PimHClru1GSw3OltcW13YinV1GWko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nprpff5XOOu1vdD79lPc0TUz8XXJIC7hQG1ThZC7CW6fOGMrFIKivoBOlpBoV1IcR
         nMLEiGp3ZHApvWP+T3jZgiixAFO4j/lQaEEgZi4eIEmDhImkqYTl14umuRZ+OreBta
         zGnJ475wRQFOl7gKtSY6XsUH4aro5fTvHrUa4iaA=
Received: by mail-wr1-f54.google.com with SMTP id y13so3359458wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:54:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXuHWfl2kvBlIp3C1WWOsYw/ckDK49jjGPNxfCzDsyXHjcbzzx3
        BLO7Eet9Qo1swRABV9/WLFhIf3ze6yF7DkO1iSp9TA==
X-Google-Smtp-Source: APXvYqzEwOkPeTwugCD/xOd5gMZCr+MAtTbWCMANz+6JzZLvI5F6202ZTck2wgyDfc5N3IJlNZ04sO5EecJDJA9yCic=
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr28562532wrn.108.1554908082373;
 Wed, 10 Apr 2019 07:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190410015326.24500-1-aubrey.li@linux.intel.com>
 <CALCETrWV9SVDGQmzvZuub4aOPGyVqx7gPdk6D0s2_7j471jT_g@mail.gmail.com>
 <89957461-ec42-f041-a7e9-2452b2e83d39@linux.intel.com> <CALCETrWD4H8zZVD+Mk+=1VWmYNWx=aC7w+LOi8KqoSpAFgD--Q@mail.gmail.com>
 <d9e9f68e-e8bb-7e53-9909-d86f5f73f617@linux.intel.com> <39318cc8-340f-5366-f1d6-e7dcbb6ba595@linux.intel.com>
In-Reply-To: <39318cc8-340f-5366-f1d6-e7dcbb6ba595@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 10 Apr 2019 07:54:31 -0700
X-Gmail-Original-Message-ID: <CALCETrUPHg8b-aRpo3NhaedGMJgQxOJjgQN_9fjubnDWEzo+aA@mail.gmail.com>
Message-ID: <CALCETrUPHg8b-aRpo3NhaedGMJgQxOJjgQN_9fjubnDWEzo+aA@mail.gmail.com>
Subject: Re: [PATCH v14 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 8:40 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2019/4/10 10:36, Li, Aubrey wrote:
> > On 2019/4/10 10:25, Andy Lutomirski wrote:
> >> On Tue, Apr 9, 2019 at 7:20 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >>>
> >>> On 2019/4/10 9:58, Andy Lutomirski wrote:
> >>>> On Tue, Apr 9, 2019 at 6:55 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >>>>>
> >>>>> The architecture specific information of the running processes could
> >>>>> be useful to the userland. Add support to examine process architecture
> >>>>> specific information externally.
> >>>>>
> >>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: Andi Kleen <ak@linux.intel.com>
> >>>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >>>>> Cc: Dave Hansen <dave.hansen@intel.com>
> >>>>> Cc: Arjan van de Ven <arjan@linux.intel.com>
> >>>>> Cc: Linux API <linux-api@vger.kernel.org>
> >>>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> >>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>>> ---
> >>>>>  fs/proc/array.c         | 5 +++++
> >>>>>  include/linux/proc_fs.h | 2 ++
> >>>>>  2 files changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/proc/array.c b/fs/proc/array.c
> >>>>> index 2edbb657f859..331592a61718 100644
> >>>>> --- a/fs/proc/array.c
> >>>>> +++ b/fs/proc/array.c
> >>>>> @@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
> >>>>>         seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
> >>>>>  }
> >>>>>
> >>>>> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> >>>>> +{
> >>>>> +}
> >>>>
> >>>> This pointlessly bloats other architectures.  Do this instead in an
> >>>> appropriate header:
> >>>>
> >>>> #ifndef arch_proc_pid_status
> >>>> static inline void arch_proc_pid_status(...)
> >>>> {
> >>>> }
> >>>> #endif
> >>>>
> >>>
> >>> I saw a bunch of similar weak functions, is it not acceptable?
> >>>
> >>> fs/proc$ grep weak *.c
> >>> cpuinfo.c:__weak void arch_freq_prepare_all(void)
> >>> meminfo.c:void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
> >>> vmcore.c:int __weak elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
> >>> vmcore.c:void __weak elfcorehdr_free(unsigned long long addr)
> >>> vmcore.c:ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> >>> vmcore.c:ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
> >>> vmcore.c:int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
> >>> vmcore.c:ssize_t __weak
> >>
> >> I think they're acceptable, but I don't personally like them.
> >>
> >
> > okay, let me try to see if I can refine it in an appropriate way.
>
> Hi Andy,
>
> Is this what you want?
>
> Thanks,
> -Aubrey
>
> ====================================================================
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 2bb3a648fc12..82d77d3aefff 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -990,5 +990,8 @@ enum l1tf_mitigations {
>  };
>
>  extern enum l1tf_mitigations l1tf_mitigation;
> +/* Add support for architecture specific output in /proc/pid/status */
> +void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
> +#define arch_proc_pid_status arch_proc_pid_status
>
>  #endif /* _ASM_X86_PROCESSOR_H */
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 2edbb657f859..fd65a6ba2864 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -401,6 +401,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>         seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>
> +/* Add support for architecture specific output in /proc/pid/status */
> +#ifndef arch_proc_pid_status
> +#define arch_proc_pid_status(m, task)
> +#endif
> +
>  int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>                         struct pid *pid, struct task_struct *task)
>  {
> @@ -424,6 +429,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>         task_cpus_allowed(m, task);
>         cpuset_task_status_allowed(m, task);
>         task_context_switch_counts(m, task);
> +       arch_proc_pid_status(m, task);
>         return 0;
>  }
>

Yes.  But I still think it would be nicer to separate the arch stuff
into its own file.  Others might reasonably disagree with me.

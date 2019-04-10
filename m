Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7128C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C55420857
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554863145;
	bh=kuRlCwgiOe7v5Hczqqg15uH9UzuclPm1ETliL0WoJe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=woYe4AfX4CLI3D3kNChjbjbBWGrJ5Ai+wdb2ouDazA8+8MgHS4hW3wMU0K4ldHq2c
	 ljCwB33MsM+GIhELgDmsP4ez6WzpEsCpVsGZtwXiERO1GxHcLpwfFa2Ivck11h5kp9
	 VIB7RO/fuKzGBZwn4cJEtpO2tPd8ExsZS+epuGGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDJCZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfDJCZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:25:43 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518F3218E2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554863142;
        bh=kuRlCwgiOe7v5Hczqqg15uH9UzuclPm1ETliL0WoJe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQBjPKeruYQHFZKI722jpT62HSV3pLHS8amVmAFSuQCGjsK9o/iQZsUKttqpioghR
         0aeQpcO6+JHAvBQqnyRIN0EkC0tNKpNenm8e+Jkx31DBjBoaZ+fIxc80gOOO3c+t7d
         KL9QXbjRh+akxxtlvhjHk9XDm2MuNd1QooHofv7Q=
Received: by mail-wm1-f53.google.com with SMTP id y197so804596wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 19:25:42 -0700 (PDT)
X-Gm-Message-State: APjAAAW4+aeG9vdmfCCyOy7GafwSYmc6Z9c+Ux7HIAsA92FTO1XF8gVn
        ATEBV+02xBHM7cASQgKmPzppCCcJQ5cWTWiw8unBGA==
X-Google-Smtp-Source: APXvYqxSLXH7mn7VTpVsJfZVRZdyq/0O6sWeD40YBKzXgrH/icZE0Nk58f1YqPxSGMvZqS4TzNp9GT4azQ5u7Rhlwmg=
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr868273wmc.135.1554863140838;
 Tue, 09 Apr 2019 19:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190410015326.24500-1-aubrey.li@linux.intel.com>
 <CALCETrWV9SVDGQmzvZuub4aOPGyVqx7gPdk6D0s2_7j471jT_g@mail.gmail.com> <89957461-ec42-f041-a7e9-2452b2e83d39@linux.intel.com>
In-Reply-To: <89957461-ec42-f041-a7e9-2452b2e83d39@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Apr 2019 19:25:29 -0700
X-Gmail-Original-Message-ID: <CALCETrWD4H8zZVD+Mk+=1VWmYNWx=aC7w+LOi8KqoSpAFgD--Q@mail.gmail.com>
Message-ID: <CALCETrWD4H8zZVD+Mk+=1VWmYNWx=aC7w+LOi8KqoSpAFgD--Q@mail.gmail.com>
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

On Tue, Apr 9, 2019 at 7:20 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2019/4/10 9:58, Andy Lutomirski wrote:
> > On Tue, Apr 9, 2019 at 6:55 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >>
> >> The architecture specific information of the running processes could
> >> be useful to the userland. Add support to examine process architecture
> >> specific information externally.
> >>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Andi Kleen <ak@linux.intel.com>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Cc: Dave Hansen <dave.hansen@intel.com>
> >> Cc: Arjan van de Ven <arjan@linux.intel.com>
> >> Cc: Linux API <linux-api@vger.kernel.org>
> >> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>  fs/proc/array.c         | 5 +++++
> >>  include/linux/proc_fs.h | 2 ++
> >>  2 files changed, 7 insertions(+)
> >>
> >> diff --git a/fs/proc/array.c b/fs/proc/array.c
> >> index 2edbb657f859..331592a61718 100644
> >> --- a/fs/proc/array.c
> >> +++ b/fs/proc/array.c
> >> @@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
> >>         seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
> >>  }
> >>
> >> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> >> +{
> >> +}
> >
> > This pointlessly bloats other architectures.  Do this instead in an
> > appropriate header:
> >
> > #ifndef arch_proc_pid_status
> > static inline void arch_proc_pid_status(...)
> > {
> > }
> > #endif
> >
>
> I saw a bunch of similar weak functions, is it not acceptable?
>
> fs/proc$ grep weak *.c
> cpuinfo.c:__weak void arch_freq_prepare_all(void)
> meminfo.c:void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
> vmcore.c:int __weak elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
> vmcore.c:void __weak elfcorehdr_free(unsigned long long addr)
> vmcore.c:ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> vmcore.c:ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
> vmcore.c:int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
> vmcore.c:ssize_t __weak

I think they're acceptable, but I don't personally like them.

>
> > Or add /proc/PID/x86_status, which sounds better in most respects to me.
> >
>
> I didn't figure out how to make /proc/PID/x86_status invisible to other
> architectures in an appropriate way, do you have any suggestions?

#ifdef CONFIG_X86?

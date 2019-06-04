Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C241C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E3A20665
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFDTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:42:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54278 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:42:34 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hYFKK-0003VR-JR; Tue, 04 Jun 2019 13:42:32 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hYFKJ-0007o7-Hd; Tue, 04 Jun 2019 13:42:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        deepa.kernel@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
References: <000000000000410d500588adf637@google.com>
        <87woia5vq3.fsf@xmission.com>
        <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org>
        <87pno23vim.fsf_-_@xmission.com>
        <CANaxB-ztx3-3cfsbK4rTnGAAcODJmgKHyhHF_0oBe+qqyf5Leg@mail.gmail.com>
Date:   Tue, 04 Jun 2019 14:42:23 -0500
In-Reply-To: <CANaxB-ztx3-3cfsbK4rTnGAAcODJmgKHyhHF_0oBe+qqyf5Leg@mail.gmail.com>
        (Andrei Vagin's message of "Tue, 4 Jun 2019 11:33:06 -0700")
Message-ID: <87tvd5m928.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hYFKJ-0007o7-Hd;;;mid=<87tvd5m928.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LHOs2ASTeC5rbSwE5z5ADEuXNxkG8CfI=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal/ptrace: Don't leak unitialized kernel memory with PTRACE_PEEK_SIGINFO
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:

> On Tue, May 28, 2019 at 6:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>
>> Recently syzbot in conjunction with KMSAN reported that
>> ptrace_peek_siginfo can copy an uninitialized siginfo to userspace.
>> Inspecting ptrace_peek_siginfo confirms this.
>>
>> The problem is that off when initialized from args.off can be
>> initialized to a negaive value.  At which point the "if (off >= 0)"
>> test to see if off became negative fails because off started off
>> negative.
>>
>> Prevent the core problem by adding a variable found that is only true
>> if a siginfo is found and copied to a temporary in preparation for
>> being copied to userspace.
>>
>> Prevent args.off from being truncated when being assigned to off by
>> testing that off is <= the maximum possible value of off.  Convert off
>> to an unsigned long so that we should not have to truncate args.off,
>> we have well defined overflow behavior so if we add another check we
>> won't risk fighting undefined compiler behavior, and so that we have a
>> type whose maximum value is easy to test for.
>>
>
> Hello Eric,
>
> Thank you for fixing this issue. Sorry for the late response.
> I thought it was fixed a few month ago, I remembered that we discussed it:
> https://lkml.org/lkml/2018/10/10/251

I was looking for that conversation, and I couldn't find it so I just
decided to write a test and fix it.

> Here are two inline comments.
>
>
>> Cc: Andrei Vagin <avagin@gmail.com>
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
>> Fixes: 84c751bd4aeb ("ptrace: add ability to retrieve signals without removing from a queue (v4)")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>
>> Comments?
>> Concerns?
>>
>> Otherwise I will queue this up and send it to Linus.
>>
>>  kernel/ptrace.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 6f357f4fc859..4c2b24a885d3 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -704,6 +704,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>>         if (arg.nr < 0)
>>                 return -EINVAL;
>>
>> +       /* Ensure arg.off fits in an unsigned */
>> +       if (arg.off > ULONG_MAX)
>
> if (arg.off > ULONG_MAX - arg.nr)
>

The new variable found ensures that whatever we pass in we won't return
an invalid value.  All this test does is guarantee we don't return a
much lower entry in the queue.

We don't need to take arg.nr into account as we won't try
entries that high as the queue will never get that long.  The maximum
siqueue entries per user is about 2^24.

>> +               return 0;
>
> maybe we should return EINVAL in this case

But it is a huge request not an invalid request.  The request
makes perfect sense.   For smaller values whose offset is
greater than the length of the queue we just return 0 entries
found.  So I think it makes more sense to just return 0 entries
found in this case as well.

>> +
>>         if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
>>                 pending = &child->signal->shared_pending;
>>         else
>> @@ -711,18 +715,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>>
>>         for (i = 0; i < arg.nr; ) {
>>                 kernel_siginfo_t info;
>> -               s32 off = arg.off + i;
>> +               unsigned long off = arg.off + i;
>> +               bool found = false;
>>
>>                 spin_lock_irq(&child->sighand->siglock);
>>                 list_for_each_entry(q, &pending->list, list) {
>>                         if (!off--) {
>> +                               found = true;
>>                                 copy_siginfo(&info, &q->info);
>>                                 break;
>>                         }
>>                 }
>>                 spin_unlock_irq(&child->sighand->siglock);
>>
>> -               if (off >= 0) /* beyond the end of the list */
>> +               if (!found) /* beyond the end of the list */
>>                         break;
>>
>>  #ifdef CONFIG_COMPAT
>> --
>> 2.21.0.dirty
>>

Eric

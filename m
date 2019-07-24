Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB906C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BD218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Lqx8OPn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfGXTKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:10:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33982 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfGXTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:10:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so21413557pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=3c55STgphphZ74Tkr7e0DO52Xm8oc23hN7JygFwylXY=;
        b=Lqx8OPn1aLHQ/uSUcziIbWBa43ionTq0dyMamtLFcU251mVHo88+e4KPRuKF5mh0Y9
         RMG/jOpGnVXotjfZqOT+yo4G54408UcJX3uQdUXVeG8e4NQlqW4DjYACataDsRvCuTtP
         bTTXl59Zcu1C2zFiXSHTJkEa1Aq44TdaUEqqaLExRWz1inh64BnxCWfssojvzfYi9rFN
         WwCrsI8V/kAQEo2BAdX0XdavW5Bzgce81ABKccC41F7wc1WZe25N5jmQ+Fj67MgZ70JM
         GKEn0ofQhfMD1Hcr8tEO7oL2769tDeLi0f6akIZxZP/WGRMZFJr3ZyuVAv0gGh4RwwUH
         aXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=3c55STgphphZ74Tkr7e0DO52Xm8oc23hN7JygFwylXY=;
        b=AO20RbwCJEEw4Jrw6ZZn+TCpMouNqF+u13mnkwKsG2pBbVCxJ/09Rft+EPJpaQx0c9
         bdlf94sLjfoiQj25jFZ6eXTh39/MHVg7QNk8QpNGTjVI/J7fxK1ugDUq9BfZPvfKIeSp
         XKtFkB1oQ98QadKTJotD0jGoOJECOmp+rxvAPpX3r1X/yPovZRYO7Nywi4acHZzMh5x2
         fQR5Eo/0iqqY2ZJ1eyhLXNNhZA0JsuVx6reG1asRn9t2+1lKcekRpL2gHUM5X8bmQLqf
         k/Ew/dTRseQPnewt85Vh7UXqj7kiI1qGCl3Oy6kJe13iVhyEDp3nZegDzrzhWf5eruZO
         SflA==
X-Gm-Message-State: APjAAAXvzJ2LvVvS8pSbJqGll5UtB+VQWycHoVKVk8xdEQdHGuKZ9DyK
        BL0w7akVLV0HsJG9o16zeUE=
X-Google-Smtp-Source: APXvYqywU853m9H6EfajxKiEtQpFA9Hog8e5mn6u5MDixpfJK9EqFYRFg5ObWMEzY5XemUtkbU7ajw==
X-Received: by 2002:a65:6081:: with SMTP id t1mr83803190pgu.9.1563995429178;
        Wed, 24 Jul 2019 12:10:29 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id i124sm87012408pfe.61.2019.07.24.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:10:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:10:20 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-5-christian@brauner.io> <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com> <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io> <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
To:     Jann Horn <jannh@google.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-team <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux API <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <DB572B9F-4D21-402F-A68B-CD193BBB166C@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2019 9:07:54 PM GMT+02:00, Jann Horn <jannh@google=2Ecom> wrote=
:
>On Wed, Jul 24, 2019 at 8:27 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> On July 24, 2019 8:14:26 PM GMT+02:00, Jann Horn <jannh@google=2Ecom>
>wrote:
>> >On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner
>> ><christian@brauner=2Eio> wrote:
>> >> If CLONE_WAIT_PID is set the newly created process will not be
>> >> considered by process wait requests that wait generically on
>children
>> >> such as:
>> >>
>> >>         syscall(__NR_wait4, -1, wstatus, options, rusage)
>> >>         syscall(__NR_waitpid, -1, wstatus, options)
>> >>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
>> >>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
>> >>         syscall(__NR_waitpid, -pid, wstatus, options)
>> >>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
>> >>
>> >> A process created with CLONE_WAIT_PID can only be waited upon with
>a
>> >> focussed wait call=2E This ensures that processes can be reaped even
>if
>> >> all file descriptors referring to it are closed=2E
>> >[=2E=2E=2E]
>> >> diff --git a/kernel/fork=2Ec b/kernel/fork=2Ec
>> >> index baaff6570517=2E=2Ea067f3876e2e 100644
>> >> --- a/kernel/fork=2Ec
>> >> +++ b/kernel/fork=2Ec
>> >> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct
>> >*copy_process(
>> >>         delayacct_tsk_init(p);  /* Must remain after
>> >dup_task_struct() */
>> >>         p->flags &=3D ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>> >>         p->flags |=3D PF_FORKNOEXEC;
>> >> +       if (clone_flags & CLONE_WAIT_PID)
>> >> +               p->flags |=3D PF_WAIT_PID;
>> >>         INIT_LIST_HEAD(&p->children);
>> >>         INIT_LIST_HEAD(&p->sibling);
>> >>         rcu_copy_process(p);
>> >
>> >This means that if a process with PF_WAIT_PID forks, the child
>> >inherits the flag, right? That seems unintended? You might have to
>add
>> >something like "if (clone_flags & CLONE_THREAD =3D=3D 0) p->flags &=3D
>> >~PF_WAIT_PID;" before this=2E (I think threads do have to inherit the
>> >flag so that the case where a non-leader thread of the child goes
>> >through execve and steals the leader's identity is handled
>properly=2E)
>> >Or you could cram it somewhere into signal_struct instead of on the
>> >task - that might be a more logical place for it?
>>
>> Hm, CLONE_WAIT_PID is only useable with CLONE_PIDFD which in turn is
>> not useable with CLONE_THREAD=2E
>> But we should probably make that explicit for CLONE_WAIT_PID too=2E
>
>To clarify:
>
>This code looks buggy to me because p->flags is inherited from the
>parent, with the exception of flags that are explicitly stripped out=2E
>Since PF_WAIT_PID is not stripped out, this means that if task A
>creates a child B with clone(CLONE_WAIT_PID), and then task B uses
>fork() to create a child C, then B will not be able to use
>wait(&status) to wait for C since C inherited PF_WAIT_PID from B=2E
>
>The obvious way to fix that would be to always strip out PF_WAIT_PID;
>but that would also be wrong, because if task B creates a thread C,
>and then C calls execve(), the task_struct of B goes away and B's TGID
>is taken over by C=2E When C eventually exits, it should still obey the
>CLONE_WAIT_PID (since to A, it's all the same process)=2E Therefore, if
>p->flags is used to track whether the task was created with
>CLONE_WAIT_PID, PF_WAIT_PID must be inherited if CLONE_THREAD is set=2E
>So:
>
>diff --git a/kernel/fork=2Ec b/kernel/fork=2Ec
>index d8ae0f1b4148=2E=2Eb32e1e9a6c9c 100644
>--- a/kernel/fork=2Ec
>+++ b/kernel/fork=2Ec
>@@ -1902,6 +1902,10 @@ static __latent_entropy struct task_struct
>*copy_process(
>      delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
>        p->flags &=3D ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>        p->flags |=3D PF_FORKNOEXEC;
>+       if (!(clone_flags & CLONE_THREAD))
>+               p->flags &=3D ~PF_PF_WAIT_PID;
>+       if (clone_flags & CLONE_WAIT_PID)
>+               p->flags |=3D PF_PF_WAIT_PID;
>        INIT_LIST_HEAD(&p->children);
>        INIT_LIST_HEAD(&p->sibling);
>        rcu_copy_process(p);
>
>An alternative would be to not use p->flags at all, but instead make
>this a property of the signal_struct - since the property is shared by
>all threads, that might make more sense?

Yeah, thanks for clarifying=2E
Now it's more obvious=2E
I need to take a look at the signal struct before I can say anything about=
 this=2E

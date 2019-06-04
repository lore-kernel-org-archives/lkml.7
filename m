Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF447C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924F4207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFDXvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:51:53 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48712 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFDXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:51:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hYJDZ-0007Eb-FK; Tue, 04 Jun 2019 17:51:49 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hYJDY-0007E1-J9; Tue, 04 Jun 2019 17:51:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, e@80x24.org,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
Date:   Tue, 04 Jun 2019 18:51:39 -0500
In-Reply-To: <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 4 Jun 2019 14:26:42 -0700")
Message-ID: <878sugewok.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hYJDY-0007E1-J9;;;mid=<878sugewok.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JWsEY56EAlEOUXsS4oiORhVM/2epMWVE=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: remove the wrong signal_pending() check in restore_user_sigmask()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 4, 2019 at 6:41 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> This is the minimal fix for stable, I'll send cleanups later.
>
> Ugh. I htink this is correct, but I wish we had a better and more
> intuitive interface.
>
> In particular, since restore_user_sigmask() basically wants to check
> for "signal_pending()" anyway (to decide if the mask should be
> restored by signal handling or by that function), I really get the
> feeling that a lot of these patterns like

Linus that checking for signal_pending() in restore_user_sigmask is the
bug that caused the regression.

>> -       restore_user_sigmask(ksig.sigmask, &sigsaved);
>> -       if (signal_pending(current) && !ret)
>> +
>> +       interrupted = signal_pending(current);
>> +       restore_user_sigmask(ksig.sigmask, &sigsaved, interrupted);
>> +       if (interrupted && !ret)
>>                 ret = -ERESTARTNOHAND;
>
> are wrong to begin with, and we really should aim for an interface
> which says "tell me whether you completed the system call, and I'll
> give you an error return if not".

The pattern you are pointing out is specific to io_pgetevents and it's
variations.  It does look buggy to me but not for the reason you point
out, but instead because it does not appear to let a pending signal
cause io_pgetevents to return early.

I suspect we should fix that and have do_io_getevents return
-EINTR or -ERESTARTNOHAND like everyone else.

The concept of interrupted (aka return -EINTR to userspace) is truly
fundamental to the current semantics.  We effectively put a normally
blocked signal that was triggered back if we won't be returning -EINTR
to userspace.

> How about we make restore_user_sigmask() take two return codes: the
> 'ret' we already have, and the return we would get if there is a
> signal pending and w're currently returning zero.
>
> IOW, I think the above could become
>
>         ret = restore_user_sigmask(ksig.sigmask, &sigsaved, ret, -ERESTARTHAND);
>
> instead if we just made the right interface decision.
>
> Hmm?

At best I think that is a cleanup that will complicate creating a simple
straight forward regression fix.

Unless I am misreading things that is optimizing the interface for
dealing with broken code.

So can we please get this fix in and then look at cleaning up and
simplifying this code.

Eric

p.s. A rather compelling cleanup is to:

- Leave the signal mask alone.
- Register with signalfd_wqh for wake ups.
- Have a helper

   int signal_pending_sigmask(sigset_t *blocked)
   {
   	struct task_struct *tsk = current;
   	int ret = 0;
   	spin_lock_irq(&tsk->sighand->siglock);
        if (next_signal(&tsk->pending, blocked) ||
            next_signal(&tsk->signal->pending, blocked)) {
        	ret = -ERESTARTHAND;
                if (!sigequalsets(&tsk->blocked, blocked)) {
                	tsk->saved_sigmask = tsk->blocked;
                	__set_task_blocked(tsk, blocked);
                        set_restore_sigmask();
		}
        }
        spin_unlock_irq(&tsk->sighand->siglock);
        return ret;
   }
  
- Use that helper instead of signal_pending() in the various
  sleep functions.
- Possibly get the signal mask from tsk instead of passing it into
  all of the helpers.

Eric

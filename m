Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32404C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0216D20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnLq3kDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDMA4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:56:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34526 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDMA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:56:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so9487764oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JP8BGTDc+T+zCWF2hfOpIX7uaRUEDBwZZB4d0ncDIfE=;
        b=BnLq3kDlBDmlcVNpDV/kMrmJlav2tzyaNAcmXlFhSL20OeyNWfdlMCDJjsfjitHvYG
         Sd2l+PO7sufg3HMYlYZfyX1LAavN91C+dRxaAh0+/t3yry9GN9hxBx5bt48aRb0XZ0b7
         AWbDETU+q5wj7730p4S5B6hkkp43AAp2JSYkIgmD49G09XhaMquyOTQ9lF1ScbI6mhkC
         okC8hC64cU6CKT/ZDNRbm8Czn+h5QG/svGI3Q80OXubRhxiA88MXRa8Ogn6VKRTPWGkU
         E8f/GEVxhl5FJgGikcAjZZI7qD+gEzRNQZyO0+aaPd9JbUpR1fK2OzgpTfbvT9O8SifE
         a6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JP8BGTDc+T+zCWF2hfOpIX7uaRUEDBwZZB4d0ncDIfE=;
        b=iJL//b4IRiCB2rlCaLiTledLnOBjm/xeos35DS6YM773WwoO8QrWeO5fZAyta9CD9S
         zNh8LmEOj4I1SM4Et8+QFcy/j51nbrvcBrk4EVNC89I9iYnZRiTYmEIpDW4YRk/yNhFn
         imP1SQld3D13wgWPq/NeHO9VX08xwQFCnQccWYl4HQhvpBwIPGR2ubudvclKBWcFChIM
         qUIhGY9owxMHUhazqPCAQDUem2/Ir6BUjAvpZKrpWN8XIPDesrcp/WaH0eJcHAw3GXJa
         vah4zcnWPZhrUZUky+C7AYpoc+p4wWMdqHLouMitz2LIqRUFfMjOVBarheKcOIVNMoej
         SRxg==
X-Gm-Message-State: APjAAAXubue3hCMjuV0xeybxuW0eIkcJWVxLWqX/J8xBuPW7WMo+VkUI
        CbYfwu8M/38LgMm3AbRC6k8SPIk1jADmk/p+Mdgu9g==
X-Google-Smtp-Source: APXvYqxrCtJYnWqhCgbcLl9uaNEbSB7G2294hsBbr9Q710ZvKsvsxA5EQ0MKHoCDLE3/gf5ex2Gv4jz5rtpufdeHXk0=
X-Received: by 2002:aca:d5cf:: with SMTP id m198mr12040178oig.138.1555116971659;
 Fri, 12 Apr 2019 17:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
 <20190413000941.GA53420@google.com> <CAKOZuetX4jMPDtDqAvGgSNo4BHf9BOnu79ufEiULfM5X5nDyyQ@mail.gmail.com>
In-Reply-To: <CAKOZuetX4jMPDtDqAvGgSNo4BHf9BOnu79ufEiULfM5X5nDyyQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Apr 2019 17:56:00 -0700
Message-ID: <CAKOZuesgRPabwrx9pjf3p0S-7nsqeXoUVxeykOOmHokAL=5wqw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending due to accidental HTML. I need to take Joel's advice and
switch to a real email client]

On Fri, Apr 12, 2019 at 5:54 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Fri, Apr 12, 2019 at 5:09 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> Hi Andy!
>>
>> On Fri, Apr 12, 2019 at 02:32:53PM -0700, Andy Lutomirski wrote:
>> > On Thu, Apr 11, 2019 at 10:51 AM Joel Fernandes (Google)
>> > <joel@joelfernandes.org> wrote:
>> > >
>> > > pidfd are /proc/pid directory file descriptors referring to a task group
>> > > leader. Android low memory killer (LMK) needs pidfd polling support to
>> > > replace code that currently checks for existence of /proc/pid for
>> > > knowing a process that is signalled to be killed has died, which is both
>> > > racy and slow. The pidfd poll approach is race-free, and also allows the
>> > > LMK to do other things (such as by polling on other fds) while awaiting
>> > > the process being killed to die.
>> > >
>> > > It prevents a situation where a PID is reused between when LMK sends a
>> > > kill signal and checks for existence of the PID, since the wrong PID is
>> > > now possibly checked for existence.
>> > >
>> > > In this patch, we follow the same mechanism used uhen the parent of the
>> > > task group is to be notified, that is when the tasks waiting on a poll
>> > > of pidfd are also awakened.
>> > >
>> > > We have decided to include the waitqueue in struct pid for the following
>> > > reasons:
>> > > 1. The wait queue has to survive for the lifetime of the poll. Including
>> > > it in task_struct would not be option in this case because the task can
>> > > be reaped and destroyed before the poll returns.
>> >
>> > Are you sure?  I admit I'm not all that familiar with the innards of
>> > poll() on Linux, but I thought that the waitqueue only had to survive
>> > long enough to kick the polling thread and did *not* have to survive
>> > until poll() actually returned.
>>
>> I am not sure now. I thought epoll(2) was based on the wait_event APIs,
>> however more closely looking at the eventpoll code, it looks like there are 2
>> waitqueues involved, one that we pass and the other that is a part of the
>> eventpoll session itself, so you could be right about that. Daniel Colascione
>> may have some more thoughts about it since he brought up the possiblity of a
>> wq life-time issue. Daniel?   We were just playing it safe.

I think you (Joel) and Andy are talking about different meanings of
poll(). Joel is talking about the VFS method; Andy is talking about
the system call. ISTM that the lifetime of wait queue we give to
poll_wait needs to last through the poll. Normally the wait queue gets
pinned by the struct file that we give to poll_wait (which takes a
reference on the struct file), but the pidfd struct file doesn't pin
the struct task, so we can't use a wait queue in struct task.
(remove_wait_queue, which poll implementations call to undo wait queue
additions, takes the wait queue head we pass to poll_wait, and we
don't want to pass a dangling pointer to remove_wait_queue.) If the
lifetime requirements for the queue aren't this strict, I don't see it
documented anywhere. Besides: if we don't actually need to pin the
waitqueue lifetime for the duration of the poll, why bother taking a
reference on the polled struct file?

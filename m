Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1304A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ykqrm0ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfDTLPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:15:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46649 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfDTLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:15:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so6205206edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=533SjRzjlb4Sgec1eVhGJFFMHRXyFPupfjAINBU7ZJg=;
        b=Ykqrm0ie5C3Y53AK/O2g9e4MEi4Fz+T5k+cMCPaYqgzsV7lE2S7gXGX8Q5AKIgcY+E
         I5oZStQrpM5iHMIW5vapG/k1DSnRjfYlGWUp67gzk3hzhc+pXLyTe+SnhVb+yzb0XjyO
         VxmfMz0x0mWRNsh1NtI8QzrkmyZaLKDmsEeiAzPo1Oq4wfm1jgQTrQsUaDz7Lj+xn+eB
         Mj3ZT+RdgaK/L6ZSMU1uaoIzx6pH9Gv32ODvf68Q0+RkzTz2W4KxiLSqicWkd/7SWdUw
         WPIzgRigH6jEpWNOpUviKKsCEPhNnXeohYvGxwodBjdOpuQG0WMEogD5dHmfeZxTZ5lp
         1Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=533SjRzjlb4Sgec1eVhGJFFMHRXyFPupfjAINBU7ZJg=;
        b=P4lcbzg16LAs3qnLledCL1QpwsTtnYX8MG6/5BaublbmSBLNp5AJ3plz0ZhYzVeMCo
         W9gJCSn1A6+RO3bKsgJiCHGYYtnkAqkqYVGcfjEz3C1rQ2KJKAYxaA8nHNI+/KkPEihr
         DsYLU181E34D/X9O1Z4KDJQdWbIgbWkAcrgWypDlsOO1mzOsAgjaFwVFUgrCUzzLJ/VR
         Clb0GeYy6YcUvi3/S4ows5l/O9y+xM8V4uafGvmi1HK9j8ExReQVdHVPZ84hQruEe+sl
         hVtK08uABd9GLLtMfM2Ik7AzHb7F29iPMGdJ+at+9+6cqBB80VW9qF8wqurq554phhs6
         FHeg==
X-Gm-Message-State: APjAAAVhtqCidQE/tKHZLeImS0zpowOOg2cL0PeHoH48R9yqd0QIRwld
        90IF+2zLoGLLZgFqhKmXjoIr0w==
X-Google-Smtp-Source: APXvYqy/nNbCpOhCLhbIpfSgs72vW8SXa8mcIOGC6ppwyfj1G+JJiW/5vQZ7UJpBss3tiR7JMIzNhw==
X-Received: by 2002:a50:aa28:: with SMTP id o37mr5595181edc.121.1555758916521;
        Sat, 20 Apr 2019 04:15:16 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id r29sm2053691eda.37.2019.04.20.04.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 04:15:15 -0700 (PDT)
Date:   Sat, 20 Apr 2019 13:15:11 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190420071406.GA22257@ip-172-31-15-78>
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net> <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com> <20190420071406.GA22257@ip-172-31-15-78>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Kevin Easton <kevin@guarana.org>, Andy Lutomirski <luto@kernel.org>
CC:     Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <D2514402-C7FA-4465-8B37-6C0579F4CD84@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 20, 2019 9:14:06 AM GMT+02:00, Kevin Easton <kevin@guarana=2Eorg> =
wrote:
>On Mon, Apr 15, 2019 at 01:29:23PM -0700, Andy Lutomirski wrote:
>> On Mon, Apr 15, 2019 at 12:59 PM Aleksa Sarai <cyphar@cyphar=2Ecom>
>wrote:
>> >
>> > On 2019-04-15, Enrico Weigelt, metux IT consult <lkml@metux=2Enet>
>wrote:
>> > > > This patchset makes it possible to retrieve pid file
>descriptors at
>> > > > process creation time by introducing the new flag CLONE_PIDFD
>to the
>> > > > clone() system call as previously discussed=2E
>> > >
>> > > Sorry, for highjacking this thread, but I'm curious on what
>things to
>> > > consider when introducing new CLONE_* flags=2E
>> > >
>> > > The reason I'm asking is:
>> > >
>> > > I'm working on implementing plan9-like fs namespaces, where
>unprivileged
>> > > processes can change their own namespace at will=2E For that,
>certain
>> > > traditional unix'ish things have to be disabled, most notably
>suid=2E
>> > > As forbidding suid can be helpful in other scenarios, too, I
>thought
>> > > about making this its own feature=2E Doing that switch on clone()
>seems
>> > > a nice place for that, IMHO=2E
>> >
>> > Just spit-balling -- is no_new_privs not sufficient for this
>usecase?
>> > Not granting privileges such as setuid during execve(2) is the main
>> > point of that flag=2E
>> >
>>=20
>> I would personally *love* it if distros started setting no_new_privs
>> for basically all processes=2E  And pidfd actually gets us part of the
>> way toward a straightforward way to make sudo and su still work in a
>> no_new_privs world: su could call into a daemon that would spawn the
>> privileged task, and su would get a (read-only!) pidfd back and then
>> wait for the fd and exit=2E  I suppose that, done naively, this might
>> cause some odd effects with respect to tty handling, but I bet it's
>> solveable=2E  I suppose it would be nifty if there were a way for a
>> process, by mutual agreement, to reparent itself to an unrelated
>> process=2E
>>=20
>> Anyway, clone(2) is an enormous mess=2E  Surely the right solution here
>> is to have a whole new process creation API that takes a big,
>> extensible struct as an argument, and supports *at least* the full
>> abilities of posix_spawn() and ideally covers all the use cases for
>> fork() + do stuff + exec()=2E  It would be nifty if this API also had a
>> way to say "add no_new_privs and therefore enable extra functionality
>> that doesn't work without no_new_privs"=2E  This functionality would
>> include things like returning a future extra-privileged pidfd that
>> gives ptrace-like access=2E
>>=20
>> As basic examples, the improved process creation API should take a
>> list of dup2() operations to perform, fds to remove the O_CLOEXEC
>flag
>> from, fds to close (or, maybe even better, a list of fds to *not*
>> close), a list of rlimit changes to make, a list of signal changes to
>> make, the ability to set sid, pgrp, uid, gid (as in
>> setresuid/setresgid), the ability to do capset() operations, etc=2E=20
>The
>> posix_spawn() API, for all that it's rather complicated, covers a
>> bunch of the basics pretty well=2E
>
>The idea of a system call that takes an infinitely-extendable laundry
>list of operations to perform in kernel space seems quite inelegant, if
>only for the error-reporting reason=2E
>
>Instead, I suggest that what you'd want is a way to create a new
>embryonic process that has no address space and isn't yet schedulable=2E
>You then just need other-process-directed variants of all the normal
>setup functions - so pr_openat(pidfd, dirfd, pathname, flags, mode),
>pr_sigaction(pidfd, signum, act, oldact), pr_dup2(pidfd, oldfd, newfd)
>etc=2E
>
>Then when it's all set up you pr_execve() to kick it off=2E
>
>    - Kevin

I proposed a version of this a while back when we first started talking ab=
out this=2E

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92396C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BA623B1B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IExH9xF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEaPEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:04:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40060 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:04:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id r136so7937920oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXYHNNdG0hpclNTxi1QRvbMWEZubUS++95q9sjYB+HQ=;
        b=IExH9xF7UHvi1nlTJlWjFsUTXKPL+B2FBmcMB+NSeW27TbNnK8p+4BAhn0Fh4CDKKG
         nehQZIPgGkLzntp8bhMuMEjHSfsv4nB3lzYus2BpTq2xPTr2I5suFnwaJGWwto9zImxO
         1GIBoeWNyNRA0Aqtnjy1JHhzBR2d+7Tr3UvDUZNyZnxNSLxg7lDmdyw1JguzSj8GzgtG
         AvGu9lKj8Kbz0ttZiOGwsRAwDlqobptRCyaIvc4U1AmwgZV27BQPxdhwkj1+3Iaqa8XL
         u2RENfSnwp/xA89ZNfyksq/4vmrr1A4qB4sF6e/+XU7Ngz4rQIp+HUaFOG+aUkYHxG48
         aibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXYHNNdG0hpclNTxi1QRvbMWEZubUS++95q9sjYB+HQ=;
        b=E8nKm1mccdYLNw6bRz8X12IjFFwnC/HmNy9qE0UDO5s6i7VDEafiqaUpFiZUBiSIRn
         DdT7n/9g3MeB+fBsvcQe59s+ihqJN8gBRCdtQl/UDfPSkzyZuuCuVs13O1lg/cbMPk/k
         0Q7Cr2lizdaLm67Zl3ymE+bRxWFSF+l+e5Hl2PU5hh1Pc1rz/umroLe4Z8svyUn01KDd
         y/+2FnyeV+J2xy8ok5MpoVMAlB+SkdDlBSLRvkHHetQNcqYqyQVR52xnrdBik3TN/Eow
         J+FqCeAltlBo4GEXordBKUaMB87C5okiDg8w+tssPDqG+MD1WEMXkvUyZR0ghBPGpabq
         6DJQ==
X-Gm-Message-State: APjAAAW07Guba2BHYZwCIFJCvMiHvZ/EbOwMlWhSsvLzwXzQMjtc8Y9N
        suh/Nx6+MdQ7LnqSoBiwNEudpOsEIkWYLYTLz7cvLw==
X-Google-Smtp-Source: APXvYqx5/9x76dr3UevTiL7kdfrFuK/Vonkoaw1nviIufEMW5gCt6elT7kv16G57lZ1Pbeqbg4fzXICN2z2qBqfyK9k=
X-Received: by 2002:aca:f308:: with SMTP id r8mr6467543oih.39.1559315081040;
 Fri, 31 May 2019 08:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com> <87ef4gzpjw.fsf@xmission.com>
In-Reply-To: <87ef4gzpjw.fsf@xmission.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 May 2019 17:04:14 +0200
Message-ID: <CAG48ez2kc0ed8BuoAeffKv5dq2KQtfWt6rzt9nbvM04J2nrswQ@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 3:42 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > I'm actually trying to get rid of the ->mm access in
> > __ptrace_may_access() entirely by moving the dumpability and the
> > user_ns into the signal_struct, but I don't have patches for that
> > ready (yet).
>
> Do you have a plan for dealing with old linux-threads style threads
> where you have two processes that share the same mm, but have different
> signal_structs.

Oh, I hadn't realized that linux-threads exists and uses this feature...

> I don't think it is required to share any other structures except
> mm_struct when you share mm_struct.  Maybe sighand_struct.
>
> Not to derail your idea.  Only needing to look at signal_struct sounds
> very nice.  I just know we have some other somewhat bizarre cases the
> kernel still supports.

My line of thought was that conceptually, dumpability doesn't have
much to do with the mm_struct. Dumpability has the following purposes,
as far as I know:


1. Prevent the creation of core dumps with elevated privileges in
attacker-specified locations (if the core_pattern is a relative path).
This could happen in the following scenarios:
1a) setuid executable crashes with elevated privileges (dumpability is
reduced in setup_new_exec() on privileged execve() for this reason)
1b) a privileged process is deliberately sharing its fs_struct with an
attacker-controlled one
2. Prevent reading the memory of processes that are running
execute-only binaries [*] (dumpability is reduced in would_dump() on
execve() for this reason)
3. Prevent ptrace-attaching (and similar forms of access) against
formerly-privileged processes that have dropped UID/GID/caps
privileges, but still have some other form of privilege left (e.g.
file descriptors). Similarly, prevent reading process memory after a
privilege transition by triggering a core dump.

For numbers 1a and 2, it doesn't matter on which level the flag is -
during execve, the signal_struct and the new mm_struct are both not
shared, so the effect is the same.

For number 1b, you're probably not sharing the mm_struct, so either
way the privileged process needs to mark itself as nondumpable or
already be nondumpable for some reason. (I think I know a single
example where this actually happens, and that one's a setuid helper,
so it's nondumpable from the start anyway.)

For number 3, when the kernel automatically marks a process as
nondumpable during commit_creds(), I don't think it matters for
security on which level that change happens, whether it's on the task
level, the signal_struct level, or the mm_struct level, since you can
only attach to a task that has itself gone through the
privilege-dropping process - in other words, as long as the scope of
the dumpability flag includes the scope of the credentials (which is
per-task), it should be fine. I think the behavior actually makes more
sense here if it happens on the signal_struct level - for number 3, if
one process with shared mm drops privileges, that is irrelevant for
other processes sharing the mm, since they remain inaccessible until
they also go through a similar credential change.


For manual control of the dumpability through PR_SET_DUMPABLE, the
prctl(2) manpage says that dumpability is a property of "the process",
which is the same wording that is also used for per-task properties
and at least one per-thread-group property in there; so I was hoping
that I could get away with just fudging the semantics so that
PR_SET_DUMPABLE only affects the thread group. In case someone tells
me that I can't do that because it would break something, my backup
plan was to do something really ugly in PR_SET_DUMPABLE, similar to
what zap_threads() and __set_oom_adj() do, like this:

if (refcount_read(current->signal->sigcnt) != 1) {
  for_each_process(p) {
    if (READ_ONCE(p->mm) != current->mm)
      continue;
    task_lock(p);
    if (p->mm == current->mm)
      WRITE_ONCE(p->signal->dumpable, dumpable);
    task_unlock(p);
  }
}

But I'd really like to avoid that, because it makes the code messier,
slower, and in my opinion, less logical.


The reason why I want to make this change is that I think the current
fail-open behavior of __ptrace_may_access() for a process whose
mm_struct has gone away is dangerous; but I also don't want to just
make it fail-closed. So I have to shove the dumpability information
somewhere else (or muck around with the mm_struct's lifetime, but I'd
like to avoid that).


[*]: That doesn't really work though, does it? I don't think anything
prevents running an execute-only program in a task that already has a
ptracer attached to it. And for dynamically-linked binaries, I think
you can probably still create a new user namespace, do chroot() in
there, and then the kernel will resolve the absolute path to the ELF
loader inside the chroot(), and then your own fake ELF loader can dump
the binary. And I don't think the AT_SECURE flag gets set, so you can
use LD_PRELOAD or whatever.

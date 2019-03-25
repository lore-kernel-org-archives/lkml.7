Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38A720896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aK36mWuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfCYRHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:07:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34323 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:07:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id k21so7361100otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ch0OV8M6YIOdvxGSuNdwcBPWv9lI9ZbSET9AOYgpngk=;
        b=aK36mWuyy7U2IzOrTKhxNE0jv33D60E916JjlH1Q8RnlFqE47j7AD/MyW/LbtIjrBc
         kNE10U0rZefp/vwJdDM1xIlYmhRcEjFDRhmiZZKrdtkNTF8Hyz7fANxqIhvWMJqhskb+
         nSDqydw0yVmuI4eR39iMUMlKrKTXDqSGE9TMsFyrArAzfGPIpM5RPcM5Lpbx4cIN9rW6
         tMAf7HcPhILqnZMuXsThbaP0vyh/YZzvYYoavJUFkmPRpaQpCSoqqlGquIcwmmODPXWQ
         JpB6P2V0TOxnF1pdxfoK3lpKkJtGUgQVTsPapYRhGp9rPRmE8+eOm4duu6Kpqdb3gPE7
         9PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ch0OV8M6YIOdvxGSuNdwcBPWv9lI9ZbSET9AOYgpngk=;
        b=g+uk64Wkl5V/7HO4mSJItVISz0Mdrlo/qZddj+y8b5IDDMwdD+oKgIQ4PPpD9Dg7xH
         NvZLcwKAore6RCg9F6JzNTAvC0kPSmUa4Y9Gznkr1jwYLDrbbUaKoRcHXtwXFj8F3oMG
         EJrWZB6x7afMDKyk838kkKNTODewrkptPH/2xJeII1liehhFrwUUTXDfPP9Hzse1oS5b
         rzWDyUO3Vf+0I1tf+ZMvS4qADYurXXUg5l4ozVImwj+65cInPP1Zqy6nQPmMqMiOED9k
         1l3OFGF1dvXDi2Cn5t1R9Yg2JB6+D0+GmDcb9eNOPRQ6jUBkEUaOU6RVtY90FT0Y4nDe
         I9Xw==
X-Gm-Message-State: APjAAAWlvxnnU05Fg8OTff5RV3z8XNsm4ORhEnrvjvWchoKbzBHpFkV+
        B3QwoFpCPOLkt00MVexzPh9o99YbePmnwHNqd6FSeg==
X-Google-Smtp-Source: APXvYqy1ji806IKUqp7ButNeJYaaAa+C5ILGIortk3vFX+HE4b3xuriYquNT6nVWhQP6xL9lD3ijm7091p6/Ti175H0=
X-Received: by 2002:a9d:130:: with SMTP id 45mr18226340otu.352.1553533656121;
 Mon, 25 Mar 2019 10:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <8075dfac-94d2-b8c5-e37a-afe9b88bb48e@yandex-team.ru>
In-Reply-To: <8075dfac-94d2-b8c5-e37a-afe9b88bb48e@yandex-team.ru>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 10:07:22 -0700
Message-ID: <CAKOZuestyk-mMFujBK7i=uqTcSGOReP5SZVmSH7Hp2iKqBDMBQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:05 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> On 25.03.2019 19:48, Daniel Colascione wrote:
> > On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> >> The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> >> I quote Konstantins original patchset first that has already been acked and
> >> picked up by Eric before and whose functionality is preserved in this
> >> syscall. Multiple people have asked when this patchset will be sent in
> >> for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> >> Muthusamy from Oracle [3].
> >>
> >> The intention of the original translate_pid() syscall was twofold:
> >> 1. Provide translation of pids between pid namespaces
> >> 2. Provide implicit pid namespace introspection
> >>
> >> Both functionalities are preserved. The latter task has been improved
> >> upon though. In the original version of the pachset passing pid as 1
> >> would allow to deterimine the relationship between the pid namespaces.
> >> This is inherhently racy. If pid 1 inside a pid namespace has died it
> >> would report false negatives. For example, if pid 1 inside of the target
> >> pid namespace already died, it would report that the target pid
> >> namespace cannot be reached from the source pid namespace because it
> >> couldn't find the pid inside of the target pid namespace and thus
> >> falsely report to the user that the two pid namespaces are not related.
> >> This problem is simple to avoid. In the new version we simply walk the
> >> list of ancestors and check whether the namespace are related to each
> >> other. By doing it this way we can reliably report what the relationship
> >> between two pid namespace file descriptors looks like.
> >>
> >> Additionally, this syscall has been extended to allow the retrieval of
> >> pidfds independent of procfs. These pidfds can e.g. be used with the new
> >> pidfd_send_signal() syscall we recently merged. The ability to retrieve
> >> pidfds independent of procfs had already been requested in the
> >> pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> >> [5]. A use-case where a kernel is compiled without procfs but where
> >> pidfds are still useful has been outlined by Andy in [6]. Regular
> >> anon-inode based file descriptors are used that stash a reference to
> >> struct pid in file->private_data and drop that reference on close.
> >>
> >> With this translate_pid() has three closely related but still distinct
> >> functionalities. To clarify the semantics and to make it easier for
> >> userspace to use the syscall it has:
> >> - gained a command argument and three commands clearly reflecting the
> >>    distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
> >>    PIDCMD_GET_PIDFD).
> >> - been renamed to pidctl()
> >
> > Having made these changes, you've built a general-purpose command
> > command multiplexer, not one operation that happens to be flexible.
> > The general-purpose command multiplexer is a common antipattern:
> > multiplexers make it hard to talk about different kernel-provided
> > operations using the common vocabulary we use to distinguish
> > kernel-related operations, the system call number. socketcall, for
> > example, turned out to be cumbersome for users like SELinux policy
> > writers. People had to do work work later to split socketcall into
> > fine-grained system calls. Please split the pidctl system call so that
> > the design is clean from the start and we avoid work later. System
> > calls are cheap.
> >
> > Also, I'm still confused about how metadata access is supposed to work
> > for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
> > You snipped out a portion of a previous email in which I asked about
> > your thoughts on this question. With the PIDCMD_GET_PIDFD command in
> > place, we have two different kinds of file descriptors for processes,
> > one derived from procfs and one that's independent. The former works
> > with openat(2). The latter does not. To be very specific; if I'm
> > writing a function that accepts a pidfd and I get a pidfd that comes
> > from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
> > smaps or oom_score_adj or statm for the named process in a race-free
> > manner?
> >
>
> Task metadata could be exposed via "pages" identified by offset:
>
> struct pidfd_stats stats;
>
> pread(pidfd, &stats, sizeof(stats), PIDFD_STATS_OFFSET);
>
> I'm not sure that we need yet another binary procfs.
> But it will be faster than current text-based for sure.

There are many options. I have some detailed thoughts on several of
them, but long design emails seem rather unwelcome. Right now, I'd
like to hear how Christian intends his patch set to address this use
case.

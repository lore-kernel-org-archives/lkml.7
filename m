Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D61C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727D2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="O1zkMvcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfCaPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:05:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35165 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbfCaPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:05:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so5960893edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cx/zd+U/8YS2qou0yunnQnhx/UfblkUNvc4Sl4wgWN8=;
        b=O1zkMvcrI7fTOdPOTtQHaCUXerCTga3w4DS60QWjQkC84PlygawGAcdDL3Uj9UWEwt
         UocA8Q9+C2MPyYvewlOZnz84H9sltqZehk8lFXi0SZcQBfnWxReusZO1YeH+/Jwu5I1y
         G2e1kXAzeoMaaOFUJBYS4nRI/mZIf8ovGlyhGCrwpbNVF7nwqcmW9zVHFyWNbl9XP9xt
         Emkzmz73fUZo0r7wUGck5Xv+kK4u7HVbgl2atf6iIrqm/bb71Q8nTSAnUVWNeQAJmfhQ
         tVIOgHrW5mXAjE80KcA5mYSeVQJzs1w6QBk0+RCWOxow2PPFPvap7v7MeIAxbeVavWg2
         8tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cx/zd+U/8YS2qou0yunnQnhx/UfblkUNvc4Sl4wgWN8=;
        b=sLtW8fIT9wq9Bq8IDITnG0Lhc3fhqwpmaHAd6129EMufvSclj3xPA5ZDqMp6jytxs2
         B4eteMLFyVTzjf+k/9LBkt0b8J0WIuDO/e5B+CSx5Mk/xm81RH1phOi2FworqLhE1R7i
         7JvTguE0AnfmLRe5tOkjn3EnEksXWBkGxHw8dxJK+kEMd3aAMGlyCB8SUPxNLir/6z0k
         0pY+OP/XQHOoFh869rREEegb/tMRXG5wNAo08N7Rfy6l31iMwui0reiorPEzWXSTeI1W
         GOjprAGnhuwTGhzw6fvxsqcvypkwGH+6Y/e70GwbJe1wgbHW1BMN0qNgt+MvcGhk4SHv
         v/xQ==
X-Gm-Message-State: APjAAAVwPZH4bkmL8UKcBwHQBdlmOkqxjbU7iMq7AwIk14ARudX3Z9Nv
        x/MTzuCkMvTdOC9fuKBVx8Mbkg==
X-Google-Smtp-Source: APXvYqxloP8NpyPZHiMoqXBeDX6UcnUoTtmUPrcpxNWYUxX8/UIj+mlQ63h15YvbEbYXX0osD+IAJg==
X-Received: by 2002:a50:aa0f:: with SMTP id o15mr39115103edc.129.1554044710805;
        Sun, 31 Mar 2019 08:05:10 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id v35sm2375522edm.14.2019.03.31.08.05.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 08:05:10 -0700 (PDT)
Date:   Sun, 31 Mar 2019 17:05:08 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190331150507.zpyugdvtmr6rgpda@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
 <20190331010716.GA189578@google.com>
 <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
 <20190331040810.GB189578@google.com>
 <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
 <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 07:52:28AM -0700, Linus Torvalds wrote:
> On Sat, Mar 30, 2019 at 9:47 PM Jann Horn <jannh@google.com> wrote:
> >
> > Sure, given a pidfd_clone() syscall, as long as the parent of the
> > process is giving you a pidfd for it and you don't have to deal with
> > grandchildren created by fork() calls outside your control, that
> > works.
> 
> Don't do pidfd_clone() and pidfd_wait().
> 
> Both of those existing system calls already get a "flags" argument.
> Just make a WPIDFD (for waitid) and CLONE_PIDFD (for clone) bit, and
> make the existing system calls just take/return a pidfd.

Yes, that's one of the options I was considering but was afraid of
pitching it because of the very massive opposition I got
regarding"multiplexers". I'm perfectly happy with doing it this way.

> 
> Side note: we could (should?) also make the default maxpid just be
> larger. It needs to fit in an 'int', but MAXINT instead of 65535 would
> likely alreadt make a lot of these attacks harder.

Yes, agreed.

> 
> There was some really old legacy reason why we actually limited it to
> 65535 originally.  It was old and crufty even back when..

So Jann and I have been thinking about going forward with the following
idea:
With the pidfd_open() patchset I have pidfds are simple anone inode file
descriptors stashing a reference to struct pid of a process. I have
mentioned this is in prior mails. This cleanly decouples pidfds from
procfs completely.
The reason why we want to use pidfds with no connection to a specific procfs
instance, even in environments that have procfs, is that we would like to add
the API to clone with CLONE_PIDFD that you just mentioned that creates a
new process or thread and returns a pidfd to it. In the context of such
a syscall, it would be awkward to have the kernel open a file in some
procfs instance, since then userspace would have to specify which procfs
instance the fd should come from.

There is an argument to be made that for consistency's sake we should - although
I don't feel strongly about it - disallow the usage of pidfd_send_signal() with
fds referring to /proc/<pid> then. Unless you want this to always work. If you
want this to work then we would simply submit pidfd_open() for the 5.2
window. If you agree that it makes sense to only have pidfd_open() file
descriptors working with pidfd_send_signal() we would send a revert for
pidfd_send_signal() now and resubmit it together with pidfd_open()
during the 5.2. merge window. This decouples pidfds completely from
procfs not just when it is not compiled in or mounted.

I very much care about this being done right. If this means temporarily
kicking pidfd_send_signal() out until 5.2 I'm happy to do so.

Btw, the /proc/<pid> race issue that is mentioned constantly is simply
avoidable by placing the pid that the pidfd has stashed relative to the
callers' procfs mount's pid namespace in the pidfd's fdinfo. So there's
not even a need to really go through /proc/<pid> in the first place. A
caller wanting to get metadata access and avoid a race with pid
recycling can then simply do:

int pidfd = pidfd_open(pid, 0);
int pid = parse_fdinfo("/proc/self/fdinfo/<pidfd>");
int procpidfd = open("/proc/<pid>", ...);

/* Test if process still exists by sending signal 0 through our pidfd. */
int ret = pidfd_send_signal(pid, 0, NULL, PIDFD_SIGNAL_THREAD);
if (ret < 0 && errno == ESRCH) {
        /* pid has been recycled and procpidfd refers to another process */
}

Christian

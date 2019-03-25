Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CBD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UjRYBYPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfCYUPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:15:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfCYUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:15:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so8225750wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmLdD6aJLXTMFnFYFxgdKx7drqQI0DUv3LXX8YeW5HM=;
        b=UjRYBYPl/y6EKhZTkg3gFWY2ZlKNZ3HAN5z57fjgYnzPpK/BI2eKLPRO0x69WePelJ
         YvheQEdPQ0VL7n9XrI6QZ3uWHRdKKtIXme2zP5E/I4C9X7gyn893a+N31RU7cvN+OzFM
         I0GE230OkPzvP4HFt2yVyJQdZlkMnBbxXtUjRgYXE30kRckPiLwcL9/yFTGS3w2upOhy
         lr2UsevLXf1QTUaK6Vstm4ztPFojfNrqaEJO/gqXtC1bKSJxFEj8hhR6NXj+lI44NYBD
         H+BMsUFTX9NOgDZc0draoLTBnTD9r7Yi1qcVWrh2fRrfYBXqZB1yudsKSfqBBAGVH8EI
         52lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmLdD6aJLXTMFnFYFxgdKx7drqQI0DUv3LXX8YeW5HM=;
        b=sGWc5gjJGNj6yyjZO0AwdcX8zsyNNb3RrjtWMtOzmcr7kln/9/JlYMPr516mSA9Ftj
         djc86CKn27eMgdQc4soxh19vfARubewkg/rEPmsnfuhiykMyJeMKUWKYg8OJbVYAeNCu
         Kd0/D1zMJNwDZS/c5Bo2uU+KrDw7Zifyb1NQWv9dkjClfeslAUGIME719HyB36iT8bc0
         p+fCVL+wewYRujHm7WZEBJbpUzEDvlRbrzGCj8vQD1Y4wYD+0EgJPFbjJuMR83jkmZOH
         XGPTMBH+QTlrws9DFD84Ub9HGTCDvO3Qpyqi5TV9DhtSUjnJ1j5AYVSf5NY0n7y5YwSN
         iy5w==
X-Gm-Message-State: APjAAAUJ5D0262JnWvw3nXyNWoAsnjL0jL4SAoRmIG22Hh5D4Uxdp4yO
        aj27KRx6gcXyiUrTaLX+35UpEw==
X-Google-Smtp-Source: APXvYqw8PZdvAaiYs0Mi2qfw9679nAJ1+9rH4hODGkcGMQFT/f51lu0ceC2iLYTSXDhpXEsqNTf1nA==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr16356346wrq.280.1553544947701;
        Mon, 25 Mar 2019 13:15:47 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id s2sm2180347wmc.7.2019.03.25.13.15.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:15:47 -0700 (PDT)
Date:   Mon, 25 Mar 2019 21:15:45 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>, khlebnikov@yandex-team.ru,
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
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] pid: add pidctl()
Message-ID: <20190325201544.7o2kwuie3infcblp@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325173614.GB25975@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:36:14PM -0400, Joel Fernandes wrote:
> On Mon, Mar 25, 2019 at 09:48:43AM -0700, Daniel Colascione wrote:
> > On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > I quote Konstantins original patchset first that has already been acked and
> > > picked up by Eric before and whose functionality is preserved in this
> > > syscall. Multiple people have asked when this patchset will be sent in
> > > for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> > > Muthusamy from Oracle [3].
> > >
> > > The intention of the original translate_pid() syscall was twofold:
> > > 1. Provide translation of pids between pid namespaces
> > > 2. Provide implicit pid namespace introspection
> > >
> > > Both functionalities are preserved. The latter task has been improved
> > > upon though. In the original version of the pachset passing pid as 1
> > > would allow to deterimine the relationship between the pid namespaces.
> > > This is inherhently racy. If pid 1 inside a pid namespace has died it
> > > would report false negatives. For example, if pid 1 inside of the target
> > > pid namespace already died, it would report that the target pid
> > > namespace cannot be reached from the source pid namespace because it
> > > couldn't find the pid inside of the target pid namespace and thus
> > > falsely report to the user that the two pid namespaces are not related.
> > > This problem is simple to avoid. In the new version we simply walk the
> > > list of ancestors and check whether the namespace are related to each
> > > other. By doing it this way we can reliably report what the relationship
> > > between two pid namespace file descriptors looks like.
> > >
> > > Additionally, this syscall has been extended to allow the retrieval of
> > > pidfds independent of procfs. These pidfds can e.g. be used with the new
> > > pidfd_send_signal() syscall we recently merged. The ability to retrieve
> > > pidfds independent of procfs had already been requested in the
> > > pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> > > [5]. A use-case where a kernel is compiled without procfs but where
> > > pidfds are still useful has been outlined by Andy in [6]. Regular
> > > anon-inode based file descriptors are used that stash a reference to
> > > struct pid in file->private_data and drop that reference on close.
> > >
> > > With this translate_pid() has three closely related but still distinct
> > > functionalities. To clarify the semantics and to make it easier for
> > > userspace to use the syscall it has:
> > > - gained a command argument and three commands clearly reflecting the
> > >   distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
> > >   PIDCMD_GET_PIDFD).
> > > - been renamed to pidctl()
> > 
> [snip]
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
> 
> This is true, that such usecase will not be supportable.  But the advantage
> on the other hand, is that suchs "pidfd" can be made pollable or readable in
> the future. Potentially allowing us to return exit status without a new
> syscall (?). And we can add IOCTLs to the pidfd descriptor which we cannot do
> with proc.
> 
> But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> can be translated into a "pidfd" using another syscall or even a node, like
> /proc/pid/handle or something. I think this is what Christian suggested in
> the previous threads.

Andy - and Jann who I just talked to - have proposed solutions for this.
Jann's idea is similar to what you suggested, Joel. You could e.g. do an
ioctl() handler for /proc that would give you a dirfd back for a given
pidfd. The advantage is that pidfd_clone() can then give back pidfds
without having to care in what procfs the process is supposed to live.
That makes things a lot easier. But pidfds for the general case should
be anon inodes. It's clean, it's simple and it is way more secure.

> 
> And also for the translation the other way, add a syscall or modify
> translate_fd or something, to covert a anon_inode pidfd into a /proc/pid
> directory fd. Then the user is welcomed to do openat(2) on _that_ directory fd.
> Then we modify pidfd_send_signal to only send signals to pure pidfd fds, not
> to /proc/pid directory fds.
> 
> Should we work on patches for these? Please let us know if this idea makes
> sense and thanks a lot for adding us to the review as well.
> 
> Best,
> 
>  - Joel

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30420848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rar45WNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfCYVTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:19:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34779 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:19:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so3879838oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clu/v+zScTurikdYCiWf9MTkrZ/GFufqbrLsyaOq414=;
        b=rar45WNefs+TXaTTfwdsdmj73Z7TpHlqGu2uFxDRzuIsoeWCZ5gq+6wBXMHRiMyjvy
         +xhGjxaaB7QRSwHyjg3fA0qoIJQG6/PZwSsAEyokXdZw9WGZV9DkpWFxi2Ohk9saQZ+o
         zmYNU31J9z/GRuoGjtmyjEp04Ap0vKVloSNU9ZQ1moRdwXw+XgcZVHWjURMrmFqvSEk0
         ttvQPOZAPX+Pu80KtNRZbtWrcgJdvTqbekahwH9tpj6sjKG6sbs5WClsdYttgyX7Rw88
         PnmROPeTHpaiV62S9dUM8HeJVnR5ygSPYdPOsQjo709Zd2oUxrpypISvwrponHehgAd+
         fFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clu/v+zScTurikdYCiWf9MTkrZ/GFufqbrLsyaOq414=;
        b=pulLjKrB6uW5NcxcVI+xiEHEa5Ry0r3odChltIUBQjQnWz6FNIWsu1tu4OzlbCmMsa
         mll08E/uqOsXtgHnRuub/fflYQ2ZXtgCACfMhWjhWkw7tnz8tcc/7Drt/PkL+BX7Rcn0
         TdV0xgyZnI0d/J2Ag83MCI5z1KeGye4mQK0ZxTT9GnUdpPrPW7BSu9tk30kpGQa2bMcw
         +BIVRozUm2fwOd5v5gEU7kQ+gjOTezHQ91ogXdhUqN6EZcQTOJtS2w+AF2kNdt/w1YxV
         AcGzOl2kDqUdItQZMxalO4VlDlTZqDSLE4FgK/T2aipNYhFeQIwUW9VqtJH7E9/B5rHn
         HWUg==
X-Gm-Message-State: APjAAAXcZbmjCSQQH28OkWAG166uMGcMrlnnlraMvqVJCjHeSH1xqY/u
        +KmKjAAvMrN4rOqsc8psZyEAeODNHDqn2R7DXyTFrQ==
X-Google-Smtp-Source: APXvYqzuvoXzFCrMLQ2O7+nRmjaaIKDPp6IF7eSE5cF1XYQz892y+Neya0QFg0l7a/xwCrBRfjcKVXR1O3AUX2h7EBU=
X-Received: by 2002:aca:47d4:: with SMTP id u203mr13426750oia.175.1553548792584;
 Mon, 25 Mar 2019 14:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <20190325201544.7o2kwuie3infcblp@brauner.io>
 <20190325211132.GA6494@google.com>
In-Reply-To: <20190325211132.GA6494@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Mar 2019 22:19:26 +0100
Message-ID: <CAG48ez0K9xcSf28rXOy3k0dEL3b_4b-DfcdCO=JO7vVZeJoBcA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Mar 25, 2019 at 09:15:45PM +0100, Christian Brauner wrote:
> > On Mon, Mar 25, 2019 at 01:36:14PM -0400, Joel Fernandes wrote:
> > > On Mon, Mar 25, 2019 at 09:48:43AM -0700, Daniel Colascione wrote:
> > > > On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > syscall. Multiple people have asked when this patchset will be sent in
> > > > > for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> > > > > Muthusamy from Oracle [3].
> > > > >
> > > > > The intention of the original translate_pid() syscall was twofold:
> > > > > 1. Provide translation of pids between pid namespaces
> > > > > 2. Provide implicit pid namespace introspection
> > > > >
> > > > > Both functionalities are preserved. The latter task has been improved
> > > > > upon though. In the original version of the pachset passing pid as 1
> > > > > would allow to deterimine the relationship between the pid namespaces.
> > > > > This is inherhently racy. If pid 1 inside a pid namespace has died it
> > > > > would report false negatives. For example, if pid 1 inside of the target
> > > > > pid namespace already died, it would report that the target pid
> > > > > namespace cannot be reached from the source pid namespace because it
> > > > > couldn't find the pid inside of the target pid namespace and thus
> > > > > falsely report to the user that the two pid namespaces are not related.
> > > > > This problem is simple to avoid. In the new version we simply walk the
> > > > > list of ancestors and check whether the namespace are related to each
> > > > > other. By doing it this way we can reliably report what the relationship
> > > > > between two pid namespace file descriptors looks like.
> > > > >
> > > > > Additionally, this syscall has been extended to allow the retrieval of
> > > > > pidfds independent of procfs. These pidfds can e.g. be used with the new
> > > > > pidfd_send_signal() syscall we recently merged. The ability to retrieve
> > > > > pidfds independent of procfs had already been requested in the
> > > > > pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> > > > > [5]. A use-case where a kernel is compiled without procfs but where
> > > > > pidfds are still useful has been outlined by Andy in [6]. Regular
> > > > > anon-inode based file descriptors are used that stash a reference to
> > > > > struct pid in file->private_data and drop that reference on close.
> > > > >
> > > > > With this translate_pid() has three closely related but still distinct
> > > > > functionalities. To clarify the semantics and to make it easier for
> > > > > userspace to use the syscall it has:
> > > > > - gained a command argument and three commands clearly reflecting the
> > > > >   distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
> > > > >   PIDCMD_GET_PIDFD).
> > > > > - been renamed to pidctl()
> > > >
> > > [snip]
> > > > Also, I'm still confused about how metadata access is supposed to work
> > > > for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
> > > > You snipped out a portion of a previous email in which I asked about
> > > > your thoughts on this question. With the PIDCMD_GET_PIDFD command in
> > > > place, we have two different kinds of file descriptors for processes,
> > > > one derived from procfs and one that's independent. The former works
> > > > with openat(2). The latter does not. To be very specific; if I'm
> > > > writing a function that accepts a pidfd and I get a pidfd that comes
> > > > from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
> > > > smaps or oom_score_adj or statm for the named process in a race-free
> > > > manner?
> > >
> > > This is true, that such usecase will not be supportable.  But the advantage
> > > on the other hand, is that suchs "pidfd" can be made pollable or readable in
> > > the future. Potentially allowing us to return exit status without a new
> > > syscall (?). And we can add IOCTLs to the pidfd descriptor which we cannot do
> > > with proc.
> > >
> > > But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> > > can be translated into a "pidfd" using another syscall or even a node, like
> > > /proc/pid/handle or something. I think this is what Christian suggested in
> > > the previous threads.
> >
> > Andy - and Jann who I just talked to - have proposed solutions for this.
> > Jann's idea is similar to what you suggested, Joel. You could e.g. do an
> > ioctl() handler for /proc that would give you a dirfd back for a given
> > pidfd. The advantage is that pidfd_clone() can then give back pidfds
> > without having to care in what procfs the process is supposed to live.
> > That makes things a lot easier. But pidfds for the general case should
> > be anon inodes. It's clean, it's simple and it is way more secure.
>
> That makes sense to me, it is clean and I agree let us do that.
>
> Also for the "blocking on pid exit status" usecase, instead of adding a new
> syscall like pidfd_wait, lets just make that a new IOCTL to the
> file_operations of the anon_inode pidfd file. This will lets us specify
> exactly what to wait on (wait on death or wait on zombie) and lets us avoid
> having a new syscall and create new fd just for waiting. Let me know if you
> disagree, but otherwise I am thinking of modifying my patches that way and
> avoid adding a new syscall.

But often you don't just want to wait for a single thing to happen;
you want to wait for many things at once, and react as soon as any one
of them happens. This is why the kernel has epoll and all the other
"wait for event on FD" APIs. If waiting for a process isn't possible
with fd-based APIs like epoll, users of this API have to spin up
useless helper threads.

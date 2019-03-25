Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7B82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XujgIApO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfCYVLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:11:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46801 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:11:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so7141555pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jyVHk31YoPF/20Q5gETkNpBt+MU4HAYmyq8OtbTdtbE=;
        b=XujgIApOSEtfZseoz1M3zcErPdcKCCrLv4BP40TpG23Cj2GaYdZE1VXOEneUOj8bx5
         4Z1jlWCcfCPBY64PZxVh2wSyOsDu5WnHEDexlgyD4Zt1Tt05H5V/GIW4D2+rCSXXpAQk
         vMs4lRzzz/LVsTM/KB+eS2RjDVfS+ZcVGQtg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyVHk31YoPF/20Q5gETkNpBt+MU4HAYmyq8OtbTdtbE=;
        b=o3LKofTccz+dcyNPFdSipPxBvMM+6tu5UDBDLXsG7fSubplI9qo5tZrelWzeXgb/bB
         wcik9c/kxe7yIxhPbnHg4Ob1sTGZb6b1G0UkVmaB78RNzEJEmBhdh0pKpieF1tZZBfim
         iBzicvFM6LLLlzB9N6TkfUN36XWQXi/8/zYh6Sx5FMfFO5y+YawPQ8Ih7cB5ZfzvNHZk
         2W218/8rDJ6sgaSB250kExP2dTm7AQ/qNlrvC/p3L9OA3gCfkcIrUeV7zSQHLiU3Kwao
         ppPY41054Lpx4n7ZycZZNnUMjI86IcKdcbriPCe7mPna8iYZLNYvmS8tgBTELruq85xC
         SlwA==
X-Gm-Message-State: APjAAAVtVl1QJ/y3fMHaSbcLZ4kLq3Ufqy9juMmMzdawKK5aft5aLvio
        fB7IjmPSeiLkBarKZDOzeLAGYA==
X-Google-Smtp-Source: APXvYqyfps33QIR+Ds7SxXoePmFPm1pv0rPere1h/TiyuBpMtG5M6COiil2FhTCycEffLsJ1SXnDLA==
X-Received: by 2002:a63:465b:: with SMTP id v27mr7000170pgk.165.1553548294365;
        Mon, 25 Mar 2019 14:11:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e63sm23359233pfe.120.2019.03.25.14.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:11:33 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:11:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
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
Message-ID: <20190325211132.GA6494@google.com>
References: <20190325162052.28987-1-christian@brauner.io>
 <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com>
 <20190325201544.7o2kwuie3infcblp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325201544.7o2kwuie3infcblp@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:15:45PM +0100, Christian Brauner wrote:
> On Mon, Mar 25, 2019 at 01:36:14PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 25, 2019 at 09:48:43AM -0700, Daniel Colascione wrote:
> > > On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > I quote Konstantins original patchset first that has already been acked and
> > > > picked up by Eric before and whose functionality is preserved in this
> > > > syscall. Multiple people have asked when this patchset will be sent in
> > > > for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> > > > Muthusamy from Oracle [3].
> > > >
> > > > The intention of the original translate_pid() syscall was twofold:
> > > > 1. Provide translation of pids between pid namespaces
> > > > 2. Provide implicit pid namespace introspection
> > > >
> > > > Both functionalities are preserved. The latter task has been improved
> > > > upon though. In the original version of the pachset passing pid as 1
> > > > would allow to deterimine the relationship between the pid namespaces.
> > > > This is inherhently racy. If pid 1 inside a pid namespace has died it
> > > > would report false negatives. For example, if pid 1 inside of the target
> > > > pid namespace already died, it would report that the target pid
> > > > namespace cannot be reached from the source pid namespace because it
> > > > couldn't find the pid inside of the target pid namespace and thus
> > > > falsely report to the user that the two pid namespaces are not related.
> > > > This problem is simple to avoid. In the new version we simply walk the
> > > > list of ancestors and check whether the namespace are related to each
> > > > other. By doing it this way we can reliably report what the relationship
> > > > between two pid namespace file descriptors looks like.
> > > >
> > > > Additionally, this syscall has been extended to allow the retrieval of
> > > > pidfds independent of procfs. These pidfds can e.g. be used with the new
> > > > pidfd_send_signal() syscall we recently merged. The ability to retrieve
> > > > pidfds independent of procfs had already been requested in the
> > > > pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> > > > [5]. A use-case where a kernel is compiled without procfs but where
> > > > pidfds are still useful has been outlined by Andy in [6]. Regular
> > > > anon-inode based file descriptors are used that stash a reference to
> > > > struct pid in file->private_data and drop that reference on close.
> > > >
> > > > With this translate_pid() has three closely related but still distinct
> > > > functionalities. To clarify the semantics and to make it easier for
> > > > userspace to use the syscall it has:
> > > > - gained a command argument and three commands clearly reflecting the
> > > >   distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
> > > >   PIDCMD_GET_PIDFD).
> > > > - been renamed to pidctl()
> > > 
> > [snip]
> > > Also, I'm still confused about how metadata access is supposed to work
> > > for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
> > > You snipped out a portion of a previous email in which I asked about
> > > your thoughts on this question. With the PIDCMD_GET_PIDFD command in
> > > place, we have two different kinds of file descriptors for processes,
> > > one derived from procfs and one that's independent. The former works
> > > with openat(2). The latter does not. To be very specific; if I'm
> > > writing a function that accepts a pidfd and I get a pidfd that comes
> > > from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
> > > smaps or oom_score_adj or statm for the named process in a race-free
> > > manner?
> > 
> > This is true, that such usecase will not be supportable.  But the advantage
> > on the other hand, is that suchs "pidfd" can be made pollable or readable in
> > the future. Potentially allowing us to return exit status without a new
> > syscall (?). And we can add IOCTLs to the pidfd descriptor which we cannot do
> > with proc.
> > 
> > But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> > can be translated into a "pidfd" using another syscall or even a node, like
> > /proc/pid/handle or something. I think this is what Christian suggested in
> > the previous threads.
> 
> Andy - and Jann who I just talked to - have proposed solutions for this.
> Jann's idea is similar to what you suggested, Joel. You could e.g. do an
> ioctl() handler for /proc that would give you a dirfd back for a given
> pidfd. The advantage is that pidfd_clone() can then give back pidfds
> without having to care in what procfs the process is supposed to live.
> That makes things a lot easier. But pidfds for the general case should
> be anon inodes. It's clean, it's simple and it is way more secure.

That makes sense to me, it is clean and I agree let us do that.

Also for the "blocking on pid exit status" usecase, instead of adding a new
syscall like pidfd_wait, lets just make that a new IOCTL to the
file_operations of the anon_inode pidfd file. This will lets us specify
exactly what to wait on (wait on death or wait on zombie) and lets us avoid
having a new syscall and create new fd just for waiting. Let me know if you
disagree, but otherwise I am thinking of modifying my patches that way and
avoid adding a new syscall.

thanks!

 - Joel


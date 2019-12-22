Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35D20733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLVUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:16:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42128 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLVUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:16:15 -0500
Received: from [172.58.30.161] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ij7e6-0002dA-FH; Sun, 22 Dec 2019 20:16:11 +0000
Date:   Sun, 22 Dec 2019 21:15:58 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <ealvarez@mozilla.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jed Davis <jld@mozilla.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] pid: Introduce pidfd_getfd syscall
Message-ID: <20191222201556.zcjceuwpel26jo37@wittgenstein>
References: <20191220232810.GA20233@ircssh-2.c.rugged-nimbus-611.internal>
 <20191222124756.o2v2zofseypnqg3t@wittgenstein>
 <CAMp4zn-x3wiYVgmoVfkA61Epfh7JoEHUn5QCpULERxLPkLoMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn-x3wiYVgmoVfkA61Epfh7JoEHUn5QCpULERxLPkLoMYA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 10:36:42AM -0800, Sargun Dhillon wrote:
> , On Sun, Dec 22, 2019 at 4:48 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Fri, Dec 20, 2019 at 11:28:13PM +0000, Sargun Dhillon wrote:
> > > This syscall allows for the retrieval of file descriptors from other
> > > processes, based on their pidfd. This is possible using ptrace, and
> > > injection of parasitic code along with using SCM_RIGHTS to move
> > > file descriptors between a tracee and a tracer. Unfortunately, ptrace
> > > comes with a high cost of requiring the process to be stopped, and
> > > breaks debuggers. This does not require stopping the process under
> > > manipulation.
> > >
> > > One reason to use this is to allow sandboxers to take actions on file
> > > descriptors on the behalf of another process. For example, this can be
> > > combined with seccomp-bpf's user notification to do on-demand fd
> > > extraction and take privileged actions. For example, it can be used
> > > to bind a socket to a privileged port.
> > >
> > > /* prototype */
> > >   /*
> > >    * pidfd_getfd_options is an extensible struct which can have options
> > >    * added to it. If options is NULL, size, and it will be ignored be
> > >    * ignored, otherwise, size should be set to sizeof(*options). If
> > >    * option is newer than the current kernel version, E2BIG will be
> > >    * returned.
> > >    */
> > >   struct pidfd_getfd_options {};
> > >   long pidfd_getfd(int pidfd, int fd, unsigned int flags,
> > >                  struct pidfd_getfd_options *options, size_t size);
> That's embarrassing. This was supposed to read:
> long pidfd_getfd(int pidfd, int fd, struct pidfd_get_options *options,
> size_t size);
> 
> >
> > The prototype advertises a flags argument but the actual
> >
> > +SYSCALL_DEFINE4(pidfd_getfd, int, pidfd, int, fd,
> > +               struct pidfd_getfd_options __user *, options, size_t, usize)
> >
> > does not have a flags argument...
> >
> > I think having a flags argument makes a lot of sense.
> >
> > I'm not sure what to think about the struct. I agree with Aleksa that
> > having an empty struct is not a great idea. From a design perspective it
> > seems very out of place. If we do a struct at all putting at least a
> > single reserved field in there might makes more sense.
> >
> > In general, I think we need to have a _concrete_ reason why putting a
> > struct versioned by size as arguments for this syscall.
> > That means we need to have at least a concrete example for a new feature
> > for this syscall where a flag would not convey enough information.
> I can think of at least two reasons we need flags:
> * Clearing cgroup flags
> * Closing the process under manipulation's FD when we fetch it.
> 
> The original reason for wanting to have two places where we can put
> flags was to have a different field for fd flags vs. call flags. I'm not sure
> there's any flags you'd want to set.
> 
> Given this, if we want to go down the route of a syscall, we should just
> leave it as a __u64 flags, and drop the pointer to the struct, if we're

I think it needs to be an unsigned int. Having a 64bit register arg is
really messy on 32bit and means you need to have a compat syscall
implementation which handles this.

Christian

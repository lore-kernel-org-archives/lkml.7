Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41D9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FF620820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440068AbfIWOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:47:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438206AbfIWOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:47:39 -0400
Received: from [172.58.27.190] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCPcd-000393-Is; Mon, 23 Sep 2019 14:47:28 +0000
Date:   Mon, 23 Sep 2019 16:47:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
Message-ID: <20190923144711.ssbrg6bdquhewo7q@wittgenstein>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <87tv939td6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tv939td6.fsf@mid.deneb.enyo.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:53:09PM +0200, Florian Weimer wrote:
> * Michael Kerrisk:
> 
> > SYNOPSIS
> >        int pidfd_open(pid_t pid, unsigned int flags);
> 
> Should this mention <sys/types.h> for pid_t?
> 
> > ERRORS
> >        EINVAL flags is not 0.
> >
> >        EINVAL pid is not valid.
> >
> >        ESRCH  The process specified by pid does not exist.
> 
> Presumably, EMFILE and ENFILE are also possible errors, and so is
> ENOMEM.

So, error codes that could surface are:
EMFILE: too many open files
ENODEV: the anon inode filesystem is not available in this kernel (unlikely)
ENOMEM: not enough memory (to allocate the backing struct file)
ENFILE: you're over the max_files limit which can be set through proc

I think that should be it.

> 
> >        A  PID  file descriptor can be monitored using poll(2), select(2),
> >        and epoll(7).  When the process that it refers to terminates,  the
> >        file descriptor indicates as readable.  Note, however, that in the
> >        current implementation, nothing can be read from the file descrip‐
> >        tor.
> 
> “is indicated as readable” or “becomes readable”?  Will reading block?
> 
> >        The  pidfd_open()  system call is the preferred way of obtaining a
> >        PID file descriptor.  The alternative is to obtain a file descrip‐
> >        tor by opening a /proc/[pid] directory.  However, the latter tech‐
> >        nique is possible only if the proc(5) file system is mounted; fur‐
> >        thermore,  the  file  descriptor  obtained in this way is not pol‐
> >        lable.
> 
> One question is whether the glibc wrapper should fall back back to the
> /proc subdirectory if it is not available.  Probably not.

No, that would not be transparent to userspace. Especially because both
fds differ in what can be done with them.

> 
> >        static
> >        int pidfd_open(pid_t pid, unsigned int flags)
> >        {
> >            return syscall(__NR_pidfd_open, pid, flags);
> >        }
> 
> Please call this function something else (not pidfd_open), so that the
> example continues to work if glibc provides the system call wrapper.

Agreed!

Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80DC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7C21707
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfEZU1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:27:48 -0400
Received: from port70.net ([81.7.13.123]:59088 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfEZU1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:27:46 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 16:27:44 EDT
Received: by port70.net (Postfix, from userid 1002)
        id 64F7EABEC0BA; Sun, 26 May 2019 22:20:42 +0200 (CEST)
Date:   Sun, 26 May 2019 22:20:42 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/2] open: add close_range()
Message-ID: <20190526202041.GO16415@port70.net>
References: <20190523154747.15162-1-christian@brauner.io>
 <20190523154747.15162-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523154747.15162-2-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner <christian@brauner.io> [2019-05-23 17:47:46 +0200]:
> This adds the close_range() syscall. It allows to efficiently close a range
> of file descriptors up to all file descriptors of a calling task.
> 
> The syscall came up in a recent discussion around the new mount API and
> making new file descriptor types cloexec by default. During this
> discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
> syscall in this manner has been requested by various people over time.
> 
> First, it helps to close all file descriptors of an exec()ing task. This
> can be done safely via (quoting Al's example from [1] verbatim):
> 
>         /* that exec is sensitive */
>         unshare(CLONE_FILES);
>         /* we don't want anything past stderr here */
>         close_range(3, ~0U);
>         execve(....);

this does not work in a hosted c implementation unless the libc
guarantees not to use libc internal fds (e.g. in execve).
(the libc cannot easily abstract fds, so the syscall abi layer
fd semantics is necessarily visible to user code.)

i think this is a new constraint for userspace runtimes.
(not entirely unreasonable though)

> The code snippet above is one way of working around the problem that file
> descriptors are not cloexec by default. This is aggravated by the fact that
> we can't just switch them over without massively regressing userspace. For
> a whole class of programs having an in-kernel method of closing all file
> descriptors is very helpful (e.g. demons, service managers, programming
> language standard libraries, container managers etc.).

was cloexec_range(a,b) considered?

> (Please note, unshare(CLONE_FILES) should only be needed if the calling
>  task is multi-threaded and shares the file descriptor table with another
>  thread in which case two threads could race with one thread allocating
>  file descriptors and the other one closing them via close_range(). For the
>  general case close_range() before the execve() is sufficient.)

assuming there is no unblocked signal handler that may open fds.

a syscall that tramples on fds not owned by the caller is ugly
(not generally safe to use and may break things if it gets used),
i don't have a better solution for fd leaks or missing cloexec,
but i think it needs more analysis how it can be used.

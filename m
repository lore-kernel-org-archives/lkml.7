Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282A7206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIeF1HgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfCYWhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:37:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45591 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfCYWhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:37:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so12332194qtv.12;
        Mon, 25 Mar 2019 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcOB96nS4s8XOc/MLIW+p+m1S26m5cC95QgoWySnH4A=;
        b=FIeF1HgC0yaAWDWvg64LvQe/xobGMFm2LpE1sptgXEsIz7OpGtCS+3ssikHBJWiT54
         mJ2K0ul6MQ9QjcZU0A5Ua+m4QLoq+BMFoDfLzBbOg8Pj+h//RliY3ZoO0MHpS0sP46e3
         RgVsP3iNheSB9kTZzeVaxMPv6BhvEZXW+lXGipvLrRNsN4YJKeCqSIeSsm9rgGrPOUC2
         QsbAP2vo9BKz1mcWcAU9uMSRAqzBpRmJSIG0+Wg+1SwGwe3AQnkfYGAV7AtEoEluecgL
         Bohb3GChKR2iYDaRQ1AdKdqWHDs1AqaJ8efJR6Vhwiebz9Dqix+Xc+I+w3HGIxsDceqv
         SpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcOB96nS4s8XOc/MLIW+p+m1S26m5cC95QgoWySnH4A=;
        b=S18N5Eh+UI1THFCPN//o+Lg+Zd5nZP+Bd3nwkQmuftSGoUj0WaC/4jYEGTF83MwCft
         dlQNeOjcr8LLW9A4YB7Wqhgo/TNEIukLYvC38mPgNfdCFCNwYWj/g1hmgDFzEUy2YRBj
         1QLnkMZYWHwxXrMZRkag7L9pderS0pSPKPHd1W/tkYWoM5ix1e65NXN8JSoHM/3POTNM
         1L8XKGgNumPCbP4W0UNK4+j2Pn7dY8vgTQffNBrg+6CmrsDqqiyk3ncKCGu4N63DijVj
         qcvSwY0ngvn+Sg7HGB45MncFBxuWxDbowc4HXDfhweHmxrgQmbP/7DNav34KqeWEb1iF
         kTuQ==
X-Gm-Message-State: APjAAAWi5j4shIvXW3/0gsj6S6aykug/LBTDMwR3pNbbhNIJqioX7hM9
        gDGrR/vlSKmskLMHPJXJ1P63dBMoBEXvtBZCnFA=
X-Google-Smtp-Source: APXvYqz5A2f4SLwhDxrQcE+sEFfXuK3Npxca5xyjnMmVq8+wHzCBvesLk3g+N/lqGSTdlJ/2mkCmDNJ7Iur3kazXUs4=
X-Received: by 2002:a0c:958d:: with SMTP id s13mr22192116qvs.205.1553553459109;
 Mon, 25 Mar 2019 15:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <20190325201544.7o2kwuie3infcblp@brauner.io>
 <20190325211132.GA6494@google.com> <CAG48ez0K9xcSf28rXOy3k0dEL3b_4b-DfcdCO=JO7vVZeJoBcA@mail.gmail.com>
 <20190325214338.GA16969@google.com> <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
 <CAKOZuetkCKKs7sWgDNL3R5GMyXyrjLf0VZsHvh92VmYkdQcBCA@mail.gmail.com>
In-Reply-To: <CAKOZuetkCKKs7sWgDNL3R5GMyXyrjLf0VZsHvh92VmYkdQcBCA@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 22:37:25 +0000
Message-ID: <CAGLj2rGi_+oh=qp=kK0fOq=AEKt5b9oHZXKCWvWPPEHPquOvSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
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

On Mon, Mar 25, 2019 at 10:07 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Mon, Mar 25, 2019 at 2:55 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> >
> > On Mon, Mar 25, 2019 at 9:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 10:19:26PM +0100, Jann Horn wrote:
> > > > On Mon, Mar 25, 2019 at 10:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > But often you don't just want to wait for a single thing to happen;
> > > > you want to wait for many things at once, and react as soon as any one
> > > > of them happens. This is why the kernel has epoll and all the other
> > > > "wait for event on FD" APIs. If waiting for a process isn't possible
> > > > with fd-based APIs like epoll, users of this API have to spin up
> > > > useless helper threads.
> > >
> > > This is true. I almost forgot about the polling requirement, sorry. So then a
> > > new syscall it is.. About what to wait for, that can be a separate parameter
> > > to pidfd_wait then.
> > >
> >
> > This introduces a time window where the process changes state between
> > "get pidfd" and "setup waitfd", it would be simpler if the pidfd
> > itself supported .poll and on termination the exit status was made
> > readable from the file descriptor.
>
> I don't see a race here. Process state moves in one direction, so
> there's no race. If you want the poll to end when a process exits and
> the process exits before you poll, the poll should finish immediately.
> If the process exits before you even create the polling FD, whatever
> creates the polling FD can fail with ESRCH, which is what usually
> happens when you try to do anything with a process that's gone. Either
> way, whatever's trying to set up the poll knows the state of the
> process and there's no possibility of a missed wakeup.
>

poll will possibly work and return immediately, but you won't be able
to read back anything, because for the kernel there will be no waiter
before you open one. If you make pidfd pollable and readable (for
parents, as an example), the poll ends immediately but there will
something to read from the fd.

> > Further, in the clone4 patchset, there was a mechanism to autoreap
> > such a process so that it does not interfere with waiting a process
> > does normally. How do you intend to handle this case if anyone except
> > the parent is wanting to *wait* on the process (a second process,
> > without reaping, so as to not disrupt any waiting in the parent), and
> > for things like libraries that finally can manage their own set of
> > process when pidfd_clone is added, by excluding this process from the
> > process's normal wait handling logic.
>
> I think that discussion is best had around pidfd_clone. pidfd waiting
> functionality shouldn't affect wait* in any way nor affect a zombie
> transition or reaping.

So this is more akin to waitfd and traditional wait* and friends, and
a single notification fd for possibly multiple children? I just wanted
to be sure one would (should) be able to use a pidfd obtained from
pidfd_clone without affecting the existing waitfd, and other
primitives. The same application's components should be able to host
their own set of children using such an API (think libraries) and
without affecting the process.

>
> > Moreover, should anyone except the parent process be allowed to open a
> > readable pidfd (or waitfd), without additional capabilities?
>
> That's a separate discussion. See
> https://lore.kernel.org/lkml/CAKOZueussVwABQaC+O9fW+MZayccvttKQZfWg0hh-cZ+1ykXig@mail.gmail.com/, where we talked about permissions extensively. Anyone can hammer on
> /proc today or hammer on kill(pid, 0) to learn about a process
> exiting, so anyone should be able to wait for a process to die --- it
> just automates what anyone can do manually. What's left is the
> question of who should be able to learn a process's exit code. As I
> mentioned in the linked email, process exit codes are public on
> FreeBSD, and the simplest option is to make them public in Linux too.

People might be using them in ways that convey information between the
parent and child something else shouldn't be able to know. They might
be relying on this assumption that it is private. I don't think
opening it up without requiring *some* privileges is safe.

Also, taking this further, if the structure being returned from a read
isn't just the exit code but something more elaborate (you have
mentioned siginfo previously), or even statistics like getrusage, I
would be concerned if anyone except those with CAP_SYS_PTRACE or so
should be able to obtain such a readable pidfd/waitfd.

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wM+w9Sr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfCYWH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:07:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34085 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfCYWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:07:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id t78so6438841vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8Kt5g0xQuiHEvUzy0l6vIAHbYuidiEQQbmDh4SgmAc=;
        b=wM+w9Sr1hH5S87yVczvVzzf9epUmzqXRJdZBqFythZ1CaODErF06WAAurwOKteG1pP
         ClsO5Uk81HU8o36HvGTOOtxnzKCyMYzA4Y+HPnsOKcBRF1DNQKcpCJYGwoSbXejpc3k7
         ovqG8HVPypDUOstY74F61CBU7ArPp7Z8dAa8XP7WRJSIslL6Su5zrfmsrT/daATfqyDs
         tdK2eFmtdt5TwDmzrUylAgOmtKYTh2yCARS/APht1QDsdCb1ZWSV9y2e8oME8mhH1mfQ
         LoZfEjgxeWLCmauCaFRavyRH/Ie74QNv+QpVUCDEuErABRNUveWUM9AQyZsGgGIPXGTc
         GfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8Kt5g0xQuiHEvUzy0l6vIAHbYuidiEQQbmDh4SgmAc=;
        b=k9Mb6nz9aj2XotCdI3gQVN9t94zfB+29tkaOtWoZjBT+pNwicbpZYUhKrG4FSAhU5p
         cyqGH46YuKVAjZPOJSNv6ezdldQl+vcnPFyqqIsTb/vFjKx0P0/MhhCeP27VIbJUycmr
         dKbbN9/eK1HiaunpRsE4L33GwxoAY7+NhchioLiRhvbtFMQvBB76wr2Y7y+21m+hqoFA
         uHYoBbk37KZ69rP4VlfRVQI3E+JGXeafMrNaBOCX4TJenkvNZF4LwF0umm+4eYtplxrl
         G4I7gcPTZhHx0pcrpSwfe/yPWmE0ZHBIjfB/CWAT0ch7VKFf9lmKxKu5lDTalwDFbk5b
         sIzg==
X-Gm-Message-State: APjAAAUsZ+tKA3zqN7NPybk66JlTloIO7spsqkBgvRJlw1jjs83FKGmT
        a6KhXv9uQdIC3CvTv9lhebKpRCZfgIfVwnwYkWKo8A==
X-Google-Smtp-Source: APXvYqyWTdF4MIo+DfkaRnU0+6h/k4fjbm4WvGAJsuIH/ZZK/OKilQ1uE4Wlr+Jheioarx5kbhu6Yu2MiRlchwC/Pxw=
X-Received: by 2002:a05:6102:18d:: with SMTP id r13mr257253vsq.171.1553551646548;
 Mon, 25 Mar 2019 15:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <20190325201544.7o2kwuie3infcblp@brauner.io>
 <20190325211132.GA6494@google.com> <CAG48ez0K9xcSf28rXOy3k0dEL3b_4b-DfcdCO=JO7vVZeJoBcA@mail.gmail.com>
 <20190325214338.GA16969@google.com> <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
In-Reply-To: <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 15:07:14 -0700
Message-ID: <CAKOZuetkCKKs7sWgDNL3R5GMyXyrjLf0VZsHvh92VmYkdQcBCA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
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

On Mon, Mar 25, 2019 at 2:55 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> On Mon, Mar 25, 2019 at 9:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Mar 25, 2019 at 10:19:26PM +0100, Jann Horn wrote:
> > > On Mon, Mar 25, 2019 at 10:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > But often you don't just want to wait for a single thing to happen;
> > > you want to wait for many things at once, and react as soon as any one
> > > of them happens. This is why the kernel has epoll and all the other
> > > "wait for event on FD" APIs. If waiting for a process isn't possible
> > > with fd-based APIs like epoll, users of this API have to spin up
> > > useless helper threads.
> >
> > This is true. I almost forgot about the polling requirement, sorry. So then a
> > new syscall it is.. About what to wait for, that can be a separate parameter
> > to pidfd_wait then.
> >
>
> This introduces a time window where the process changes state between
> "get pidfd" and "setup waitfd", it would be simpler if the pidfd
> itself supported .poll and on termination the exit status was made
> readable from the file descriptor.

I don't see a race here. Process state moves in one direction, so
there's no race. If you want the poll to end when a process exits and
the process exits before you poll, the poll should finish immediately.
If the process exits before you even create the polling FD, whatever
creates the polling FD can fail with ESRCH, which is what usually
happens when you try to do anything with a process that's gone. Either
way, whatever's trying to set up the poll knows the state of the
process and there's no possibility of a missed wakeup.

> Further, in the clone4 patchset, there was a mechanism to autoreap
> such a process so that it does not interfere with waiting a process
> does normally. How do you intend to handle this case if anyone except
> the parent is wanting to *wait* on the process (a second process,
> without reaping, so as to not disrupt any waiting in the parent), and
> for things like libraries that finally can manage their own set of
> process when pidfd_clone is added, by excluding this process from the
> process's normal wait handling logic.

I think that discussion is best had around pidfd_clone. pidfd waiting
functionality shouldn't affect wait* in any way nor affect a zombie
transition or reaping.

> Moreover, should anyone except the parent process be allowed to open a
> readable pidfd (or waitfd), without additional capabilities?

That's a separate discussion. See
https://lore.kernel.org/lkml/CAKOZueussVwABQaC+O9fW+MZayccvttKQZfWg0hh-cZ+1ykXig@mail.gmail.com/,
where we talked about permissions extensively. Anyone can hammer on
/proc today or hammer on kill(pid, 0) to learn about a process
exiting, so anyone should be able to wait for a process to die --- it
just automates what anyone can do manually. What's left is the
question of who should be able to learn a process's exit code. As I
mentioned in the linked email, process exit codes are public on
FreeBSD, and the simplest option is to make them public in Linux too.

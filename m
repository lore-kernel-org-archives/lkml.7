Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B771C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CB9206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPiDd5ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfCYVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:55:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46363 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:55:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so12215496qts.13;
        Mon, 25 Mar 2019 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEGJ5ejGA8qWSwhDIAUbXXUwBYpATKIo9SvRXHqf8B8=;
        b=HPiDd5ecaXbvBaWKSliqBzjPjyqFsrkbz2VkB+FzGMfFuDwIGbMCAFqTzoUn3jYuOS
         dBIfzhuII1Dnn5vMBpvE8HEK7dVggRMeTIjuJlvR+tdwjwbXCx7Knv888uSn77LluNar
         jVTYBJPb4rUa7JeRz3J8gZDgjSPZYXAiq6a7I0EJTr25z+E7UVEZuCXCTEgDSy01PVCi
         XU70Yf+OEmt9Ee1iI0LttBvSlz7dwIFf57iqlGy2ou9PIdTVUlztcyIGwHmAF/f9LHG2
         QqSkwe2usaKBmdHjydEQewxGCIEXnEFB4mpmlA2e9bpuvSj1aH6cCic4nf6zUWEVuwsI
         9tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEGJ5ejGA8qWSwhDIAUbXXUwBYpATKIo9SvRXHqf8B8=;
        b=FwHhJeVALlf+5Gz7et4RwjZTHsWHhm+xZOlocqsmsaftJjc3DSwtKiXwgfVYFBBMyA
         bqqs9L3w9t374caTa0ytAQLnsQERBHYTD+WR/UDxivk6jNg1YVGU1fGC/xYU8qjh+iVJ
         OeAFMTISVYW6H41Huf8f9jfEUvGbMpQkdta2vOJOObzjQ1VNLZdQeygyLZjh17qz7k0i
         M7VAhXNhfBG/+2Ue07v7WjPerJwbZ+N3gQn6IC5j94fhLtnJY5hRq9EHDkrQaITt9Q2a
         jTUh99gdiC8dihAYndwD6rWQMkYxPQ40sLNP1MaDYHNZ/bxXtitymKl7bo1TzV0zLa3A
         ecuQ==
X-Gm-Message-State: APjAAAUUSSjgM6TS3xGVHto1ytMq4JMsd8yy+FCERYFAFX3J3xZRlRUU
        lobBQE2RadQZMgNiBb6ZI29ICVfarqGYYZ1iNss=
X-Google-Smtp-Source: APXvYqzS9uhfpLN+4SW6EOIfl3NQcRQEk2PHC6xc/mDJVRLEm+Z4GPnuu5obsh2uEElH1PEmQsUDbOpHzsob/A5ATiY=
X-Received: by 2002:a0c:958d:: with SMTP id s13mr22039465qvs.205.1553550913597;
 Mon, 25 Mar 2019 14:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <20190325201544.7o2kwuie3infcblp@brauner.io>
 <20190325211132.GA6494@google.com> <CAG48ez0K9xcSf28rXOy3k0dEL3b_4b-DfcdCO=JO7vVZeJoBcA@mail.gmail.com>
 <20190325214338.GA16969@google.com>
In-Reply-To: <20190325214338.GA16969@google.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 21:54:58 +0000
Message-ID: <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
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

On Mon, Mar 25, 2019 at 9:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Mar 25, 2019 at 10:19:26PM +0100, Jann Horn wrote:
> > On Mon, Mar 25, 2019 at 10:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > But often you don't just want to wait for a single thing to happen;
> > you want to wait for many things at once, and react as soon as any one
> > of them happens. This is why the kernel has epoll and all the other
> > "wait for event on FD" APIs. If waiting for a process isn't possible
> > with fd-based APIs like epoll, users of this API have to spin up
> > useless helper threads.
>
> This is true. I almost forgot about the polling requirement, sorry. So then a
> new syscall it is.. About what to wait for, that can be a separate parameter
> to pidfd_wait then.
>

This introduces a time window where the process changes state between
"get pidfd" and "setup waitfd", it would be simpler if the pidfd
itself supported .poll and on termination the exit status was made
readable from the file descriptor.

Further, in the clone4 patchset, there was a mechanism to autoreap
such a process so that it does not interfere with waiting a process
does normally. How do you intend to handle this case if anyone except
the parent is wanting to *wait* on the process (a second process,
without reaping, so as to not disrupt any waiting in the parent), and
for things like libraries that finally can manage their own set of
process when pidfd_clone is added, by excluding this process from the
process's normal wait handling logic.

Moreover, should anyone except the parent process be allowed to open a
readable pidfd (or waitfd), without additional capabilities?

> Thanks.
>
>  - Joel
>

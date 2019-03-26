Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F14C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yq8dP6tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCZDDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:03:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40166 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCZDDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:03:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id b11so917639plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJSCE91nRq7dxmP8eW+epFcXHvqxYHPonMa2hKnFAtQ=;
        b=yq8dP6tBcCJ8vtGQy8q04TNHt7N8uSPuRg3f1Nd5rlzJVuPzCeu7LS0OwxbE03FCtf
         Izf+CdjKGS5rTmiav6Z1GwSydOd3/6SlgMYZKkr8RGH+6A6MR/fAQN8iWlPWIi9OjWXo
         eFMHL0bk8ZILwCY93M1ItFmh43pqHXus9jyH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJSCE91nRq7dxmP8eW+epFcXHvqxYHPonMa2hKnFAtQ=;
        b=L57sAX/HbWMu0Kp9Q9DGNkFxpfxm0ROZbSob5q7yfWMD+cU9S/7O5122uxuNmufHVm
         jBK9fWWlHdxkhJq9yRnScLxYxDPuzIAHjOrjfhqCGTQSHeSNUAC6qpEkTPiYaFE+LYLv
         QcqlTEvYBJQkYVK2PWQ9+VlS2cI+Pr50akG7kl1lTul0MSkJXIeJdnVw3+T9/fLUrsHe
         byTVvKDYfgYF+fO2QVPqIn4wvFMhU0Sbn4TjIRI/lNhuBPh99IGeZdIV3smS59WzLuni
         dUymqfbYmOwZwwSUwW/jdfhwcmxTBJ5mKgsEPIfLfgc2csyBqazA/UtNDVB6fkjFZkeQ
         DEbg==
X-Gm-Message-State: APjAAAUz0tYmNU6YUH/DY/1is/yCTH3gbwmqWL0DCLN7kEJTrC3a/i4G
        M7ls+FuVe6+WVzDge8/O2NlWog==
X-Google-Smtp-Source: APXvYqyERBqCnPIxFLeLa0NlCn/HwX/G6BvmOmBLkhg1oLKvE6K5B1j0yljhoJnj+H0LCGKnm6PTJg==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34mr27609815plp.302.1553569390274;
        Mon, 25 Mar 2019 20:03:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 140sm22599378pfb.55.2019.03.25.20.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 20:03:08 -0700 (PDT)
Date:   Mon, 25 Mar 2019 23:03:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
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
Subject: Re: [PATCH 0/4] pid: add pidctl()
Message-ID: <20190326030307.GA213200@google.com>
References: <20190325162052.28987-1-christian@brauner.io>
 <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com>
 <20190325201544.7o2kwuie3infcblp@brauner.io>
 <20190325211132.GA6494@google.com>
 <CAG48ez0K9xcSf28rXOy3k0dEL3b_4b-DfcdCO=JO7vVZeJoBcA@mail.gmail.com>
 <20190325214338.GA16969@google.com>
 <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLj2rEODAg+Y5D5Oxy3Gp-Yg6mqeisPnLQJ334TWSdrPW1L7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:54:58PM +0000, Jonathan Kowalski wrote:
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

It is much cleaner to add a new pidfd_wait syscall for this as discussed in
the other thread. Adding .poll directly to the pidfd would seem to complicate
the blocking configuration. Do we block until the task is a zombie or until
it is dead?  That is not possible to specify easily. Also if we need to
return other types of information from the pidfd, not just exit state, then
it is not clear whether blocking on a pidfd just purely on exit status makes
sense. It is much cleaner to add a new pidfd_wait syscall giving it a pidfd,
specify what to block on (EXIT_DEAD or EXIT_ZOMBIE or both) and then return a
wait fd that can be read/blocked and returning all the needed information on
unblock.

> Further, in the clone4 patchset, there was a mechanism to autoreap
> such a process so that it does not interfere with waiting a process
> does normally. How do you intend to handle this case if anyone except
> the parent is wanting to *wait* on the process (a second process,
> without reaping, so as to not disrupt any waiting in the parent), and
> for things like libraries that finally can manage their own set of
> process when pidfd_clone is added, by excluding this process from the
> process's normal wait handling logic.

The pidfd_wait logic being discussed does not depend on or affects the
autoreap behavior. This wait is not the traditional wait family of calls.
It is for just getting notified about reading all the exit state of a task.
Once I post the code, it will be clear. And I'll CC you..

thanks,

 - Joel


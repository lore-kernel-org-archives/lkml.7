Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223682082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="A7xIWUJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfCZRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:06:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33649 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfCZRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:06:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so11460221edg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYHIjggyJoD/vENjjLBQMxNjFW6kf2tIbNZRZn7uTMI=;
        b=A7xIWUJNfkLhdFHBA4KFdMCf+QH1kRJr4tmdo9kY4zjWCmQ5faim2AAAXvfk9G2E94
         BHvQQ1XwdbOqLXdfCP88u5c1/Omr6/2oOgRqVOTxDgopGQO6yCQ4Bq9GDly3P/U3XgYl
         ZZFs2332Lt6hAXhP6pSX5H0u4F5Ce1FIdWXscPfnBV39UN35eXLtGXOG/ZCDXz8KacTA
         mI22p8EUJjWLdAX8dLHVeo07NgYbBDYyMzMxozih1JuKwNyB9rWTMohbAgetJIbSk1IG
         wQoWXU+cOE/D7c2XjdjX20McKlYqgCFFjKrTTslk5wPLYbrxqFXYmseni0DO60R2kBAz
         nI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYHIjggyJoD/vENjjLBQMxNjFW6kf2tIbNZRZn7uTMI=;
        b=EBzvY8RXjROciHWgZZZa3LPKolX8POO3+V8OPn0bb4An+yXuWO3QU85Fp22nndEgf0
         Fjt3xn2JV/9O32uqSnTO2z6jgYFF32xpmesH4Lv1LHRMkfNSoG/HlCKUG4KlUQvLfuOz
         REJ3/CKxPU9LnLG9CFoN41c4wUI7coh9fbg52ozYfWCDTda7ZQD9PPK5TI7pZm6jH/Cy
         rxTJy4+Jhpv85O6mW1i8GQHIf7c4FzyvGOAgoUaPKuNS8p5/ToFlbopylxyD5qWFKQDt
         T4dYCNyq7P9VkasV1QuBeioTL/A1Vb3wWdYnC2T+NkYo8rcukuAqThVeWbmOoBZ8Kiq8
         IuEQ==
X-Gm-Message-State: APjAAAUCOl6xHPbluy9aYuCk44oD7exAWyY7Y0fRy1Vr3P4iHm1tDFKU
        XQxehwr3OpCRKNnm4+iyvkZZLlaR3TMgOA==
X-Google-Smtp-Source: APXvYqzKBb7pHdjLWmNGsfmS2gw0s9Xtg77YnuflZkx9kBHpP/PvHeur5WUjICkeON80cVuYfvpwHQ==
X-Received: by 2002:aa7:d945:: with SMTP id l5mr20903050eds.263.1553619961247;
        Tue, 26 Mar 2019 10:06:01 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id g41sm1303504edb.23.2019.03.26.10.05.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 10:06:00 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:05:58 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jann Horn <jannh@google.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326170557.y5fbn7lfegfllhwt@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io>
 <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io>
 <CAKOZuetcp=UPRWDkLUxLTmu-vqdN6qSmN9=0uP8MUuwyLoYfEA@mail.gmail.com>
 <20190326164354.qecuzkqz6ic2433i@brauner.io>
 <CAKOZueuXtWwC+U9-q3QG41p-fwjMxmujTUegmVkorLzFcY2-SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueuXtWwC+U9-q3QG41p-fwjMxmujTUegmVkorLzFcY2-SA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:50:28AM -0700, Daniel Colascione wrote:
> On Tue, Mar 26, 2019 at 9:44 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Tue, Mar 26, 2019 at 09:38:31AM -0700, Daniel Colascione wrote:
> > > On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > > > > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > > > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > > > > Thanks for the patch.
> > > > > > >
> > > > > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > >
> > > > > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > > > > syscall:
> > > > > > >
> > > > > > > We still haven't had a much-needed conversation about splitting this
> > > > > > > system call into smaller logical operations. It's important that we
> > > > > > > address this point before this patch is merged and becomes permanent
> > > > > > > kernel ABI.
> > > > > >
> > > > > > I don't particularly mind splitting this into an additional syscall like
> > > > > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > > > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > > > > about this rn is that it connects both apis in a single syscall
> > > > > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > > > > what other people think.
> > > > >
> > > > > There's something to be said for
> > > > >
> > > > > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> > > > >
> > > > > /* get pidfd */
> > > > > int pidfd = pidfd_open(1234, -1, 0);
> > > > >
> > > > > /* convert to procfd */
> > > > > int procfd = pidfd_open(-1, 4, 0);
> > > > >
> > > > > /* convert to pidfd */
> > > > > int pidfd = pidfd_open(4, -1, 0);
> > > >
> > > > probably rather:
> > > >
> > > > int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
> > > > int procfd = pidfd_open(-1, 4, PROCFD_TO_PIDFD);
> > > > int pidfd = pidfd_open(1234, -1, 0);
> > >
> > > These three operations look like three related but distinct functions
> > > to me, and in the second case, the "pidfd_open" name is a bit of a
> > > misnomer. IMHO, the presence of an "operation name" field in any API
> > > is usually a good indication that we're looking at a family of related
> > > APIs, not a single coherent operation.
> >
> > So I'm happy to accommodate the need for a clean api even though I
> > disagree that what we have in pidctl() is unclean.
> > But I will not start sending a pile of syscalls. There is nothing
> > necessarily wrong to group related APIs together.
> 
> In the email I sent just now, I identified several specific technical
> disadvantages arising from unnecessary grouping of system calls. We
> have historical evidence in the form of socketcall that this grouping
> tends to be regrettable. I don't recall your identifying any
> offsetting technical advantages. Did I miss something?
> 
> > By these standards the
> > new mount API would need to be like 30 different syscalls, same for
> > keyring management.
> 
> Can you please point out the problem that would arise from splitting
> the mount and keyring APIs this way? One could have made the same
> argument about grouping socket operations, and this socket-operation
> grouping ended up being a mistake.

The main reasons why I am not responding to such mails is that I don't
want long tangents about very generic issues. If you can find support
from people that prefer to split this into three separate syscalls:

pidfd_open()
pidfd_procfd()
procfd_pidfd()

I'm happy to do it this way. But it seems we can find a compromise, e.g.
by having

pidfd_open(pid_t pid, int fd, int fd, unsigned int flags)

and avoid that whole email waterfall.

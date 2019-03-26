Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A342C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07452070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALDrepSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfCZRAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:00:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35165 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:00:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id g24so2982650vki.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRcI8/8uKTsntrarZeCm/4QLIQOEcDuZ+FgBJO07Gig=;
        b=ALDrepSeckrgXbQRemVTnDKLm0K8ha8dngvze3TQJhnsGvwmf3eP9OUps0e9mYFGk5
         yvnVQORMYHgc4+t3fUnWuJ8bmSE0M3NvypWfZxRQqrLIYD4t9Km+HQLx4Oh7gC+TC+Lr
         FiCgeSmQdIdkvjz1aYWnLug2wDTJ800Dytx/CJbCRqeC5nLSqYDMjMr+pnD11qGo7UUM
         77777K250MA6yWYesbAtbz4cYokhbTqj3W0I+5kmXtss76KMp3agddUXwLbOsjel7O8E
         2aznW1gVo/dtqmhx2SmTM32x7puDYYlaQu6dYRNVxAkieXTRgyGg7Vd1HA92dEaKnvo1
         LjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRcI8/8uKTsntrarZeCm/4QLIQOEcDuZ+FgBJO07Gig=;
        b=iJpE96/VCGL5dFb818446ho2cd0I8ZBo/7D/pcfMiLwkqpXN7zD1Q5hvCIaRF21ox6
         AEeWWEIPFXk1UDZbPYkCJBypI9gzXyCdNMj+sv/RXtyREFMwzCf3858ndmwGiNsRuQro
         gTPkrTNdBmrMTse2psArVKP6ruktU42NYSJUpg9cLvoxjzjpMAR3gFUzMo9RXp64Cd1L
         feck/rn0J6kFJELbCaFiVKt7pzUDuR6nRrXPiYzjYfvKybbTLdy1b4hI083IREVgNIir
         KQ+9p+HcXxxOalEZXiFGJAfhrZjQWpuDFSVre5pknnOAg3/5FuidiEbfWNT1ecvZ4J63
         M2BA==
X-Gm-Message-State: APjAAAVU0QBam5dtiaa1h2ItuT0qMUXNVfG7oSWnZxnaopg7MC/7KaQC
        R704ecj2eoZXGs1xh6ePsmDo07GC5AxGLLqTojT/yw==
X-Google-Smtp-Source: APXvYqyZ1NrImz1MT2uiCCyAMniheo68pO7dxdabiOVdORMQgMHMMWDZJfkYUCI3VgfEj7r8MSb6EiiMDbTitENOjnY=
X-Received: by 2002:ac5:c2cb:: with SMTP id i11mr1300787vkk.51.1553619639301;
 Tue, 26 Mar 2019 10:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io> <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io> <CALCETrXdyTxJZBXR02Dd=fnZYNLxFYgiJfnJCONBK5khy7JPVQ@mail.gmail.com>
 <20190326164634.ba5dko6weazp3zyd@brauner.io>
In-Reply-To: <20190326164634.ba5dko6weazp3zyd@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 26 Mar 2019 10:00:27 -0700
Message-ID: <CAKOZuev7sSTEaOAiKjs+WKtr8uDoeSSDS__YFoZVM0nCQQh5mA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:46 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 09:42:59AM -0700, Andy Lutomirski wrote:
> > On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > > > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > > > Thanks for the patch.
> > > > > >
> > > > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > > >
> > > > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > > > syscall:
> > > > > >
> > > > > > We still haven't had a much-needed conversation about splitting this
> > > > > > system call into smaller logical operations. It's important that we
> > > > > > address this point before this patch is merged and becomes permanent
> > > > > > kernel ABI.
> > > > >
> > > > > I don't particularly mind splitting this into an additional syscall like
> > > > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > > > about this rn is that it connects both apis in a single syscall
> > > > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > > > what other people think.
> > > >
> > > > There's something to be said for
> > > >
> > > > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> > > >
> > > > /* get pidfd */
> > > > int pidfd = pidfd_open(1234, -1, 0);
> > > >
> > > > /* convert to procfd */
> > > > int procfd = pidfd_open(-1, 4, 0);
> > > >
> > > > /* convert to pidfd */
> > > > int pidfd = pidfd_open(4, -1, 0);
> > >
> > > probably rather:
> > >
> > > int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
> >
> > Do you mean:
> >
> > int procrootfd = open("/proc", O_DIRECTORY | O_RDONLY);
> > int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD);
> >
> > or do you have some other solution in mind to avoid the security problem?
>
> Yes, we need the proc root obviously. I just jotted this down.
>
> We probably would need where one of the fds can refer to the proc root.
>
> pidfd_open(pid_t, int fd, int fd, 0)

Indeed. This is precisely the pidfd-procfd translation API I proposed
in the last paragraph of [1].

[1] https://lore.kernel.org/lkml/CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com/

Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC859206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkgZ4pvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfCZQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:38:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44513 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbfCZQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:38:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so12037896otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvGMKneZDvgBoQO9WKpYlgMFSlMx0qHliuhIZ0RURuY=;
        b=WkgZ4pvBsM7OaWPPaDLIlyd6tXXTgazNDrxPXuius0S2rSNexVHijpJOs1Z4VRwYIr
         Xj2+H/gHZkMyTRmnQ7ovX2d/HVRz0kTa3uuefeUFZSdCRQFi+3kx45P6p7lvxPeJjiol
         3HUFPmD1eFFnTGSamcs23fZfyF9aWQhF8FCM4v9afH3vceQ2REW1iiU2nZmV6kGvqr9f
         4PZIGCKtXznBngmTSY1JPff+BXnqKAQa9siz4YBwZo7FJoxQkjVu8bELOPHawp7yfL1M
         MgW8Tui9d3YEQZm1AgUJ39FnNmkYVQ74bGwqtPnml7658kwKc//QsteSzQR4OVM0BQSY
         wprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvGMKneZDvgBoQO9WKpYlgMFSlMx0qHliuhIZ0RURuY=;
        b=HIzxDmr51pIhamwfdBF68fuuRdGUqan3Jr3LOSzZPz2a0jx25JjLPzklzjKMdJ3PTd
         JQ6qYFkG55PRF3nNQ/jL/XjC7TpuwXpyz1IaK0zdNsSGozLiGApqwlbax5WgyQjtqPR0
         0WOuVbATpJkYl0hqX9UCyqNuoH74ro0Z72BwscQIcCYIPq4UQGmAt2no+AkdK/RklIjm
         4vHori//Ku+haz49NLN2n/eJnYaK8CESi8VzUD5ewB7T8Il7iIP6yi24viaIUDi6FZMC
         47zJaY6N+YTU/JuHP+nuIlWPZ6JP7jlnKfKh0iGNYfIPd9PItChNtny3JJjnObAeCoWh
         tnpQ==
X-Gm-Message-State: APjAAAVDs5jiAGJR4lUOwkAp/vkOBATyWHGO2jtwmA9LNPZ0m384d+SG
        GZqS8M8w7YIRIO0rkaFOi4IYf52XpCxnrGLUjBDEcA==
X-Google-Smtp-Source: APXvYqy5X9emIhngEkEG6JE1avtQDYYfkUAZZmW+xmgFKWJuIBXoMB7pqfFk+XzuxQazNZAsz/Xh13k3U9eRETBvsUc=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr22320306oth.308.1553618323107;
 Tue, 26 Mar 2019 09:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io> <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io>
In-Reply-To: <20190326163452.uku4bgkessxzxvai@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 26 Mar 2019 09:38:31 -0700
Message-ID: <CAKOZuetcp=UPRWDkLUxLTmu-vqdN6qSmN9=0uP8MUuwyLoYfEA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > Thanks for the patch.
> > > >
> > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > syscall:
> > > >
> > > > We still haven't had a much-needed conversation about splitting this
> > > > system call into smaller logical operations. It's important that we
> > > > address this point before this patch is merged and becomes permanent
> > > > kernel ABI.
> > >
> > > I don't particularly mind splitting this into an additional syscall like
> > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > about this rn is that it connects both apis in a single syscall
> > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > what other people think.
> >
> > There's something to be said for
> >
> > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> >
> > /* get pidfd */
> > int pidfd = pidfd_open(1234, -1, 0);
> >
> > /* convert to procfd */
> > int procfd = pidfd_open(-1, 4, 0);
> >
> > /* convert to pidfd */
> > int pidfd = pidfd_open(4, -1, 0);
>
> probably rather:
>
> int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
> int procfd = pidfd_open(-1, 4, PROCFD_TO_PIDFD);
> int pidfd = pidfd_open(1234, -1, 0);

These three operations look like three related but distinct functions
to me, and in the second case, the "pidfd_open" name is a bit of a
misnomer. IMHO, the presence of an "operation name" field in any API
is usually a good indication that we're looking at a family of related
APIs, not a single coherent operation.

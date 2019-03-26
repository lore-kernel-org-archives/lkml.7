Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B26A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv7VGBCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfCZQeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:34:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37887 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbfCZQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:34:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so10445210oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faurlb/wNW6vWfzEIgf901C4vUon97CL0YpZomQpneY=;
        b=Qv7VGBCxKTz41fmcgJq7JWkQlzFJ1K5auhNzyk4BUhB5iFobsNJHXfTpTR51BVMuLf
         Lemd8P7P7ZRvi6m9XBaH8iYOe+avytUy6M1E6toWlNb+QVzgjPai7U3GNrkfms8cC2T3
         Xij1SETlKtIuwZzTeD57b8g+w7nnLCjlGuMqJrRtS5uHNv5CfV+GkSccD6lB2kzjZg6d
         W8QIJEBtkFzqATA3dlQdmsjq2eKBAsxdH7pIfq0h8H5rWLa0cHQLhe+d7KU5XFAaErAt
         jyEDFKW6LpoJzmHd0CTiYYtn9BzZJ9bJa4FQrJ8wIaNomYPpgEnBtROzNp77oxadJE+Y
         geYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faurlb/wNW6vWfzEIgf901C4vUon97CL0YpZomQpneY=;
        b=TNQXhahNCa55v3yDxRCao1l5wgMRKhOk2nErATUYPXq6mTyMjWVcOhu+r8FAv+4jDE
         n43S2l//M9PJXBBnwBlGt1CsPJNDgUkLKCv2ASNWnNjvenJbKfv+E8psplgdFizhas3t
         t8tA7RpWmaRkCxyDqyxc7KdJaUu/37QM+reBRhLXv29pOMCjlbmnrTdpwQlckokh2pIC
         HTph7CZsqFpwEQP6SejnfMZuS0/TsdSIGxCkHP4Xzjx1feSt/qstSXSpfXJw3p8NSdwX
         T/Z1WrGEiP2dIdxXkaIHs959R8U40azA9ol/WKlQ1rGu9KVuMzWsoynJj2F4AuuesPps
         /yXA==
X-Gm-Message-State: APjAAAV4W66xjT70A73DS7KgePWJ6Uw8A98SUhUF0WexgZ37gtblr2+Q
        zd1KGxMFuRRm2EcHJxKZVGDr5caOedlfxjyxDU/Jcw==
X-Google-Smtp-Source: APXvYqw9W9MbG8S5wTJ3KPOL6RkZPhDoctFi3qt47taLu+LZN9c1C/ptVZvZvD7d4YoLsFuH/mpY+W43IHe6wCLQu64=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr16517306oif.117.1553618044095;
 Tue, 26 Mar 2019 09:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com> <20190326162337.o256x7hiodu2qfyg@brauner.io>
In-Reply-To: <20190326162337.o256x7hiodu2qfyg@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 26 Mar 2019 09:33:52 -0700
Message-ID: <CAKOZueubdBMVyVg_7rmuT5KCJSvHK+FehkODkRgTmUKz0Ka_Bw@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 9:23 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > Thanks for the patch.
> >
> > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > I quote Konstantins original patchset first that has already been acked and
> > > picked up by Eric before and whose functionality is preserved in this
> > > syscall:
> >
> > We still haven't had a much-needed conversation about splitting this
> > system call into smaller logical operations. It's important that we
> > address this point before this patch is merged and becomes permanent
> > kernel ABI.
>
> I don't particularly mind splitting this into an additional syscall like
> e.g.  pidfd_open() but then we have - and yes, I know you'll say
> syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> about this rn is that it connects both apis in a single syscall
> and allows pidfd retrieval across pid namespaces. So I guess we'll see
> what other people think.

Thanks. I also appreciate a clean unification of related
functionality, but I'm concerned that this API in particular --- due
in part to its *ctl() name --- will become a catch-all facility for
doing *anything* with processes. (Granted, heavy use of a new, good,
and clean API would be a good problem to have.) This
single-system-call state of affairs would make it more awkward than
necessary to do system-call level logging (say, strace -e), enable or
disable tracing of specific operations with ftrace, apply some kinds
of SELinux policy, and so on, and the only advantage of the single
system call design that I can see right now is the logical
cleanliness.

I'd propose splitting the call, or if we can't do that, renaming it to
something else --- pidfd_query --- so that it's less likely to become
a catch-all operation holder.

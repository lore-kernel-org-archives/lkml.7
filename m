Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD3020848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQcLdfA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfCYUe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:34:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39922 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCYUe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:34:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so9357843otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epcnJRVRcwZXdSQ+iTPglDNMRevkUZIbnelduCAg4CI=;
        b=JQcLdfA5zk+hKV/2XesKq9vYN6WriVOLPAgTeMkFYqiUJakkOKoHWuS0lOfdXl7AUQ
         neRHS1hJTHTUfpuxDz33edboR36JwF4UYdGQH8TNf3Xswg3ql0XIpc5KbYclXdeI5RhP
         5LOchdkEhF2aQDEQoXxHWisRvYlMaL4M826rBCSuXGxtXXE/6xo2SzqFMW+eRaqU0QPt
         pbXdSkNGtt+JfKkCHhGT15UEJRgZKCt1iHCEhbep3xO1l2KsiXaAdaKcoZAnus23HiCb
         14y4FD++oZA2tsyjCWPMhHWLGvNkyRFPX52G1IBVdbda37dAww8Y/cEAWSdPmX6bzz86
         U7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epcnJRVRcwZXdSQ+iTPglDNMRevkUZIbnelduCAg4CI=;
        b=E30gNRkLlDBVXqxXN+pWOJFtEAuNIH5U14ta6Fn7C+etl9UPpLAohv3mzOUP4Q7uqT
         FpepiaDgmKWxl6nju1j8I0V/mDRM2QZ0XJljFnT+2kqfYdbMwaQyhCFBqzW51xdNn0nQ
         D7+We0nn4x8Qe7IAf6DaJnbjO3cUr8i7y1OQBnRfHFHKNApZzVYF4oO47+ZzEHscunnQ
         8YMh/b6nwcJcmEekYeHNwKpT/a8O2OaYrvi5pv4aYffHMUHsBfH9ucIqzrbBef0Zo1ML
         99RhW5Dh1QelNHFWW1WScYAkNXC+bSXi/XqygrqUv26/Ukh9TQPbZEbXOgEoSjXuC19q
         3PEg==
X-Gm-Message-State: APjAAAVkcGWRDJQbW19MLz6ns/OciR9L0ST959bFWDAhus7pifgS68DY
        +2X0d4ML1rRS/Db2bSfL+iKgZ4TvQ+4nnoRVMO3+YA==
X-Google-Smtp-Source: APXvYqzgCphFNrNTc11DzBHpjdZyhg1otvncX7I6pKbqFwUre5EIKczbS8KXhJMtjJRp/ql3UF2OQhUFIN02JASYyaI=
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr20490544otp.198.1553546066315;
 Mon, 25 Mar 2019 13:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
 <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
 <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com> <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com>
In-Reply-To: <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Mar 2019 21:34:00 +0100
Message-ID: <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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

On Mon, Mar 25, 2019 at 9:15 PM Daniel Colascione <dancol@google.com> wrote:
> On Mon, Mar 25, 2019 at 12:42 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> > On Mon, Mar 25, 2019 at 6:57 PM Daniel Colascione <dancol@google.com> wrote:
[...]
> > Yes, but everything in /proc is not equivalent to an attribute, or an
> > option, and depending on its configuration, you may not want to allow
> > processes to even be able to see /proc for any PIDs other than those
> > running as their own user (hidepid). This means, even if this new
> > system call is added, to respect hidepid, it must, depending on if
> > /proc is mounted (and what hidepid is set to, and what gid= is set
> > to), return EPERM, because then there is a discrepancy between how the
> > two entrypoints to acquire a process handle do access control.
>
> That's why I proposed that this translation mechanism accept a procfs
> root directory --- so you'd specify *which* procfs you want and let
> the kernel apply whatever hidepid access restrictions it wants.
[...]
> > > and 2) it's
> > > "fail unsafe": IMHO, most users in practice will skip the line marked
> > > "LIVENESS CHECK", and as a result, their code will appear to work but
> > > contain subtle race conditions. An explicit interface to translate
> > > from a (PIDFD, PROCFS_ROOT) tuple to a /proc/pid directory file
> > > descriptor would be both more efficient and fail-safe.
> > >
> > > [1] as a separate matter, it'd be nice to have a batch version of close(2).
> >
> > Since /proc is full of gunk,
>
> People keep saying /proc is bad, but I haven't seen any serious
> proposals for a clean replacement. :-)
>
> > how about adding more to it and making
> > the magic symlink of /proc/self/fd for the pidfd to lead to the dirfd
> > of the /proc entry of the process it maps to, when one uses
> > O_DIRECTORY while opening it? Otherwise, it behaves as it does today.
> > It would be equivalent to opening the proc entry with usual access
> > restrictions (and hidepid made to work) but without the races, and
> > because for processes outside your and children pid ns, it shouldn't
> > work anyway, and since they wouldn't have their entry on this procfs
> > instance, it would all just fit in nicely?
>
> Thanks. That'll work. It's a bit magical, but /proc/self/fd is magical
> anyway, so that's okay.

Please don't do that. /proc/$pid/fd refers to the set of file
descriptors the process has open, and semantically doesn't have much
to do with the identity of the process. If you want to have a procfs
directory entry for getting a pidfd, please add a new entry. (Although
I don't see the point in adding a new procfs entry for this when you
could instead have an ioctl or syscall operating on the procfs
directory fd.)

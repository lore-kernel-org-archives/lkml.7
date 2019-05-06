Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CEFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7A920675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBoBEQKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEFSiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:38:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39339 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEFSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:38:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id x16so4487403oic.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJEsU4nDrYVuZtMVVFf4WrJq7TRs9Dl+cfY2LjHeYik=;
        b=MBoBEQKfRSbHx9GOc308vRlaTuHtNlVgKaleqLz6VWU9jPubTioCuQS5bAsqlJPl70
         kLLf/a2s74wO9d7xMzl6NvPOTPL95DMI5Kd8roODkNjxkLqb+OJj7T2K9+fA3DD5YiFy
         Csn5W9HSmnaJHJQKPXJBxM2D9lac7YK6NYqM6oWR3WwnOdIdF2bxlYFtB6WOB8Re40Ge
         1pbNACljeg5BON3hEiNjZvJYjZgCF6OX3MuKJy0mXq/rO3FU0ptaX4FNkdijc4oSUknn
         hJFQ0aAo3YIZ2MKlhIfRpUSY02KuEtPwlFSu2EjYDy7zdM0tmerfOmBXnlYcrQB+zWBH
         YTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJEsU4nDrYVuZtMVVFf4WrJq7TRs9Dl+cfY2LjHeYik=;
        b=XUX1/im/B7l4Ua6J3PyxEVd1gHiT1YHdRII4/7lB+GjwSlcrUo03G/+r7ktQRXf7EN
         J8+FxT+M3o6wSoHgyrLVySZZgyOO08Oei2kWRU0m7xbzLFcPe9MA9huOj9wnMrqAuzqI
         pRNBo/arkFMiqkxMbFbo13dqnJxDvqB2r1y/seHIdrv+4XC1pOdS4ZlyYcFAm13fsuZR
         gP5YukZvBiKk3yOqzJhAMh6SxdUvfOsR7D5pmSQjVysiMvgG1tr9F6f7w2bqDvZ4T35G
         K/W/GuqX/hq5PSha3wiTW8tiP+WXNx9WI4d9M630g4whl39zANsTbLq71KKMce3q9qpD
         l6Ww==
X-Gm-Message-State: APjAAAWjybn55+45RrrBU4y7Fpd1Pb4TxCkd0k8bAK2rF38IEH4SRwzP
        xV0Ke0w50JC+rtXYGBGxQWx3fTcPGOTXetN4vZ8sxQ==
X-Google-Smtp-Source: APXvYqyRtYhLJtXFbPaT/4axbLHrLss+1Ssr+PITeKIx+2SHq2/t5N+tRD9+558gYq8usuNGo+uYxRI39k8vizFBPt0=
X-Received: by 2002:aca:5412:: with SMTP id i18mr2217737oib.157.1557167883599;
 Mon, 06 May 2019 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
In-Reply-To: <20190506165439.9155-6-cyphar@cyphar.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 May 2019 20:37:37 +0200
Message-ID: <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 6:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> The need to be able to scope path resolution of interpreters became
> clear with one of the possible vectors used in CVE-2019-5736 (which
> most major container runtimes were vulnerable to).
>
> Naively, it might seem that openat(2) -- which supports path scoping --
> can be combined with execveat(AT_EMPTY_PATH) to trivially scope the
> binary being executed. Unfortunately, a "bad binary" (usually a symlink)
> could be written as a #!-style script with the symlink target as the
> interpreter -- which would be completely missed by just scoping the
> openat(2). An example of this being exploitable is CVE-2019-5736.
>
> In order to get around this, we need to pass down to each binfmt_*
> implementation the scoping flags requested in execveat(2). In order to
> maintain backwards-compatibility we only pass the scoping AT_* flags.
>
> To avoid breaking userspace (in the exceptionally rare cases where you
> have #!-scripts with a relative path being execveat(2)-ed with dfd !=
> AT_FDCWD), we only pass dfd down to binfmt_* if any of our new flags are
> set in execveat(2).

This seems extremely dangerous. I like the overall series, but not this patch.

> @@ -1762,6 +1774,12 @@ static int __do_execve_file(int fd, struct filename *filename,
>
>         sched_exec();
>
> +       bprm->flags = flags & (AT_XDEV | AT_NO_MAGICLINKS | AT_NO_SYMLINKS |
> +                              AT_THIS_ROOT);
[...]
> +#define AT_THIS_ROOT           0x100000 /* - Scope ".." resolution to dirfd (like chroot(2)). */

So now what happens if there is a setuid root ELF binary with program
interpreter "/lib64/ld-linux-x86-64.so.2" (like /bin/su), and an
unprivileged user runs it with execveat(..., AT_THIS_ROOT)? Is that
going to let the unprivileged user decide which interpreter the
setuid-root process should use? From a high-level perspective, opening
the interpreter should be controlled by the program that is being
loaded, not by the program that invoked it.


In my opinion, CVE-2019-5736 points out two different problems:

The big problem: The __ptrace_may_access() logic has a special-case
short-circuit for "introspection" that you can't opt out of; this
makes it possible to open things in procfs that are related to the
current process even if the credentials of the process wouldn't permit
accessing another process like it. I think the proper fix to deal with
this would be to add a prctl() flag for "set whether introspection is
allowed for this process", and if userspace has manually un-set that
flag, any introspection special-case logic would be skipped.

An additional problem: /proc/*/exe can be used to open a file for
writing; I think it may have been Andy Lutomirski who pointed out some
time ago that it would be nice if you couldn't use /proc/*/fd/* to
re-open files with more privileges, which is sort of the same thing.

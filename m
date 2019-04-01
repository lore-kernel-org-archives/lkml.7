Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A457C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB922082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN9CHwKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDAV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:58:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37010 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:58:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so6696027qkk.4;
        Mon, 01 Apr 2019 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDePpgwXcePqusDqA5Z1tklxNFAP/0zBUyt3wDwtZo0=;
        b=mN9CHwKp6/MH1hbten6BgMOla7Hk1ofRaH8Li3AJLbLI8c77gPJyWYYyH3VEc+wWGQ
         0Vwlqocvs6SQ6JWav2PDWCJOcqOXgZ5UACChwf5ZA9k9C2RSJSzWenLPbbDyk65lpq/9
         HixdNUF8qRP8jtR5KhrW6INBiAIQJ9v10Mz3tj30nmMqflWJ7Ne18EoPdSw8vQ2Oc3vx
         dmYft0RAidNsKCl0+7tXCgADrBmNt+3/oBFBxinPF6JzaLyGzju6ZbNhF+6uCk7VnUzV
         qI5TVk4+MMrNm9HB/uy8P93OlKlUHCdobHxd3D2IJlOZaatcMviaOwwdU9o+hz5YY9Qj
         iGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDePpgwXcePqusDqA5Z1tklxNFAP/0zBUyt3wDwtZo0=;
        b=c5wrYZvVoCFYu+tLdGJukYO4dDaDaCDyfOw1+sw04QvzrN4aU2p7UKJ58poxqnHTno
         kn8z0spiH1Am6DR+Vws7nrvUxbt9Jy7yHJ84AoetWbfgtl9aAuQTtzsr4CVd1YtlPPg6
         kkQY0YW4Tqe1jQjf61xdtjkw/hAgWYNEvOnccWM0AEmf9EebtzmLlYpXxbG7F0LZzU74
         It8BGM0EJA6EF9jFaMp6rDP8cysGAApb/P2jmTg94RLzvlwD9ojUxK77s175QYfaSKS7
         gkspb5Rg5Dldn4bQ4SSyodkp778lJFnRS1IfbDLSwew6ODDcQn0CUEmaMQ2oA4rcLhWq
         2ioA==
X-Gm-Message-State: APjAAAXfTjUCCPH8tjg7cuqn2fPX6GeEP0v5ARCD0nA3o+UUqKj88lLG
        UpTmvCgMGtoHg7/pyUIccy6UfMx9Ns+AwGJCVCQ=
X-Google-Smtp-Source: APXvYqwrltiWzY7iE7UAHEnGDRNJHwctZbKdZ8xmGtKvMtD3+nWlD6zLayPUama/wwpiKzPprsISn6b6VI+eDMvaslE=
X-Received: by 2002:a37:9cc1:: with SMTP id f184mr53423899qke.211.1554155887139;
 Mon, 01 Apr 2019 14:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
 <20190401194214.4rbvmwogpke3cjcx@brauner.io> <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 1 Apr 2019 22:58:04 +0100
Message-ID: <CAGLj2rFvWE6ENFyKSbZMrhqSrLjkm0YrRh2+O0LC04HmJuEY5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 12:42 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > From what I gather from this thread we are still best of with using fds
> > to /proc/<pid> as pidfds. Linus, do you agree or have I misunderstood?

You mention the race about learning the PID, PID being recycled, and
pidfd_open getting the wrong reference.

This exists with the /proc model to way. How do you propose to address this?


>
> That does seem to be the most flexible option.
>
> > Yes, we can have an internal mount option to restrict access to various
> > parts of procfs from such pidfds
>
> I suspect you'd find that other parties might want such a "restrict
> proc" mount option too, so I don't think it needs to be anything
> internal.
>
> But it would be pretty much independent of the pidfd issue, of course.
>
> > One thing is that we also need something to disable access to the
> > "/proc/<pid>/net". One option could be to give the files in "net/" an
> > ->open-handler which checks that our file->f_path.mnt is not one of our
> > special clone() mounts and if it is refuse the open.
>
> I would expect that that would be part of the "restrict proc" mount options, no?

I was thinking if some part of /proc could be split in a procpidfs,
with possibly shared code, which means with the new mount API, you
could configure a superblock with restricted views by virtue of mount
options, per task. This only gives you the view as inside /proc/<PID>,
and you might not be able to lift restrctions depending on privileges
in owning userns of the task.

Now, this would mean we keep the notion of anon inode fds as pidfds,
and on supported systems, you could configure an instance, pass the
pidfd descriptor in the fsconfig stage (David Howells demonstrated
similar support for passing user and net namespace descriptors during
superblock configuration) and also the pidns descriptor. Without
mounting the fs, the mount fd can then be used to do metadata access
passing it to openat and friends, possibly passed to others. This is
more granular than restrcting access over the entire /proc instance,
and can be adjusted per process, and since you need the pidfd's pidns
descriptor, you cannot easily cross namespace boundaries with just a
single pidfd. You can also create many variants of restricted versions
of a single task's proc directory.

The pidfd API and /proc access can be connected while also keeping
them both separate, conceptually.

There are some details but this will wound up being much more powerful
(restricting /proc as a whole is ofcourse also fine, in addition to
this). There are some details on when and how someone should be able
to do this, but is something like this up for discussion?

>
> > Basically, if you have a system without CONFIG_PROC_FS it makes sense
> > that clone gives back an anon inode file descriptor as pidfds because
> > you can still signal threads in a race-free way. But it doesn't make a
> > lot of sense to have pidfd_open() in this scenario because you can't
> > really do anything with that pidfd apart from sending signals.
>
> Well, people might want that.
>
> But realistically, everybody enables /proc support anyway. Even if you
> don't actually fully *mount* it in some restricted area, the support
> is pretty much always there in any kernel config.
>
> But yes, in general I agree that that also most likely means that a
> separate system call for "open_pidfd()" isn't worth it.
>
> Because if the main objection to /proc is that it exposes too much,
> then I think a much better option is to see how to sanely restrict the
> "too much" parts.
>
> Because I think there might be a lot of people who want a restricted
> /proc, in various container models etc.
>
>                    Linus

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7E420700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sofge5Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfCYSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:19:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40173 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:19:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so11457668qts.7;
        Mon, 25 Mar 2019 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgdsgHJcgRgphvylW+SbxQ9uq05xhpqcmxzkgd+jX0E=;
        b=sofge5ZtL5VQw+du4wHZ+O94zQO2ncoyiIJlesL72MvgBiL4hPoHl+QDzpu6fcINc+
         lHldT+O+aqNzm33dcO2HNgnJnzMaL81h6u9TYPlwqarGcU605o27ORzTPQl4oGyTGq8V
         /xncWaH/RKlAFNt46pBd16EQN2V4WRkPJmdpENQEeS3t+UbxBwEulFh7YP/uLbyVygcs
         k3NcRcMR0MIKwIGnZ3pEFeAskvGOWBf6TXCDXmQk02lKrSFCEAt4wdjpUUo+mdP9C1K+
         kLdBgfcLNKvjwvKsV7xnYeA8S6WlGesgLsWW9ZNE/++Jbo8zRRnMUpOlR0j5rPdyvcte
         y5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgdsgHJcgRgphvylW+SbxQ9uq05xhpqcmxzkgd+jX0E=;
        b=Yzt7tGca1zuOzqq1JJ3xGNqRotAlKrozlP8Ba7aHmVJTYZqICJQkTQHXleejBrVGKc
         8ip0oPidZ7fREQ2Od6056Big27lIKaOvoxUtici0zIa6wCA+urYOJIOvijhn1KnYAQ4e
         ZBNVYdyZqEFoh3iFflcGJMWrgnUpmp3kIXvwKoISZjN0NtQwO0ORnTwSp9OVL/tuakTn
         vYFlNn48JOGYZ51j55Mp9t1uu0Rb/wkH3Og0+XYHw10c8FAaD8ilnvGI6z+2Bu7gbLjy
         WPZrg9Gey5ONugn34V+/d+IDGI+o4JdiHqqJo4yCux6gFJw7zJe2Xt6wWZuPkyo5sQEl
         AD7g==
X-Gm-Message-State: APjAAAXaLUS5ABH6T3SND1AELKeqeVAKYM9aW7gIE/jixAHylwaxvRH8
        uP/I4e6lUWO0iEvRRKUHRh5UIvE45+mfCjBwxCA=
X-Google-Smtp-Source: APXvYqw6XP/QX2tZiLUJ+HIi2TBBN+nJo0c5x7geRIfVvsC8UHOauo8uRbinpI/6BkRdyKDygQCoUJvjfyVfR4mdJmw=
X-Received: by 2002:aed:3faa:: with SMTP id s39mr16915570qth.280.1553537970723;
 Mon, 25 Mar 2019 11:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
In-Reply-To: <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 18:19:16 +0000
Message-ID: <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
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

On Mon, Mar 25, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
>
> [..snip..]
>
> I don't like the idea of having one kind of pollfd be pollable and
> another not. Such an interface would be confusing for users. If, as
> you suggest below, we instead make the procfs-less FD the only thing
> we call a "pidfd", then this proposal becomes less confusing and more
> viable.

That's certainly on the table, we remove the ability to open
/proc/<PID> and use the dir fd with pidfd_send_signal. I'm in favor of
this.

> > But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> > can be translated into a "pidfd" using another syscall or even a node, like
> > /proc/pid/handle or something. I think this is what Christian suggested in
> > the previous threads.
>
> /proc/pid/handle, if I understand correctly, "translates" a
> procfs-based pidfd to a non-pidfd one. The needed interface would have
> to perform the opposite translation, providing a procfs directory for
> a given pidfd.
>
> > And also for the translation the other way, add a syscall or modify
> > translate_fd or something, to covert a anon_inode pidfd into a /proc/pid
> > directory fd. Then the user is welcomed to do openat(2) on _that_ directory fd.
> > Then we modify pidfd_send_signal to only send signals to pure pidfd fds, not
> > to /proc/pid directory fds.
>
> This approach would work, but there's one subtlety to take into
> account: which procfs? You'd want to take, as inputs, 1) the procfs
> root you want, and 2) the pidfd, this way you could return to the user
> a directory FD in the right procfs.
>

I don't think metadata access is in the scope of such a pidfd itself.

> > Should we work on patches for these? Please let us know if this idea makes
> > sense and thanks a lot for adding us to the review as well.
>
> I would strongly prefer that we not merge pidctl (or whatever it is)
> without a story for metadata access, be it your suggestion or
> something else.

IMO, this is out of scope for a process handle. Hence, the need for
metadata access musn't stall it as is.

If you really need this, the pid this pidfd is mapped to can be
exposed through fdinfo (which is perfectly fine for your case as you
use /proc anyway). This means you can reliably determine if you're
opening it for the same pid (and it hasn't been recycled) because this
pidfd will be pollable for state change (in the future). Exposing it
through fdinfo isn't a problem, pid ns is bound to the process during
its lifetime, it's a process creation time property, so the value
isn't going to change anyway. So you can do all metadata access you
want subsequently.

The upshot is that this same pidfd can then be returned from a future
extension of clone(2) Christian is planning to work on. It is still
undecided whether this fd should be only readable by the parent
process or everyone (which would just be a matter of changing the
access mode depending on the caller), but that we can discuss all that
when the patchset is posted.

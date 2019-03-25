Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F71C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83A3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8/zHf8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfCYVPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:15:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39258 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCYVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:15:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so9468440otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dule8/Sib5NZg46Ic7dMLM20PZXCss5GqQ0YoQLmGxY=;
        b=E8/zHf8snyhpahrEZ72FqUQE4vBX/m15HVOJQtTqmWf0bnqwk8IM5qxvai+3j+cCND
         NoIU7UaeJFhPdXNyJojeU+s/o5ALsz4mThWnucCftkR4XxJSaXQQoze0IEbnw1iMCVhe
         KamAQwFPGgql+mFhUr+bdk3Iue/VXs5rw7pn16MjymW+rPcib6DZiZkWCzZeRQJoavl/
         XRNPV5h2VvoBz8Rwxc3XMuANGQpDWA1cuqsdhTyvvn/kLInu5WIeCDjLfRbNCpF8WmPO
         xcVoH0aTdPvinaUkTWIbz1S1uWq1BvaObYXLw6UtCcnVCI33/N2W+f8dMTieSjWQ2ua6
         K7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dule8/Sib5NZg46Ic7dMLM20PZXCss5GqQ0YoQLmGxY=;
        b=FfBg30llZz+Glh+Xkz3iMF8eHNFJr+ae8PDZshWmtIqCX0AePMiT790hERrULu2Lho
         Rbz1S17py+JkX1q3uuv6yEbwQZPdJFlTNiyiyvoKSxDAZ3uMylbHfTlK+7QsSIen7HPv
         s8XzXy5Vf6Mtz1Uk7wyhfF0G4P3y9TCWRxWib65TVT0vObyLSy3UCBcPfq/HoJgUJG5x
         Lv++nB/OVZIzK99SoI+1iQR987uqw49ThxohEYYdiujZeMWHOzXxZ+tSchmAGsezthMq
         Fy7PHDtt5Zjm3CyPfsx0Ez38YvnYRpO867utLAwCdRYev9uIfYRCEx/m7+HNxlwI97Ry
         DVqQ==
X-Gm-Message-State: APjAAAVG1aIZPtzqY1TzXeBOGfXbzczacAqq75qhIX7rYOm71CFdagl7
        oVxD9AnxTWAyN9mn8fE3uno8MGV53pMm6C42HUQRPw==
X-Google-Smtp-Source: APXvYqw+nccoHIF4zcxeUGa4C18Xk+3o6WUhv7TFHnqH5TEnRC5sFMcqyYrIscSUhTWs77LdWNlJinbjAqmilseKMss=
X-Received: by 2002:a9d:309:: with SMTP id 9mr19042441otv.230.1553548549129;
 Mon, 25 Mar 2019 14:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
 <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
 <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com>
 <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com>
 <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com> <CAGLj2rE7k-p=ZniyV6bDm-VbhAdzSSwxYcVV=X_Rsky5nixGvw@mail.gmail.com>
In-Reply-To: <CAGLj2rE7k-p=ZniyV6bDm-VbhAdzSSwxYcVV=X_Rsky5nixGvw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Mar 2019 22:15:22 +0100
Message-ID: <CAG48ez2Fy1tFyZqy7bVwG=aBJnwm1mdZgHzchFiguzufctw03Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
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

On Mon, Mar 25, 2019 at 9:40 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> On Mon, Mar 25, 2019 at 8:34 PM Jann Horn <jannh@google.com> wrote:
> >
> >  [...SNIP...]
> >
> > Please don't do that. /proc/$pid/fd refers to the set of file
> > descriptors the process has open, and semantically doesn't have much
> > to do with the identity of the process. If you want to have a procfs
> > directory entry for getting a pidfd, please add a new entry. (Although
> > I don't see the point in adding a new procfs entry for this when you
> > could instead have an ioctl or syscall operating on the procfs
> > directory fd.)
>
> There is no new entry. What I was saying (and I should have been
> clearer) is that the existing entry for the fd when open'd with
> O_DIRECTORY makes the kernel resolve the symlink to /proc/<PID> of the
> process it maps to, so it would become:
>
>   int dirfd = open("/proc/self/fd/3", O_DIRECTORY|O_CLOEXEC);

That still seems really weird. This magically overloads O_DIRECTORY,
which means "fail if the thing is not a directory", to suddenly have
an entirely different meaning for one magical special type of file. On
top of that, unlike an ioctl or a new syscall, it doesn't convey
explicit intent and increases the risk of confused deputy issues.

> This also means you cannot cross the filesystem boundry, the said
> process needs to have a visible entry (which would mean hidepid= and
> gid= based access controls are honored), and you can only open the
> dirfd of a process in the current ns (as the PID will not map to an
> existent process if the pidfd maps to a process not in the same or
> children pid ns, in fdinfo it lists -1 in the pid field (we might not
> even need fdinfo anymore)).

AFAICS that doesn't have anything to do with whether you do this as a
syscall, as an ioctl, or as a jumped symlink. The kernel would have to
do the same security checks in any of those cases - only a classic,
non-jumped symlink would implicitly go through the existing permission
checks. And if you implement this with a non-jumped symlink, you get
races.

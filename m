Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989120848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PToCVP9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:40:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44907 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:40:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so7680845wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydXQkjDWC81cEr+9mLJodiCszaqjihgM8gnFgFEMl0Q=;
        b=PToCVP9XIWJiq8vDGX6o2FsDO0gSCatshfam89nPRuYrBHzzffwXLjCGSwo09PaeiX
         F1Xbh+Yo2PK72QIXqSem3YiGKkaKf4QPM+dDptvJgj/AiJESkjxan9fGlbWyxBFOCnLr
         Ur+PaWLeOHMcs59Hbv+MqPLr2CAfcUPSf1UyNRRyzDDYKJEwzdohAFJLrxaPipkDMqK/
         Ilz2BHYy9qY8KGbz7t+Zx/YU7wvycSylGDi8tB6dH7MGtGfKeKynK9bDHL067v22r7Yw
         gI9jGihjh8mhIo4y+VbRCmbEZBVNhEFqvYLcbKz3JQp0538mxs16Y0eI+xYLQCHLHAHy
         6/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydXQkjDWC81cEr+9mLJodiCszaqjihgM8gnFgFEMl0Q=;
        b=YkVXh1irMLfAZUyT6MyeU/GyVK6ety9uppNRiSbC81SRaVC/i03Og4QWg8vh9rdWNR
         se+Xe8naXhxdXmHo6Q44kfc5ZVIXLgKXIPjuBwHTKDH4okgNLU3W0j6IF2dUIL9q8o0T
         48vxPVfAKdYLq02efdu1dNRKdSP5N3dcOc9UlDArfQaFqWkPFR8ehpo/ZD/EgaWVEIv/
         GJms2sItmg01FPXoJJn+zSXeDXdlkJZ9X1ebMXfZysj6bRllmpis6oWNc6pS7e+99cRo
         aa84Fpy1EByhnW3i+gcLZLLUoSxziKYPED4w7mODEQGKmOtibWR6bZdIXcxmIF1WVRQt
         ONNA==
X-Gm-Message-State: APjAAAVJjekTWGVl6EJqdfINq8qwxReurct04WK6AOKYTZRJi0T8zVAC
        3y0Kz8EmjTkjM08MZi7vRX+N57o+y2pXsg==
X-Google-Smtp-Source: APXvYqzG/7ufWn6iHLTG+svm/a/2nLnxWvU7bPUSFhY5SlvVqPNZmup5mn/pofSQxRtwJPo75V1MXw==
X-Received: by 2002:a5d:60cf:: with SMTP id x15mr16585382wrt.96.1553546423685;
        Mon, 25 Mar 2019 13:40:23 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id b3sm21313053wmj.15.2019.03.25.13.40.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:40:23 -0700 (PDT)
Date:   Mon, 25 Mar 2019 21:40:21 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20190325204021.iknfkdvwykqlgzm4@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com>
 <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
 <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
 <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com>
 <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com>
 <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:34:00PM +0100, Jann Horn wrote:
> On Mon, Mar 25, 2019 at 9:15 PM Daniel Colascione <dancol@google.com> wrote:
> > On Mon, Mar 25, 2019 at 12:42 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> > > On Mon, Mar 25, 2019 at 6:57 PM Daniel Colascione <dancol@google.com> wrote:
> [...]
> > > Yes, but everything in /proc is not equivalent to an attribute, or an
> > > option, and depending on its configuration, you may not want to allow
> > > processes to even be able to see /proc for any PIDs other than those
> > > running as their own user (hidepid). This means, even if this new
> > > system call is added, to respect hidepid, it must, depending on if
> > > /proc is mounted (and what hidepid is set to, and what gid= is set
> > > to), return EPERM, because then there is a discrepancy between how the
> > > two entrypoints to acquire a process handle do access control.
> >
> > That's why I proposed that this translation mechanism accept a procfs
> > root directory --- so you'd specify *which* procfs you want and let
> > the kernel apply whatever hidepid access restrictions it wants.
> [...]
> > > > and 2) it's
> > > > "fail unsafe": IMHO, most users in practice will skip the line marked
> > > > "LIVENESS CHECK", and as a result, their code will appear to work but
> > > > contain subtle race conditions. An explicit interface to translate
> > > > from a (PIDFD, PROCFS_ROOT) tuple to a /proc/pid directory file
> > > > descriptor would be both more efficient and fail-safe.
> > > >
> > > > [1] as a separate matter, it'd be nice to have a batch version of close(2).
> > >
> > > Since /proc is full of gunk,
> >
> > People keep saying /proc is bad, but I haven't seen any serious
> > proposals for a clean replacement. :-)
> >
> > > how about adding more to it and making
> > > the magic symlink of /proc/self/fd for the pidfd to lead to the dirfd
> > > of the /proc entry of the process it maps to, when one uses
> > > O_DIRECTORY while opening it? Otherwise, it behaves as it does today.
> > > It would be equivalent to opening the proc entry with usual access
> > > restrictions (and hidepid made to work) but without the races, and
> > > because for processes outside your and children pid ns, it shouldn't
> > > work anyway, and since they wouldn't have their entry on this procfs
> > > instance, it would all just fit in nicely?
> >
> > Thanks. That'll work. It's a bit magical, but /proc/self/fd is magical
> > anyway, so that's okay.
> 
> Please don't do that. /proc/$pid/fd refers to the set of file
> descriptors the process has open, and semantically doesn't have much
> to do with the identity of the process. If you want to have a procfs
> directory entry for getting a pidfd, please add a new entry. (Although
> I don't see the point in adding a new procfs entry for this when you
> could instead have an ioctl or syscall operating on the procfs
> directory fd.)

Very much agreed!

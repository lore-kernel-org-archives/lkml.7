Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F94C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ABD20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpY7ert1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfCaPVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:21:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45911 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbfCaPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:21:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id n14so3990506vsp.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+llreTrJt/JdzQbNiKe3QjVP9ZEEoAd9OjEaM4nLe9M=;
        b=lpY7ert1TcoA4tHo25RQZtbNwfddZsEc/6jwbwye4t+A4wwx1Hv8C+HisE8O1NWVOe
         l5QrbQsiVy9SBDPfhOp+jAM4YoN+jc+VXUqN2gknKR70DnsbnXdNDjujF7Vy8AuNgQqE
         jYTdphIsKjUPdj2Pmy7Vjc+H+qEm0/oeXx46hTqznfxU1YVZFfY/DeijT++4htDzNffP
         MoPLrXKY7dSP+UjXD9sce7X3zuQBybzafPcpfdi4mt+ThTpWrWHOo03quUVI7LiUcVzD
         PrOXgblG3zmA8ByGZpR7iQ/4b33RlukCXqnwjq5ZHYnG6Uu34ZkFjSBSzzHobT0mNH6L
         aAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+llreTrJt/JdzQbNiKe3QjVP9ZEEoAd9OjEaM4nLe9M=;
        b=mtgqKln+4JW1eSL8+O/4IjlVVw0z+e1rZoTgjG84ILHAdB1/JeEWEE39KMTqwh7qHM
         sxF9ZKaHHhvsjL1Lu4iB0PcMVQzygJiQG1VfRxYEP4zEneHKtm/E+KlhSQAKKLDUHKwl
         0FthU40H7SFMkZoUxxMPxeRpvmzowzdeMjR7coPU1ZAtvgHDrPQzaqL91jHokOH2i89w
         wPqgHnGafhBjM64pMaUJNswPLDRy/XaQlJCgJkaA3U//lnazg1jUZTbf3zhHPSpDMyw5
         kHZVnuOeK2zwUrd7CZcZ9Q8BiikZQTLiO/rHSuqwyVcTwZBgLX+zLAH16QASWgFQh5RZ
         mPiA==
X-Gm-Message-State: APjAAAV7vrXemBmAdecO45c8IIXkXP0XFeMnvksowRdj71CM67AngXLO
        gzWGsaLyRjY/U2kzAdIHmopDOKQZ5RZYdDshHgDrlw==
X-Google-Smtp-Source: APXvYqz2iqUolcpoLH3fHhBwiU+3Cwt9f931KYGp8+Tw6vBtVYlcE6pDZxUX8h2+UGk71eq2HG8jCnHWPOAQF3mTDuw=
X-Received: by 2002:a67:ea0a:: with SMTP id g10mr13091406vso.77.1554045711026;
 Sun, 31 Mar 2019 08:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
 <20190331010716.GA189578@google.com> <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
 <20190331040810.GB189578@google.com> <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
 <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com> <20190331150507.zpyugdvtmr6rgpda@brauner.io>
In-Reply-To: <20190331150507.zpyugdvtmr6rgpda@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 31 Mar 2019 08:21:39 -0700
Message-ID: <CAKOZues=PUZzKWoL10qiaLXgbDwE0YjygSdf4ZZSZHvOYMO=3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
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

On Sun, Mar 31, 2019 at 8:05 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Sun, Mar 31, 2019 at 07:52:28AM -0700, Linus Torvalds wrote:
> > On Sat, Mar 30, 2019 at 9:47 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > Sure, given a pidfd_clone() syscall, as long as the parent of the
> > > process is giving you a pidfd for it and you don't have to deal with
> > > grandchildren created by fork() calls outside your control, that
> > > works.
> >
> > Don't do pidfd_clone() and pidfd_wait().
> >
> > Both of those existing system calls already get a "flags" argument.
> > Just make a WPIDFD (for waitid) and CLONE_PIDFD (for clone) bit, and
> > make the existing system calls just take/return a pidfd.
>
> Yes, that's one of the options I was considering but was afraid of
> pitching it because of the very massive opposition I got
> regarding"multiplexers". I'm perfectly happy with doing it this way.

This approach is fine by me, FWIW. I like it more than a general-purpose pidctl.

> Btw, the /proc/<pid> race issue that is mentioned constantly is simply
> avoidable by placing the pid that the pidfd has stashed relative to the
> callers' procfs mount's pid namespace in the pidfd's fdinfo. So there's
> not even a need to really go through /proc/<pid> in the first place. A
> caller wanting to get metadata access and avoid a race with pid
> recycling can then simply do:
>
> int pidfd = pidfd_open(pid, 0);
> int pid = parse_fdinfo("/proc/self/fdinfo/<pidfd>");
> int procpidfd = open("/proc/<pid>", ...);

IMHO, it's worth documenting this procedure in the pidfd man page.

> /* Test if process still exists by sending signal 0 through our pidfd. */

Are you planning on officially documenting this incantation in the
pidfd man page?

> int ret = pidfd_send_signal(pid, 0, NULL, PIDFD_SIGNAL_THREAD);
> if (ret < 0 && errno == ESRCH) {
>         /* pid has been recycled and procpidfd refers to another process */
> }

I was going to suggest that WNOHANG also works for this purpose, but
that idea raises another question: normally, you can wait*(2) on a
process only once. Are you imagining waitid on a pidfd succeeding more
than one? ISTM that the pidfd would need to internally store not just
a struct pid, but the exit status as well or some way to get to it.

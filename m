Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA748C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CEC2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR4Fl6t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfC3QLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:11:36 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44037 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfC3QLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:11:35 -0400
Received: by mail-ua1-f66.google.com with SMTP id p13so1692733uaa.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpNOyL6dpK2H4PEQwORzPIg3umPBEXnJBvIn35JJ+is=;
        b=AR4Fl6t+Wkeu1wHtC+pMv+KsiC0g6jXGbma0v5GisnpIy7q8avmvwhvijuc7vXlU+O
         KFoOWewTAkyQiVx5QUy9Q0RYsNXsDBuJO+/RTpCOcgL0FjywfU7H6rFIFvBK4DYyo+R+
         vj5Z6Ljz7CRZtjP7A8+lorapM6Ku2MEo/1Lb2UR464TBZgK1d6/QXzpYdQaexEz8d5/5
         cdC5F9ekPUvTNDayj6O+r4EYpCPIghHSMqs9+VxZzEnbu1XJYWaz/kn/RRmYWwCmUVmK
         llF/2Fw3DR3cWK0ftW/6dFpepZufp+wguzwE0PXnVZCXEixPVnqefmwO4/DwXQGRGzoq
         O7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpNOyL6dpK2H4PEQwORzPIg3umPBEXnJBvIn35JJ+is=;
        b=mTjT4W5/RANAMVmVStAm4isc3S2AacIoAiz4J24tAR3SvJTbg8WeGOqm8+pcCAws2f
         z9wu8QBykj9YdJQGrVoAaThm9o2WX9je4IGN2f0a4E8UTYgWw2vQMDBVfQKKAYwOzOrd
         LbZ61O2AZgjZzI03zrh+9p5iYU1hbOZv2Kszp0nnWgP5HhgUwsmOYOKzkZrtDmEwQBqZ
         6xwbGqlISXjEV4k3wswzOaLt8BIJOCjS5+L7KE6BwrSmVM3kLXq4JybXJ4n40bmc5bZf
         ZgFKkQxfuEePgLydjViX3HKCGfPFsf9JkQn2wGGtgZfQl/HD5qUd/kaIW/JvWqP3NIwG
         zb2A==
X-Gm-Message-State: APjAAAWcGko5geD/3NHan2gJjwdD5l/pjWo4JHxXrX7SwJEEOaMP+XEN
        7ezWFDPzH5Mh2Bi6WCwcTUzgZeEkE2+UTVGq2ItkZA==
X-Google-Smtp-Source: APXvYqwi5kK33yuOoMtWXR2FeeS7g/ypxhTJ5V+zpMu/WfdGD0ORt7ItqzaUoL0HC3rJA3PBX+jBkwmbPQBdPW2K708=
X-Received: by 2002:ab0:73d3:: with SMTP id m19mr32438404uaq.46.1553962293959;
 Sat, 30 Mar 2019 09:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
In-Reply-To: <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 30 Mar 2019 09:11:22 -0700
Message-ID: <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 29, 2019 at 8:54 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > /* Introduction */
> > This adds the pidfd_open() syscall.
> > pidfd_open() allows to retrieve file descriptors for a given pid. This
> > includes both file descriptors for processes and file descriptors for
> > threads.
>
> I'm ok with the pidfd_open() call to just get a pidfd, but that
> "pidfd_to_profs()" needs to go away.
>
> If you want to open the /proc/<pid>/status file, then just do that.
> This whole "do one and convert to the other" needs to die. No, no, no.

How do you propose that someone open the /proc/<pid>/status file in a
race-free manner starting with the result of calling pidfd_open?

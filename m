Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D1C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601A52082E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLVkTWYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfGEMRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:17:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43132 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGEMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:17:16 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so18664714ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=attF657RYtQ1qVlMlhaW4Cdqr/YPSVY99/m/3/stAMA=;
        b=LLVkTWYkTYW1InwoPztrYJ7JNBcPC4tteZxQAWNwP7giTcQztjKskBzsbE/81kmVs9
         tJPiJIWgKBTmjHoqkgkpPgb/XRKjCzgC+BaslDWrp3HuKcQUqJSbD/3q/JbWAU759zWF
         KGDPdJUL1AH3zo4vszQgoU9gEgUkCL43ci/qr1fPVwii+265Gk//CFqLlSTf1Np8XikZ
         l0rwnBKLy13lU2w0qfbbB/ymrhSXuSEsKh8yYB7EXWU1ZmZiRaUbN92IQBimJpE+9FdT
         cao8odFLqN9Rkij4Z2lkeyaFAipCgFd2DC+3Pl7Y+0zD7f07C+QRLDnatHHUR4Qf3BW9
         qjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=attF657RYtQ1qVlMlhaW4Cdqr/YPSVY99/m/3/stAMA=;
        b=P6PH3J37n2KQku6vW8nqn6SaI7BQn9ewARBBq9FotIUZg48TefufNNxCzPY8YDS0aS
         YTGvlXiSScehNRo8KHB3fgP+1X0Z5Ax/KP26MVtPSlnTchPY4+HV/fiYH6v1uWnfDep9
         kxEwDWy3edALBXKlC+0DAwyUoQSc+RCrdVjR+iTFmHY4lYTAgCLPEM8UVlEUGrh5De3N
         2Ztqev2q2rjCJ5XofreIUgU47tit0Dg9akaJwrbRwV8O8sfb0lT0MIezwXNGc6c/zqty
         aHrBjkXxFX3l3RQmCJv8rlwZKIVKQNTfCyYcjuIO2Nu8oz1m4Uq/VffphxFtc7r4BrZX
         O7Hg==
X-Gm-Message-State: APjAAAWxL7rrtpu+xjbABTgLoJAPlcmJZ4FxVEX/Lj7DbX5PPxoc+BJ2
        A5RTux3FuwNDyIvsGK4OyQI87sca3Eo118TQlK7Bpg==
X-Google-Smtp-Source: APXvYqz04w6d1Zql9T9Y6gFDzNOmXCVtQOzC3p8gFLr3aw7GqYahW12dxWLaRgWY6ONfrqfA7jBkhAOCY2H0qjY8/IQ=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr4025057ioa.138.1562329035066;
 Fri, 05 Jul 2019 05:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain> <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
 <20190701151808.GA790@sol.localdomain>
In-Reply-To: <20190701151808.GA790@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 14:17:04 +0200
Message-ID: <CACT4Y+YxjcY2wMJm2THYi6KouQ1dzyGTNEjOe8wSqj8in2qigw@mail.gmail.com>
Subject: Re: general protection fault in do_move_mount (2)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 5:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Jul 01, 2019 at 04:59:04PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > >
> > > Dmitry, any idea why syzbot found such a bizarre reproducer for this?
> > > This is actually reproducible by a simple single threaded program:
> > >
> > >     #include <unistd.h>
> > >
> > >     #define __NR_move_mount         429
> > >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> > >
> > >     int main()
> > >     {
> > >         int fds[2];
> > >
> > >         pipe(fds);
> > >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> > >     }
> >
> >
> > There is no pipe in the reproducer, so it could not theoretically come
> > up with the reproducer with the pipe. During minimization syzkaller
> > only tries to remove syscalls and simplify arguments and execution
> > mode.
> > What would be the simplest reproducer expressed as further
> > minimization of this reproducer?
> > https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> > I assume one of the syscalls is still move_mount, but what is the
> > other one? If it's memfd_create, or open of the procfs file, then it
> > seems that [ab]used heavy threading and syscall colliding as way to do
> > an arbitrary mutation of the program. Per se results of
> > memfd_create/procfs are not passed to move_mount. But by abusing races
> > it probably managed to do so in small percent of cases. It would also
> > explain why it's hard to reproduce.
>
> To be clear, memfd_create() works just as well:
>
>         #define _GNU_SOURCE
>         #include <sys/mman.h>
>         #include <unistd.h>
>
>         #define __NR_move_mount         429
>         #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
>
>         int main()
>         {
>                 int fd = memfd_create("foo", 0);
>
>                 syscall(__NR_move_mount, fd, "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
>         }
>
> I just changed it to pipe() in my example, because pipe() is less obscure.

Then I think the reason for the bizarre reproducer is what I described above.

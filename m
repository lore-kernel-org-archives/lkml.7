Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA6C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A6420872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdJGCc/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442013AbfIXVJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:09:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44066 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbfIXVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:09:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so2803021otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQkB7bi48akuclIATQVoqE958M+eJ2QEZpzqC72+kvg=;
        b=qdJGCc/WSkznfzlwqEskmqvJju3gOGUfVjauS0N+JVZEaAyPF8n3QPZEqfNP0Ht8Lb
         KZoxRgUVzOL0weQuqoPo8LqdgBh+A4BZd5gPb73MmGmaCa2kLIAci39BIDKvNjdQfizl
         1epob1IAq07xx5/zes1kgFY4ekHvhNAKKIBHDzAqopnuZI658CV8BdR3QXojvSLdPZja
         dvXOm8eHEkMp1aLUuP3cu/g/0lX8ioUPolPYQccvHBPuB0VPm5dlvuyRQMW7Yq1YpfSS
         NSsuVTEvHRKbQcO0Z/OZL7X2IVGS9pItCyqD1fs6ET9zMgjHEvci+hfRw73ajZDFSbmN
         YnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQkB7bi48akuclIATQVoqE958M+eJ2QEZpzqC72+kvg=;
        b=BfZOd897nU6MQsUo5sPdMOQ0XLkrGYZ1FUbkuuPGz+r1etN5NPDE38Yn1dEx3dvcTi
         x9KTzOJWYpvCdYzf/U/ikDRMRH4Nr19IDR2PVHLtrvVsrKyukPmiHxW26byYCDUnd6xk
         UhQ0P8FQPZevXOOPVwizjdMofrY6JVmijqRODfjUUKA+WvzD5QfoiF9SgD98cte8eHEh
         cRDWrsJkHu7nPt9kBkg32W2A+yywVTOyGl8dSBSHxeCzcP0wXamxnBSx4IDX7JGu0tdo
         Gu4COrNnEAbOypVXlXa9+mR4sz0ut7GDRR1SlRmdLPr6+qpxaf2EFngYTgdbsCH1pr/o
         MCwg==
X-Gm-Message-State: APjAAAX2F+Z6MuUCFUbDgBd++Hr8QaEpKt6H/ktQAXjE0v77nuVls9TG
        31BHfyt9gx/PXg7JnLkfsp1tP9IbxF1pyVUhFhTCsw==
X-Google-Smtp-Source: APXvYqyaBNsjkpbQ2c9tp8Ci8G41mH0vJifEkwcyIGvvW3+IVOVzCVg+ZK2RuqRwelZ35Ng/sl8rW7aKTvFOZvGKKws=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr3747315otn.311.1569359349938;
 Tue, 24 Sep 2019 14:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de> <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com> <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
In-Reply-To: <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 24 Sep 2019 14:08:33 -0700
Message-ID: <CAKOZueuJ=En9=mtFvhpmsnjqMAOjVmffaVwwzpe=ieHemxH3mw@mail.gmail.com>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 2:00 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Christian,
>
> >>> If you're the parent of the process you can do this without CLONE_PID=
FD:
> >>> pid =3D fork();
> >>> pidfd =3D pidfd_open();
> >>> ret =3D pidfd_send_signal(pidfd, 0, NULL, 0);
> >>> if (ret < 0 && errno =3D=3D ESRCH)
> >>>     /* pidfd refers to another, recycled process */
> >>
> >> Although there is still the race between the fork() and the
> >> pidfd_open(), right?
> >
> > Actually no and my code is even too complex.
> > If you are the parent, and this is really a sequence that obeys the
> > ordering pidfd_open() before waiting:
> >
> > pid =3D fork();
> > if (pid =3D=3D 0)
> >       exit(EXIT_SUCCESS);
> > pidfd =3D pidfd_open(pid, 0);
> > waitid(pid, ...);
> >
> > Then you are guaranteed that pidfd will refer to pid. No recycling can
> > happen since the process has not been waited upon yet (That is,
>
> D'oh! Yes, of course.

You still have a race if you're the parent and you have SIGCHLD set to
SIG_IGN though.

> > excluding special cases such as where you have a mainloop where a
> > callback reacts to a SIGCHLD event and waits on the child behind your
> > back and your next callback in the mainloop calls pidfd_open() while th=
e
> > pid has been recycled etc.).

That's a pretty common case though, especially if you're a library.

> > A race could only appear in sequences where waiting happens before
> > pidfd_open():
> >
> > pid =3D fork();
> > if (pid =3D=3D 0)
> >       exit(EXIT_SUCCESS);
> > waitid(pid, ...);
> > pidfd =3D pidfd_open(pid, 0);
> >
> > which honestly simply doesn't make any sense. So if you're the parent
> > and you combine fork() + pidfd_open() correctly things should be fine
> > without even having to verify via pidfd_send_signal() (I missed that in
> > my first mail.).
>
> Thanks for the additional detail.
>
> I added the following to the pidfd_open() page, to
> prevent people making the same thinko as me:
>
>        The following code sequence can be used to obtain a file  descrip=
=E2=80=90
>        tor for the child of fork(2):
>
>            pid =3D fork();
>            if (pid > 0) {     /* If parent */
>                pidfd =3D pidfd_open(pid, 0);
>                ...
>            }
>
>        Even  if  the  child process has already terminated by the time of
>        the pidfd_open() call, the returned file descriptor is  guaranteed
>        to refer to the child because the parent has not yet waited on the
>        child (and therefore, the child's ID has not been recycled).

I'd prefer that sample code be robust in all cases.

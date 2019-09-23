Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF72C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1694920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtZVa39H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393767AbfIWL0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:26:46 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:38470 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbfIWL0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:26:46 -0400
Received: by mail-ua1-f46.google.com with SMTP id 107so4202605uau.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IFdwQB/ijINnA/lqlmbhpdAwR/YqjJgUmIEdCY57TRQ=;
        b=AtZVa39H3Xtur7smzRZSAgg07PxhyIHQVN8+CyVQrPEfTRLQEjLrIILub5Zeges/nQ
         3uKUFiBL6SNW03v7RKQRUyjDFM4NQ7hwCfPxMjNnbd1tnO7xfv8q2vD+zqWJL2TJmQgR
         MJOsQrsW7jzTSpquLrFphFxPYbxXa49l4dH8AzlsLTRtH9pCPVWf26vbcAnfDp3rSreB
         siqCdt34IVlVlUf+86Jw8igtQUZRzUQs8IcpTas2POshYHB93fvq5jYZFTzKKgaTifxh
         m6BMxWWuGuFgcUcCWjD4RJSglFyv1BIJ9FPuKnZ37ihhKP5O+IDkHtYuOpdh3uPotaWE
         el6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IFdwQB/ijINnA/lqlmbhpdAwR/YqjJgUmIEdCY57TRQ=;
        b=fVlkfiY4JALNznOCDJjYvmzI8E3GUW8vaZeUD18dLFDm0s1fKjrMhmWKp4D8FG8B9U
         BSFpks1YelN3I3GeIvBSkYeNOiOrjDtqiySVWMl7qQDMoXmUpejxcARNkoeyyPWKrTwU
         JEZCG6Ou3E6yr70BT5YyBjdX/vqyA6+epAc6A5ElYTSt/+8BgXq2a7eXNWYMGJMYYt5F
         VSfGJTdGzHq3Pk2RNwZhmm+YvDTgwOgjB0rPvTpmMMI1XYLKTVB/1NEW0LIUJswXoC5S
         xYi+FTbiasVJJjtqN/UM9vy2nYGMTvI4TiiOWY1trp6wOgZHX0UEjwxM4P3xUdRgjCKy
         7uew==
X-Gm-Message-State: APjAAAVOkq3D7eB28f1P2YDcz8yF4jhiwvOlYGMp8vtu35pL8SECpStp
        rypasqpalWqtbbov8Td2MOwa4pwnT+fwdHAnqk4tDQ==
X-Google-Smtp-Source: APXvYqyNSv3j9oFCo5Iv0a8bmqE4PuPid1Lo/7mebRqk5VMMOgNaP8qAY2MHuNIc1V7q3Qnj31ABEbdIbyybnwp6zoU=
X-Received: by 2002:ab0:748a:: with SMTP id n10mr15884519uap.41.1569238003126;
 Mon, 23 Sep 2019 04:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com> <87tv939td6.fsf@mid.deneb.enyo.de>
In-Reply-To: <87tv939td6.fsf@mid.deneb.enyo.de>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 23 Sep 2019 04:26:07 -0700
Message-ID: <CAKOZuetTgKjgWZpCaBz8q662MwVQ-UhrV4oWFqKEWr35mQTFLw@mail.gmail.com>
Subject: Re: For review: pidfd_open(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:53 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Michael Kerrisk:
>
> > SYNOPSIS
> >        int pidfd_open(pid_t pid, unsigned int flags);
>
> Should this mention <sys/types.h> for pid_t?
>
> > ERRORS
> >        EINVAL flags is not 0.
> >
> >        EINVAL pid is not valid.
> >
> >        ESRCH  The process specified by pid does not exist.
>
> Presumably, EMFILE and ENFILE are also possible errors, and so is
> ENOMEM.
>
> >        A  PID  file descriptor can be monitored using poll(2), select(2=
),
> >        and epoll(7).  When the process that it refers to terminates,  t=
he
> >        file descriptor indicates as readable.

The phrase "becomes readable" is simpler than "indicates as readable"
and conveys the same meaning. I agree with Florian's comment on this
point below.

> > Note, however, that in the
> >        current implementation, nothing can be read from the file descri=
p=E2=80=90
> >        tor.
>
> =E2=80=9Cis indicated as readable=E2=80=9D or =E2=80=9Cbecomes readable=
=E2=80=9D?  Will reading block?
>
> >        The  pidfd_open()  system call is the preferred way of obtaining=
 a
> >        PID file descriptor.  The alternative is to obtain a file descri=
p=E2=80=90
> >        tor by opening a /proc/[pid] directory.  However, the latter tec=
h=E2=80=90
> >        nique is possible only if the proc(5) file system is mounted; fu=
r=E2=80=90
> >        thermore,  the  file  descriptor  obtained in this way is not po=
l=E2=80=90
> >        lable.

Referring to procfs directory FDs as pidfds will probably confuse
people. I'd just omit this paragraph.

> One question is whether the glibc wrapper should fall back back to the
> /proc subdirectory if it is not available.  Probably not.

I'd prefer that glibc not provide this kind of fallback.
posix_fallocate-style emulation is, IMHO, too surprising.

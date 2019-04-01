Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9253120857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIrNn3yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfDAQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:27:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37395 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDAQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:27:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so6024329qkk.4;
        Mon, 01 Apr 2019 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kma5HlMIaIo7ZZt/W843TSdh6qmdafDEwgat7MOQ+j8=;
        b=qIrNn3ypf5fh4GsslusABeGu83vEEVti55xgl1bu9+PSnnywYXuoL2NB+2vjMa65sm
         nW2GSKw+FioeEIipXrU218vrwc67DcPotro6KRAluqDmFoihqs37wQiDZoM30gdTiWZN
         SmCTIburjH+aJbO2gkhJWBxCsW9aqwTRW2qwsPq2flsqros3dgGqR6gGr35zxGwGfahd
         IkDw4XfwpIoxcnFKm12Mkhz8nix5DE6vhOfQq38BE58wXtsKyVh6eBZ84Y03h7L9RA+e
         l/6vBYKa1hzPuhkKcx26B3ow5pQIdP52eL461ZtrKVzeBnBKCJItNvsoDWLGHw71K6bl
         VZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kma5HlMIaIo7ZZt/W843TSdh6qmdafDEwgat7MOQ+j8=;
        b=aMfAzyHF9sw7LGojdmQIVk68zT6D+JJ2RF1Qws+/y0Evnq9J+eX5WDPborKKKJfLDu
         uKeXVwyf7+dxgm399xs5AxggozvCwPGWaQUpuoON4ODRL27D8xsf+UlsugG0WHentDqD
         /kpYqtXUdJATcre7Wph6E5TFigs2xRKmc2kbp1rAq6RKDWN3x6O1XKGnDfkRhPUYwzDN
         beCTtVWm4xgRY981/L9GPijpk6ws9PwHKWUoJO0cvv4CS/OxO7BDkT8dpaaSDzTg0XSp
         ge/l1aI7huaRjvoAXoOQd71EOhen5JVmYsnoL8GBjAXzkjKhFkJezu99MeMlyVax+ZCE
         GFEA==
X-Gm-Message-State: APjAAAWR1uFmu/VaMKIavDOqc3ygdsAIa/svuZSkajFQ0zQ92DNE8c+L
        TwR4DbpUwib7uCFqdI7f3QsWn4pTKwY2UFy1rZA=
X-Google-Smtp-Source: APXvYqzrKZlfagbcHduRRxXMqU7IexwoqtJqGyjlcNNFAVA7fPbS3k0UsVjutWwJvvykSVEiVx92TRfdhtUKKMFVfO4=
X-Received: by 2002:a37:478d:: with SMTP id u135mr40076936qka.257.1554136062815;
 Mon, 01 Apr 2019 09:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com> <CAHk-=wi1UEsMv5wmBZB5S+5YiCbxd-AtVsoz1TfuD-KrdcLQew@mail.gmail.com>
In-Reply-To: <CAHk-=wi1UEsMv5wmBZB5S+5YiCbxd-AtVsoz1TfuD-KrdcLQew@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 1 Apr 2019 17:27:39 +0100
Message-ID: <CAGLj2rHdv1rvx++Vf5LaAnZENMoq2+b-OPYmgGMnuOnaCzav3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
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

On Mon, Apr 1, 2019 at 5:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 9:07 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> >
> > With the POLLHUP model on a simple pidfd, you'd know when the process
> > you were referring to is dead (and one can map POLLPRI to dead and
> > POLLHUP to zombie, etc).
>
> Adding ->poll() to the pidfd should be easy. Again, it would be
> trivially be made to work for the directory fd you get from
> /proc/<pid> too.
>
> Yeah, yeah, pollable directories are odd, but the vfs layer doesn't
> care about things like "is this a directory or not". It will just call
> the f_op->poll() method.

I know, Andy even sent a patch for that long back. The question is,
this sure solves the immediate usecase, but it inhibits some very
powerful (and natural) things from being realised in the future, and
makes some choices harder.

Currently, pidfd_send_signal doesn't work across PID namespaces. It
would be possible to make it work, but some things need to be taken
care of, precisely, that one allows a task to open pidfds for tasks
*it* can see. Why? because you essentially isolate the PID namespace,
so your open() for this namespace suddenly doesn't start opening
things it cannot see through some other namespace (i.e. /proc),
precisely how you cannot open sockets in network namespaces from the
outside, though if you can setns, you should be able to (same with
pidfds). This makes for a nice delegation model, I can essentially put
a task in a namespace with no other tasks, keep pushing pidfds into
the damn thing, and subject to kernel permissions and capabilities it
can yield in the owner userns, signal the said task. You can extend
this to ptrace and other things, by making them accept a pidfd. This
means userspace has to explicitly pass such descriptors around to make
this work, like it does today (and how I can use an open socket and
accept connections whilst living in totally isolated network
namespace).

Besides that, /proc comes with too much stuff, it should be possible
to go from pidfd to /proc/<PID> and do whatever you wish to, but
atleast two things that require varying levels of capabilities of
inspection, the latter of which can be isolated by mount namespaces
even if the process would usially be allowed to peek into it and read
the entire thing, do not end being munged together. I can choose to
pass both, but if /proc dir fds *are* pidfds, you need the entire
complexity of masking and whatnot (which would be usable on its own,
no doubt), making directory descriptors pollable and readable, etc
etc.

>
>               Linus

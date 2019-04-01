Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D23F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554136648;
	bh=OhbAfona81QGQJw30n/rTcWHrk7OUcfavJvHPCmLDU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D6NR3lSgGDJPLzgk4hfNPVO3D0iWh707wLSrhl/gsv+/Imo7pJaAHkKrqVbSCLCbF
	 OPQCP3EPyoS56sVfcB5t8S7uvORl2yhrKU2AM14LVsQx8VjL3+hfB7ZkePohsYpris
	 OJAmWMJUqoutoHKWnEpAYHWEwnzeZN6vdDbfQYrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfDAQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:37:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40714 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDAQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:37:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so8798540ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2/hei+vgqKaKtTHjgY02R0PKIHdRQxpOxoHgedAK9E=;
        b=ABfnGwP/pRA2TzpAMPGT68+v5gOV5AsgcMpu2qkb/KkfzfuZSWFRd4Vo38qjgI+Xcu
         vsRyPeQt/6P0JIbssE3tupmndGvmtBdLbjuG/sbB2H1crfNf4Rqs24a7nMmyWBAto/ds
         taZmLrriDkaFPX9iOqydhmqyPgoqNiUTFhrIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2/hei+vgqKaKtTHjgY02R0PKIHdRQxpOxoHgedAK9E=;
        b=pQP9GIMUaqNPKGaVGBh+8qBN89PYN6WKmuHk+wuhEeSh+W8FKp1NOVKcwL1wO6vplk
         zs2ZuNMwrTji9QbORzQnh30mMcXz6ZYyMQd6I6A/YS53f8CoocHv0h8j7XAJkQEep9f9
         yN/nZ+PNX56Bqoe3V+9RnryXIY6S5Ndf5spVFz2sMLNImnRdT4EYNMO0N32f2K4UlFJO
         9eT0a9tl0BRJCem5NCGVHlnEZrn312IVS7U8Po50o0ZP3t2TCZD8t8cLpjIG9AXk+uil
         4FomzNLs+TDFs/9sWFK+uotzLuTNqBBfI4qOl7hFMYCeUmoH/DCQokU1AcoKw9/ZD3mg
         ydzw==
X-Gm-Message-State: APjAAAV1s1Z03IB7zmPEuDakMCU5tjSlcK6oBmc3PUMQjATm1TYxfYW1
        jhKlUbYo41BJPD0ty3LaJxMUHREs0oc=
X-Google-Smtp-Source: APXvYqw/RfjM374brSHl0mIndiZSwrMoftq3pebcuUrVEde0mCdeVH6EBgJWE30hwmeOMZFZ6bEhZw==
X-Received: by 2002:a2e:8ece:: with SMTP id e14mr21562069ljl.66.1554136643938;
        Mon, 01 Apr 2019 09:37:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s16sm1017453lji.61.2019.04.01.09.37.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:37:23 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a28so6780845lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:37:23 -0700 (PDT)
X-Received: by 2002:a19:9107:: with SMTP id t7mr33401391lfd.48.1554136212826;
 Mon, 01 Apr 2019 09:30:12 -0700 (PDT)
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
 <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com> <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
In-Reply-To: <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 09:29:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
Message-ID: <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
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

On Mon, Apr 1, 2019 at 9:22 AM Daniel Colascione <dancol@google.com> wrote:
>
> There's a subtlety: suppose I'm a library and I want to create a
> private subprocess. I use the new clone facility, whatever it is, and
> get a pidfd back. I need to be able to read the child's exit status
> even if the child exits before clone returns in the parent. Doesn't
> this requirement imply that the pidfd, kernel-side, contain something
> a bit more than a struct pid?

Note that clone() has always supported this, but it has basically
never been used.

One of the early thinkings behind clone() was that it could be used
for basically "AIO in user space", by having exactly these kinds of
library-private internal subthreads that are hidden as real threads.

It's why we have that special CSIGNAL mask for setting the exit
signal. It doesn't *just* set the signal to be sent when the thread
exits - setting the signal to something else than SIGCHLD actually
changes behavior in other ways too.

In particular a non-SIGCHLD thread won't be found by a regular
"waitpid()". You have to explicitly wait for it with __WCLONE (which
in turn is supposed to be used with the explicit pid to be waited
for).

Now, none of this was ever really used. The people who wanted AIO
wanted the brain-damaged POSIX kind of AIO, not something cool and
clever. So I suspect the whole exit-signal thing was just used for
random small per-project things.

              Linus

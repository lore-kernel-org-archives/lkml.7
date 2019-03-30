Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69AAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEED218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553966682;
	bh=CbDUA+cfXE2Exvs+3nC0M0rodAepq93Ab0oAg162oBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C8CQxn1eMtcwj9ybxPl7psomu8ngwbFnIs0HA47i5lXtL3ztV2kEnTaPZTUekHIIa
	 oqZ4S+SOFHN9TJqIgyLhHCGuraNojnQKzZjc4R8PXULQ641rluNOsEinsuZ4NpEXSN
	 q8VczIt+5JfKUzQJvQagr27Cy8/zIS+GQPkLx8f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfC3RYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:24:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45979 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfC3RYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:24:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so4552871ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beyhB6lVljywyNB9oOMjClZFho1egNhaGdBfwfOVZJk=;
        b=HNLe0b3zBn5uphaNuZIp8EjWNxsktADrGJGgA77KSX1EPoz0skooeMSSZIQlHLe0dV
         ybyNYsVeYS6TossBku4xTZWYNWdHjASM1c4dax9TEC2gr/+/UTHWLZ3zdWRp+RxB2Snz
         ntqaH7zqMHUKT5LIkLIfdtGUDv3cD8sGOG6XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beyhB6lVljywyNB9oOMjClZFho1egNhaGdBfwfOVZJk=;
        b=Epje7aJvVaU1jXF10ddp6cfvkd24Kb26r738PoBfGQU/witkNdxkBpMRoI4hksMy88
         3LoSqB1Ln49KcEhfFjFoBspeqRbVIciVO94W/ZCU9dh3Bz4SpgGzGfh2D8D179hm8IfM
         UbEmPAAaTQAjZykIrVz7cWx91iQGehTITRajNQ4+UxkY8GvReJ/WG5BGcj6VwSxIAWin
         cWx18cuXJnS4N7XtdWK6Go8Un0acHJtTyCzH6mbXAKReq4nUM6oJdFxhwuRP2XIiArIG
         3OmyA0ajobPVG+AusV66j9M7S/T+eC39GFGDgXz0VuwCRZXRd+mrdqosT1V2Ezdqhy9R
         5QvQ==
X-Gm-Message-State: APjAAAVi6EmFlTd0TYzNLncTYS/1AK4SFDS3+58F7OtlUV7gEtC2mYcR
        lRkOEmrZwAhBu4/iJD5DHJVA2BWmWAs=
X-Google-Smtp-Source: APXvYqyn0BuAXEewhebI9wqmjmpzk6bfoDBCKey2IwyQQ28FIx2K6kXTNGMy8JO6upQNdpIYc6jR9Q==
X-Received: by 2002:a2e:9213:: with SMTP id k19mr8615919ljg.118.1553966677764;
        Sat, 30 Mar 2019 10:24:37 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 1sm1024192ljw.56.2019.03.30.10.24.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 10:24:36 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id b7so3498268lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:24:36 -0700 (PDT)
X-Received: by 2002:a19:954b:: with SMTP id x72mr27981956lfd.67.1553966676025;
 Sat, 30 Mar 2019 10:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com> <20190330171215.3yrfxwodstmgzmxy@brauner.io>
In-Reply-To: <20190330171215.3yrfxwodstmgzmxy@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 10:24:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
Message-ID: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
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

On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
>
>
> To clarify, what the Android guys really wanted to be part of the api is
> a way to get race-free access to metadata associated with a given pidfd.
> And the idea was that *if and only if procfs is mounted* you could do:
>
> int pidfd = pidfd_open(1234, 0);
>
> int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
> int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);

And my claim is that this is three system calls - one of them very
hacky - to just do

    int pidfd = open("/proc/%d", O_PATH);

and you're done. It acts as the pidfd _and_ the way to get the
associated status files etc.

So there is absolutely zero advantage to going through pidfd_open().

No. No. No.

So the *only* reason for "pidfd_open()" is if you don't have /proc in
the first place. In which case the whole PIDFD_TO_PROCFD is bogus.

Yeah, yeah, if you want to avoid going through the pathname
translation, that's one thing, but if that's your aim, then you again
should also just admit that PIDFD_TO_PROCFD is disgusting and wrong,
and you're basically saying "ok, I'm not going to do /proc at all".

So I'm ok with the whole "simpler, faster, no-proc pidfd", but then it
really has to be *SIMPLER* and *NO PROCFS*.

PIDFD_TO_PROCFD violates *everything*.

                      Linus

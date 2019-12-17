Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6775F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaEjEkXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLQIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:38:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38551 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLQIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:38:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so5275497qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIrJhAT0FZhqQC6+Cfro2tTwtRlfUc9In4WJNBC43uo=;
        b=iaEjEkXevA627OxJCzZ3NT3qqWnixZkvLc+Zn6rDW2XaSJM1DAQ1pnANyQhzNZWdh1
         ZJQVCnCn3V/O06S7e/Fbm622YJQOyHOFH4sVpvEqfskqGkvYsad+HHQvc42xo16Rz+8I
         3qc6Ec2MvYPxm5McGtdapkq9zdbcm0K5fTHcf/g0BaJHevbYKgORRhenmyBvOa+hR+zg
         FH5GUdmgKa3FSqa7j7Yz38fVVN26FhVekIZ/wf6jUjBechjAFgtAodAhHSadHAobt/Ut
         mwg+6McPmtVlWTMNL2DXAhf/HGhlznRWDUUfr8Jcm4HNFoYEINSmPxKBsNp+85H3gTmd
         MYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIrJhAT0FZhqQC6+Cfro2tTwtRlfUc9In4WJNBC43uo=;
        b=SplqGCdqufmZo7FQNUSIUfWkq/7sMsE433+O264011Fa9KYVz4iXGLUq0kLmUeUXej
         k55e2P0+LOUj/rrnRcH0GRPhivIr//czWOmrNyJoGrAEw8evFHbZHpGEqf+NFgdvSQed
         DwSzzww6mt+nEx6DcaCp42ybiTIRYtIEXc/OTsAR3FdasuGsV9kmPAjNQZaEfvzh1Fif
         u6HHKEijaEulk7mddrbYe09BlivZd7lG6btDy0UfABnZ1qsfoczqZRE1xOtCM2AMVD1I
         2KgM0qRmY3DvmVX4SJF3u6rLu9Kqdk1ttS1m9vjglrisb8thYKIkdpu8EB0yqMpsF+gd
         fVbw==
X-Gm-Message-State: APjAAAUc3lzSr2c4ZGwybB7LsvUbaZGdqwH5937u1vDpXGUWSSSnk/1M
        UJgv9ACJ4i4Yrg7TOWF9dCXFjxqh9lNcWhjGZ6xl+A==
X-Google-Smtp-Source: APXvYqx9z2ouMjEeQz/Xavdg/AecETmTyPaGZA4hqLN0aYcZAhJk9Mdy7kggv+Ou1e8U8qRibYrlZ+Y1VuTCMVTyuFQ=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr3684654qkg.43.1576571932878;
 Tue, 17 Dec 2019 00:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191217051234.GA54407@google.com> <CACT4Y+ZV_syKQt6hDwf3WH5-LpFo==rsVsQY7+YCMfpUCtzj_A@mail.gmail.com>
 <20191217082449.GC54407@google.com>
In-Reply-To: <20191217082449.GC54407@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 09:38:41 +0100
Message-ID: <CACT4Y+bdvwSBTeqkfJ3kWMOB_QSq84TzumeoTzv89v3in-439A@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 9:24 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (19/12/17 08:54), Dmitry Vyukov wrote:
> > On Tue, Dec 17, 2019 at 6:12 AM Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > >
> > > On (19/12/16 18:59), Tetsuo Handa wrote:
> > >
> > > Can you fuzz test with `ignore_loglevel'?
> >
> > We can set ignore_loglevel in syzbot configs, but won't it then print
> > everything including verbose debug output?
>
> What would be the most active source of debug output?
>
> dev_dbg(), which is dev_printk(KERN_DEBUG), can be compiled out, if I'm
> not mistaken. It probably depends on CONFIG_DEBUG or something similar,
> unlike dev_printk(), which depends on CONFIG_PRINTK. It seems that we have
> significantly more dev_dbg() users, than direct dev_printk(KERN_DEBUG).
>
> Does fuzz tester hit pr_debug() often? File systems? Some of them
> have ways to compile out debugging output as well. E.g. jbd_debug,
> _debug, ext4_debug, and so on.

As far as I remember it produces an infinite amount of output on debug
level. Even for normal level it produces much more than one would
normally expect as it does random things all over the kernel with
maximum frequency.

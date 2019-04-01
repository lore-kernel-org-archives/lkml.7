Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B0B20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554154245;
	bh=91N3Odd3NnXopgNivjD5KnsCOlQmToWRjPZ+u577wC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dP4lfgbqu4o+eIOngkideXvVzMTq1EhuFsm1gmei/iYkmbxGOtRKfpWlFUwA3Hpr2
	 2YXHaDoLjPgGx0jxJSw3ypHNOjBouCXatCZ1wy0i7JdJVTxvjY2kvaV5T+QeCsXNrE
	 EpaasIVKPOCrsrzxlmDlx2KpgcSB2T6NBT8uMnTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDAVao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:30:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37495 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:30:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so9615520ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMXJ/m9oIy+nA+Cbm8U5H8R/R1W1YG/xRHF8Ie05RlI=;
        b=eC7fqbk8S/oTbA+EppWReoKiBnR4Nv8UdSoRwgs6E5Kt0/vRcWxhzXZNWDVE5uOmGP
         3y/wZssfhpm/YDnbrxN3D4e0u2hxXPkraykx7vdxBnbW0WP6bdIbHidvGmUz3TjWJhWO
         xGhfsJYBiKZ5f7QZyZvaxRmd3ca4Q9bjp9KMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMXJ/m9oIy+nA+Cbm8U5H8R/R1W1YG/xRHF8Ie05RlI=;
        b=IZXkSSZg11L422t6bgJEPJN305BsAb7YhhXJUOuOHMmWHCBcnYLZYjla1SOUQFV9JU
         JYMrQR0iLlRGPqA5TzszOw5xZvKOwKWzO6tVc16sYHTDIy159qhnIsSd2Tiaq2EE5igZ
         t124IUB0P6ytZ7nyEGwJzXqHFz/Pt7IvElTgpaRvCNbhMncgVisk39ves8esIoN53hfg
         TC0BG+S+ozsue8bW8aiduEHIDHtLkIW4JMAEGYk8cETjOJpxWN/t6fZAYYCu1/jcTYEZ
         rBxkXav2lXU5Ri3m68qRtWz18hOh6Ml6ZkiqOjzGV/E1Z/nwzpXgGq57/6xNwQipcj2q
         75dQ==
X-Gm-Message-State: APjAAAVTd6vSxfElSEQhkOBkNxxVCPuVzuY5c8LJXWGXcbLY3VsvTrnE
        wM8biTvNBLvuk3zT7p7EOvmuNr5FM0Q=
X-Google-Smtp-Source: APXvYqzRqR2cXqWbqVcLaPTnESAUpZ741uc5LS+1E1Bqq25AkYDflyYeWCILfPsMmTSZoHvsAKeFzw==
X-Received: by 2002:a2e:9bc7:: with SMTP id w7mr31076623ljj.58.1554154240711;
        Mon, 01 Apr 2019 14:30:40 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j9sm2391828lja.92.2019.04.01.14.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:30:37 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f18so9573879lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:30:36 -0700 (PDT)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr34853791ljk.78.1554154236323;
 Mon, 01 Apr 2019 14:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com> <20190401194214.4rbvmwogpke3cjcx@brauner.io>
In-Reply-To: <20190401194214.4rbvmwogpke3cjcx@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 14:30:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
Message-ID: <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 12:42 PM Christian Brauner <christian@brauner.io> wrote:
>
> From what I gather from this thread we are still best of with using fds
> to /proc/<pid> as pidfds. Linus, do you agree or have I misunderstood?

That does seem to be the most flexible option.

> Yes, we can have an internal mount option to restrict access to various
> parts of procfs from such pidfds

I suspect you'd find that other parties might want such a "restrict
proc" mount option too, so I don't think it needs to be anything
internal.

But it would be pretty much independent of the pidfd issue, of course.

> One thing is that we also need something to disable access to the
> "/proc/<pid>/net". One option could be to give the files in "net/" an
> ->open-handler which checks that our file->f_path.mnt is not one of our
> special clone() mounts and if it is refuse the open.

I would expect that that would be part of the "restrict proc" mount options, no?

> Basically, if you have a system without CONFIG_PROC_FS it makes sense
> that clone gives back an anon inode file descriptor as pidfds because
> you can still signal threads in a race-free way. But it doesn't make a
> lot of sense to have pidfd_open() in this scenario because you can't
> really do anything with that pidfd apart from sending signals.

Well, people might want that.

But realistically, everybody enables /proc support anyway. Even if you
don't actually fully *mount* it in some restricted area, the support
is pretty much always there in any kernel config.

But yes, in general I agree that that also most likely means that a
separate system call for "open_pidfd()" isn't worth it.

Because if the main objection to /proc is that it exposes too much,
then I think a much better option is to see how to sanely restrict the
"too much" parts.

Because I think there might be a lot of people who want a restricted
/proc, in various container models etc.

                   Linus

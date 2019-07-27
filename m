Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0051EC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53F2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564245708;
	bh=JSudOvumhUOsEh/n8w/ZGVBNNp2i0LBYPXVdZt5UtFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gk+sObIdnCGRrHgLBYOAbZn/fdEwqI5Zd5sbaBkNGqAuePdP0969LkBA4UJXvfr1K
	 c+P8UsNwutHU87SeLeSFu4KkhRbFm15L78nFnYO7xZ3U+/2k8zFXNJgc2xU4JWd9E+
	 /j2ePLuDufkr7dHaxSToHNesZE9v6a38r7HpRCo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfG0Qlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:41:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41269 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfG0Qlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:41:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so54380357ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URzo6r2h2/jBzyZ/IbgB9BNeTix2jmweMWplmeW7miE=;
        b=fUv1YrBBaXDgQir2L0b+1MYDz2FMOyGCVVhV3BqLC7Ynrf0k01/vDoIA/nLEk9UeCn
         ycwRuXTvxvUZ1/CLFddwJCNil6D/+omHdt2hn979QSKWvEKEbHFsr+k6yfvf6glxKqoC
         rWRXDRFy+5wsQTx9spjJ3c8Bvxfb+4qXzE1Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URzo6r2h2/jBzyZ/IbgB9BNeTix2jmweMWplmeW7miE=;
        b=IJRx0wZ4+fZvx864dvW531r7A4okHDjvdzmshmsRM+iE15KA3tiQoZ6gvzGVyA6jE/
         em6CKjPzC6H/ZR2U80f9sNNT/uC3lC5vgnBukGbssfza2uXS1y8auKLOWTBhLWKsHXA0
         D04F6HD8GZXJ9AYpInOSz5wUhPiyJGalmJKLj4JUl1jfA5q/s5jaa/ir/uwGZbR510wF
         1RrwvC1scx05aNHgE5PPm4ahjh2ltgSv04RqDm5rAdTKYuKAEGbHurMyOjwmxDuLBeDK
         BCGvSeNZS40kHLD61jNcRO6afctX6iju+WWZhGWf18s+IbgGU/pyx5GCB2uqGwAbsXYW
         nGEw==
X-Gm-Message-State: APjAAAUv1lsXTbyuXl2DPSROTdWj/DjCtS6o6zcExFVQw/RnwWsJrFSs
        QgjZDmutgUQg1d89UHBEi8zIXVzVxgY=
X-Google-Smtp-Source: APXvYqyUjGDYVgzJXIoUhmR/5UKA9po8NfgNO2fRQhITjR6spE2d8frf5CbQAgub5jBvHkMjRGyMPw==
X-Received: by 2002:a2e:9950:: with SMTP id r16mr35766982ljj.173.1564245704372;
        Sat, 27 Jul 2019 09:41:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m4sm11202697ljc.56.2019.07.27.09.41.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 09:41:42 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c9so39109500lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:41:41 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr48540131lfm.134.1564245701693;
 Sat, 27 Jul 2019 09:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190727085201.11743-1-christian@brauner.io> <20190727085201.11743-2-christian@brauner.io>
 <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
In-Reply-To: <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jul 2019 09:41:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtGyQTLLb7m=jkMY5hOcj+TsOKSoeoJC7Jc1_h_XL+tw@mail.gmail.com>
Message-ID: <CAHk-=wgtGyQTLLb7m=jkMY5hOcj+TsOKSoeoJC7Jc1_h_XL+tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 9:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Something like
>
>   struct pid *fd_to_pid(unsigned int fd)
>   {
>         struct fd f;
>         struct pid *pid;
...

I forgot to put my usual disclaimer about TOTALLY UNTESTED GARBAGE in
that email. I want to make that part clear: that code snippet was
meant as a rough guide of direction, not as a "this works".

Hopefully that was clear.

Also note again that one of the reasons I would prefer that
"fd_to_pid()" interface is that you _can_ do it cleverly with RCU
lookup, but that requires a lot of care.

In particular, I think all of our _existing_
"proc_pid(file_inode(file))" users are done while you actually hold a
reference to "struct file *", so they don't have to worry about races
with another thread doing the final ->release(). So the "clever" thing
is possible, but might need a _lot_ of care to make sure the 'struct
pid *' associated with the file still exists.

The example code sequence was not doing the clever thing, obviously.
So it was untested _and_ simple-stupid. But it has the interface that
I'd prefer.

              Linus

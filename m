Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78105206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiJfEFfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfHXUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:18:12 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35578 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfHXUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:18:11 -0400
Received: by mail-ua1-f65.google.com with SMTP id m8so1644998uap.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zfEO+Of97f0VCldvVRJl3jzEF01O6soGli/loZclzk=;
        b=CiJfEFfo1GhUFTvULOmIWC5bky0UhNotA9EofhxO4+2Cd9KvnmBRPB6hGuQFhuAXwJ
         Mf7+XdP/Zb4xXtjIaOfMfbMaQpe98nHR1WFAIDUqUl6lSfoh5N6YkchHMEss2Z7wmXRv
         mIN1BXAFZpi+SynQvspsYrZxrH8jV01EUoqVt4oI5oVTwO6tctGVNu+Gx+DZX4YcnnWT
         pUO0Oeafs9qrk8HXoIhQUWukfn1efWZ6t1CZQkpVU6dxRoB/3gD8bO7d0APRfzkEuP01
         6A3Oop2AiXmYSlChvGG9uj5KK5z6ZoLIIlfJYts9owMo4k3T92eSIqfy7wB0W5m6uFPz
         fndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zfEO+Of97f0VCldvVRJl3jzEF01O6soGli/loZclzk=;
        b=KfkXl1ZPTI5L1SAFuAGP/If5vohiVwzLlFFVCgPFd7rDJRX190wd6dmFlUgKNvTQqN
         vAvVM/UkJlx6+o2zCN6D7nKZKHZXS/V4Y8arBvBp6KCbWfQH0UxvL0FYsvhEcfpTZ7qs
         wTHlH4SSXu9jdOQZ/aWjp09OaVy4FO4QZpcp1UF9Hy6gvKIfJA4t8U0U9Rn8uNNhquO3
         yP4zeikiSQ1RNkFRHB6l5pwT/xUMLWkanXN9oWl3guS7e6hjPbgxFnwbIu/a8oCQDFk8
         iIHoiGSAyz6hxYMLFD9yi/ru2MhmVhpmuvKRrn8vf0Z2GQXIA48VXEHs6BdN3+H2vtmD
         LprA==
X-Gm-Message-State: APjAAAW0wl4ogyc1Bt8kLvh32cXN2onmkpCcSYGj1ItH9WtR3pHkPFa8
        U4Eg94+mHJcKFPQUjkYftbEReoqjT91Ael3UG7Arrw==
X-Google-Smtp-Source: APXvYqxjVPBCRB+CRwr4t5I/R3fEcc9xAf9hOK0mmX0eHtTD2rTNJ8/siW0Z/MdtMGoJdUYWfX/KXqMK5Snr1pytTE0=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr5623819uae.85.1566677889720;
 Sat, 24 Aug 2019 13:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190820033406.29796-1-cyphar@cyphar.com> <20190820033406.29796-8-cyphar@cyphar.com>
In-Reply-To: <20190820033406.29796-8-cyphar@cyphar.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 24 Aug 2019 13:17:33 -0700
Message-ID: <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:37 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> The most obvious syscall to add support for the new LOOKUP_* scoping
> flags would be openat(2). However, there are a few reasons why this is
> not the best course of action:
>
>  * The new LOOKUP_* flags are intended to be security features, and
>    openat(2) will silently ignore all unknown flags. This means that
>    users would need to avoid foot-gunning themselves constantly when
>    using this interface if it were part of openat(2). This can be fixed
>    by having userspace libraries handle this for users[1], but should be
>    avoided if possible.
>
>  * Resolution scoping feels like a different operation to the existing
>    O_* flags. And since openat(2) has limited flag space, it seems to be
>    quite wasteful to clutter it with 5 flags that are all
>    resolution-related. Arguably O_NOFOLLOW is also a resolution flag but
>    its entire purpose is to error out if you encounter a trailing
>    symlink -- not to scope resolution.
>
>  * Other systems would be able to reimplement this syscall allowing for
>    cross-OS standardisation rather than being hidden amongst O_* flags
>    which may result in it not being used by all the parties that might
>    want to use it (file servers, web servers, container runtimes, etc).
>
>  * It gives us the opportunity to iterate on the O_PATH interface. In
>    particular, the new @how->upgrade_mask field for fd re-opening is
>    only possible because we have a clean slate without needing to re-use
>    the ACC_MODE flag design nor the existing openat(2) @mode semantics.
>
> To this end, we introduce the openat2(2) syscall. It provides all of the
> features of openat(2) through the @how->flags argument, but also
> also provides a new @how->resolve argument which exposes RESOLVE_* flags
> that map to our new LOOKUP_* flags. It also eliminates the long-standing
> ugliness of variadic-open(2) by embedding it in a struct.
>
> In order to allow for userspace to lock down their usage of file
> descriptor re-opening, openat2(2) has the ability for users to disallow
> certain re-opening modes through @how->upgrade_mask. At the moment,
> there is no UPGRADE_NOEXEC. The open_how struct is padded to 64 bytes
> for future extensions (all of the reserved bits must be zeroed).

Why pad the structure when new functionality (perhaps accommodated via
a larger structure) could be signaled by passing a new flag? Adding
reserved fields to a structure with a size embedded in the ABI makes a
lot of sense --- e.g., pthread_mutex_t can't grow. But this structure
can grow, so the reservation seems needless to me.

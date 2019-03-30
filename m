Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91C2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553962170;
	bh=7e3mC5bpvn9PPaYCiJ38W6lX7L61veK4wh8eYeu/JVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CyC8YmkuFDYuvEnVnm4O7io3yZJKMKz7NRYwlS5RUdz9nxAG8LKafz3u35DjDAXI/
	 vb+XErTB4LSjV6q83E2RXcKg4upG3GaWxnkCzXN7dHZdRuuxCWE9pL9SPo+jZFd+96
	 RNGNj0Tgkb0x/KXyNw+llYhFDHhc9LUAEvHmQPb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfC3QJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:09:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35247 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfC3QJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:09:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so4516497ljc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoGUtS9aezEjh657hTxl/2nLS7gtTCX3mBgWFI/otHk=;
        b=KWq5bClZrtD2QuethBOJCCzwEJppfjZBsZLTGiLsWKEQKxLFPm9Xm2Jgtw6niIyN4i
         xwpVwq7Kqs15vLxyPXGNPBTsXJgjs76055HvxZxOkiAlk2qimGBSO22Uo5f9x2+NB8qF
         MuIV/iWYvCJHqrfU/luhOrxNr+ZysZ4NZXswA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoGUtS9aezEjh657hTxl/2nLS7gtTCX3mBgWFI/otHk=;
        b=W/6pcIRQ5mOz9nc/FmTN3vlUZ5gakeDLEPelz4a07JeNAkR3HYE5B5f4oofdclwZuN
         HDcKcfdsU3O08UFOseZHOq1eqqXvZXResQux7PqhJ5tZhXufpy3M9bukslCjcTCPvMVy
         e5/GWN3RlhodAAVzw7hRIUmQq1ASNu25qU7n10+2Wc+DwnNZ64rTydGR/XZLLxGHYyje
         rZmPYrd3GeVv807yH7nmFPGU3MVkXi9bsUp+m2439ZUdClpOyUd6Fm5ikKjj7OPp3o1B
         LqJLi7WO3xweYT3b5mfDXAuRo4JSH2Ni/SMlLvFTnbGD02FNc4aSh+0xNsvYzdBfpNQt
         U18w==
X-Gm-Message-State: APjAAAXjHb0Mlc0EtwQ5pNeb1b7pfExlkRHbwXUrjTt3C0S6asTPFgjT
        +s8fAgsxrrLKrV9oPL6uNkrHxFUL9bQ=
X-Google-Smtp-Source: APXvYqwt1zzRNzbTXOMwi0UscP4gk1xqzo2Pgqc7DrMtLvFAUePE2NEJzhg6vPLpioFqhktZWZ6wEA==
X-Received: by 2002:a2e:974d:: with SMTP id f13mr29782703ljj.140.1553962167062;
        Sat, 30 Mar 2019 09:09:27 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h14sm999402ljg.10.2019.03.30.09.09.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 09:09:26 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h16so4466809ljg.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:09:26 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr23470417lja.125.1553962166079;
 Sat, 30 Mar 2019 09:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io>
In-Reply-To: <20190329155425.26059-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 09:09:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
Message-ID: <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, serge@hallyn.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>, dancol@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 8:54 AM Christian Brauner <christian@brauner.io> wrote:
>
> /* Introduction */
> This adds the pidfd_open() syscall.
> pidfd_open() allows to retrieve file descriptors for a given pid. This
> includes both file descriptors for processes and file descriptors for
> threads.

I'm ok with the pidfd_open() call to just get a pidfd, but that
"pidfd_to_profs()" needs to go away.

If you want to open the /proc/<pid>/status file, then just do that.
This whole "do one and convert to the other" needs to die. No, no, no.

                   Linus

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13733C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A5926EF5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559335131;
	bh=Ia3uU7zptpBxmPwJTDxGE7gxED8i/K+dmysJH1u5vtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sm3oGPa3VLAE/Epx+kZ6PfTa0k9UFnBDoVFvyJrkNx2cKHUHORC/uGxHSlmzmqzcE
	 Mpvbj+GBLMhSudZSI259h1v4jQlq8wq2gmfvNSMp9XkFyQE1SIKObQ97JD5ZScnD5Q
	 OSD//+od92PxtRm5yaB9T/yO2mqaciHOXb7K9iGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfEaUiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:38:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34963 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfEaUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:38:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so10878850ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJg5QUCA0uPT2F+o9Dh7JaPgMKMdBBZHboAZ09rcF54=;
        b=HfKC+uYBIngRJFypqrkOc0/UKsvYuqY5793NSQ4XY5ZlXJ+nUBECGXpPw/5aGC59wy
         JFNPgtG+Ghy8dk7PmRHD9Jb6iiamQbvnEB3o/mJLZs5MdHJjv1mMjI0sDXPSMAIL9FZE
         M+O9r4iy3Y5UUwrhzyC/sNO6wPFFFmD2vNTz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJg5QUCA0uPT2F+o9Dh7JaPgMKMdBBZHboAZ09rcF54=;
        b=q5Z5WbOcLcJX66O5LKWJGV7WeGtiA5ZeiGpi4rZkaFILem2qTjudtr8io/xx+uQXUV
         22NFV5sP+gDOAkUMH6VWKv1gBGiBObYuhn5U+tbxgs1zopIWv5Htk2CS2qIIcdZKDGGM
         OA4kAuvBthm1rw+xeoazMqtoWpG+eZxO8n+aA1bP1wExnnedHiWMEiMaJdb/y/HZyOC9
         lef1K3L30pNzNXnMxRBWBN00NQxjKiHfXa3PgfUTDUrT/s4cQ40iQY/z2LRGTU9rRlib
         D0DjW/1WcNiguvkcSgYH9MoDhsqo02qm7gPqHPi/KfQ0BfqROzp8d+sJQKHfdv6XBZDY
         RrwQ==
X-Gm-Message-State: APjAAAXEIC4BEzZhwuUf2/iRq6IbnIpl0PcQ/I9+jylWOuZfc1lH/Bhm
        SIu1QjF2qbM+CwcW31WZsijbwsPRDjA=
X-Google-Smtp-Source: APXvYqyiTEJ0dYYzeDcFlT3KTCgOKV62W1Ca0CxRgcOYzMM6t7LbUEgcK8faNKckJajCEWR3pIaupA==
X-Received: by 2002:a2e:7001:: with SMTP id l1mr7074142ljc.11.1559335127642;
        Fri, 31 May 2019 13:38:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s20sm973471lfb.95.2019.05.31.13.38.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:38:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a10so7611820ljf.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:38:45 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr6980173ljj.52.1559335125640;
 Fri, 31 May 2019 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190529152237.10719-1-christian@brauner.io> <20190529222414.GA6492@gmail.com>
In-Reply-To: <20190529222414.GA6492@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 May 2019 13:38:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
Message-ID: <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fork: add clone3
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 3:24 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> Thank you for thinking about time namespaces. I looked at this patch
> quickly and I would suggest to move a termination signal out of flags. I
> think we can add a separate field (exit_signal) into clone_args. Does it
> make sense? For me, exit_signal in flags always looked weird...

I agree - the child signal in flags was always just a "it fits" kind
of thing, and that was obviously true back then, but is not true now.

In fact, if we move it out of flags, we'd open up new flag values for
the new interface, in that now the low 8 bits are freed up for more
useful things.

In fact, even for the old ones, we might just say that instead of the
full 8-bit CSIGNAL field, nobody ever *used* more than 6 bits, because
_NSIG is 64, and we've never actually had named signals > 31.

(Yeah, yeah, somebody could use signal 64, and yes, mips has _NSIG
128, but realistically we could get two new clone signals in the old
interface and I think nobody would even notice).

In fact, all of the CSIGNAL bits are ignored if CLONE_THREAD or
CLONE_PARENT is set.

                   Linus

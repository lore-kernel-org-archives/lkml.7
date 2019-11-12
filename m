Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016CBC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91E820674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bNxjrx04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLXDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:03:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41832 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:03:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so12840626pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soAK6mR7/nlH57wscE6Anu+LxHtbszZd20gXy3dqtds=;
        b=bNxjrx04Kt52AdGurWf++izr0TcUWE+iYJy7xJCbvM+w+E/MiddxwrF5h3mu5PeZKw
         DHa4bg/tfGyMpe1pGUgEUT8A6iMzek4x5HopvI+08asWwi2Rb65z1gdA8Q9/z6PVbQaq
         iRhFfpwdXXcp981sv9EZnSPA4rEl9wDxUloj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soAK6mR7/nlH57wscE6Anu+LxHtbszZd20gXy3dqtds=;
        b=EFT8oR6w9bzM+AO1kUyYLmbIzbmt2Ywl5XtafSJ3lhxBpzZzLGPHtBZwJXwUZiWciP
         Sm2MWoVzE8WXDmyrPzlZOMEme73/ID9VFtM7KF3qUYL+VCcNLc0V5NCbavvhjrV8Dj/T
         YiqYiwuIUNr9wNbqV6GyHtD6XNmN6Erv31PF/9nZEEIWI47FgTLMmkQPrtsKQQinwAby
         p6jlUQnvoF/ZVphQ1teJQnpKuH1Un2KoypIxdmcvKfK9Ou2B6k0vvU57pFeSEFQUOBwA
         csk3KraqJsR9rQd5j14GK5EmQg2BKw+CjiIMukmYSrfPt8Srsaqd7xC6TAvWLFaNadTk
         Dv3Q==
X-Gm-Message-State: APjAAAV3COR2dG/kNF+vfn6ukkFcgPsNGBHd93PNXU7Qgc+EJfiQ+X6h
        MuASIkGqXd7z10oF6KlKCfTgOA==
X-Google-Smtp-Source: APXvYqyTTxwcPuc1qZNwB4971E9nj9vEsULrk0Nc2D0CgwZfZ4ItP+YMjk1mY+/0xAfOV9FfqS32+A==
X-Received: by 2002:a63:3cd:: with SMTP id 196mr31871pgd.150.1573599809214;
        Tue, 12 Nov 2019 15:03:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r22sm33477pfg.54.2019.11.12.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:03:28 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:03:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <201911121502.3CADFBE3@keescook>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
 <20191111165800.GD7017@mit.edu>
 <CAG48ez3K6g7NSFmeuw-4paqPQTDYmNkZ-nVvufk25EB+Us850w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3K6g7NSFmeuw-4paqPQTDYmNkZ-nVvufk25EB+Us850w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:24:33PM +0100, Jann Horn wrote:
> On Mon, Nov 11, 2019 at 5:58 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Mon, Nov 11, 2019 at 03:55:35PM +0100, Jann Horn wrote:
> > > Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
> > > was announced here:
> > > <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
> > > Basically they periodically check whether the userspace stack pointer
> > > points into a MAP_STACK region, and if not, they kill the process. So
> > > even if it's a no-op on Linux...
> >
> > Hmm, is that something we should do in Linux?  Even if we only check
> > on syscall entry, which should be pretty inexpensive, it seems like it
> > would be very effective in protecting various ROP techniques.
> 
> I'm not a big fan, especially if that would only happen on syscall
> entry; at the point where you have enough control to perform syscalls,
> it probably isn't too difficult to move your ROP stack over to a
> legitimate stack.

It does have "your process is doing something unexpected" checking,
though, if we want to declare (and enforce) the expected behavior of
userspace stack usage. (i.e. not strictly as a ROP defense.)

-- 
Kees Cook

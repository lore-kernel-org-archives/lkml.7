Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DCDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E102820645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yc7BySIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfDSTFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34478 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfDSTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:05:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so2933122pfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdlqMNaLNIUwAQPpuXGhRQfoDFNz32pxi9mvWn75Usc=;
        b=yc7BySIbEieSuzGNYU3PloZV2SqBj/vts66Bq7IE7Ccr3AvIRcxGFEUFvbJ6Ma0ucV
         NSmkoVDbDQEZhwGgh1Jp/E2B9+DieYltLy2D1WDGZPgkRd6yaFFvMr3jIwaefOxdaH4h
         /EsGItuGBYRKibUEykMMXnvv2Cs7mRHbKS9G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdlqMNaLNIUwAQPpuXGhRQfoDFNz32pxi9mvWn75Usc=;
        b=e6oOOZGRmtxD3n9A+NDbOH7lrII6t5LPR1L5GMEfIh3fTinf2jG10PAeCCp8WLgE1t
         OVmJDj48NruUufoHxgXpr/zej7th5b56/OVS+xJHiOg0XlO/6Kh8zlFSUs++2e6ZKGXo
         q11rt+pnW/d1fWYn1gMd0z6O3PDeDakCL4EVo3BraNbOSmtQ3vUxD41aLvOIKJFQvXlf
         UQbeHwzH8RL8bf+tgVqNLcDO3Lw3OpW2F4vzeHfrx9OgW5QvPZ88QmXbbGoJGD2ukTLJ
         lP3DRF8mW9X2QTXHUhW1O6wUB3GRWaKkVx943TNygbzjj7kdC+o1s78RvVKrSCQD6jNz
         01kg==
X-Gm-Message-State: APjAAAX0jMx9FyBkPrKVx7/K3hntEAH7a0/Fb46HwZljAVxR/GjBgwiK
        KGIy4X1/4Jo5jvkM3p3SGh4C8w==
X-Google-Smtp-Source: APXvYqxfXeP0ss2yu9sHSgl32QGmwYH8C7fTjqqNZzhIoXGrLYj/21HDPSW56qW0FC9k2gzhqNC8Bw==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr5549867pgh.263.1555700740202;
        Fri, 19 Apr 2019 12:05:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q24sm9246042pgm.16.2019.04.19.12.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 12:05:39 -0700 (PDT)
Date:   Fri, 19 Apr 2019 15:05:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419190538.GC251571@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <CAGLj2rELsr0PUgu41uZX_TKCpT-Q00X+cvgBhJ-U7RU3EBo5tA@mail.gmail.com>
 <CAKOZueu=5aNf+oDFBM56TbqZwKpB6q1y81V1cbL+k4DTyV53+A@mail.gmail.com>
 <CAHk-=wi79KTxCYZgMZNapULR-ratPiZVt+fgh=DhgtYR_gYPAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi79KTxCYZgMZNapULR-ratPiZVt+fgh=DhgtYR_gYPAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:14:58PM -0700, Linus Torvalds wrote:
> On Thu, Apr 18, 2019 at 11:58 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 11:44 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> > >
> > > Would using something other than POLLIN be an option (maybe POLLPRI)?
> > > The convention is to use it to indicate readability on the descriptor,
> > > and also possibly POLLHUP instead of POLLERR (the latter is less of a
> > > problem, but FreeBSD also does the same, so it'd help with some
> > > consistency for libraries wanting to use this, which aren't interested
> > > in other sub states).
> >
> > Existing event loop libraries generally support checking only for
> > readability and writability. Not setting POLLIN would make these FDs
> > more difficult to use with existing event loop libraries. What
> > advantage would compensate for this difficulty?
> 
> Right.
> 
> Usually you'd set POLLIN in _addition_ to any other more specialized poll flag.
> 
> For example, when a socket has shut down the read side, we do
> 
>         if (sk->sk_shutdown & RCV_SHUTDOWN)
>                 mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
> 
> because while it's true that EPOLLRDHUP is the most _specific_ poll
> bit, it's _also_ true that a read shutdown means that the read() will
> return immediately.
> 
> So generally a HUP condition should mean that POLLIN and POLLOUT also
> get set. Not because there's any actual _data_ to be read, but simply
> because the read will not block.

Sounds great and I agree with Linus and Daniel. So I am guessing you are Ok
with the current set of flags proposed this patch, so I will keep them intact
in future patch postings. But please let me know if you want me to change
something about the flags.

thanks!

 - Joel


Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25783C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F128220835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCGIFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:05:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35698 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:05:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so16079962qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyS5PIyHbEzMeUuqAgjGcHWeinlFgTIy5Dp7cS+QVdk=;
        b=uccuLIewYu57zZIiMNNTTLyoUlREoSRY4wiOlIiLMJ/1KIA4LcVjQTtndPTTb1zqT6
         +ZtnjNqaVqlqkjJLL7Du/W1jFbTbPRRKkCbJDhHx4oGQUFv0pbcBJty3rIWWYe+H69HQ
         dwQ8iaDx5d8GvleI7SXcvOevT9UFYg5ms0FvTUvtARo/nxE7WtsesbJLxyU0J+OKCUOa
         aPzeBj5UxRbOcSkwOfImTUTp7bMPsiBQ7mJRD8ligiLDYRG8JNwtzMqtPWwa/DN07Nte
         acSsV8XHr58w5cBGvQ7P1Cj8AYsluWAYNUWvLWDDhXRxpktGppCzxfv4sxMjkfsA63oH
         TpVw==
X-Gm-Message-State: APjAAAWYbpvFNFJ6/PEAIG3dbbS80IMXSojvEfIY7JbrVRqGbgKVUO3b
        qtdt7UzQVwpo7MUklHWvwLRTmzZMHQyyy72/OXI=
X-Google-Smtp-Source: APXvYqynfxtE6Gd5kK0CkQacjpBvaclWuqrf4dML6duL+ZDc9KY5CiUXymmZFdEaDU6NIn5iAoNEMkrRmEtiAaYTRxE=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr9049663qtb.319.1551945938715;
 Thu, 07 Mar 2019 00:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20190305162351.5aadde66@jawa> <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
 <20190307085329.2b6cbeb7@jawa>
In-Reply-To: <20190307085329.2b6cbeb7@jawa>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 09:05:21 +0100
Message-ID: <CAK8P3a3GotM4WY9dJK8yPujxLgHXtnes=nMUKq5fJ4hTkZWqzg@mail.gmail.com>
Subject: Re: [Y2038] Question regarding support of old time interfaces beyond y2038
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Zack Weinberg <zackw@panix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 8:53 AM Lukasz Majewski <lukma@denx.de> wrote:
>
> Hi Zack,
>
> > On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > From other discussion [4] - regarding the following system calls:
> > >  time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> > > alarm, getitimer, setitimer, select, utime, utimes, futimesat, and
> > >  {old,new}{l,f,}stat{,64}.
> > >
> > > "These all pass 32-bit time_t arguments on 32-bit
> > >  architectures and are replaced by other interfaces (e.g. posix
> > >  timers and clocks, statx). C libraries implementing 64-bit time_t
> > > in 32-bit architectures have to implement the handles by wrapping
> > >  around the newer interfaces."
> >
> > 1) We should be clear that most of these will continue to be supported
> > as C library interfaces even if they are not system calls.  Some of
> > them are obsolete enough and/or rarely used enough that we might not
> > bother (the older ways to set the system clock, for instance).
>
> The question here is about the decision if even the old time APIs shall
> be supported on 32 bit systems which are going to be Y2038 proof (like
> the 'stime').

See my other reply. In the kernel, it won't be supported (the old syscall
is of course still there, but we may have an option to remove all time32
interfaces). In glibc, it's probably there in a y2038-safe way since it is
there now, other C libraries may take other decisions that are independent
of y2038.

      Arnd

Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331EEC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0629A216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGMFdpC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGLQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:48:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGLQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:48:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so4532704pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni09UiARp+MdsV5i46eFbEoOGcDLZp7mIU1Zcn2V3hU=;
        b=QGMFdpC6Ax4a4jxtRfFBEfMG4AWSqkF/V9jBSOoJHnuHzdse6x8BK7J3S3ABLBDkY0
         dzvj+CRYeX0umfh5O/Q6O1zCrKithtOUuo0RHdyLYwUGsQ66rD6+I38FhmMO06PxTkQG
         LuCcINmPOeCkMARm3HyGLixgQx6+YGgO+4DO77m4GVfFQp5REnXHcjd6gDCfTagu8wyY
         VZRHEIXd1wewNnMN4yPrmzNcEbp0qSaJ6X6TpIvP0ZRkaowyUHHb/Lj7t87li1kmbhki
         pNBqwH/emx6P+2CS9+uzmGygtNX8Z70EZSzDBbF4ya1+two3smKizAuwR7779/Mo3roS
         eEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni09UiARp+MdsV5i46eFbEoOGcDLZp7mIU1Zcn2V3hU=;
        b=JCurJ61z9pccAP+A9iHWSaNmZeKnbENGat79ubcrUxuLnLCRE2Op27DWUPtu6Hyo0M
         2d1vjkzHII4nHiNO1/pt9luqKwq4gXpH7qZwKVwBogisWIMGKd1PcDkN4Kyr3VAgC7VZ
         fUQM+B1CGozXZ97Clpw2rNQzyaLqOec4Fd0YSlsjBa0xD/6AGq++DQJc/3PHNsI55jB3
         a6DE8p+G141oarRIdmOwSrEEbUG/5pWGn8Uly/x/UyD5tTkw7dLScpyN9tgxmb7UHaIY
         J8so3XAI1nLI2E/FC5lvHZTdbGvJOrhXig7VJK7rqjvI4UvaGmR1zDpMykdq6M9eGmRI
         9BKQ==
X-Gm-Message-State: APjAAAWudMASWO93HpvC1Sk3KwqpXFMBW0JohfSsJ0LCBkjNhPlimKSk
        0eKysTXWCrDgjjPF81sdytlJVAnsGGdgZnRkKXtJtw==
X-Google-Smtp-Source: APXvYqySR2tx+r/ihp3uBr6JjtggdOxUMBs98H8Kes0shjcInwAnHMzSQHGzS+DDrh8Lcm4Hhe0FrkG67u7TJToFUiA=
X-Received: by 2002:a65:5687:: with SMTP id v7mr12062329pgs.263.1562950099845;
 Fri, 12 Jul 2019 09:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190703081119.209976-1-arnd@arndb.de> <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
 <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com>
In-Reply-To: <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Jul 2019 09:48:08 -0700
Message-ID: <CAKwvOdkOG_fcJLc-2mFUUp9N1CrJ6EcnZjpraHsvfTsmiKX4SQ@mail.gmail.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 12, 2019 at 2:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed,  3 Jul 2019 10:10:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> > <scratches head>
> >
> > Surely clang is being extraordinarily dumb here?
> >
> > DECLARE_WAIT_QUEUE_HEAD_ONSTACK() is effectively doing
> >
> >         struct wait_queue_head name = ({ __init_waitqueue_head(&name) ; name; })
> >
> > which is perfectly legitimate!  clang has no business assuming that
> > __init_waitqueue_head() will do any reads from the pointer which it was
> > passed, nor can clang assume that __init_waitqueue_head() leaves any of
> > *name uninitialized.
> >
> > Does it also warn if code does this?
> >
> >         struct wait_queue_head name;
> >         __init_waitqueue_head(&name);
> >         name = name;
> >
> > which is equivalent, isn't it?
>
> No, it does not warn for this.

So I think this is just a bug in Clang, where it's getting tripped up
due to the GNU C statement expression.  See the example I put in this
bug report: https://bugs.llvm.org/show_bug.cgi?id=42604

Clang is warning for this pattern of struct assignment, but not for
non-aggregate (integral) assignment.

(I think that pattern is pretty cool; it makes it more straightforward
to provide macro's that properly construct aggregates in C; in
particular I feel like I've been looking for something like this to
simply the use of __attribute__((__cleanup__)) to do RAII in C and
make smart pointers, fd's, etc.).

Let's fix Clang, drop the kernel workaround, and thanks for the discussion.
-- 
Thanks,
~Nick Desaulniers

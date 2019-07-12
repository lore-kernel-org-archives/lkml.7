Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E817C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69949208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfGLHpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:45:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41420 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGLHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:45:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so5720307qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 00:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zDvUGnwlFGzvagKhUVJk8facxGemI4EdWJj1iZGmhg=;
        b=A9CU1nUQb52qKCcR6YmsIgySoVqQdo+45AeW5UI4UkwseoJRRZ2UOE3Jvxf9ga+UNM
         GiYddje1WG39rq7Ti6AM/Ru5sxWPIgQ8t79ZYUIRoAQDVc7vnJd2K75zL7eFkpi+siSn
         eVGkPrbFsUDkldOBtNrgwV74HoL/YH8kscexsmiyeJMQUn7nxkkA+Ds1aAcXuhBQ1Dzj
         Nych8e/i+u87+WRjwi7JpHBufd2CUdGTyrdlwzNzLHYMtl5DPJywrhYwcPxucOcPlUaE
         sJbE+MNIdqfNl82AvZ6Q0tYFHThdYUyYR7ohb83lSaFrqzbeRMIfAfv7rEpYxihtSl7Z
         ixZA==
X-Gm-Message-State: APjAAAW01CBQswOTMkaj6SEuTPxMySc+LbNoFv+GlOilcLo+2xrER5UP
        M5OEcTxmMgrNKX24g0pHmXuYUyMmu1TUwBkoLwA=
X-Google-Smtp-Source: APXvYqzKaFVFH4FWCYrJDt+ENzHkf8xn407Kw66iBAjC78XR6zlfCepjBXeXRQwBVRRfIob9JcCYo4r1erXbXpmbelQ=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr4940302qka.138.1562917523902;
 Fri, 12 Jul 2019 00:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190703081119.209976-1-arnd@arndb.de> <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
In-Reply-To: <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 09:45:06 +0200
Message-ID: <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  3 Jul 2019 10:10:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> <scratches head>
>
> Surely clang is being extraordinarily dumb here?
>
> DECLARE_WAIT_QUEUE_HEAD_ONSTACK() is effectively doing
>
>         struct wait_queue_head name = ({ __init_waitqueue_head(&name) ; name; })
>
> which is perfectly legitimate!  clang has no business assuming that
> __init_waitqueue_head() will do any reads from the pointer which it was
> passed, nor can clang assume that __init_waitqueue_head() leaves any of
> *name uninitialized.
>
> Does it also warn if code does this?
>
>         struct wait_queue_head name;
>         __init_waitqueue_head(&name);
>         name = name;
>
> which is equivalent, isn't it?

No, it does not warn for this.

I've tried a few more variants here: https://godbolt.org/z/ykSX0r

What I think is going on here is a result of clang and gcc fundamentally
treating -Wuninitialized warnings differently. gcc tries to make the warnings
as helpful as possible, but given the NP-complete nature of this problem
it won't always get it right, and it traditionally allowed this syntax as a
workaround.

int f(void)
{
    int i = i; // tell gcc not to warn
    return i;
}

clang apparently implements the warnings in a way that is as
completely predictable (and won't warn in cases that it
doesn't completely understand), but decided as a result that the
gcc 'int i = i' syntax is bogus and it always warns about a variable
used in its own declaration that is later referenced, without looking
at whether the declaration does initialize it or not.

> The proposed solution is, effectively, to open-code
> __init_waitqueue_head() at each DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> callsite.  That's pretty unpleasant and calls for an explanatory
> comment at the __WAIT_QUEUE_HEAD_INIT_ONSTACK() definition site as well
> as a cautionary comment at the __init_waitqueue_head() definition so we
> can keep the two versions in sync as code evolves.

Yes, makes sense.

> Hopefully clang will soon be hit with the cluebat (yes?) and this
> change becomes obsolete in the quite short term.  Surely 6-12 months
> from now nobody will be using the uncluebatted version of clang on
> contemporary kernel sources so we get to remove this nastiness again.
> Which makes me wonder whether we should merge it at all.

Would it make you feel better to keep the current code but have an alternative
version guarded with e.g. "#if defined(__clang__ && (__clang_major__ <= 9)"?

While it is probably a good idea to fix clang here, this is one of the last
issues that causes a significant difference between gcc and clang in build
testing with kernelci:
https://kernelci.org/build/next/branch/master/kernel/next-20190709/
I'm trying to get all the warnings fixed there so we can spot build-time
regressions more easily.

      Arnd

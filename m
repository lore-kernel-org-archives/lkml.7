Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F06C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3B2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogP3Zy3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfFSRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:41:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFSRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:41:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so100011pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TIWmFG9D6KuYaPFIMfBgrrfumRxehwTCrylwENN8xU=;
        b=ogP3Zy3tnbLA3NRbrm8pfcXaJEJp4mx7LgYEInZBCECHgHYG2R6gOOeTzB9sArGh/8
         ZLxrMSPp0DuvAwLzLoqVDXbLLtJFzdRQI5yHswt7FVbzgzusC8aj9lzhMm6eU0Jjp3hO
         Wd4rGk8YJqq7zMH8YdE0vDIS+Ey36+/dsv5XmxIawSfzvtlswqgh9dvg1cQY6y5g+fd7
         Ljm6TTu4lb5w9MZijiRtayY+n+kwjLm8v2qNLVZeW4RrYwSJNtrwMJjRiVbH/VLi7wLA
         qlL91n+rf2jZMSWVyNzB/ccbhQ3qUOwFXKUyD3L6U5Xhsld0FKLR4gAsh27v5/ONYaAf
         7vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TIWmFG9D6KuYaPFIMfBgrrfumRxehwTCrylwENN8xU=;
        b=JJzuVLlYWb0Cq1nA/LVTKmrHB9drALW4KGZW1S5rxtu/7EdNotWbXQwZj0aYAPyOoV
         un5bEk2TmLwgsBwmk1rVkAZWc0YWQesv1wGPO8YjcsPHG9xnqVx7sQo/DSYoO0gjTXE2
         oCvp4xJOiGtlKD9f4JDxRsQ2YjoYjBVyghbcJMKfwgtCrO+MB6PsIRptroXPxCbdYj+Y
         svhdIbRD2jz5qPs5mObRJnfRs0aGkIBkY/qQ5JmM3yY+PfjLg3N0pIrR8vfKvqfeosLX
         XHulX4qcTUxrpGp93BYUzWA35jkfXEsz7BHOXtZJ6w+Nb8887SoPWxFjltw3pIU8l5OX
         jGfQ==
X-Gm-Message-State: APjAAAWQhj5X9kNXM4sxv0nSh4tieetXN8lrHTuXCI33bjSUpvofk/OZ
        1Mt1sNlsmV1rdJ624XIwLC9Mr3a6FnXdxWI3esmXQg==
X-Google-Smtp-Source: APXvYqy+enr3Ts5pw8yfp3XBlK7WV6lAGqKMLC8GD484atRHugjWP233gEQrAu2FKMbtShYw2c3OSlB5XWLQw93/s54=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr115353335pls.119.1560966089069;
 Wed, 19 Jun 2019 10:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190618211440.54179-1-mka@chromium.org> <20190618230420.GA84107@archlinux-epyc>
 <CAKwvOd=i2qsEO90cHn-Zvgd7vbhK5Z4RH89gJGy=Cjzbi9QRMA@mail.gmail.com> <f22006fedb0204ad05858609bc9d3ed0abc6078e.camel@perches.com>
In-Reply-To: <f22006fedb0204ad05858609bc9d3ed0abc6078e.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Jun 2019 10:41:17 -0700
Message-ID: <CAKwvOdkJCt7Du01e3LreLdpREPuZXWYnUad6WzqwO_o4i0yk7A@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 2:36 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-06-18 at 16:23 -0700, Nick Desaulniers wrote:
> > As a side note, I'm going to try to see if MAINTAINERS and
> > scripts/get_maintainers.pl supports regexes on the commit messages in
> > order to cc our mailing list
>
> Neither.  Why should either?

Looks like `K:` is exactly what I'm looking for.  Joe, how does:
https://github.com/ClangBuiltLinux/linux/commit/a0a64b8d65c4e7e033f49e48cc610d6e4002927e
look?  Is there a maintainer for MAINTAINERS or do I just send the
patch to Linus?

-- 
Thanks,
~Nick Desaulniers

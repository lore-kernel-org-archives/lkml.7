Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D534820820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6iTeezr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDJVvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:51:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38250 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:51:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id t15so1323993uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NkU3OomiDM2n3PhPZjvX+q6FnTqeBC15UID7r08M78=;
        b=h6iTeezr//aFIhYsFLtbPW9Qnh2cTqOem9rN5DsSvxg21HWew1QajuYjYeJ5e4kxlZ
         LraHM7XY5Co1ognr5QI5tsC9KA+2d6egcQc4X7euanQ2D6MN+xdmOk2/cYyJRL74XX5a
         LxPfCEAQNd6Ez2XDXYO/45bmKth1eNniqKgLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NkU3OomiDM2n3PhPZjvX+q6FnTqeBC15UID7r08M78=;
        b=M01wvvTp5TDryvnXUMu0xyH5g+GYiksT0wICvLNzWR8Ehy1egr14nnXFrfqmWkEehD
         l4GXRh0PPnD3gyNmqf2OAWEzs4wQ0gFdW888XFEEqRLA3AtPtjrA/05q5I7kYeYaRHdU
         bWXdKNwPjz+HBotlbvg7YjxKp8d7JZGXn+yBp+dlFdroax68dkwZIF0gseZKmUPHQZgl
         djP7UfsMAjhWrqIFXLthl5QjGkqGKJ43M/r/3cRSlwG4Wu7mEJaJKd3oEEofL+1aAdFo
         UDAmLjNO88ZUu+QFPBlip9HZbqKNAJKrhZfO/W3uFnYenqiPW3Nm0yl+bz5KlwI4N89Z
         VUYw==
X-Gm-Message-State: APjAAAU1rZT4FDL1kalrjJfJcel7eH5ClYBja9LcuJrU58GiYBWsvN2f
        vtwlbcx82tiVHHaK+S5U6PZhuaoq9iQ=
X-Google-Smtp-Source: APXvYqzp4wMxS1k0dzuY3TG8nAsTsN/E/vknUUz/Sa3OTU1TkQdurBHBn9O6aPJh4NBlyQMar4Rw5g==
X-Received: by 2002:ab0:238e:: with SMTP id b14mr23337412uan.52.1554933066264;
        Wed, 10 Apr 2019 14:51:06 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id m23sm54404917vsl.24.2019.04.10.14.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:51:05 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id t78so2301751vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:51:05 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr26741596vsc.196.1554933064639;
 Wed, 10 Apr 2019 14:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com> <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
In-Reply-To: <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:50:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
Message-ID: <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:24 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Wed, Apr 10, 2019 at 8:46 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Apr 8, 2019 at 3:09 PM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > Use the shared variables for range check, instead of declaring a local one
> > > in every source file.
> >
> > I was expecting this to be a tree-wide change for all the cases found
> > by patch 1's "git grep".
> >
>
> Hi Kees,
>
> I have already the whole patch ready, but I was frightened by the
> output of get_maintainer.pl, so I decided to split the patch into
> small pieces and send the first one.

Heh, sounds fine. Normally the big tree-wide changes go via Linus just
before cutting rc1 (or rc2). This is "only" 31 source files, though,
so maybe akpm wants to take these instead? Andrew, how do you feel
about that?

> Patches for /proc/sys/net and drivers/ are pretty big, and can be
> merged after the 1/2 inclusion.
>
> > Slight change to the grep for higher accuracy:
> >
> > $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
> > 245
> >
>
> Right, my regexp wrongly matches also one_hundred, one_jiffy, etc.
> Anywqay, I did the changes by hand, so apart the commit message, the
> content should be safe.
>
> > Only 31 sources:
> > $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' | cut -d: -f1 |
> > sort -u > /tmp/list.txt
> > $ wc -l /tmp/list.txt
> > 31
> >
> > One thing I wonder about is if any of these cases depend on the extra
> > variable being non-const (many of these are just "static int").
> >
> > $ egrep -H '\b(zero|one|int_max)\b.*=' $(cat /tmp/list.txt) | grep -v static
> >
> > Looks like none, so it'd be safe. How about doing this tree-wide for
> > all 31 cases? (Coccinelle might be able to help.)
>
> It could be true for other sysctl values like
> xpc_disengage_max_timelimit or fscache_op_wq, but it's very unlikely
> that someone writes, for example, 5 into a variable named "zero". If
> it does, it most likely a bug, so const is our friend.

I completely agree. :) I just wanted to make sure and it turned out
the grep was very easy.

-- 
Kees Cook

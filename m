Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DCF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfJPG5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:57:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40462 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbfJPG5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:57:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so19204976ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 23:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jn51E7CHg9BRoH5fZ6ikubNN+LcIafO+PMv/rB0cfpU=;
        b=HKQUF3zkCddkQqSr5Dw7p7n7obOxPQbm1qTVEkdRpn8892ye5SC7RyQWjTdreZZLXn
         HOb5aCIoPGmqbh72DA7dQy9PgP3KlmtDIK5lSDgYfCpE36Rlhzc026s4WUNb19zL8Qal
         vjUZqEvj1R+9vA/YxuAaXHDDTQ2GoOwbkvtD3tqQEUPXA56Fin/oXo/bY4rmqeK2kfBi
         w8HVBUB8ygIFSjObeKqK3pWp2a3XhiIU2J6YNHsOWlYPXQqNBR57bQPZPy2+aCLFnUzD
         5a8Z6IhwW2trnXM8le/6K9bIhTUl4gj2IMWgu7ZRxGdvZqsj1lFgVY5pWsimKHrP9Kw+
         VkMQ==
X-Gm-Message-State: APjAAAX4hWfVfgloSQydiIdWrCJJZDnW+fZKBA9kLjHxcrFf5wf+VckD
        WhnjW8Mf448hgm8gAHoywTLScxasW4mjYWakbtp6fA==
X-Google-Smtp-Source: APXvYqx51gV+Y1QjSyr2AoMzkZI/h34WOr04EycVqfWyQkbql2gypOJx+T1tGe3O65hZeX260JrIBONm5ZGvkT6F9cY=
X-Received: by 2002:a9d:7345:: with SMTP id l5mr22858189otk.39.1571209042125;
 Tue, 15 Oct 2019 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be>
 <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
 <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
 <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
 <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
 <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
 <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
 <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com>
 <e09057e0eefb221549ef9686826e2d190ef36a9c.camel@perches.com>
 <CAMuHMdUvoQz7a7NmLHdpNjRnAUMdbqxFRvB2vdLhHj8pw4Z9Rw@mail.gmail.com> <70c9eaac3510bf8857338d82e14c7e3eded9faa9.camel@perches.com>
In-Reply-To: <70c9eaac3510bf8857338d82e14c7e3eded9faa9.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Oct 2019 08:57:10 +0200
Message-ID: <CAMuHMdUBdhSVqpT4grtdKyHxoVEfJcoiTrVzau_kVeFoUw8zvg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Oct 15, 2019 at 7:24 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-10-15 at 18:40 +0200, Geert Uytterhoeven wrote:
> > The advantage of formail over git-mailsplit is that the former doesn't
> > create a bunch of files that need to be stored in a temporary place,
> > and cleant up afterwards.
> > But hey, that can be handled in yet-another-script...
>
> Or yet-another-git-hook.

Too late: thou maintainer shall run checkpatch before  applying patches.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

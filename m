Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552BDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2001D2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaiG/My2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFUKjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:39:24 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38099 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:39:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id k9so3522249vso.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/GyhlxzDlZ/c+fwrm+Fm2Dc67r0DcAh+69Mb7gFlO3k=;
        b=oaiG/My2zmbB65WJe4cbDgNEyrknHvYXILox7hiJ7FCYFHhGY5Ff2YL8ONaBwKx5pD
         XqoJmqRKroXwJjHa9xBaqoaLTOCQGZV5FpjwkJxfn9y/UtvQwI7HwI35PuXIvHGQXQMW
         PPy/o8z6jZB7YHc42y4AmyBoe8FUmw1cL/TdSrfZBegjqTUoN5uXmKFTTAqPmTYzO+Yh
         iHRr5uouh3j4VajNERh78oQowHtY+GbXUfdYfPUkKjEO0pX1EDgHhSrJ7oaJP8XpWkV1
         8eBFW06bEbggFrMHGcvfsQzuNt3ZJtb8vqeS7577k5UXarwpSnqZTtQi3CfG945NDDcZ
         eMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/GyhlxzDlZ/c+fwrm+Fm2Dc67r0DcAh+69Mb7gFlO3k=;
        b=WuuHkA2qBYUV2LoxShNQJkROM2GGdlKCYhDQDhhLLrVynCfegw5DY3dT323sz6zB5Y
         k9sx3ZCo8X5ry+rmHJ7uA3mQThXK0Lve8Lzax5lC2MDb4ne1Y+wD7zIrg5JqQNBHfJD5
         rc+AaULYN7Z2/Hwk74Q9Np3pC1UQNLZ40oBmR/BMV5lP9O4Z7MpKhnxqO9paSs2Lajn6
         mS5fWS2KwvquhVYcC0rGl9Mo5TNFA5mpSVYPku2SimwM+EUegN/OfhJPBGOuvrA7P6Va
         ad8jLhhOQb/jryJKOpALtuZulj51+KNry6Z+1TI42tOUN777drcA5x59uZUMhcawXNO4
         MSgw==
X-Gm-Message-State: APjAAAX+aI1jy0KZe9EBV2jEz6KPtIYkq40hIpwGIOZ8XWNBTtM0Mclr
        9r/rB5oB0/jdAISjPdoGdHQn9U/ipwBD4RqGUpYhag==
X-Google-Smtp-Source: APXvYqyh48CTqAoGqpwVNMKP36hE0e9kEq/4FyzDdnT36MjTnjH0TKMAT7VqOvhq6sV6TIPCijvxp5d7rVv7RHf3YhM=
X-Received: by 2002:a67:8d8a:: with SMTP id p132mr10336981vsd.103.1561113563011;
 Fri, 21 Jun 2019 03:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <1561063566-16335-1-git-send-email-cai@lca.pw> <201906201801.9CFC9225@keescook>
In-Reply-To: <201906201801.9CFC9225@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Jun 2019 12:39:11 +0200
Message-ID: <CAG_fn=VRehbrhvNRg0igZ==YvONug_nAYMqyrOXh3kO2+JaszQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
To:     Kees Cook <keescook@chromium.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 20, 2019 at 04:46:06PM -0400, Qian Cai wrote:
> > The linux-next commit "mm: security: introduce init_on_alloc=3D1 and
> > init_on_free=3D1 boot options" [1] introduced a false positive when
> > init_on_free=3D1 and page_poison=3Don, due to the page_poison expects t=
he
> > pattern 0xaa when allocating pages which were overwritten by
> > init_on_free=3D1 with 0.
> >
> > Fix it by switching the order between kernel_init_free_pages() and
> > kernel_poison_pages() in free_pages_prepare().
>
> Cool; this seems like the right approach. Alexander, what do you think?
Can using init_on_free together with page_poison bring any value at all?
Isn't it better to decide at boot time which of the two features we're
going to enable?

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> >
> > [1] https://patchwork.kernel.org/patch/10999465/
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >
> > v2: After further debugging, the issue after switching order is likely =
a
> >     separate issue as clear_page() should not cause issues with future
> >     accesses.
> >
> >  mm/page_alloc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 54dacf35d200..32bbd30c5f85 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1172,9 +1172,10 @@ static __always_inline bool free_pages_prepare(s=
truct page *page,
> >                                          PAGE_SIZE << order);
> >       }
> >       arch_free_page(page, order);
> > -     kernel_poison_pages(page, 1 << order, 0);
> >       if (want_init_on_free())
> >               kernel_init_free_pages(page, 1 << order);
> > +
> > +     kernel_poison_pages(page, 1 << order, 0);
> >       if (debug_pagealloc_enabled())
> >               kernel_map_pages(page, 1 << order, 0);
> >
> > --
> > 1.8.3.1
> >
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

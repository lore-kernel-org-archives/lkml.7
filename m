Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA41C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C1C21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBUhkiFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfI0WRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:17:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46642 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0WRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:17:37 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so20317888ioo.13;
        Fri, 27 Sep 2019 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtdpHWdaOzBJG1l11wjunhszkLf4m5dPyPl2qjcAnbY=;
        b=WBUhkiFOSjclrVig0cBN8oFEn7WORx06MoPzAkReZqA4s9NLdOxOjA184PpWetX+hG
         vjH4N8eLkTzK+BAJdLsabMGt6SaKXm3ne1YXkk3w1Ch+N5+4Qj6wtkHV9Zk+HIvd1pii
         ITF/tPOYgfzQJmybTYQss+F3rDkrSD+V1BA01d7xjx+mlxblCcG+aK1VCqllwHJJJPhm
         EkdpBgjzFF+GfG0y/lfUM1oD8c84SDdjN4+TZncxdl3r9kYv8L+TRdY4d8Jc/BXWr9h4
         AXmM3vQw3JzMA3JxVDwcxraHQ1bj6GEx97yQ9sHiVvE7GtBlpXAGF6YLqbcTmUNzT3P+
         o27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtdpHWdaOzBJG1l11wjunhszkLf4m5dPyPl2qjcAnbY=;
        b=jXKszmTf6zRLfStsce5lTcRjrOMzPb8Dd2m10QZiHXGyenWBM/E7FhzWforBv6q2OD
         ph/ifsQsxKEQmecBvjP/ZqsCp3zf/AD+kh8/bHQaYBxNEdssWa2EjQaSNAqp2Mej2DJe
         r0Y/4mG3txs9DxW+AZRgAaqgLnIC0MJjV4PCJri4b38AinxACnERW6Hch8gVQ0LtGLt7
         QHb5hPWi1V3IEcWztM99TRGRZGORJ1azpAhlvnDZHF9G99ifk5jVGyU37DeL/9tfoWHk
         P1TMtnATTjG0bhjHzRRLxXS26YfM8Vx6nG6WGW84FP8RiQAlp4vSqd46uW1YlNp8SgNj
         Kx9w==
X-Gm-Message-State: APjAAAWl4hjjB+QcZBjicQt25MBHkVzaFqfejZun6D49zg47zyb/a6dx
        2AIbLN1WmWPZM7ti3GwxmCg6lRfRU+IaGGlDRSM=
X-Google-Smtp-Source: APXvYqyHXEisUqb2a6eJK99BhNByQ1sbKF2JLQs5QtBQUj8A/zZmvp28P35HAZXoXXuArHOuS1WS37fHaTbcvNmAkr4=
X-Received: by 2002:a92:d110:: with SMTP id a16mr6993851ilb.97.1569622656548;
 Fri, 27 Sep 2019 15:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <1569613623-16820-1-git-send-email-cai@lca.pw> <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
 <1569619686.5576.242.camel@lca.pw> <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
In-Reply-To: <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 27 Sep 2019 15:17:25 -0700
Message-ID: <CAKgT0UfZBNmn1aZdvRT6Yvki3LBi_Nr5hjkYeSnpA7S8kY58-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        gor@linux.ibm.com, David Hildenbrand <david@redhat.com>,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 2:59 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:
>
> > >
> > > So I think you've moved the arch_free_page() to be after the final
> > > thing which can access page contents, yes?  If so, we should have a
> > > comment in free_pages_prepare() to attmept to prevent this problem from
> > > reoccurring as the code evolves?
> >
> > Right, something like this above arch_free_page() there?
> >
> > /*
> >  * It needs to be just above kernel_map_pages(), as s390 could mark those
> >  * pages unused and then trigger a fault when accessing.
> >  */
>
> I did this.
>
> --- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
> +++ a/mm/page_alloc.c
> @@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
>                 kernel_init_free_pages(page, 1 << order);
>
>         kernel_poison_pages(page, 1 << order, 0);
> +       /*
> +        * arch_free_page() can make the page's contents inaccessible.  s390
> +        * does this.  So nothing which can access the page's contents should
> +        * happen after this.
> +        */
>         arch_free_page(page, order);
> +
>         if (debug_pagealloc_enabled())
>                 kernel_map_pages(page, 1 << order, 0);
>

So the question I would have is what is the state of the page after it
has been marked unused and then pulled back in? I'm assuming it will
be all 0s.

I know with the work I am still doing on marking pages as unused this
ends up being an additional item that we will need to pay attention
to, however in our case we will just be initializing the page as zero
if we end up evicting it from the guest.

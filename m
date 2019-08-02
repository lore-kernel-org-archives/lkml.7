Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B150C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3C1204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCfHoybp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfHBPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:10:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHBPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:10:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so29896629qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX2PNnPqRc1Vez9Gt0ymgNUdMb/B4mN+i8ZPfiL6UFc=;
        b=TCfHoybpUYB0q57sGjslZY0Qzg2W5zqXK9GXEpT81w3xFylA5VAxbe7I2hDdBlAkOw
         vZQBSCELRIJW8I77+ptRAHLm9EnjBBqrgcnn2911JFtYKIFpJMbyRxF4xP7jQfNzmuA4
         Wl9Q2wfvPCIH2gL2kkaYx8aYF4kei6qLWvNFf0AJDgFtg5Utrhy7/oEPxz6cOpsjNb1G
         EPwdTu28JLG2EBx43Wln3+visWVuhE91Z/GQIQwQpHwKFxwy9BpHrECtjw+hKG/UNaiP
         FWMaVNBX9O2PAF7dPK4iEFIIilBFVP5mSpEwbINmhLQep6ln3P9Tn3TJjNohzzr7uDtB
         kN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX2PNnPqRc1Vez9Gt0ymgNUdMb/B4mN+i8ZPfiL6UFc=;
        b=ZOB/FW1bH6JhDO2600/1of5+m3taQw09VmFMHq5dFkK0dBANA/np7lzLT45iZXAmma
         3Jq2S0mfRPUWiw+qdyGww+4fD83UVI82f9y6SX5YrsjSJoOgJzasU1zCPvspPPTyyFAt
         z/f/CkFvkBu8aiZy5LMAoC6hnjL4q8REvgvBxfQv/ujsJrNXQbji+aZgOViG0teIW7/V
         kcZGOPLV7T5D6gjSIH+dLbu+m/YGOT56wAHx+hI/mhMCulBcG4cjRH365cfnWwQSCk7U
         0lmf78KhhclebqmQlLzhxnUmuj401QUY7fDwSZ8TcgBX00gswNLujVUSegMqwpHd1U6U
         h3+w==
X-Gm-Message-State: APjAAAU1NUDhJSdF9Ti86Ajrm0MpNcgF1838DAlpKeLe4eafTco70DH3
        zjswkrS1XetBzGzTFOZpNjfawqSV1SJF3oCpccm2
X-Google-Smtp-Source: APXvYqzD/POmLm2vKfx6D1RC+luKxBQ/NjM0j2hWAxzv3R2JplpeeTrEROmYPNGnrMsBM/LkS1BimmH9BbnLMwr4jBw=
X-Received: by 2002:a0c:b755:: with SMTP id q21mr95331996qve.92.1564758612071;
 Fri, 02 Aug 2019 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190802015332.229322-1-henryburns@google.com>
In-Reply-To: <20190802015332.229322-1-henryburns@google.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Fri, 2 Aug 2019 08:09:35 -0700
Message-ID: <CA+VK+GN1hx1jh81JAKtL9L20L=014L-m3N3HtsDYa1ZqbMR0Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: Migration can leave pages in ZS_EMPTY indefinitely
To:     Henry Burns <henryburns@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 6:53 PM Henry Burns <henryburns@google.com> wrote:
>
> In zs_page_migrate() we call putback_zspage() after we have finished
> migrating all pages in this zspage. However, the return value is ignored.
> If a zs_free() races in between zs_page_isolate() and zs_page_migrate(),
> freeing the last object in the zspage, putback_zspage() will leave the page
> in ZS_EMPTY for potentially an unbounded amount of time.
>
> To fix this, we need to do the same thing as zs_page_putback() does:
> schedule free_work to occur.  To avoid duplicated code, move the
> sequence to a new putback_zspage_deferred() function which both
> zs_page_migrate() and zs_page_putback() call.
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Jonathan Adams <jwadams@google.com>
>
> ---
>  mm/zsmalloc.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1cda3fe0c2d9..efa660a87787 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1901,6 +1901,22 @@ static void dec_zspage_isolation(struct zspage *zspage)
>         zspage->isolated--;
>  }
>
> +static void putback_zspage_deferred(struct zs_pool *pool,
> +                                   struct size_class *class,
> +                                   struct zspage *zspage)
> +{
> +       enum fullness_group fg;
> +
> +       fg = putback_zspage(class, zspage);
> +       /*
> +        * Due to page_lock, we cannot free zspage immediately
> +        * so let's defer.
> +        */
> +       if (fg == ZS_EMPTY)
> +               schedule_work(&pool->free_work);
> +
> +}
> +
>  static void replace_sub_page(struct size_class *class, struct zspage *zspage,
>                                 struct page *newpage, struct page *oldpage)
>  {
> @@ -2070,7 +2086,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
>          * the list if @page is final isolated subpage in the zspage.
>          */
>         if (!is_zspage_isolated(zspage))
> -               putback_zspage(class, zspage);
> +               putback_zspage_deferred(pool, class, zspage);
>
>         reset_page(page);
>         put_page(page);
> @@ -2115,15 +2131,9 @@ static void zs_page_putback(struct page *page)
>
>         spin_lock(&class->lock);
>         dec_zspage_isolation(zspage);
> -       if (!is_zspage_isolated(zspage)) {
> -               fg = putback_zspage(class, zspage);
> -               /*
> -                * Due to page_lock, we cannot free zspage immediately
> -                * so let's defer.
> -                */
> -               if (fg == ZS_EMPTY)
> -                       schedule_work(&pool->free_work);
> -       }
> +       if (!is_zspage_isolated(zspage))
> +               putback_zspage_deferred(pool, class, zspage);
> +
>         spin_unlock(&class->lock);
>  }
>
> --
> 2.22.0.770.g0f2c4a37fd-goog
>

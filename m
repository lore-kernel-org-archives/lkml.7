Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085B21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7XWS51m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfIBV2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:28:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36771 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:28:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id s18so2666937qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m5Tr8peCYLPTBLyG4jlj+OLhYRR0ev+4cBo1n2zucSI=;
        b=E7XWS51m3HrCCTEixm5DCt3mCnbxRvgSDNLcJNwLa+R4y1JIjfRngyCAtllxj7BiDV
         QXSvevY8BokCCfeECi4pWRDaupFZQ6gaOBdFwoHvyuMn3hh0ueJtchjxb+/pZ8fibZYY
         AYtVk6gogONa8YRAddmi9iNLn6SXWOFGuBgPDbLmI0UuopSdZgtT1FPRv+5bJUSzP9Ju
         Lp/778ylNxlmOoTesZOF75ZgMBtAvAZfz+aBqMBpvhIIT6JS2KUHJOA3k9DtmPGZktjy
         CxFywRTqNgyBJQfWJmuN4Cf3XFB/HBs9BONoBLBlwdhhpJYf+0HjHk7gWvjCEJnoo1qM
         zx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5Tr8peCYLPTBLyG4jlj+OLhYRR0ev+4cBo1n2zucSI=;
        b=nwH+8qmzS199CHLje1AsBcdVNyqfU3tJ9FwSF2AlLNDGJaLLIK2IfEHbYhfyfU0Bek
         dWMpOKTvUE2x4tY3eiKklCFAkUSTy2PB84uPdc76UoCEn9zw+LCgfFJR+aKAfaqzgGqL
         JKLcF6PMUfrdQCG9iM/89/rKzW5UBvZeVQqdubaPQJYJniFcP4wPTKIH23SraI/llrXC
         2pH8suMQ63KqaIiYVtwidB0bUV+CBftiJS/zXAFoqkB1K0TFMYrfVAdGbqsAbtIbGWa/
         z751GTNfPxAqizQP/Hxkp6aSctwOHITNepj5ZdB1qyXWX1XW1ofF3P7Q/oIexmimn8rO
         qYsw==
X-Gm-Message-State: APjAAAUZmJB40Fi0E2lhWVr4oH0mhn9ctK/X9i/GrPGnIwJnb4cEmQOC
        cDzRkwYhkbS58KhwOy8I3DHAbIIMaRAomVChd2g=
X-Google-Smtp-Source: APXvYqySasX/x6fK/ZFBF4sNLvCdTUg5vYzZ0ptU0WC1DQqA7ozHIr8NeksPjbfjj3j9Z+i5q/D67EoDgzPair+kAjY=
X-Received: by 2002:a37:8684:: with SMTP id i126mr18173762qkd.433.1567459692698;
 Mon, 02 Sep 2019 14:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190830035716.GA190684@LGEARND20B15> <20190830135007.8b5949bd57975d687ff0a3f8@linux-foundation.org>
In-Reply-To: <20190830135007.8b5949bd57975d687ff0a3f8@linux-foundation.org>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Tue, 3 Sep 2019 06:28:08 +0900
Message-ID: <CADLLry497WBX0y+y5UuKgSLRjCd+5vbL1qAfUW-U4qsJ8zR6Vg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: move 'area->pages' after if statement
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     urezki@gmail.com, guro@fb.com, rpenyaev@suse.de, mhocko@suse.com,
        rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=EB=85=84 8=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 5:50, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Fri, 30 Aug 2019 12:57:16 +0900 Austin Kim <austindh.kim@gmail.com> wr=
ote:
>
> > If !area->pages statement is true where memory allocation fails,
> > area is freed.
> >
> > In this case 'area->pages =3D pages' should not executed.
> > So move 'area->pages =3D pages' after if statement.
> >
> > ...
> >
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2416,13 +2416,15 @@ static void *__vmalloc_area_node(struct vm_stru=
ct *area, gfp_t gfp_mask,
> >       } else {
> >               pages =3D kmalloc_node(array_size, nested_gfp, node);
> >       }
> > -     area->pages =3D pages;
> > -     if (!area->pages) {
> > +
> > +     if (!pages) {
> >               remove_vm_area(area->addr);
> >               kfree(area);
> >               return NULL;
> >       }
> >
> > +     area->pages =3D pages;
> > +
> >       for (i =3D 0; i < area->nr_pages; i++) {
> >               struct page *page;
> >
>
> Fair enough.  But we can/should also do this?

I agreed since it is the same treatment.
Thanks for feedback.

>
> --- a/mm/vmalloc.c~mm-vmalloc-move-area-pages-after-if-statement-fix
> +++ a/mm/vmalloc.c
> @@ -2409,7 +2409,6 @@ static void *__vmalloc_area_node(struct
>         nr_pages =3D get_vm_area_size(area) >> PAGE_SHIFT;
>         array_size =3D (nr_pages * sizeof(struct page *));
>
> -       area->nr_pages =3D nr_pages;
>         /* Please note that the recursion is strictly bounded. */
>         if (array_size > PAGE_SIZE) {
>                 pages =3D __vmalloc_node(array_size, 1, nested_gfp|highme=
m_mask,
> @@ -2425,6 +2424,7 @@ static void *__vmalloc_area_node(struct
>         }
>
>         area->pages =3D pages;
> +       area->nr_pages =3D nr_pages;
>
>         for (i =3D 0; i < area->nr_pages; i++) {
>                 struct page *page;
> _
>

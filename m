Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A28BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD920872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVLMysH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440496AbfJRVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:54:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38802 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394243AbfJRVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:54:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so11262857qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/NuivOaNcoVxSGecvK1Wkc/UqqJxGqtaVPaOthR2x8=;
        b=PVLMysH0ZgoHbB8ys0h71PvCjq6BoXMmpyc7E3kYu6dUDS/qfK95htRVtkaJH9jH0F
         mSX0SISUKRjEVV6wtc/sQLngzyFkyrX26j0lRtGMQezlu/+2uIxqazah6sz53SNS0XKM
         Ri4HGtynzc9X8OPa5RDRpAt7ar9r1cb4KcgKSI9CxjltPdi1F/qLUrK6VxCcfhh+zOy/
         ZExxxaE5zQghDP9lkihlIPfYql4LOVSA6z8EiO7orY+2w1MYsZ80OQVikwhIMM9l3FDH
         4dL4E0Sor3fijW8SH2FZpsxzyFAdw/RgqdOAgccnl2ZA3xUoQFpjx7AbCiFRCOy28Q8K
         4IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/NuivOaNcoVxSGecvK1Wkc/UqqJxGqtaVPaOthR2x8=;
        b=d+qOcwFf/0RfY7vLbd8UYh/hr8zY1O5c+w/jD75JsRhPtlYt77kO3SUtzgPMyoR4Sa
         zGKbMcKkxtc5Xui23/xA7S8a2nZCXxho26llizGtYWgJHy8HjtcL32QUXpqUO/Nf8BYF
         26ivTuxJEDIrZ3yDmRLTVzNgs+5KTJrX+pHQzDL63OJaPJj1XgHBpjbNr8mzm9kggGiN
         flGgSSYKSdtkROxYh/4arwpJI8g8kHF14VoiHu+JUUhjsYrHihvbxqdLRHsCh4RSuQOa
         THzC4TT4u3397aGaodnyHbggGgwFBF2zgUt+lhh83lBRuDB6vTDipRfqnlLNq7YB+sBU
         axRA==
X-Gm-Message-State: APjAAAW5zJsxpQX5t/natb8T4gP/hzRgPAuyD9jcfYgwCUKLk6xZxaHA
        jZuG9h6/CLfh36keS5d2SUej6FuZalfEUloJyAU=
X-Google-Smtp-Source: APXvYqw6UQGbFGK6oM1Jx+Eq1w8Q45Sy98nmnXn8Bg4aR3D9UWf+fS0HS1BwJJBa7OtrUyeC9NP9fNdol8AT9qvmNKY=
X-Received: by 2002:ac8:2a5d:: with SMTP id l29mr12091370qtl.314.1571435662831;
 Fri, 18 Oct 2019 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191017164223.2762148-1-songliubraving@fb.com>
 <20191017164223.2762148-5-songliubraving@fb.com> <CAHbLzkoTT4p9u__EdFgt7_47NHOV5r=nB8EmvBx+1TcyzX5RJg@mail.gmail.com>
 <20191018133231.vifgnueulyo57vpy@box>
In-Reply-To: <20191018133231.vifgnueulyo57vpy@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Oct 2019 14:54:09 -0700
Message-ID: <CAHbLzkr967JVjnv=kyuUdYJvdAKKbQy67-MvUrb7VeQUZAuHXQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/thp: allow drop THP from page cache
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        matthew.wilcox@oracle.com, kernel-team@fb.com,
        william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:32 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Oct 17, 2019 at 02:46:38PM -0700, Yang Shi wrote:
> > On Thu, Oct 17, 2019 at 9:42 AM Song Liu <songliubraving@fb.com> wrote:
> > >
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > >
> > > Once a THP is added to the page cache, it cannot be dropped via
> > > /proc/sys/vm/drop_caches. Fix this issue with proper handling in
> > > invalidate_mapping_pages().
> > >
> > > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Tested-by: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Song Liu <songliubraving@fb.com>
> > > ---
> > >  mm/truncate.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/mm/truncate.c b/mm/truncate.c
> > > index 8563339041f6..dd9ebc1da356 100644
> > > --- a/mm/truncate.c
> > > +++ b/mm/truncate.c
> > > @@ -592,6 +592,16 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
> > >                                         unlock_page(page);
> > >                                         continue;
> > >                                 }
> > > +
> > > +                               /* Take a pin outside pagevec */
> > > +                               get_page(page);
> > > +
> > > +                               /*
> > > +                                * Drop extra pins before trying to invalidate
> > > +                                * the huge page.
> > > +                                */
> > > +                               pagevec_remove_exceptionals(&pvec);
> > > +                               pagevec_release(&pvec);
> >
> > Shall we skip the outer pagevec_remove_exceptions() if it has been done here?
>
> It will be NOP and skipping would complicate the code.

Yes, it would be. Anyway, it looks ok too. Acked-by: Yang Shi
<yang.shi@linux.alibaba.com>

>
> --
>  Kirill A. Shutemov

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B24C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8692677B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IArgLlu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfEaKaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:30:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40155 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:30:02 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so14391970itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWqWKbrAXVr1vv0ljUZ6j7dXVWf1RBTgGsA5MBSNUDk=;
        b=IArgLlu8LmO7rxsbIzDBJH+C6i9e6ya0ROYBmaFB3kCW73c9o7/AAGRhMxxwj5BsQk
         LT8g8mNOZg3+RkmnjyD1jX2oHO8otMAFNYFmpJRNTieoM7JuWMEdIk/MH/wRlzLkzh3c
         wxgzLHTd2OMG9kAh3C65YbgKeePH/wCbNmtVgnKF2LvKD7mxHvppTesb2d3vctOKskrP
         zurQOU+5/Eyjwb5C6VbVvl7G6CF6Z2AOlfsbucyCTiWABaF/hxeIMVWaL/gDVZeLswZA
         oINW4QjBd65Ls/5rhMQfnSVwxOLVzI770l1bBLs3bBsugkPx7avPsn4xu5SYHrRe5J7W
         PKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWqWKbrAXVr1vv0ljUZ6j7dXVWf1RBTgGsA5MBSNUDk=;
        b=MJaxkKo16sHbt1YBBXSN9y2r4UmJNIEq7ggs3+6H9JI68kTxCy4idT8HSArCaUA8JF
         jj/4QPE2uTOsjOtbFNb9sB4ktGogHH4St3Ivp0udjFYdJnM758Qi4cK2TjV1FPPGPcRz
         B7LZcmxA3x7LC1JghfXuPa6+eqBqJsaG0ZiwJ5krd1zPU7nAhmb2fXMCr08ClT1vjld6
         giQfGryfvGH9TCpzxPfbmxDNajxDl3WRwWcc/cUSjBcy//rD43OvhOA/CnbjkpYw0j0Q
         yXyUF3EAxcEULQ/vYRWes3+8t1ZNfw7TD1LNInzDXy2VRuGTp+3KZhJrcjSPSLJRn2Sd
         ZpKg==
X-Gm-Message-State: APjAAAVh7JRc5S1db+eKgZEtHJvn9ypbdURX7tySndCg9PkQkqt5Kv7c
        Ykv+9UIG2khc/HKcc/rxcDrixpfLmy5+tdbQrw==
X-Google-Smtp-Source: APXvYqyN+gUIJsr2+bHWe1Wx8z3cnmNTBcqucuzX9xp4KiKGGrOa6Hjyz1OY/59rJtFUDo9xy0JNdMXT6rf8fbtyzB4=
X-Received: by 2002:a24:5095:: with SMTP id m143mr6363629itb.68.1559298601767;
 Fri, 31 May 2019 03:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com> <20190530214726.GA14000@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190530214726.GA14000@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 31 May 2019 18:29:50 +0800
Message-ID: <CAFgQCTvatXv68gv-g7ZwpvVMoX78F616bxVMchgeQX-wGCRkow@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 5:46 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, May 30, 2019 at 06:54:04AM +0800, Pingfan Liu wrote:
> > As for FOLL_LONGTERM, it is checked in the slow path
> > __gup_longterm_unlocked(). But it is not checked in the fast path, which
> > means a possible leak of CMA page to longterm pinned requirement through
> > this crack.
> >
> > Place a check in the fast path.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/gup.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f173fcb..00feab3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2235,6 +2235,18 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >               local_irq_enable();
> >               ret = nr;
> >       }
> > +#if defined(CONFIG_CMA)
> > +     if (unlikely(gup_flags & FOLL_LONGTERM)) {
> > +             int i, j;
> > +
> > +             for (i = 0; i < nr; i++)
> > +                     if (is_migrate_cma_page(pages[i])) {
> > +                             for (j = i; j < nr; j++)
> > +                                     put_page(pages[j]);
>
> Should be put_user_page() now.  For now that just calls put_page() but it is
> slated to change soon.
>
Not aware of these changes. And get your point now.

> I also wonder if this would be more efficient as a check as we are walking the
> page tables and bail early.
>
> Perhaps the code complexity is not worth it?
>
Yes. That will spread such logic in huge page and normal page.
> > +                             nr = i;
>
> Why not just break from the loop here?
>
A mistake.

Thanks,
  Pingfan
> Or better yet just use 'i' in the inner loop...
>
> Ira
>
> > +                     }
> > +     }
> > +#endif
> >
> >       if (nr < nr_pages) {
> >               /* Try to get the remaining pages with get_user_pages */
> > --
> > 2.7.5
> >

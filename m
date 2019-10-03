Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D8EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078C020700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fd53pALg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfJCMOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:14:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39872 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfJCMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:14:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so3207918qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EaMAN3l7OjmmHPY5foDFT/JHZpitrV1Zhkp1njn6pF8=;
        b=fd53pALg/i7/fDWKjZ1CAZQAMXsLhANtFFZLWvQ1bHL5i0w9K+qF5KVpcjtYSCL7o5
         v9zjjdLFOIJCRwJ5AulwCHFEAmV8cdOLYPt2rMTbxDRHGCwuGUsWmLyIgLxyfKKuGftW
         DItRVfj7mlkw58Ytagr2Kt5ZAq0k0E1yBVBqrqZytBrl7vYUfbH9zxtQfcZhpoBP6TJx
         jYv1LyUoPFlwcX6YPDS26fU6sFUq8NtEb9YEFejRtb4HlM7Mddj+mISuPLUzy0756u1s
         t5aA5k/6tgGLC2VTRqbykgkCnAHNdHSA9wS5djcq4X9jVdxw7HIQZfawhH9VAN93/CZr
         rk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EaMAN3l7OjmmHPY5foDFT/JHZpitrV1Zhkp1njn6pF8=;
        b=UD34ltf33SXhPrRKxhivm8wvi5nGVY2sHswHAA8dSDhXob9uoqwzcqSXxHMhYpoctk
         ig2ygqhEnMsTK+BHzYkX677V2onLZsL1EUQo1YSSTE5Hzfbs8g/hRqowyeug5AxUZO9q
         pSIQscdtqWAq2O5uSNFLKa+jH5qtCfq9u7N4wK4Qy4Uwk/CQKAgvR4fD7G/kcns1Kogb
         NYKUg/nDy+xMAH6QEhGaYY+ccOjk7Cbe0PAyplLbocqpJgJiunoOHkKw/0yOrTAmrDIg
         60+y+HfVmewqslgnJYdH7Y6hxjih9CF/KNB6grpSbWLyGzsFjq1CW8UyA5sB+lBiiiw9
         bKoQ==
X-Gm-Message-State: APjAAAUShnUSp67IYTBx/69edKKA/v3kFrk9KnsGGwGeIg1QafUmKc6i
        iRhCswn3k5QA8oACaDqwiAUokg==
X-Google-Smtp-Source: APXvYqx23Ode9lvxzQiDr2/Wr19WXFRC4gkIgYc8CKyZymnST/Ny6bT9TLpU/ncCLwouL8vAueyphg==
X-Received: by 2002:ac8:3b52:: with SMTP id r18mr9865084qtf.62.1570104881711;
        Thu, 03 Oct 2019 05:14:41 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t65sm1201300qkh.23.2019.10.03.05.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 05:14:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in has_unmovable_pages()
Date:   Thu, 3 Oct 2019 08:14:40 -0400
Message-Id: <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 8:01 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Will something like this be better ?

Not really. dump_page() will dump PageCompound information anyway, so it is t=
rivial to figure out if went in that path.

> hugepage_migration_supported() has got
> uncertainty depending on platform and huge page size.
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15c2050c629b..8dbc86696515 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8175,7 +8175,7 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>        unsigned long found;
>        unsigned long iter =3D 0;
>        unsigned long pfn =3D page_to_pfn(page);
> -       const char *reason =3D "unmovable page";
> +       const char *reason;
>=20
>        /*
>         * TODO we could make this much more efficient by not checking ever=
y
> @@ -8194,7 +8194,7 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>                if (is_migrate_cma(migratetype))
>                        return false;
>=20
> -               reason =3D "CMA page";
> +               reason =3D "Unmovable CMA page";
>                goto unmovable;
>        }
>=20
> @@ -8206,8 +8206,10 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>=20
>                page =3D pfn_to_page(check);
>=20
> -               if (PageReserved(page))
> +               if (PageReserved(page)) {
> +                       reason =3D "Unmovable reserved page";
>                        goto unmovable;
> +               }
>=20
>                /*
>                 * If the zone is movable and we have ruled out all reserve=
d
> @@ -8226,8 +8228,10 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>                        struct page *head =3D compound_head(page);
>                        unsigned int skip_pages;
>=20
> -                       if (!hugepage_migration_supported(page_hstate(head=
)))
> +                       if (!hugepage_migration_supported(page_hstate(head=
))) {
> +                               reason =3D "Unmovable HugeTLB page";
>                                goto unmovable;
> +                       }
>=20
>                        skip_pages =3D compound_nr(head) - (page - head);
>                        iter +=3D skip_pages - 1;
> @@ -8271,8 +8275,10 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>                 * is set to both of a memory hole page and a _used_ kernel=

>                 * page at boot.
>                 */
> -               if (found > count)
> +               if (found > count) {
> +                       reason =3D "Unmovable non-LRU page";
>                        goto unmovable;
> +               }
>        }
>        return false;
> unmovable:

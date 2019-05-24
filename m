Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3665C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EE721773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qs74XkHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfEXD6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:58:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35243 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387703AbfEXD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:58:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id n14so7500990otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f6c9m1oolNz7qnNp31NpIo+ILEox6NGu8lwYyMw+NLU=;
        b=Qs74XkHjFhIG5eWAqZuHInffVvs+3AV05OrIpZ2xTnqAoDqX14pggyRk9f9DKHpuSs
         IRIBA2Ri/L1Hws5vXuO4/80WJMPdl81Bfp9VTtv6MkS+yeMMugK5uHJSDrPNnXcruuw3
         fJM4itI1+d6xJhugS2SaMdwDq6lT+66DbFSttJHrPC9+6vC2KDSJ8ido/7gjDGJXyt6f
         Eli8t58rYv3qybUABQC+8jQRyJo3F65nGswTPDcjH5BfeMOzlFdaSN0IOzN5j/p+fvgV
         4gO7UElauHskekm3kCMewjQB2ilKCmqgQOr8DJjZu2CsqzL0iuxZTXFDWF/JNWUVpQX/
         GcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6c9m1oolNz7qnNp31NpIo+ILEox6NGu8lwYyMw+NLU=;
        b=C7w6F8T09osbLZFMnSeMmmJ9H3mPA9JlVqQHIXtUJBJqY24dlJG5blbxsOtLzGslt+
         82DsY2Mky8tXTiap+aTZcaD+XRAlLuQumR+5Jpe0LSmY606xT+UVsh17pyaas4orJ5vr
         /R+etpePoZj7OULSxWGwAyNxVeTMTFHR1hnITZB+LcRPkKInFDHg58fV3pJT3QNtvhgC
         bx5z0crOyUjpj3auB/qsSaeJrnN/zoGXd5kbwADJ0AXUy5dSjgCqvuFOYB5ATWvv0rJy
         G2HhfpCVrY4PPAbHBq8Gd8tut/yLR9D4pmW0j42kVA7/7n7Cr9LMY3rwheGHbpPwp667
         J6aw==
X-Gm-Message-State: APjAAAVqNJ5w+k7HN7mzd3oVGpc+HnOAJ5YEiEmpRm5/eGDV8LK6Db8K
        e3+C1XN9IuQvuiy//F3IsxPRyh4B3REgbFpw/ns92g==
X-Google-Smtp-Source: APXvYqywpzGD5Aa+i2XlHKnDBTwl+TOaDWcG21EMI6kjm8dn1v7UUbbQbcsfdcmnB3N5ud5QB84Okj6zu4K2XRFRUpg=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr4573516otr.207.1558670303779;
 Thu, 23 May 2019 20:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190523223746.4982-1-ira.weiny@intel.com>
In-Reply-To: <20190523223746.4982-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 23 May 2019 20:58:12 -0700
Message-ID: <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 3:37 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Device pages can be more than type MEMORY_DEVICE_PUBLIC.
>
> Handle all device pages within release_pages()
>
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.
>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/swap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 3a75722e68a9..d1e8122568d0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
>                 if (is_huge_zero_page(page))
>                         continue;
>
> -               /* Device public page can not be huge page */
> -               if (is_device_public_page(page)) {
> +               if (is_zone_device_page(page)) {
>                         if (locked_pgdat) {
>                                 spin_unlock_irqrestore(&locked_pgdat->lru=
_lock,
>                                                        flags);
>                                 locked_pgdat =3D NULL;
>                         }
> -                       put_devmap_managed_page(page);
> -                       continue;
> +                       if (put_devmap_managed_page(page))

This "shouldn't" fail, and if it does the code that follows might get
confused by a ZONE_DEVICE page. If anything I would make this a
WARN_ON_ONCE(!put_devmap_managed_page(page)), but always continue
unconditionally.

Other than that you can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

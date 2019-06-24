Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4392054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJAnkSq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfFXJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:41:40 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38848 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfFXJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:41:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id k125so5586002ywe.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u7V8Y/svVqpZMFRwTixoQtso+KwwiAflO76wYwcLCwc=;
        b=AJAnkSq9urX/SgB0iyZYZ3sYrMhkBQbukYZV9Tk0Q8YPBamjJueRwljXf0tlIb9GTS
         vKOnQh36JFOo9tlUIfmufWeXo7VMM7ZNYZL+zX29WjYRNh88l9Kk+9lp5LZzPQx1cvJI
         wwA0nT7R/ywdSw1wPOQGMYhAi5syDHaQ2cXHDlY2M+jqVI0DsynY9yTQKAV73r1xScR8
         s2/jyMheB4ubCIUkEDEPXsF+pIGy8Y+sWNKSLvMtTqbWgkRhUlvOzWZtcvvk56cKMvQj
         XECr1nWzZhjRNseymLXV9rZe0hw9AafFPvkGCDNUbvStkh6NuKMhfCPTziG2/i88Jvtl
         tPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u7V8Y/svVqpZMFRwTixoQtso+KwwiAflO76wYwcLCwc=;
        b=HgbTXr+pMtDJCgkcq7CJDoPvTaxO1TjN7FvOOecemEbDbj+RWDTYr3CZ7duFxt6xSv
         3vXBHy1S5GN7OZf8QGA6kVwUzItjjQYb41ezB/VQiUxIYdzq/1xrW9Inbf698hJn621j
         wRrHS5mHd88X9OEwBVyfuuLc+WO8q5uJVAUH0IwbHEOvRHnblSSaBkBRPr6J7H/lSeI7
         J9dvW8wbcueolKx9VOSMnCK3Q5EM6qLwjGCsqS9GA0GtelXpStutlejZ6TH+geF9K7UN
         Xk301ht+hQuytfSdRj+Qx9r6P+RQY423FefB5mssItyC6D4LjH++b+jXLQIXycE+h/o1
         3h0w==
X-Gm-Message-State: APjAAAXm8y995CzXozjztMmxxRD65I6xcD15+Pv/fzmQDSscPJgOfaKw
        +lirPf+sUepP4RkQHM4brKToMt5zn0MDbK3W9NlBw7Ca
X-Google-Smtp-Source: APXvYqzCtMpSgY48T3u1VN3+5omx2myWrqHuWpKYIdbGpQAXuo+geGpyiy7nfmKnmoYZYTH/0r4k4Ek8y8eMikufcaE=
X-Received: by 2002:a81:1bc5:: with SMTP id b188mr46386195ywb.232.1561369299261;
 Mon, 24 Jun 2019 02:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190624050937.6977-1-houweitaoo@gmail.com>
In-Reply-To: <20190624050937.6977-1-houweitaoo@gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 24 Jun 2019 11:41:28 +0200
Message-ID: <CA+KHdyWTst1GFUC3JqHAieuV19UdR67LEPhvDKYZ569u2L1qbA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix a compile warning in mm
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>, Roman Gushchin <guro@fb.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Hou.

It has already been fixed. Please have a look at:

https://ozlabs.org/~akpm/mmotm/broken-out/mm-vmalloc-avoid-bogus-wmaybe-uni=
nitialized-warning.patch
https://ozlabs.org/~akpm/mmotm/broken-out/mm-vmalloc-avoid-bogus-wmaybe-uni=
nitialized-warning-fix.patch

--
Vlad Rezki

On Mon, Jun 24, 2019 at 7:09 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> mm/vmalloc.c: In function =E2=80=98pcpu_get_vm_areas=E2=80=99:
> mm/vmalloc.c:976:4: warning: =E2=80=98lva=E2=80=99 may be used uninitiali=
zed in
> this function [-Wmaybe-uninitialized]
> insert_vmap_area_augment(lva, &va->rb_node,
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4c9e150e5ad3..78c5617fdf3f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -913,7 +913,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>         unsigned long nva_start_addr, unsigned long size,
>         enum fit_type type)
>  {
> -       struct vmap_area *lva;
> +       struct vmap_area *lva =3D NULL;
>
>         if (type =3D=3D FL_FIT_TYPE) {
>                 /*
> --
> 2.18.0
>


--=20
Uladzislau Rezki

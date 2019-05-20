Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E34C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A19C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHGovjx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392156AbfETQ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:29:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39727 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbfETQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:29:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so6950862plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=byKYPTND9YCeJJHnLBgAwQB4XeP+2knzrQ48PDwWxpg=;
        b=fHGovjx4PpiC1jOvqzA/Ecf1EzMl3NrIClO5m2ir+OpwlV6DW+ZDfHON7wTNel3tfm
         Ue5BC+Zij3L1zQ6a3ZH9N4C/YCBBSs//PV5Fyu+JbV/RnsCh5PIKWT9C6ugPIsLluGSt
         j02IcyMU6A+xKgrSrfN8TjytKlMLK1g+W+8+pYSgoK0/1RCW38cP/257Ikp1JNvsVpvM
         Z9IOZuDzlOEc64sFHlFVqojo0yJhwmBRhJko+CCsW93nz3GklGebuvSJiKsXJHJmJkHT
         jlJKvkINej8mN8Gu/86wRJDVuQ1qkMRMRTrra0E18so6glYg9gvvwEEfrgKj+DKLRuU1
         Gsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=byKYPTND9YCeJJHnLBgAwQB4XeP+2knzrQ48PDwWxpg=;
        b=Vt2dr4zTbnP8UZyXIIERbJGaW/aBIYIKVeDftozfRmrXLlhmKQRuM/SDWVJ8qMXCGB
         T45M6Lx50Zmk5VyDqTqHngLP6iQJDwi9/Y2vgfVTunJxZ2EQZk8+rdtCp8JKE+znLQ5g
         XhCwsZ5PgMhK+4yLD0FQyV662acyLEYAh6k30uzI+nDqxqJ8HEVH6N0CKTX5vctt7DjT
         ALpPqBCqvrEY/9q7ofc74zEsYI5sjiJDuKc0rSYfXJHNCGnXYlSvh7/v4tUv69atHiY7
         SufGL6NqYDgyjr/2Y//2yuCAx4x1hkSUXRsovzeuzTVwpsvmsP8YobhzLKuxFMNFpHSc
         DqqQ==
X-Gm-Message-State: APjAAAUJyC8vW0Qr/6AHveshtwAiE/JWk1CzosXF1b/n9ui5kCUwCYxX
        zJR0ASqmOP2rAJc1awjbqDR8ZwQUHyp8xPYa5FM=
X-Google-Smtp-Source: APXvYqyyaw5zpahyX3bKiYjur5LZoFYK15o3299Pf26i/dwF+cCH7jBL37QqVKzb7ETz0LCWzP3ry3IGEelO7Dy7wJI=
X-Received: by 2002:a17:902:24c7:: with SMTP id l7mr27106129plg.192.1558369754339;
 Mon, 20 May 2019 09:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190520044951.248096-1-drinkcat@chromium.org>
In-Reply-To: <20190520044951.248096-1-drinkcat@chromium.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 21 May 2019 01:29:03 +0900
Message-ID: <CAC5umygGsW3Nju-mA-qE8kNBd9SSXeO=YXMkgFsFaceCytoAww@mail.gmail.com>
Subject: Re: [PATCH] mm/failslab: By default, do not fail allocations with
 direct reclaim only
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=8820=E6=97=A5(=E6=9C=88) 13:49 Nicolas Boichat <drinkc=
at@chromium.org>:
>
> When failslab was originally written, the intention of the
> "ignore-gfp-wait" flag default value ("N") was to fail
> GFP_ATOMIC allocations. Those were defined as (__GFP_HIGH),
> and the code would test for __GFP_WAIT (0x10u).
>
> However, since then, __GFP_WAIT was replaced by __GFP_RECLAIM
> (___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM), and GFP_ATOMIC is
> now defined as (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM).
>
> This means that when the flag is false, almost no allocation
> ever fails (as even GFP_ATOMIC allocations contain
> __GFP_KSWAPD_RECLAIM).
>
> Restore the original intent of the code, by ignoring calls
> that directly reclaim only (___GFP_DIRECT_RECLAIM), and thus,
> failing GFP_ATOMIC calls again by default.
>
> Fixes: 71baba4b92dc1fa1 ("mm, page_alloc: rename __GFP_WAIT to __GFP_RECL=
AIM")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Good catch.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

> ---
>  mm/failslab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/failslab.c b/mm/failslab.c
> index ec5aad211c5be97..33efcb60e633c0a 100644
> --- a/mm/failslab.c
> +++ b/mm/failslab.c
> @@ -23,7 +23,8 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpf=
lags)
>         if (gfpflags & __GFP_NOFAIL)
>                 return false;
>
> -       if (failslab.ignore_gfp_reclaim && (gfpflags & __GFP_RECLAIM))
> +       if (failslab.ignore_gfp_reclaim &&
> +                       (gfpflags & ___GFP_DIRECT_RECLAIM))
>                 return false;

Should we use __GFP_DIRECT_RECLAIM instead of ___GFP_DIRECT_RECLAIM?
Because I found the following comment in gfp.h

/* Plain integer GFP bitmasks. Do not use this directly. */

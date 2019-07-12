Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B96FC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B072146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO1+NrHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfGLVUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:20:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36818 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfGLVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:20:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so4838764pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3nQ6WqoKV1cJLu5kutjgFzb55g8DMnxDsBnzM+IJlk=;
        b=SO1+NrHCsY/p+NPvc3Kvu0+XSrfRbRTLzv3DQJLqpiFFvqlLUD41ZoEkyf6m1oHe4Z
         jPjUcQV+on58ZaeQw5aTtJ8kCYKORHDTh2WlfxPXov3Dc4CfdlQLXJImGmDxZH6tjgvr
         Tws5g4mQ9PCoQ9DVbjsHk8SfTVehVb44KcsePAOf1bmonYeTpN3gthAddO14MhoderoH
         6J3RLw1verLonYpdq5/f8xMwPEnmy7z+F4MS8Aj2pkiVXA98qdWKRL+foPi4qol44ogz
         j1G5S+7Qz74srx1QdeYh8+UMNuuO+lonHyNVKHiSHGqcO67wRrUlERTwgtKnmG6/UQNb
         Ojaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3nQ6WqoKV1cJLu5kutjgFzb55g8DMnxDsBnzM+IJlk=;
        b=rLF92HSFlYFasDxVqBHKzhdWsYHxZuSbJRMvGampF6xYX48Rx/4kIvFqNM17/rA3S2
         uOTq0agZXfkujNhkmppdJTkpc5zEQvw3hSZkfU4hNjR78XdwLs39Id8xjm8fbWXhvoz3
         89yN9cCWPxEuWQ70dF7hQuRfhsmo+89v+jh7tYDGt1Ha1ewYS8fOi7NMc7yUGSBubDFH
         uaSKGgVV3WCeiKOkQNHgp5vrw0G5qOpc11Fg5O/4WWiIOEehN+2GkVKSs7RG1auCho8g
         YdeOtyJ+VtNrwDuDuAMy5ZH+4G29mzn0v8WGS+3mb8tcW+BzVVKu9yXzPmr/TjylSI5i
         mpPA==
X-Gm-Message-State: APjAAAWy1uz/GtttHm+iJvcm9dFWmc+sYWx/YVzkNk0WizosvLgh2/qU
        lnEDoFFYMetYhwCljQclr91DA2oXw9Mnl0kuC8CiU2JuKZa2vg==
X-Google-Smtp-Source: APXvYqzG4QkIxbPOQ7VlpW4ch9ojpA1msBPUiP9xzzSCgv5/7yPWMvJXkWidRQ3SRI5VVIh7WKj1DZ1Xl5aorYOAyQQ=
X-Received: by 2002:a65:5687:: with SMTP id v7mr13607513pgs.263.1562966434285;
 Fri, 12 Jul 2019 14:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190712090740.340186-1-arnd@arndb.de>
In-Reply-To: <20190712090740.340186-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Jul 2019 14:20:23 -0700
Message-ID: <CAKwvOdk2piniLx8x0QyvYseyhfXEWFt4kYaSnzNH1d_=LBTzLw@mail.gmail.com>
Subject: Re: [PATCH] lib/mpi: fix building with 32-bit x86
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The mpi library contains some rather old inline assembly statements
> that produce a lot of warnings for 32-bit x86, such as:
>
> lib/mpi/mpih-div.c:76:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions

I feel like I'm having flashbacks here:
https://lore.kernel.org/linuxppc-dev/CAKwvOd=f9OOR=i10q_auQuQCVH657neQtjt51UA176p_PMOHVw@mail.gmail.com/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
(Thanks for the patch!)

>                                 udiv_qrnnd(qp[i], n1, n1, np[i], d);
>                                 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> lib/mpi/longlong.h:423:20: note: expanded from macro 'udiv_qrnnd'
>         : "=a" ((USItype)(q)), \
>                 ~~~~~~~~~~^~
>
> There is no point in doing a type cast for the output of an inline assembler
> statement, so just remove the cast here, as we have done for other architectures
> in the past.
>
> See-also: dea632cadd12 ("lib/mpi: fix build with clang")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/mpi/longlong.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
> index 08c60d10747f..3bb6260d8f42 100644
> --- a/lib/mpi/longlong.h
> +++ b/lib/mpi/longlong.h
> @@ -397,8 +397,8 @@ do { \
>  #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
>         __asm__ ("addl %5,%1\n" \
>            "adcl %3,%0" \
> -       : "=r" ((USItype)(sh)), \
> -            "=&r" ((USItype)(sl)) \
> +       : "=r" (sh), \
> +            "=&r" (sl) \
>         : "%0" ((USItype)(ah)), \
>              "g" ((USItype)(bh)), \
>              "%1" ((USItype)(al)), \
> @@ -406,22 +406,22 @@ do { \
>  #define sub_ddmmss(sh, sl, ah, al, bh, bl) \
>         __asm__ ("subl %5,%1\n" \
>            "sbbl %3,%0" \
> -       : "=r" ((USItype)(sh)), \
> -            "=&r" ((USItype)(sl)) \
> +       : "=r" (sh), \
> +            "=&r" (sl) \
>         : "0" ((USItype)(ah)), \
>              "g" ((USItype)(bh)), \
>              "1" ((USItype)(al)), \
>              "g" ((USItype)(bl)))
>  #define umul_ppmm(w1, w0, u, v) \
>         __asm__ ("mull %3" \
> -       : "=a" ((USItype)(w0)), \
> -            "=d" ((USItype)(w1)) \
> +       : "=a" (w0), \
> +            "=d" (w1) \
>         : "%0" ((USItype)(u)), \
>              "rm" ((USItype)(v)))
>  #define udiv_qrnnd(q, r, n1, n0, d) \
>         __asm__ ("divl %4" \
> -       : "=a" ((USItype)(q)), \
> -            "=d" ((USItype)(r)) \
> +       : "=a" (q), \
> +            "=d" (r) \

-- 
Thanks,
~Nick Desaulniers

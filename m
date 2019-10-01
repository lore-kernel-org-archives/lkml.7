Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA7C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8E021920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsAwZFtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfJALyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:54:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37611 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJALyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:54:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id u20so5355525plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64JhZwkDAvaFL8oefy3Dlv2PxK4l6sjIBqb8vtnMKK4=;
        b=FsAwZFtTbM4w3tHIi2kjemmZZb9MFNARVFQbkmLTTM+KBtRRefSY9TD7PMsLPnR+MA
         K2dvDteLSzcL5PMfivtOgnn0CpAVfivvC0Z518L1eFH2D5tzCavGG2Dy6qaO00N+fWi2
         B3hn97e4qNV0xeJRMQ+VvhAK+WlnXvAgsqf0pXKOlrBmnNIUj7tsu7sedcbglekADziM
         EKrF0usaaJgyIvFYGObLpAIwI9+Fw3ALKztiM2CYmyg2CiKYLnDs5bqr58PrmyFeELBJ
         trkfycHg1STppUj82ww83kYr6QvHQRrjHWQMPZobSwLO4lOq3aQJOVYgCVUvRaXqpC2e
         YnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64JhZwkDAvaFL8oefy3Dlv2PxK4l6sjIBqb8vtnMKK4=;
        b=exxcI0UUk97d2H/dS3/uuKBXREtk3tlVVcvwTCL+GDm1pCvbm4KsnfBXf1v0/1XUOm
         j1qtNT0SdKubuegD6h924NVwLpw0Jc6lztzJK9jTU2FW1lqmoQken+dlXNtdrGIQiAW3
         hrmPJdxW25BUMVI9GLQx5PEKq0bpkIwNRK/0EsZcZz+TMvXMkzT4eTpk84IlahsMAxnN
         yCLNpPhGBD+rBYMMu+v38CjVqImqHogkBzRmWDVB5h9pJOQ1KER5SkrH5KHSt4mz0qPT
         opun4WZQLJ6j5/3atIKvfee+3RsJ76qAMtrQxSztdP8D/dB0dnYv59CQr/lijIdPD83w
         ASmQ==
X-Gm-Message-State: APjAAAX0QaFOweHvMD28jNpC3zcJiZZ40RK8nXW1Fe8P4BXYRvlf6pe9
        vqSGXDJXS1l4RX2H7OIH/WLYNhYxfihj/4GUhoItDYKnwr7aDw==
X-Google-Smtp-Source: APXvYqyJ3Lc7ZQwJT/ACH4RnfsrK1gLwn2azs4odvDQ8uIFF8FKln1z8z11y/394MkKXlOL3lk6SBWElOW9Xv/VNjWU=
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr25171552plp.336.1569930840195;
 Tue, 01 Oct 2019 04:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <29dd42d5-52e3-e2a2-679f-f0e8648f2b40@infradead.org>
In-Reply-To: <29dd42d5-52e3-e2a2-679f-f0e8648f2b40@infradead.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 1 Oct 2019 13:53:48 +0200
Message-ID: <CAAeHK+zFuuPb0RgKcb4c2AjgPh3X29faDYU-O+3DQhd0hrOWNw@mail.gmail.com>
Subject: Re: [PATCH mmotm] sparc64: pgtable_64.h: fix mismatched parens
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 2:23 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix lib-untag-user-pointers-in-strn_user.patch unmatched left paren.
> Fixes many of these build errors:
>
> ../mm/gup.c: In function '__get_user_pages':
> ../mm/gup.c:791:30: error: expected ')' before ';' token
>   start = untagged_addr(start);
>                               ^
> In file included from ../arch/sparc/include/asm/pgtable.h:5,
>                  from ../include/linux/mm.h:99,
>                  from ../mm/gup.c:7:
> ../arch/sparc/include/asm/pgtable_64.h:1102:2: note: to match this '('
>   ((__typeof__(addr))(__untagged_addr((unsigned long)(addr)))
>   ^
> ../mm/gup.c:791:10: note: in expansion of macro 'untagged_addr'
>   start = untagged_addr(start);
>           ^~~~~~~~~~~~~
> ../mm/gup.c:892:21: error: expected ';' before '}' token
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> ---
>
> Is this already fixed???

Hi Randy,

Yes, this has been fixed by a22fea94992a2bc5328005e62f368413ede49c14.

Thanks!

>
>
>  arch/sparc/include/asm/pgtable_64.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- mmotm-2019-0925-1810.orig/arch/sparc/include/asm/pgtable_64.h
> +++ mmotm-2019-0925-1810/arch/sparc/include/asm/pgtable_64.h
> @@ -1099,7 +1099,7 @@ static inline unsigned long __untagged_a
>         return start;
>  }
>  #define untagged_addr(addr) \
> -       ((__typeof__(addr))(__untagged_addr((unsigned long)(addr)))
> +       ((__typeof__(addr))(__untagged_addr((unsigned long)(addr))))
>
>  static inline bool pte_access_permitted(pte_t pte, bool write)
>  {
>

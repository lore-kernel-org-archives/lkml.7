Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C948C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F292082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJs+UgGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDAOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:22:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37160 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfDAOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:22:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so5718834qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yynG3rTDs2gDqeJdVb4ntcI7Gi13+HlcUmvdxrRDzWs=;
        b=IJs+UgGdnyhTmsBzquw+JnHS53NHMITGpQKYU0Bn2els5FlaUkUdru/1tfRt0Kx9kF
         nUKIzLSCsfhsR/NtGflymjCWEs3u602CxaMsP7KDVV9uzTPo+TMvgDOjaPr7lF2E1e1R
         VnSqnWERaFSXEVS9f/snPa/C9ymanNjbH2JvzuhBMx5vh8xg09zLuU3sVW+UESBR8KtI
         IzydSlb9i/025V7cyEOWza3APbWEIdKf3jIXZzpyFrVZcofZQHSLAg5QwE6SJuBrBDzT
         lJjoIS9LvnAVK9hKGK+OEnYBxeMxKGbg3AfbDL59YUXcnjyZOD2XKkIdhbuFSXr1gARh
         z1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yynG3rTDs2gDqeJdVb4ntcI7Gi13+HlcUmvdxrRDzWs=;
        b=FpTq4ml4M6sDVJ0NfsqpBF2twLoH6XnXb8pM1h26AdrziPZLUfrPmlER16xegPtLsU
         9uJQ94GCYW/dGxLKFM01Tb7GR6gKAuDueKJhPP6EZuPmkur7XLrndy4V4Ao6UE+seYCg
         DrrzxoaA/bX36dhOuJwH2NUl5L88NlmoPDqBTNr3Lc43LIX/VYej0z2wxv7A9iQBVU+Q
         fE+AMlES0iPTEAP69JxFlBeCYBYkJoGJ0ySzKNJCNQhSWyl4JBUY1MwU92oZAAytbKqP
         8Y1u3RGLNj6FtAliYx6Mq8ipSPGQ2DTGCLx6b5bBYx5HcOj2TeAQc9br/gFLiOkIhzqM
         ep9A==
X-Gm-Message-State: APjAAAWp8jZX918tIAGfF2Cu20zAb3YrrdyAqRHUboPmm9wxcgG/dSsS
        8X8TujeWSVhLCU5JJ3hMBjP2ot3jSutcx9ysstU=
X-Google-Smtp-Source: APXvYqy79Q+yHjorbIVgMmpduAy9fyc9tXLFRFjT04yPQ9pcQyhYBZafmnmL8Lsg3hafAGxDJrw365QfTgoXE11d+cw=
X-Received: by 2002:ae9:eb0b:: with SMTP id b11mr23728295qkg.214.1554128525831;
 Mon, 01 Apr 2019 07:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190330131346.40289-1-smuchun@gmail.com> <20190401104432.GB14874@arrakis.emea.arm.com>
In-Reply-To: <20190401104432.GB14874@arrakis.emea.arm.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Mon, 1 Apr 2019 22:21:58 +0800
Message-ID: <CAPSr9jHmx8unVN3rsQzGSSc4hYL2wafw20D8QKf8NG65dX7ErQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: fix max_mapnr is assigned the wrong value
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, logang@deltatee.com,
        robin.murphy@arm.com, ghackmann@android.com, hannes@cmpxchg.org,
        stefan@agner.ch, david@redhat.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thanks for your reply.  In fact, I didn't hit any problem.  I just read the=
 code
and found the problem. I see max_mapnr is to only be used in the
generic pfn_valid().
As you said, we do not use it on arm64.  So in a sense, the patch is
meaningless.

But I think since it is a problem, why not fix it (Even if max_mapnr
is not be used)?
What is your opinion?

Catalin Marinas <catalin.marinas@arm.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:44=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sat, Mar 30, 2019 at 09:13:46PM +0800, Muchun Song wrote:
> > When we not use flat memory, the mem_map will be NULL and
> > pfn_to_page(max_pfn) is a pointer which is located in kernel space. So
> > max_mapnr is assigned a very large number(e.g., 0xffffxxxx_xxxxxxxx) - =
fix
> > it.
> >
> > Signed-off-by: Muchun Song <smuchun@gmail.com>
> > ---
> >  arch/arm64/mm/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index bc02818fa48b..e86c21a44c88 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -535,7 +535,7 @@ void __init mem_init(void)
> >       else
> >               swiotlb_force =3D SWIOTLB_NO_FORCE;
> >
> > -     set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
> > +     set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> >
> >  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> >       free_unused_memmap();
>
> The patch looks fine but did you actually hit any problem? max_mapnr
> seems to only be used in the generic pfn_valid() which we do not use on
> arm64 (just wondering if it needs a cc stable; it doesn't look like as
> it's not a regression).
>
> --
> Catalin

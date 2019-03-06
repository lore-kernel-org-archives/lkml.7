Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D702C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54CC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+XlbTbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfCFChe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:37:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40434 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCFChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:37:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so9007393eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dto52epf/L30pO15g7OSuLPsnvnnkRo2oO4/kvhk0PM=;
        b=N+XlbTbGePT1MOOD1qNtA8RURD7aqIs3sNXjIv9GsUfhaohR+hIlZEZQFBh0JpfnFX
         5Pbqk9Op1eZ+RDsymZWJVlF98yKwGvV0Cueiw9ey8vuJkMMZ8u4aDggUcl7AfC7ZesWY
         sWZW205tOvE/hvPeWtbdBzRHyv40+ausSHtTtrFGuB+GW2n/LVWXRCZd5kqcVSpPK13l
         yuuqDJAEIYiKJVrbIdTf8RNdh7wz9tsPoEXkEbiV+hPLZtkW6SL4yx3i28q4ESp6+eH3
         GD2s+PFZHv3FbMJw/AaxU8aL7dyti4I9y75zBaFOwnfjo5SXvWztdPOSe9gkV6q1TXPq
         2ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dto52epf/L30pO15g7OSuLPsnvnnkRo2oO4/kvhk0PM=;
        b=YT8q9KRK8yMQErTgSraRs8aXdTqAfGo47MK7GJsnnW5dBsFKCO3H5vEfate0C7hN5J
         LVRMxSgWCDa9vBH0cpx/CRNiMKluyAe84oig9A/rmybN5xOzUMDDUoWOZMWsigl4tk5W
         YWL+jHwxzdEXbVKH4a39ooFEQXmQxAuW5c/oroggrLhpR4JAni9/fHFRKJZmxZHlKZg+
         Q4OTTNTuiw5QXeFkRtyLgyKdx5FpgLJHErQ6QSYou94+o7cySTdiiKsUo+WY3h9LvvGn
         qoQwV2ONTHJ/hrt/aWJA9VXKHR6sNfQhrUph+8WyXSjpuJ3iiCyq+FYjXXZe4FxaPWMq
         r6tw==
X-Gm-Message-State: APjAAAUAsXnAbw338UAoBP+OzpHKjyOOFa2jnoDh+NhKWCVlgyUzu8W3
        6tILpDH+c3s7WLxx6PIq6+k7Lb88961kHxOlTeE=
X-Google-Smtp-Source: APXvYqzOrOSGSILsO0pYkE9COKykD9R5JdO9lbNmAwkEyvcJQMoYfNtxwwzetFKT85oOe7o1uXdi9niKoqRBjXcnGh8=
X-Received: by 2002:a50:b136:: with SMTP id k51mr21911999edd.111.1551839852133;
 Tue, 05 Mar 2019 18:37:32 -0800 (PST)
MIME-Version: 1.0
References: <1551710008-3283-1-git-send-email-albin_yang@163.com>
In-Reply-To: <1551710008-3283-1-git-send-email-albin_yang@163.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 6 Mar 2019 10:36:54 +0800
Message-ID: <CAEbi=3d5MtuADekfHLCs=jAcAF6b9GgvvKcndvWQX31Ry-McgA@mail.gmail.com>
Subject: Re: [PATCH] nds32: fix semicolon code style issue
To:     Yang Wei <albin_yang@163.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        rppt@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        yang.wei9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Wei <albin_yang@163.com> =E6=96=BC 2019=E5=B9=B43=E6=9C=884=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yang Wei <yang.wei9@zte.com.cn>
>
> Delete superfluous semicolons.
>
> Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
> ---
>  arch/nds32/kernel/cacheinfo.c | 2 +-
>  arch/nds32/mm/init.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/nds32/kernel/cacheinfo.c b/arch/nds32/kernel/cacheinfo.=
c
> index 0a7bc69..aab98e4 100644
> --- a/arch/nds32/kernel/cacheinfo.c
> +++ b/arch/nds32/kernel/cacheinfo.c
> @@ -13,7 +13,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>         this_leaf->level =3D level;
>         this_leaf->type =3D type;
>         this_leaf->coherency_line_size =3D CACHE_LINE_SIZE(cache_type);
> -       this_leaf->number_of_sets =3D CACHE_SET(cache_type);;
> +       this_leaf->number_of_sets =3D CACHE_SET(cache_type);
>         this_leaf->ways_of_associativity =3D CACHE_WAY(cache_type);
>         this_leaf->size =3D this_leaf->number_of_sets *
>             this_leaf->coherency_line_size * this_leaf->ways_of_associati=
vity;
> diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
> index 253f79f..e2eb4eb 100644
> --- a/arch/nds32/mm/init.c
> +++ b/arch/nds32/mm/init.c
> @@ -264,7 +264,7 @@ void __set_fixmap(enum fixed_addresses idx,
>
>         BUG_ON(idx <=3D FIX_HOLE || idx >=3D __end_of_fixed_addresses);
>
> -       pte =3D (pte_t *)&fixmap_pmd_p[pte_index(addr)];;
> +       pte =3D (pte_t *)&fixmap_pmd_p[pte_index(addr)];
>
>         if (pgprot_val(flags)) {
>                 set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));

Thank you, Yang Wei.
Acked-by: Greentime Hu <greentime@andestech.com>

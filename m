Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08129C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FCE2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/oF45NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKUJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:15:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36715 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:15:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so2435880qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZU1LI0R2ezOgbUTZ3xShVeX8BXf5NX1ShOyPwKld7lo=;
        b=k/oF45NY1cMv2CCPOezTR/XnScRr/9u09Tu1cB5e6Tc5hTFsN0D8CBSWokBRs4RKlw
         5tJh9vfeXP1Sjzm3+V92XW8dNpKZAi5JfiPlpRks7duzsCMUqlxbhvhbvqVhR4HXn7/4
         OVqCm9dqyHd95Lcn/ivlEa9Z5+/m7sVveh1X+Xv4UisBu5yea3k1aMGlYKaeFtuDqloG
         Y2YLsGKjJJtgafm/q5chcKwQv55+qWfC3d7U2Qd9U44/GlO+fAi4+Tql5+x3XvIwYzue
         WkPbguxs9Je5Upz3y6F3IHDZE8UnDp15JXtPIoRVAA2M6J9ZlgNZhrdljJ5KV8Okjl/z
         7+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZU1LI0R2ezOgbUTZ3xShVeX8BXf5NX1ShOyPwKld7lo=;
        b=X1YujtOC2t3mwmdSkhA1xx8vtcEppCZYmk0upaDPvFq3UA4JTGjgqXpkScU7OYYRqf
         BkmnUIEOZ6YDMltdvojiikazdCVe6bJqGorqnbn7xoB0D8oYTzQ7zCSwZveX7kQdRfCO
         2iyMtD5mlUvknwCXNDkAjCTZh2ZhFJMd1wr7pA04kcFnj728YzYAYcuF+HwDd/QzKEn4
         s2GrQ4NNdlTb43ruAzLRBW1gxMrgHJZ9Y7IDLPzpOs3hkC5fvUgTftyObNo/Nin4uL4S
         vNp8arbxh5vIBgrRuauWrDFxr+Fq/kicCCxkeLL2ISn+srucMCh3Qagv5q7V1vItPq3s
         NQzg==
X-Gm-Message-State: APjAAAWs0Hdg5dC/LlQZ8T07SfdAs0ocW/KK4nHrI26+TKCgVYkOhXco
        HzNABIFJOpcLbgpBzwlTyykFwt+kFN1sEYc3chVAL2bpNPU=
X-Google-Smtp-Source: APXvYqzI3JdBXd6ZdFBiOks+zc20Dx8e78asqnUyN2ccj67lqOtQbihyinUsbVJhnvAz8xfQtDrgCQKpN69VFa8zf4o=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr1835399qkd.281.1574327701433;
 Thu, 21 Nov 2019 01:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20190814034521.22659-1-standby24x7@gmail.com>
In-Reply-To: <20190814034521.22659-1-standby24x7@gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 21 Nov 2019 17:14:25 +0800
Message-ID: <CAEbi=3crLgPYNGmO+6TCrxMYxMj3aD1e2jqTxnnsCzTeAZX48g@mail.gmail.com>
Subject: Re: [PATCH] nds32: Fix typo in Kconfig.cpu
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Greentime <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masanari Iida <standby24x7@gmail.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> This patch fixes some spelling typo in Kconfig.cpu
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  arch/nds32/Kconfig.cpu | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> index f80a4ab63da2..f88a12fdf0f3 100644
> --- a/arch/nds32/Kconfig.cpu
> +++ b/arch/nds32/Kconfig.cpu
> @@ -13,7 +13,7 @@ config FPU
>         default n
>         help
>           If FPU ISA is used in user space, this configuration shall be Y=
 to
> -          enable required support in kerenl such as fpu context switch a=
nd
> +          enable required support in kernel such as fpu context switch a=
nd
>            fpu exception handler.
>
>           If no FPU ISA is used in user space, say N.
> @@ -27,7 +27,7 @@ config LAZY_FPU
>            enhance system performance by reducing the context switch
>           frequency of the FPU register.
>
> -         For nomal case, say Y.
> +         For normal case, say Y.
>
>  config SUPPORT_DENORMAL_ARITHMETIC
>         bool "Denormal arithmetic support"
> @@ -36,7 +36,7 @@ config SUPPORT_DENORMAL_ARITHMETIC
>         help
>           Say Y here to enable arithmetic of denormalized number. Enablin=
g
>           this feature can enhance the precision for tininess number.
> -         However, performance loss in float pointe calculations is
> +         However, performance loss in float point calculations is
>           possibly significant due to additional FPU exception.
>
>           If the calculated tolerance for tininess number is not critical=
,
> @@ -73,7 +73,7 @@ choice
>           the cache aliasing issue. The rest cpus(N13, N10 and D10) are
>           implemented as VIPT data cache. It may cause the cache aliasing=
 issue
>           if its cache way size is larger than page size. You can specify=
 the
> -         CPU type direcly or choose CPU_V3 if unsure.
> +         CPU type directly or choose CPU_V3 if unsure.
>
>            A kernel built for N10 is able to run on N15, D15, N13, N10 or=
 D10.
>            A kernel built for N15 is able to run on N15 or D15.

Thanks, Masanari.
Acked-by: Greentime Hu <green.hu@gmail.com>

I will queue it in nds32 next tree.

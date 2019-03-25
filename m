Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3322220872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK5qFhdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCYEGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:06:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43186 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfCYEGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:06:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id d26so6246418ede.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 21:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W2uNIY+GHug5w4hGLJzjOfyvmHN3DHiOZjVJVsz6a6k=;
        b=GK5qFhdb3lC61T8YNRTDbhllE6olxZaiAvpTFcun/+siRaLfDIVqvgvj1bzDczWYmx
         2GFBYY+lbLtJtQAHaiON9a8ncV4xtBYDldV2Uc8ZLtlHoElqJQfN8clctogN7ze/nLUE
         iBE9j8ITHrLz0ZwgEPNDkkxQKofXyjVuaGoztVfhuSf0By0fej12jRmE4UTriKBB60rW
         1ySfCWTgEhWv+Jj0l0KXM11MGT9CY6DMf97Qz+NzbMCyAuVKYCbdPJtdEpr+IU9oqXCi
         eDVP40mXvfYgB7oIDakPWNmZnJoNEPuVYRV4qjEjygjFGiTVzXovuxLmhiYhmpIXvrBP
         zSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W2uNIY+GHug5w4hGLJzjOfyvmHN3DHiOZjVJVsz6a6k=;
        b=j1guRMqwih2RD0E0nMuim2qTXQ4/6ePC3UTl0EVACVwb8tsVtG+CdFY9RntIpZWSvd
         lVouWocO/L7Vi0cdym2Wf4QuglMEfytwRyX+9nh7i3G5JAHYG56NzuDDHptmpHwGzNl/
         LSOyr7WjSHDcS2xtFY1GXypDfyOG8c7AbHXRyE9SpU2U6J8m1zkER1rpiL1nwVULhayW
         XP+I2CR6Py1tsdA37D63k74SU0c/FvwkEHQQetobTyu32umWa2+mI4oE/j0ou682C4EO
         oIkSgbU3v+Ekb9XJB1SdyHy4WV5FyiOP2pAQtWTe7CtdrvVe7rI7yu+Vt46QDM1kxuNe
         eZOA==
X-Gm-Message-State: APjAAAU2bc4sRXZzrgyJn4mAQR67dABkqeLHPVzhnyYMDXdJrG+/1+Mc
        X5mtYOGUtbGanOIOlefB68FZcd78CgMgrgWiUuRjQn2rcMw=
X-Google-Smtp-Source: APXvYqzjplzf7ok5wwS+XThTsJcFnkSG3GrKjGlA9iIUr8BSYEUXgirO2ujWl6YT1YiMSW/r/MeBfl5HU0oXud/bfCo=
X-Received: by 2002:a50:90b3:: with SMTP id c48mr13614550eda.8.1553486795889;
 Sun, 24 Mar 2019 21:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <1553268101-18742-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553268101-18742-1-git-send-email-yamada.masahiro@socionext.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 25 Mar 2019 12:05:59 +0800
Message-ID: <CAEbi=3cWZYL96ytjGw0hOBHu-DKa27aQbRwfCsT24WdiYDsrNg@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unused generic-y += cmpxchg-local.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada,

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B43=E6=
=9C=8822=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:22=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> NDS32 is the only architecture that creates <asm/cmpxchg-local.h>,
> which is not included anyone.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/nds32/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuil=
d
> index 7ef8695..c131e0e 100644
> --- a/arch/nds32/include/asm/Kbuild
> +++ b/arch/nds32/include/asm/Kbuild
> @@ -5,7 +5,6 @@ generic-y +=3D bug.h
>  generic-y +=3D bugs.h
>  generic-y +=3D checksum.h
>  generic-y +=3D cmpxchg.h
> -generic-y +=3D cmpxchg-local.h
>  generic-y +=3D compat.h
>  generic-y +=3D device.h
>  generic-y +=3D div64.h

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>

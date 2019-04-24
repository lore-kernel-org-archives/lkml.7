Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EAEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99A320878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9YPDsvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfDXHCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:02:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32839 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfDXHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:02:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id d55so14922480ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pWTQt+8V2h5k1yhcV7X1k2JWjjnKPOv7sz6YyFgX/s8=;
        b=K9YPDsvxd2uN/UwYjlT2cJVQYze6Ch0w+ZgkIzSWHhQPJXJ82E96z/i1KtLv4vXtyt
         r+bradL48Uy+kWNhXyNJSHArfcBmRryFJwwfdIMhWNV3d9+XfxSOajk39NH/c9323FGO
         SqlPdh+ypyXS0+QWrEPiMxjFPxDlQpeiBoB8O1w7xla5CyYj4NLlDuaQvb7uY5AXoU5s
         VU/mBQ7ScVQTv/LFxm2pQdwgRL3kc4IfSlS5hlg1OmBsS3NejWan5HmytaeKq3yPO6hW
         +snwNIZnenkVKbWGjbrb7dY9WxJSQQPcvkd4QMAm2urgbN6TUVgiMSPkr7DjiHsWkrJT
         NNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pWTQt+8V2h5k1yhcV7X1k2JWjjnKPOv7sz6YyFgX/s8=;
        b=MvEEJUkwt/cWXnUZ7Tjidkbte6FdYK0WQtsCEYogfuCx//9DEsPh7B+O2shalkgrTH
         mBDfm/lvbkn1M4j+eRu8AaXW0S9DezvyrQvydnuI0tKJeBuIU5E7JY5Dlaq4iXagJpmt
         RNwm8MKI2lXHU4E/XTl06AH+ydl7GOBJukJUNKwRyCuEgGJFjCiPntoXWKXTBFXcC9bq
         hKvGndPEtID10wcdqWwdCMpcAf9FVKS0lSli/4LEviutJFS3dlE5hHK5V64fFWioI1vi
         /kL3wh1SY0Z1irc4nM7Meq8gTq+3XW0AlOnqCcQlo7ZIgIvU5O8DQ4sqLPFVquNDcYDp
         LTMQ==
X-Gm-Message-State: APjAAAVM9udCJqmVPpQ7tSJDaOyWzb74vAUAsqBPZLajvvGihMF2Sj6C
        Lx1bA0M2oZzzltiwYBQOq0pOzZ5MRAq7kNeuF4A=
X-Google-Smtp-Source: APXvYqyNK2ANouxm4aBwJr6VqC8Y25jlN5PhPRMR/eAufMKrnVoHh0NJZ5RpXe6gh1bJKKkSGoYT6jpzCquphd2kpYg=
X-Received: by 2002:a17:906:641:: with SMTP id t1mr14937384ejb.158.1556089350540;
 Wed, 24 Apr 2019 00:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190418093856.17852-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190418093856.17852-1-yamada.masahiro@socionext.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 15:01:53 +0800
Message-ID: <CAEbi=3fCB8Gvu8L=D5ZJYmd9hrZZvjdB2rrHph--EHfgdoounA@mail.gmail.com>
Subject: Re: [PATCH v2] nds32: remove unused generic-y += cmpxchg-local.h
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

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B44=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:39=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> NDS32 is the only architecture that creates <asm/cmpxchg-local.h>,
> which is not included by anyone.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Fix a typo in commit log
>
>  arch/nds32/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuil=
d
> index 64ceff7ab99b..e8dbfbf8cc69 100644
> --- a/arch/nds32/include/asm/Kbuild
> +++ b/arch/nds32/include/asm/Kbuild
> @@ -6,7 +6,6 @@ generic-y +=3D bugs.h
>  generic-y +=3D checksum.h
>  generic-y +=3D clkdev.h
>  generic-y +=3D cmpxchg.h
> -generic-y +=3D cmpxchg-local.h
>  generic-y +=3D compat.h
>  generic-y +=3D cputime.h
>  generic-y +=3D device.h
Hi Yamada,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>

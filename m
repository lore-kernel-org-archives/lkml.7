Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E472064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yu4cl/Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHASq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:18:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39165 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCHASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:18:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so12734100pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMrAtyR5r9xC1KvkL1CTb57Dx9giVYGmSgH2BWeg3n0=;
        b=Yu4cl/Cea1WkMyAr5f9W2QQUF5jbIOhesJZpyZ4880czNGAHrP/+6sHZ/Kn3umigaa
         d6sn4szwCrj30xgNsm4rtywxZje1PBfU5JgPiK31w169mtpc3B30OJH+LoRwzCXIYlDR
         gKurhD9G10kZnixAq0xvG03beGYbwUbDi6N/Qc/qlzgsdgjurtMH7s5MmF9n8/iO/8EE
         0a/2MouMdipVsVuSU5kxw9yY8j7SbC7BFBOSiQoxZbYMTcIEIEbdR2MKLGlKyajQWWCC
         2baEni//CAMiDXdllcDbokN90pCJL3HT91LLLM6pBu+i2Tj0R7l5atnXFc/eczQa9P1C
         3tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMrAtyR5r9xC1KvkL1CTb57Dx9giVYGmSgH2BWeg3n0=;
        b=M+qwazPnFUcQampK/Pm0GnfFvGwGEsThKbezilSXrZvCx1bmkq946fyLIJriEPSV6O
         cecRNAug2otIk98Zjty8Ohv0ugYaJ5W7dDv2vsVzQKb1UQwBG8nFsa+FgjFwbSo/utcS
         2lO34w3Qkqdf5PQIjcJgImNoWYsGGo55cz+k/oJFAnp2lsB+RDgpqNAqVfKTJ52C2Q9e
         cAaJWJSi0VqPOhjSThiEUBcc0UO3rGKycw0EjnckR8N++4JEUiU72cinVKFu6ajNdnoT
         OTC5vCMNas3QAoTph1arzNdkv1FIXEZwpju1/ibacBUEsT/Eo1rxIujxVIJCG5lKSbqi
         bs0w==
X-Gm-Message-State: APjAAAW7COVTywkgrhznXWHEUiIRzfQOGpNP8QKCLwe8qx1r3j9KfQyi
        FghA8EQTC/0f0zCKFSrnobXhFQU6e+AIqXq63aISpw==
X-Google-Smtp-Source: APXvYqxuzsVs3K+4TZ8tTBfq2k35wOS63/9sSJaVENklPgr56ZvZgOr7DoxBcqaIRcFM5gsZvih80aXfM3zFb9KmgWQ=
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr15870178plx.13.1552004324884;
 Thu, 07 Mar 2019 16:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20190307225650.23001-1-natechancellor@gmail.com>
In-Reply-To: <20190307225650.23001-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:18:33 -0800
Message-ID: <CAKwvOd=Exr0y_3m9aJJEjPbFcWvLPjO6EtKHsXvymAU=WdQHtQ@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: pwrap: Zero initialize rdata in pwrap_init_cipher
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/soc/mediatek/mtk-pmic-wrap.c:1358:6: error: variable 'rdata' is
> used uninitialized whenever '||' condition is true
> [-Werror,-Wsometimes-uninitialized]
>
> If pwrap_write returns non-zero, pwrap_read will not be called to
> initialize rdata, meaning that we will use some random uninitialized
> stack value in our print statement. Zero initialize rdata in case this
> happens.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/401
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> I don't know if this is better or to just restructure the if statement
> below (I'm not an expert in this code so I'll leave that up to the
> maintainers to decide).

No, I the way you have it here is most correct.  That condition writes
a value somewhere, reads it back, then compares it.  The write or read
could fail.  Better to just initialize rdata in case the write fails.
Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 8236a6c87e19..2f632e8790f7 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1281,7 +1281,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
>  static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  {
>         int ret;
> -       u32 rdata;
> +       u32 rdata = 0;
>
>         pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
>         pwrap_writel(wrp, 0x0, PWRAP_CIPHER_SWRST);
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers

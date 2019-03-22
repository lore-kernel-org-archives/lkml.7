Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E53213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfCVOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:22:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36919 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfCVOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:22:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so2686113qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Stw2rpHrkW4dF59mq8dQG0sQ4gTHQozphVNZCjc4goE=;
        b=YF8BMoqjY+Zrx2uc7rhe2t//UzwCJUWFnHB7JniwuczSLTGKCH2bifk7NCpUC6ah/B
         wYwSC0qba/ei8/ehMKDLRaQUIiKyVw8SQPay4EMpDbZT4CcdiWXRgOvr82sSTvrGzZbB
         1/lBKCCKs1VAHZhGrEmHFcSv6Tmy7aPk7S4TAQ06/Tmx52V5ksCwHlNq5IDIGm2dmmJK
         g7FZHePdPynVVxcJhyW3X582ZY8osO/rqrsSUKC47hEfHm67rZfNkhKc02fuqhXi0YHg
         MPJvInG/1sfhJGVELQ1qxM5sSHg5+nsifg+lC4wja5QJHLdCsSCTtmbHGUhNDbGVi2c6
         51IA==
X-Gm-Message-State: APjAAAUvUqYT7rdn3HwsitWRhI7ZDmiHTm8/VYePI+ds3thTMg8h/SFO
        4KbJt+zrjlTa6ecJX6b1BY/3uzeAeJOMoRZPEpQ=
X-Google-Smtp-Source: APXvYqwUWfFStAQ+15rpG5oObuyIgpCrzu7ZTJ0kQgy194Kl7ih8pBY3vqWtyrEHEnBGC0BxDU/dVSOjz77k4je9RgE=
X-Received: by 2002:a0c:af02:: with SMTP id i2mr7992077qvc.40.1553264575926;
 Fri, 22 Mar 2019 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190307225650.23001-1-natechancellor@gmail.com> <CAKwvOd=Exr0y_3m9aJJEjPbFcWvLPjO6EtKHsXvymAU=WdQHtQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=Exr0y_3m9aJJEjPbFcWvLPjO6EtKHsXvymAU=WdQHtQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:22:38 +0100
Message-ID: <CAK8P3a1qw4qMjvF-=0=9tJz_HmWYamS6TDDSPSMz_-XHrevwVA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: pwrap: Zero initialize rdata in pwrap_init_cipher
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 1:18 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Mar 7, 2019 at 2:57 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/soc/mediatek/mtk-pmic-wrap.c:1358:6: error: variable 'rdata' is
> > used uninitialized whenever '||' condition is true
> > [-Werror,-Wsometimes-uninitialized]
> >
> > If pwrap_write returns non-zero, pwrap_read will not be called to
> > initialize rdata, meaning that we will use some random uninitialized
> > stack value in our print statement. Zero initialize rdata in case this
> > happens.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/401
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > I don't know if this is better or to just restructure the if statement
> > below (I'm not an expert in this code so I'll leave that up to the
> > maintainers to decide).
>
> No, I the way you have it here is most correct.  That condition writes
> a value somewhere, reads it back, then compares it.  The write or read
> could fail.  Better to just initialize rdata in case the write fails.
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I also came up with a similar patch here, but I move the initialization
to just before the first use of the variable:

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 8236a6c87e19..eb5035fd8ecd 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1355,6 +1355,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
        pwrap_writel(wrp, 1, PWRAP_CIPHER_MODE);

        /* Write Test */
+       rdata = 0;
        if (pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_WRITE_TEST],
                        PWRAP_DEW_WRITE_TEST_VAL) ||
            pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_WRITE_TEST],

Very little difference, so let's go with your patch

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

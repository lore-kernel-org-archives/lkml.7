Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B38C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA920830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfCVPJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:09:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42993 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:09:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so1390012qkg.9;
        Fri, 22 Mar 2019 08:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h95rQ83YoQMRPu5Sl13ZHNA0JXgicA32GOHx8MyGaq4=;
        b=ZE0Rmpyl5Gkjl0rNDaofunAoKOBvfdIOYs4ZRKIJte1F5zmCHaYsbxARn7f/iXc1bU
         +QdLC0yflb6YdxHPfDqvtIb952sLjmvxBeHf57QoVEJR3kmP3xG7gyCu8LOBd0ntiu4S
         Do/2QJ6lPk2uDCQA7KtqN4ejc177mO3CyG51gOtqLza4/jywJoM5MOov5xgBeL6L63ac
         /AOPeMXY9RQwUA08KBMYA9uZEiaJ8l7rVq+sEELxCoYuJ+SyY0zBYUTM8ubnY2a8h+hO
         Yv4j3EGyVKHRS+bPh8gJEBBlqk2va4YMsQpgN82RDvGNY47u1ndLz+5VrgmPuNSLboRD
         KJnw==
X-Gm-Message-State: APjAAAVKYYlLwOPf/FTgEPZdEvKJYPfFoyHXVvOhOkbPhFz2Rt4ZtDym
        4ercH9RFLJ0fCCLhYSKKA7xSUu68+hz4uEjy86c=
X-Google-Smtp-Source: APXvYqyurRQ1eVlJfrOymitwFX/5ej4cXXOOXiovxMWvoiE3sLqql2WET+r+ZW9pKqN1yxwt6+fiisjOYErZT/Fi59o=
X-Received: by 2002:a37:b386:: with SMTP id c128mr7613983qkf.330.1553267363691;
 Fri, 22 Mar 2019 08:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140906.319267-1-arnd@arndb.de> <20190322145828.GB6521@archlinux-ryzen>
In-Reply-To: <20190322145828.GB6521@archlinux-ryzen>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 16:09:05 +0100
Message-ID: <CAK8P3a1k96x_vqjCWU9Dmj3N7arpD3LLY1Tx3NLwciG-q26hzg@mail.gmail.com>
Subject: Re: [PATCH] iio: stmpe-adc: avoid harmless clang warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:58 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 03:08:39PM +0100, Arnd Bergmann wrote:
> > Clang points out a control flow bug, which happens to be harmless:
> >
> > drivers/iio/adc/stmpe-adc.c:204:13: error: variable 'data' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >
> > The warning is sensible here, so let's just avoid the case by
> > adding appropriate error handling.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/iio/adc/stmpe-adc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > index 37f4b74a5d32..ed3817c5c896 100644
> > --- a/drivers/iio/adc/stmpe-adc.c
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -205,6 +205,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> >               /* Read value */
> >               stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
> >                               (u8 *) &data);
> > +     } else {
> > +             return IRQ_NONE;
> >       }
> >
> >       info->value = (u32) be16_to_cpu(data);
> > --
> > 2.20.0
> >
>
> I sent a similar patch, which is sitting in Jonathan's testing branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=e15146e4d4349b3f309f5591ea8de8d24071265f

Ok, sorry for the dup. Your seems to be better than mine, too.

      Arnd

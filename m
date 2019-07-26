Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C8C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C6322BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="AqdQBSa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfGZR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:59:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33791 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGZR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:59:29 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so106625892iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mz6yFp/JdoMmP88Hd9wgTkqmhK5wh8hSxVlurnjVo58=;
        b=AqdQBSa+KR+uV7HGSwYjR8NLjKpjPepgw0zylTLXZ2QQt/1THpF/IcxTn9NEC2+a1o
         mEdqDuJaXZJSxYKkUXBcNCmPTgQq3dGfUhPsntmMSDH5QtHkMKiKDU86C/gca8cxTMd8
         6/yzBbfm3RVHl15/DODIgB3Cd/GPtXpUnJkV2SR4GLk5GbVLK8RwEW3EX2EtkejrFmNv
         HVjdQh5HsFf+GdZ0BQSIw5dMf1rZZwStF4kg1X0vW0pmSU3Lgs4BDbgxFVRlci6MTiKY
         tZK3xW9fmKhVo7LFGLcFqYWBmUa72CuL2KwU9npClRTQetuaBXMVcAyI7GofbWa4TVm4
         OFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mz6yFp/JdoMmP88Hd9wgTkqmhK5wh8hSxVlurnjVo58=;
        b=UmvC8zW7fWLrCFVyf6lkZfLBPDBTcB618QATwH8M/dORcRrTlP1a2QKxHQ677qPCZK
         2Sy5quJbKg7isqAifQwJ0lcMjjMTzRP3BJkIaesPZxLU0rc/u2f1HMj7hEqF3QyBuAJe
         mD3ul5Nc2zvhlnYmyP3J2EamdvKDg27xpbhEA3WENEoWHUkoxAyp/yX4riAXh8bM7UtZ
         9uklGBtuS+OWEBR8xoC6yvSpssrnyz3Gy6aiT8Z4y+iFweSYIax7oVLWMu9J+952QETw
         zX5Jshsqs461WCEbmnivmcrlLAmxWZOof9ut4Lu06ZatbecpiTSZ2byNoQz+P26avHt+
         cLGg==
X-Gm-Message-State: APjAAAXiKa1xavl5q7UKa4BunslQ5ajBC5HIhF3p5XdSW56dGglG1Gc3
        iA6wMXqtlOVCxGCv/hCRXXjV7RY88NrelBKQzUCuBg==
X-Google-Smtp-Source: APXvYqxQgZBD3hEdmYQN0ATdE+xO3I4QX7GvRTvtCBuN9N9yUSx7Dm9vAjvX0rbeiciuckyUOL3NhdqK6yM+PYnGSzE=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr16548342iol.280.1564163967979;
 Fri, 26 Jul 2019 10:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190725200817.31277-1-kartik.koolks@gmail.com> <0e273486f1c4fb6249896225837cdf2da0fd2415.camel@analog.com>
In-Reply-To: <0e273486f1c4fb6249896225837cdf2da0fd2415.camel@analog.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Jul 2019 14:59:16 -0300
Message-ID: <CAHd-oW5sOry2g_tQbgQ9-dp1esVStmS+UF-TTYoB2mWmzR10jQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kartik.koolks@gmail.com" <kartik.koolks@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:30 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Fri, 2019-07-26 at 01:38 +0530, Kartik Kulkarni wrote:
> > Add the of_device_id struct and the respective
> > of_match_device entry to complete device tree support.
> >
>
> This would be a [V2] I suppose.
>
> This change also does the rename of the driver name in a single go.
> Since it's a trivial change, it's fine from my side.

I think there was a small confusion when we sent the patches. Sorry
for that. Originally, Kartik made the rename in its own patch. Would
it be better if we resend the two patches separately?

Thanks,
Matheus

> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
>
> > Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>
> > Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 19a5f244dcae..ded0ba093a28 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -1027,9 +1027,16 @@ static const struct spi_device_id ad7280_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7280_id);
> >
> > +static const struct of_device_id ad7280_of_match[] = {
> > +     { .compatible = "adi,ad7280a", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7280_of_match);
> > +
> >  static struct spi_driver ad7280_driver = {
> >       .driver = {
> > -             .name   = "ad7280",
> > +             .name   = "ad7280a",
> > +             .of_match_table = ad7280_of_match,
> >       },
> >       .probe          = ad7280_probe,
> >       .id_table       = ad7280_id,
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/0e273486f1c4fb6249896225837cdf2da0fd2415.camel%40analog.com.

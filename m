Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27131CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D120717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="nGexxOxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJ0Sh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:37:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42717 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJ0Sh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:37:57 -0400
Received: by mail-io1-f67.google.com with SMTP id i26so7958818iog.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W72JgsGPmmhNZtme6eDZdINe8MmHqALahwfmKP4ShyY=;
        b=nGexxOxcZS1qZt7/3zp5kR38mDu+QZrlelR9kgOjdQDmyEqBCURDadNT0ztc9FQwsx
         LKgMULOyAqSQ45pZs+UkKaPOnHYa0/TZeyAUa9q9UBSVZmmSu9uSEHPbM+/zMziMnmv5
         Itoqh8yZLC0RBddUhglUSMdq17Fujs22/FMuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W72JgsGPmmhNZtme6eDZdINe8MmHqALahwfmKP4ShyY=;
        b=iOoFoKN6OzCFMZxtbK3pXqQGbGnvwJbHORuM41fjcGT7MrKrXP4QfW6vBroyYjnzJE
         Pc6UEE3bSPZZ4g8ZXXjgT4RWx14+OfTuP8JCiEexhsYrxm/saKrhS/5Tdeb6DzITB817
         7aLudAiw2bQEiBNE6A8FMb8KJWOVgpOVItvV5xi12BTAXw4+whawAg6aWQLYERJHAtcC
         V9NA70RCnM0drgL2n+isxDCVzw8kBK5A3C8WWBhFv96FyCN1R1SrvoEf6AGnR/bE7RPp
         Ji5rQYfu5PowRzQ8dtZy6978babK1EiX+6Equdnxfv61V6wCwlRgh31y9cEcuCKzHCLq
         1Nog==
X-Gm-Message-State: APjAAAXntp47Cbp9PXLtHSP006TSVSIxFFCo6X0J6gm1McrboByCp/on
        MSQakgBbpVgDe6LNC9sge4Y+aJ8w3oLivEFGreXf0A==
X-Google-Smtp-Source: APXvYqx1UK50ahGkEjebYFM9F1IbeNRlx0P4sN3kHyF3iD58GLyRWSqSX2jSzVpEO3cegs1acO6aGNHshVbwoLYjd2E=
X-Received: by 2002:a6b:c305:: with SMTP id t5mr13106457iof.87.1572201476275;
 Sun, 27 Oct 2019 11:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191023082714.18681-1-alexandru.ardelean@analog.com> <20191027165813.5a5b0519@archlinux>
In-Reply-To: <20191027165813.5a5b0519@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 27 Oct 2019 20:37:45 +0200
Message-ID: <CAJCx=gnCaqKHuZkRoCyHXR4ewwmqFCsRTiUty=CH0KB8PS+YCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hdc100x: fix iio_triggered_buffer_{predisable,postenable}
 positions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 6:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 23 Oct 2019 11:27:14 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The iio_triggered_buffer_postenable() hook should be called first to
> > attach the poll function and the iio_triggered_buffer_predisable() hook
> > should be called last in the predisable hook.
> >
> > This change updates the driver to attach/detach the poll func in the
> > correct order.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Seems fine, but should have cc'd Matt and I'd like to give him time
> to take a quick look.
>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> +CC Matt.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index bfe1cdb16846..963ff043eecf 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -278,31 +278,34 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
> >       struct hdc100x_data *data = iio_priv(indio_dev);
> >       int ret;
> >
> > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Buffer is enabled. First set ACQ Mode, then attach poll func */
> >       mutex_lock(&data->lock);
> >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> >                                   HDC100X_REG_CONFIG_ACQ_MODE);
> >       mutex_unlock(&data->lock);
> >       if (ret)
> > -             return ret;
> > +             iio_triggered_buffer_predisable(indio_dev);
> >
> > -     return iio_triggered_buffer_postenable(indio_dev);
> > +     return ret;
> >  }
> >
> >  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> >       struct hdc100x_data *data = iio_priv(indio_dev);
> > -     int ret;
> > -
> > -     /* First detach poll func, then reset ACQ mode. OK to disable buffer */
> > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > -     if (ret)
> > -             return ret;
> > +     int ret, ret2;
> >
> >       mutex_lock(&data->lock);
> >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
> >       mutex_unlock(&data->lock);
> >
> > +     ret2 = iio_triggered_buffer_predisable(indio_dev);
> > +     if (ret == 0)
> > +             ret = ret2;
> > +
> >       return ret;
> >  }
> >
>

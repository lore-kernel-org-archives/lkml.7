Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F512086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHH94aTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfGOXRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:17:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33822 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731933AbfGOXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:17:36 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so37007097iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn8VlLNQyAd5j32lIivn24k9NKqobex1p7VQed0BPHA=;
        b=EHH94aTDP0PnzaA0s5AjWTBU1xGlGD/LFZOledR+cH7MWGzDmdPqP/rCo4wxmhAZbv
         A21vq14fsMhyq2qEGMmb+aQ6HDb9tKyvTcwAm9EOfWA3tqa6gGQwGEIDPeeIn2YxupSK
         vx272qaWSFrCAzF583n1nUqKBQ6CeW5/lc4OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn8VlLNQyAd5j32lIivn24k9NKqobex1p7VQed0BPHA=;
        b=q/sBldqaSmoVmp2mW1piaffg0oGFS4TH8Usf9rMDAYTeYVVGlXMVAIv1hnxpKjxdM3
         9xs7gO+lxJcy9SUZ+xXn7u0j0Ju3gPDFfba8oQPQP7leBII35ErOlbg9xIrTAfydny7p
         K5UxBTwkXXfNahCq353H1AJQtZYGj/FrN2VOOL1oS3GeXU3gRbvP4LSQ+lBXa6RYx/q9
         xOIZHJle0Nh6bDkCEWZlIU7vf8y34KARCZpFr21z9/QyBfn9p8jHicRjc+GPHqIm71+r
         6yTB7glj15e/x1MfV1sxLhypNQ37QEbG6CSyv6EfXgW7TE5T+25z5td/DJMHziXG05rL
         lSpA==
X-Gm-Message-State: APjAAAWU7vOcebI8+CE/mLDaGZsqdidjMqqo5KFhJidUDIORptOvLjoz
        dCzO3Et0of9rNMPYexBy4p/3FvQaLpHtTkPyBxfQKg==
X-Google-Smtp-Source: APXvYqxCc4h//SlHxeX+EOOYxEHHm0Snz000w2zAi+ors9FXY+qRFFztl7vx0QzshzEbHiv4+phwJRFw642plHNUPi4=
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr2598615ioo.95.1563232655885;
 Mon, 15 Jul 2019 16:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191017.98488-1-mka@chromium.org> <20190715195557.GA29926@google.com>
 <20190715200447.GT250418@google.com>
In-Reply-To: <20190715200447.GT250418@google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 15 Jul 2019 16:17:24 -0700
Message-ID: <CAPUE2us7HZvSbpCddx4u_5KcdxedNd43-o=MZDiNfcpbzt9aXA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Benson Leung <bleung@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the original mistake. I upload a patch at
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1702884.

On Mon, Jul 15, 2019 at 1:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Benson,
>
> On Mon, Jul 15, 2019 at 12:55:57PM -0700, Benson Leung wrote:
> > Hi Matthias,
> >
> > On Mon, Jul 15, 2019 at 12:10:17PM -0700, Matthias Kaehlcke wrote:
> > > Before doing any actual work cros_ec_accel_legacy_read() acquires
> > > a mutex, which is released at the end of the function. However for
> > > 'calibbias' channels the function returns directly, without releasing
> > > the lock. The next attempt to acquire the lock blocks forever. Instead
> > > of an explicit return statement use the common return path, which
> > > releases the lock.
> > >
> > > Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > index 46bb2e421bb9..27ca4a64dddf 100644
> > > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > @@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
> > >     case IIO_CHAN_INFO_CALIBBIAS:
> > >             /* Calibration not supported. */
> > >             *val = 0;
> > > -           return IIO_VAL_INT;
> > > +           ret = IIO_VAL_INT;
> > > +           break;
> >
> > The value of ret is not used below this. It seems to be only used in
> > case IIO_CHAN_INFO_RAW. In fact, with your change,
> > there's no return value at all and we just reach the end of
> > cros_ec_accel_legacy_read.
> >
> > >     default:
> > >             return -EINVAL;
> > >     }
> >
>
> I messed up. I was over-confident that a FROMLIST patch in our 4.19
> kernel + this patch applying on upstream means that upstream uses the
> same code. I should have double-checked that the upstream context is
> actually the same.
>
> Sorry for the noise.

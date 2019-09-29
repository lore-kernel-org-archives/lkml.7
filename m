Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C39C352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EB2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="im7vmOen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfI2QzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 12:55:12 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:16987 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfI2QzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 12:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569776113; x=1601312113;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=x7b6SLeaG9bmKhPMxmT8BEbRRwJk0nI3N/pQdCncVCM=;
  b=im7vmOenWC8h5UPgD4ejuhL8BtsTPWqDoJHV8F6VjTi9vuAEOVBW8XTp
   WbIw5dGZMjNEY2+NokwYuoIfD9tMOJCMfeDmROmjq8HHxLCqOcHPDBEbM
   +ZW5EkNiRjZMspCuPVC0jWHiYz0ga/9bxqvoe+bkhTCYQOcnUs7h/h5GY
   RqpdJnr8nWM5GhUv1xn7p+UvIJP35gRi55qO9deOGte+g/i1g62UKv9Ck
   GRqwzbm51mDXOeJjdbPbJVTvYu1wWGZPZxRS/EQwNzEc/CiCclkzS8fsx
   LAeMS+Fz432ypfiqSOwpv+p2x2pedJBUbOQsTJQu/YPOeBzm+/P66zEgP
   A==;
IronPort-SDR: RhMplGOM4QMuqh/1rOs5uFo1lIBK/OkT/usYHuR2SyFJxosUcg1Noi4yvx7PfZF6WjyzSz8dfT
 Z3M3DjrgeAyoKDhuFLSPuh7526jg6zUB1uNqCRDVLXu55nRV1Kq7fEspaq0EzcbthINakOZzSg
 c6UPXyo/iDcAYrSCs+D8Z4M00WXuUfQluJYo/ytTW/9UuvL/4ioF8VxIRSP7+M/HY2mFTRKXyC
 92Z3Pk99Uje7h1FooCstp03Fh373FwNoWc8obEGUNZF4e5IP5t01i6mnl59U7E+k6H4TpWuoLh
 zIM=
IronPort-PHdr: =?us-ascii?q?9a23=3AoPdCyhaOUUREB9EYa+Cipbv/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMS+bnLW6fgltlLVR4KTs6sC17ON9fy4EjVYvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twrcutUZjYd/Nqo8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFKH4GyYJYVD+cZMulYoYvyqVsAoxW9GAeiGv/gxyRUhnPqx6A2z/?=
 =?us-ascii?q?gtHR3E0QEmAtkAsG7UrNLwNKoKU++1zajJzTXeb/NRxDzy64jIfQogofqRWr?=
 =?us-ascii?q?9xccvQyUk1GAPEklmctYLoMiiI1usRqWiX9fRvWv+yi2M+rQx6vzuhxt80h4?=
 =?us-ascii?q?XXmo4YzkrI+CZ5zYovO9G0VE12bcS5HJZUtCyXMZZ9TNk4TGFyoik6z6ULuZ?=
 =?us-ascii?q?u8fCcX1psq3wXfa/mbc4iQ5RLjSfqRLS94hH17fLK/gA6/8U26xe39Usm4yV?=
 =?us-ascii?q?JKrihYntXVuHAByhje58udRvty+Ueh3jmP1wTN5e1ePU80kq/bJ4Ygwr42iJ?=
 =?us-ascii?q?UTrVzOEjHqlEjylqObdUUp9vK25+j7YbjqvIKQOot3hw3mN6QhgM2/AeA2Mg?=
 =?us-ascii?q?gUWGib/Pyx1b3i/E35WrpKj+E6nrXXvZ3BOMQUurS5DxVL3Yk+9hazFy2m38?=
 =?us-ascii?q?gAnXkbMFJFfwqKj4zoO1HIPfD5Au6zg1eynzdxwfDJILnhD47TLnjMjrjhZ6?=
 =?us-ascii?q?xx601Cxwopy9BQ+ZZUBqsGIPLpVU+i/ODfWzk4OAyzx+/8QPB2nqwDWHiCSv?=
 =?us-ascii?q?uVPbmUsVKS/MovJOeWIoYJ7mXTMf8gss/vn38knhcvfaColc8GenCxH6w+eG?=
 =?us-ascii?q?2EamCqj9scRzRZ9jEiRfDn3QXRGQVYYGy/Cudlvmk2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUAAAc4ZBdgMbQVdFmHAEBAQQBAQw?=
 =?us-ascii?q?EAQGBUwcBAQsBhA8qhCKIHIZSgg+ZJIF7AQgBAQEOLwEBhEACgzgjNAkOAgM?=
 =?us-ascii?q?JAQEFAQEBAQEFBAEBAhABAQkNCQgnhUKCOikBgz0BAQQSEQRSEAsLDQICJgI?=
 =?us-ascii?q?CIhIBBQEcBhMigwCCC59DgQM8iyZ/M4hnAQkNgUgSeigBjA2CF4ERgxI+h0+?=
 =?us-ascii?q?CWASBLwEBAYs/gjGHK5ZJAQYCghAUjE2IPhuZNi2KKJ0EDyOBL4IRMxolfwZ?=
 =?us-ascii?q?ngU5QEBSBWhcVji0kMJEXAQE?=
X-IPAS-Result: =?us-ascii?q?A2EUAAAc4ZBdgMbQVdFmHAEBAQQBAQwEAQGBUwcBAQsBh?=
 =?us-ascii?q?A8qhCKIHIZSgg+ZJIF7AQgBAQEOLwEBhEACgzgjNAkOAgMJAQEFAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQkNCQgnhUKCOikBgz0BAQQSEQRSEAsLDQICJgICIhIBBQEcBhMig?=
 =?us-ascii?q?wCCC59DgQM8iyZ/M4hnAQkNgUgSeigBjA2CF4ERgxI+h0+CWASBLwEBAYs/g?=
 =?us-ascii?q?jGHK5ZJAQYCghAUjE2IPhuZNi2KKJ0EDyOBL4IRMxolfwZngU5QEBSBWhcVj?=
 =?us-ascii?q?i0kMJEXAQE?=
X-IronPort-AV: E=Sophos;i="5.64,563,1559545200"; 
   d="scan'208";a="10867039"
Received: from mail-lj1-f198.google.com ([209.85.208.198])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 09:55:12 -0700
Received: by mail-lj1-f198.google.com with SMTP id y28so2299176ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 09:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjNdX3e/FDjYlFzLDAbb3JmD3MBe1ko+MmFn61I90Os=;
        b=eaLsWYAJPOjhxmtCACw56DEPE7sqLX9nLXTxz6hU1tK+JUvQQO2OCLrsKM02ULvxae
         VngyARwjmxzEKRpHXXXpjbScVxQlVSDySmi8aNtbRGdaHLDcEfFG8LvdTZn1iQ38xhqN
         oziTgsDZ0464EFTVypf2PI3BtTI5IXKZIWxPzkbXKXqi95p1aH/P4Rmgr7Lev7iFPjJg
         E67bZklAFrTUGhkEp/eBBqdNoC10qCxLvqndr23AMnbS5zy7Hrrc4qooAmCDVHIcVqfP
         JzrCh3GWKyi9PkyQ6lrIwLaW3Fw+9QT41jtNLPafoiQRTFYM2SE/oGYGRzj6AxWLo1ZT
         Xf+g==
X-Gm-Message-State: APjAAAWidhw3G5UoCYhDQeJPf8ZaUlhtgLEdHhyqYf91lSV/z5q83yVN
        5tpeXMEyUybGKL2TVanWBIJJne4jl0Bm8HAbxC8qlMicGD10kyE2KcXNUX81y/Dkdnqdo1Kaens
        Kpu2v79gchoEQSqiksxWKFrtjLelSBRz9r+OE6WSOHQ==
X-Received: by 2002:a19:f512:: with SMTP id j18mr9044166lfb.169.1569776108469;
        Sun, 29 Sep 2019 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVzY32Bt/A8gXhlgqzeWJpqc+TMw73XWbverehqqSktg26b6k0t4TG24jtNlhtaPJc/gwb9AQK9KEvS4UtPUg=
X-Received: by 2002:a19:f512:: with SMTP id j18mr9044142lfb.169.1569776108214;
 Sun, 29 Sep 2019 09:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190928004642.28932-1-yzhai003@ucr.edu> <20190928064720.GA24515@osadl.at>
In-Reply-To: <20190928064720.GA24515@osadl.at>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 29 Sep 2019 09:54:54 -0700
Message-ID: <CABvMjLR1sP+-z6-vy3kKmyv-srVHdvT9=Z7g=RSWo3oDuGt8+A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized
 if regmap_read() fails
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas:

Thanks for your feedback, I made changes and submitted new patches
already. Check patch script generated a warning if I strictly align
the parameter with (. I checked other code inside this file and
modified the continuation accordingly.

On Fri, Sep 27, 2019 at 11:47 PM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Fri, Sep 27, 2019 at 05:46:41PM -0700, Yizhuo wrote:
> > Several functions in this file are trying to use regmap_read() to
> > initialize the specific variable, however, if regmap_read() fails,
> > the variable could be uninitialized but used directly, which is
> > potentially unsafe. The return value of regmap_read() should be
> > checked and handled.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> Just a few minor style issues - contentwise it look correct to me.
> Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>
>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 7b28d045d271..c032a64108b4 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> >  {
> >       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> >       int regval, timeout = 10000;
> > +     int ret;
> >
> >       /*
> >        * NOTE: we need a small delay before reading the status, otherwise
> > @@ -331,7 +332,9 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> >        */
> >       do {
> >               udelay(1);
> > -             regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +             ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +             if (ret)
> > +                     return ret;
> >       } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
> >
> >       if (timeout < 0)
> > @@ -358,7 +361,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>
> any reason not to declear ret in the declaration block ?
> so just for consistency with coding style within meson_saradc.c
> this might be:
>
>         int regval, fifo_chan, fifo_val, count;
> +       int ret;
>
> >               return -EINVAL;
> >       }
> >
> > -     regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
> > +     int ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>
> +       ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>
> > +
> > +     if (ret)
> > +             return ret;
> > +
> >       fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
> >       if (fifo_chan != chan->address) {
> >               dev_err(&indio_dev->dev,
> > @@ -491,6 +498,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
> >  {
> >       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> >       int val, timeout = 10000;
> > +     int ret;
> >
> >       mutex_lock(&indio_dev->mlock);
> >
> > @@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
> >                */
> >               do {
> >                       udelay(1);
> > -                     regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> > +                     ret = regmap_read(priv->regmap,
> > +                                     MESON_SAR_ADC_DELAY, &val);
>
> checkpatch does not fuss here but the continuation should be alligned
> witht the ( here
>
> > +                     if (ret)
> > +                             return ret;
> >               } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
> >
> >               if (timeout < 0) {
> > @@ -784,7 +795,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
> >                * BL30 to make sure BL30 gets the values it expects when
> >                * reading the temperature sensor.
> >                */
> > -             regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> > +             ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> > +             if (ret)
> > +                     return ret;
> > +
> >               if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
> >                       return 0;
> >       }
> > @@ -1014,7 +1028,11 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
> >       unsigned int cnt, threshold;
> >       u32 regval;
>
> same as above
>
> +       int ret;
>
> >
> > -     regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +     int ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>
> +       ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>
> > +
> > +     if (ret)
> > +             return ret;
> > +
> >       cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
> >       threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> >
> > --
> > 2.17.1
> >



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside

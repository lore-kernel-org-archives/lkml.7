Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2467C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B852166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="deslrq0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfENVXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:23:30 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36971 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfENVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:23:29 -0400
Received: by mail-vs1-f65.google.com with SMTP id o5so302714vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dw+3HW+QSxAU/VvQDboCS3fVZdfPTxjPbs+h6/3sd+A=;
        b=deslrq0xnkp+HiwTLf6+bMQ8aHWO2dn5MkZXFgTGxSoORKcjrUuEt2bZ7DGXJynfMM
         eQZ8XqI7jWBTUb4dglizDEpU3jfOFkzBTEEpewbpBS3K5z+yIUGnrmy3mT0yU5O6gkqU
         7QSXH/Ul6ZYL85iJ3tmF5EHFKP0/OgMEIx178=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dw+3HW+QSxAU/VvQDboCS3fVZdfPTxjPbs+h6/3sd+A=;
        b=LrT9h+SijQ/fWGF+ryXp7fawFQquNcwLzkAEFDYNS5A0hUEypZIL4sOaLivZ5msndv
         f3c2Z52rV70o8Iw5tvgh8ZeSAgsxqHMGp9aQCv2AN3DLYpDQb0DsMEYSaufOvE1MifpU
         2U0jO2/ob9XhECTEnQJz3Wl8dOCq5/58M/mHGVUUb2ZQsiMnhfToUprdtuueNF8H/phZ
         ANW4vf23XaTwch8K0h/2bMwj9Eo35oswym7lcCAvJD0BKe73uqv51b9w2chM4vJz7Mjp
         KNrvN/t9XmBQSX1Br8G8Xb7pXW6IT9K08nw8k2QXNhkhlbBWC+4GRWFdKoG+aHwt1mwS
         BbsQ==
X-Gm-Message-State: APjAAAU+5B9cf79+6ln75JCPwlhMhXQnTtF6/+aYWWAseiRxZofuUphs
        w+korw4m+mgP8oCGejgLreBf9AWV7v8=
X-Google-Smtp-Source: APXvYqwSXy1CtpkL4lCD8tNyoAKrENzSNI2dDsN8kCaZauXcEhIZjHfvaFlyDBhOIyQRoMF+Tp5T5g==
X-Received: by 2002:a67:b806:: with SMTP id i6mr18141139vsf.64.1557869007602;
        Tue, 14 May 2019 14:23:27 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id n23sm79964vsj.27.2019.05.14.14.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 14:23:26 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e2so269202vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:23:26 -0700 (PDT)
X-Received: by 2002:a67:f60b:: with SMTP id k11mr11031915vso.111.1557869006026;
 Tue, 14 May 2019 14:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190514183935.143463-1-dianders@chromium.org>
 <20190514183935.143463-2-dianders@chromium.org> <CABXOdTc36r7XV-3o8MJiaUTkaALtfQAQpi1gV2xvsDSX+S3s2A@mail.gmail.com>
In-Reply-To: <CABXOdTc36r7XV-3o8MJiaUTkaALtfQAQpi1gV2xvsDSX+S3s2A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 May 2019 14:23:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WrxeKGNH6jsuvdDaENQDnqjW2f2VO25-VReYKfP7L3Lw@mail.gmail.com>
Message-ID: <CAD=FV=WrxeKGNH6jsuvdDaENQDnqjW2f2VO25-VReYKfP7L3Lw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/chrome: cros_ec_spi: Move to real time
 priority for transfers
To:     Guenter Roeck <groeck@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 12:34 PM Guenter Roeck <groeck@google.com> wrote:

> On Tue, May 14, 2019 at 11:40 AM Douglas Anderson <dianders@chromium.org> wrote:
> > +static void cros_ec_spi_high_pri_release(struct device *dev, void *res)
> > +{
> > +       struct cros_ec_spi *ec_spi = *(struct cros_ec_spi **)res;
> > +
> > +       kthread_stop(ec_spi->high_pri_thread);
>
> Is that needed ? kthread_destroy_worker() does it for you.

Thanks for catching.  Removed.


> > +static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> > +                                          struct cros_ec_spi *ec_spi)
> > +{
> > +       struct sched_param sched_priority = {
> > +               .sched_priority = MAX_RT_PRIO - 1,
> > +       };
> > +       struct cros_ec_spi **ptr;
> > +       int err = 0;
> > +
> > +       ptr = devres_alloc(cros_ec_spi_high_pri_release, sizeof(*ptr),
> > +                          GFP_KERNEL);
> > +       if (!ptr)
> > +               return -ENOMEM;
> > +       *ptr = ec_spi;
> > +
> > +       kthread_init_worker(&ec_spi->high_pri_worker);
> > +       ec_spi->high_pri_thread = kthread_create(kthread_worker_fn,
> > +                                                &ec_spi->high_pri_worker,
> > +                                                "cros_ec_spi_high_pri");
> > +       if (IS_ERR(ec_spi->high_pri_thread)) {
> > +               err = PTR_ERR(ec_spi->high_pri_thread);
> > +               dev_err(dev, "Can't create cros_ec high pri thread: %d\n", err);
> > +               goto err_worker_initted;
> > +       }
> > +
> > +       err = sched_setscheduler_nocheck(ec_spi->high_pri_thread,
> > +                                        SCHED_FIFO, &sched_priority);
> > +       if (err) {
> > +               dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
> > +               goto err_thread_created;
> > +       }
> > +
> > +       wake_up_process(ec_spi->high_pri_thread);
> > +
> > +       devres_add(dev, ptr);
> > +
>
> If you move that ahead of sched_setscheduler_nocheck(), you would not
> need the err_thread_created: label.

Done


> > +       return 0;
> > +
> > +err_thread_created:
> > +       kthread_stop(ec_spi->high_pri_thread);
> > +
> > +err_worker_initted:
> > +       kthread_destroy_worker(&ec_spi->high_pri_worker);
>
> Are you sure about this ? The worker isn't started here, but
> kthread_destroy_worker() tries to stop it.

Right.  I was naively thinking that kthread_destroy_worker() was the
inverse of kthread_init_worker(), but clearly it's not.  :(

...and, in fact, looking closer at kthread_destroy_worker() it looks
like it's inherently slightly racy with regards to kthread_create().
Ick.  Specifically it will give a "WARN_ON" if worker->task hasn't
been set, but that doesn't get set until kthread_worker_fn runs the
first time.  Oh, but everyone's supposed to use
kthread_create_worker() to get around that!  :-)  Switching to that.
...and then of course everything looks so much cleaner!

...so after that I'm effectively implementing
devm_kthread_create_worker(), but I guess for now I'll just do that
unless someone thinks that I should try to get that landed...


I'll wait to send out a v4 till tomorrow morning to avoid spamming
with too many versions.  If anyone wants a preview feel free to look
at <https://crrev.com/c/1612165>

-Doug

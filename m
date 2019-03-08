Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F064FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF82720643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a22gjf6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCHWdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:33:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41963 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfCHWdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:33:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id y7so15353502lfg.8;
        Fri, 08 Mar 2019 14:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecuU19qycBJTuwW9GaXqsDT4+0geCFySyYSHZ6pEG4E=;
        b=a22gjf6ffZBE+VjrXalpQW9UwEAYEosE1HxLWINUzoi53kiMfwIJfVBeaYhPTnfjKU
         x/AOEDVevz4HdVqJpt17DmoRTpKVlbpD0maZnEXfAQ2xBuFtDuOYDt0X7Y2j/WvD+uP4
         rH6yJfLv9GVwOUCq10J7Rj67TVWHGUckaqlAv5VwrRY7CP197OgFJB+1ZcX/gi4Cw79z
         CUTQpBO36CdqUTj/o7qaWeRsbiaQl/NF815caTXLsODYWELhsZq6URGMOA/jlOl7AHW1
         7NwqMmvuYKz8O5NZK44lA/OVPmCzAKEh4YjR11RIiOc38FUH6YAPvzoV/ehHz4PRE9OR
         qAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecuU19qycBJTuwW9GaXqsDT4+0geCFySyYSHZ6pEG4E=;
        b=rPH13QBgTGZJGhC6I1dR17RgHgFSn+9Zc88V8RDZjx8eVngRmiGgStKGRhL2uH9VuK
         FadEYwrYZdTcL5a/5sP6OiPWmKq9RR4faOchYLzSr1hQT2XO7IQmqOS3QL6H2/zSWBNt
         w/Fl5Ls3G5wtdsgFvgLRuyY47+T1NWwtd+qb0LnBJLUy2o4L7c4osgVi6/yCIYzpC9eW
         va+AvL8Jsu+TdqOaKednhwJ/JQx7ZVBQAFUDJnvuNkFU/wgOpdmQonBOcZZ/CD6/wXZk
         xYxeZDOV1ThsJgCmpEFE9MwCdAQdemoHK5EUuNCcnnT++lJSR1/0qBGu4rRlQQnjki41
         bouQ==
X-Gm-Message-State: APjAAAV+xCrPC41nFKGqPnEL8Vsht+VYjzqvkLOP7xFsGK+WGsP2rASC
        I3GJdE7RPgyImaYZmgu1yTk=
X-Google-Smtp-Source: APXvYqzvR+QrqwxVR+h8NwC66nrrYsmbOfHNFsuvQh0kYi7HK4pBA79nxaljWwfmhBuOkl738GUz0w==
X-Received: by 2002:a19:2789:: with SMTP id n131mr2181652lfn.23.1552084398215;
        Fri, 08 Mar 2019 14:33:18 -0800 (PST)
Received: from localhost (89-64-60-178.dynamic.chello.pl. [89.64.60.178])
        by smtp.gmail.com with ESMTPSA id j8sm1644362ljh.58.2019.03.08.14.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 14:33:17 -0800 (PST)
Date:   Fri, 8 Mar 2019 23:32:53 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190308223249.GC32641@arch>
References: <20190308175935.21904-1-TheSven73@gmail.com>
 <20190308202936.GA32641@arch>
 <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:42:04PM -0500, Sven Van Asbroeck wrote:
> On Fri, Mar 8, 2019 at 3:30 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > > @@ -368,7 +376,6 @@ static int as3935_probe(struct spi_device *spi)
> > >
> > >       spi_set_drvdata(spi, indio_dev);
> > >       mutex_init(&st->lock);
> > > -     INIT_DELAYED_WORK(&st->work, as3935_event_work);
> >
> > Any specific reason for moving this elsewhere?
>
> Yes. On the remove path, cancel_delayed_work_sync() should execute after
> free_irq(), but before triggered_buffer_cleanup(). So the devm_add_action()
> must run right before devm_request_irq(). I figured it would make sense to
> group the devm_add_action() and INIT_WORK() together, as they are
> related. This also makes it easier to understand the probe/remove order
> when reading the code.
>

So perhaps that change deserves a separate patch because it smells like
a code cleanup.

> > >
> > >       ret = of_property_read_u32(np,
> > >                       "ams,tuning-capacitor-pf", &st->tune_cap);
> > > @@ -414,22 +421,27 @@ static int as3935_probe(struct spi_device *spi)
> > >       iio_trigger_set_drvdata(trig, indio_dev);
> > >       trig->ops = &iio_interrupt_trigger_ops;
> > >
> > > -     ret = iio_trigger_register(trig);
> > > +     ret = devm_iio_trigger_register(&spi->dev, trig);
> > >       if (ret) {
> > >               dev_err(&spi->dev, "failed to register trigger\n");
> > >               return ret;
> > >       }
> > >
> > > -     ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> > > -             &as3935_trigger_handler, NULL);
> > > +     ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > > +             iio_pollfunc_store_time, as3935_trigger_handler, NULL);
> >
> > You can fix arguments alignment while you are at it.
> >
>
> What type of alignment would you prefer? This?
>
>         ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>                                               iio_pollfunc_store_time,
>                                               as3935_trigger_handler, NULL);

Yes, this is what I've been thinking about. Thanks.

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17830C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC9F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DXRKn7fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDCRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:49:32 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41632 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:49:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id d15so4028213vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCLqupSs0GSF2d2ZT9+/jc576jztuWdhBICQz+0TmXs=;
        b=DXRKn7fKN/vLq9RxOQRAlGej0mJ5IbRb4oqfwM+WO1RCqRn7NTT32/U9VzH56ugmEi
         +B0G8+z7hVibQnNqXdmkrQu8J9hw+pNrULrXbYlMxs0kYjXAjEVAHLC7LIH+SqZxMRon
         E2NsIoGLBwsBhjlF0z0uKpOc62VeNoZIK2REQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCLqupSs0GSF2d2ZT9+/jc576jztuWdhBICQz+0TmXs=;
        b=XR3o1R+ELdFbWI2N7+8cMI4xapPWobTBAhTMeWx3LdkoayJOZy1MfZSwr1gBiB98g8
         K6aeehE2LovD2lUBqjI19QfQ3DhX/sq2kwjHhBtwKfafj0siEwtU+vuyXwqVH24MkNmS
         3c0IVNv8N31MFp38Amzf3oCrxuQpiJsDNJd3xBHSDv+NMz6DA7dDuZZuuShq30xzFYwV
         G81qCnazXCSfApx2VM3owruVQqIstaGirEzNyxbENwBYoQi2i3CoRKy1AyWzKeUglSEN
         UImH8pu3u1ZD0DP1Y+njex+YhQAKu08dC6gr5tLfO1AiFsM6b5Hd6qGEGY1SSp1GRS9t
         wV7Q==
X-Gm-Message-State: APjAAAXUl0oUwvwzbnoYcANuseAJ6RcECdR2ZVPoZpKBtKZONc31emzL
        MI0LgLXN6+Z/6rnqVPfDcVvKgz354MU=
X-Google-Smtp-Source: APXvYqyIDtcMBOLyHlwCRLXfmx6gr7X3u6h5Q2oI6D6noeVHcv4RKam+KpJUcYCPH0XiP2Ad52Nr+A==
X-Received: by 2002:a1f:32c7:: with SMTP id y190mr1099996vky.15.1554313770613;
        Wed, 03 Apr 2019 10:49:30 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id b9sm2928201vkb.23.2019.04.03.10.49.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:49:29 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id w13so9479301vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:49:29 -0700 (PDT)
X-Received: by 2002:a67:7f44:: with SMTP id a65mr1160133vsd.179.1554313768863;
 Wed, 03 Apr 2019 10:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190403160526.257088-1-dianders@chromium.org> <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
In-Reply-To: <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Apr 2019 10:49:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZCUp=Tq4DhKGJQm7bPvvM1Q=EUovWeBdoHVvQeu4eUA@mail.gmail.com>
Message-ID: <CAD=FV=UZCUp=Tq4DhKGJQm7bPvvM1Q=EUovWeBdoHVvQeu4eUA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 3, 2019 at 10:04 AM Brian Norris <briannorris@chromium.org> wrote:
>
> I know some of this was hashed out last night, but I wasn't reading my
> email then to interject ;)
>
> On Wed, Apr 3, 2019 at 9:05 AM Douglas Anderson <dianders@chromium.org> wrote:
> > +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> > +                                struct cros_ec_command *ec_msg,
> > +                                cros_ec_xfer_fn_t fn)
> > +{
> > +       struct cros_ec_xfer_work_params params;
> > +
> > +       INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
> > +       params.ec_dev = ec_dev;
> > +       params.ec_msg = ec_msg;
> > +       params.fn = fn;
> > +       init_completion(&params.completion);
> > +
> > +       /*
> > +        * This looks a bit ridiculous.  Why do the work on a
> > +        * different thread if we're just going to block waiting for
> > +        * the thread to finish?  The key here is that the thread is
> > +        * running at high priority but the calling context might not
> > +        * be.  We need to be at high priority to avoid getting
> > +        * context switched out for too long and the EC giving up on
> > +        * the transfer.
> > +        */
> > +       queue_work(system_highpri_wq, &params.work);
>
> Does anybody know what the definition of "too long" is for the phrase
> "Don't queue works which can run for too long" in the documentation?

Using the docs that Matthias pointed at:

https://www.kernel.org/doc/html/v5.0/core-api/workqueue.html

...take a look at the "Example Execution Scenarios".  They show tasks
that burn CPU cycles for 5 ms and this seems to be illustrating tasks
that workqueues are designed for.  That makes me feel like 5 ms is not
too long.

I don't think we'll be running for that long in our case.  While a few
tegra device trees have a big delay of 2000 for
"google,cros-ec-spi-msg-delay", I've always been of the opinion that
delay was added to work around other bugs and is probably not really
needed, so if somehow this regresses performance there we could try
tuning that down.  ...but even in that case we're only delaying for
2000 us = 2ms.  The "google,cros-ec-spi-pre-delay" on rk3288-veyron
chromebooks is 30 us.  There are some other delays hardcoded in the
driver but those are all expressed in terms of nanoseconds.

It looks like in the extreme case, though, we still could end up
having our work take 200 ms for completion as per the comments in
"EC_MSG_DEADLINE_MS".  IIRC this is a super uncommon case and only
happened on a few systems when the battery was in a particularly wonky
state and decided to do clock stretching.  Also: we shouldn't even be
busy-waiting during this time since most of it will be sitting
(presumably blocked) waiting for SPI bytes to come in.


So I think the summary is that I'm back to being convinced that the
"system_highpri_wq" should be OK.  Running lots of work with no
blocking in the system high priority workqueue can truly block other
work items there, but it seems like the amount of time we're running
is within the time bounds expected.  The work also isn't going to
fully block other workers--they will be able to run on other CPUs
still and (if they are already running) presumably they can still be
scheduled back in.


> > +       wait_for_completion(&params.completion);
>
> I think flush_workqueue() was discussed and rejected, but what about
> flush_work()? Then you don't have to worry about the rest of the
> contents of the workqueue -- just your own work--and I think you could
> avoid the 'completion'.
>
> You might also have a tiny race in the current implementation, since
> (a) you can't queue the same work item twice and
> (b) technically, the complete() call is still while the work item is
> running -- you don't really guarantee the work item has finished
> before you continue.
> So the combination of (a) and (b) means that moving from one xfer to
> the next, you might not successfully queue your work at all. You could
> probably test this by checking the return value of queue_work() under
> a heavy EC workload. Avoiding the completion would also avoid this
> race.

Thanks, I'll do that in v3 assuming someone doesn't convince me to
switch back to a private workqueue.

-Doug

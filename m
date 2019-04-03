Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFC0206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bkCVl9QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:21:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDCAVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:21:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so7208063pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Beg9ddRo3IZVhHPYaCoCFNyOggeWTISKeyfx6HoYpA=;
        b=bkCVl9QZ9FvaqL8ndLjYP5NiXNLVGePweXLsRL8v0po2seFZhHK06OJ9WI5I8igmt4
         1/vDoylcC9ewGtWc/dCw7gE5Zw0uHbQzJHdW61Yw6iQiY4xRk09l7vSqH3msJonZ0T7N
         mNbfkxkeTdJP/DhKO4DuAqbcUQiDJayOHdlkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Beg9ddRo3IZVhHPYaCoCFNyOggeWTISKeyfx6HoYpA=;
        b=I2H0nwJjEGTdu2/2dsexrHVD9LMptDx/mXpM4W/5CEt7XSjSuVcdaoZmUPlAe0LVNj
         bmfpJgaMxANAfU27eBOIoKO8/rREr2UlkM5ogpJOfyVyLe0cG2vD199aQXBllb+WQLHZ
         o5hsQo++E/2hY54A6705C2IsZMxsKkHtnCBJn4A/aFBxuQfOV4IgpJqVkc5Hcxuy3zPY
         3kfJZiP5KF8EX7WIWN5oQWhf3przmTA5lopykueika7255kowbBvtnX3oOgXW8ryI8wL
         adv+sful+QOaBLnku5fh+Y5Iv+lNndfxifRr2ADGR3VnvioEqj9pn+fxU26JvKsqsset
         iQbA==
X-Gm-Message-State: APjAAAW9VKL2RykOYB7aCC+diTkiQrCa6/c0VItka487ws/EzLAcIKGL
        bpIf11VEy4gtwRHkPmHTmx403A==
X-Google-Smtp-Source: APXvYqwY93byBivcqsBnkAKabJmLVQY6Yy/+Kh7oGGF3epn0W/usoZKfZecsn5OATuUNUIJvg0FrKQ==
X-Received: by 2002:a63:e051:: with SMTP id n17mr69209276pgj.19.1554250879146;
        Tue, 02 Apr 2019 17:21:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j67sm8253517pfc.72.2019.04.02.17.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 17:21:18 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:21:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Transfer messages at high
 priority
Message-ID: <20190403002117.GM112750@google.com>
References: <20190402224445.64823-1-dianders@chromium.org>
 <20190402231917.GL112750@google.com>
 <CAD=FV=V3S7=GNrA8JnUE+wHin8UwFTeL22EBMuDr4AFTu1nKsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=V3S7=GNrA8JnUE+wHin8UwFTeL22EBMuDr4AFTu1nKsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:38:29PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 2, 2019 at 4:19 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Doug,
> >
> > On Tue, Apr 02, 2019 at 03:44:44PM -0700, Douglas Anderson wrote:
> > > The software running on the Chrome OS Embedded Controller (cros_ec)
> > > handles SPI transfers in a bit of a wonky way.  Specifically if the EC
> > > sees too long of a delay in a SPI transfer it will give up and the
> > > transfer will be counted as failed.  Unfortunately the timeout is
> > > fairly short, though the actual number may be different for different
> > > EC codebases.
> > >
> > > We can end up tripping the timeout pretty easily if we happen to
> > > preempt the task running the SPI transfer and don't get back to it for
> > > a little while.
> > >
> > > Historically this hasn't been a _huge_ deal because:
> > > 1. On old devices Chrome OS used to run PREEMPT_VOLUNTARY.  That meant
> > >    we were pretty unlikely to take a big break from the transfer.
> > > 2. On recent devices we had faster / more processors.
> > > 3. Recent devices didn't use "cros-ec-spi-pre-delay".  Using that
> > >    delay makes us more likely to trip this use case.
> > > 4. For whatever reasons (I didn't dig) old kernels seem to be less
> > >    likely to trip this.
> > > 5. For the most part it's kinda OK if a few transfers to the EC fail.
> > >    Mostly we're just polling the battery or doing some other task
> > >    where we'll try again.
> > >
> > > Even with the above things, this issue has reared its ugly head
> > > periodically.  We could solve this in a nice way by adding reliable
> > > retries to the EC protocol [1] or by re-designing the code in the EC
> > > codebase to allow it to wait longer, but that code doesn't ever seem
> > > to get changed.  ...and even if it did, it wouldn't help old devices.
> > >
> > > It's now time to finally take a crack at making this a little better.
> > > This patch isn't guaranteed to make every cros_ec SPI transfer
> > > perfect, but it should improve things by a few orders of magnitude.
> > > Specifically you can try this on a rk3288-veyron Chromebook (which is
> > > slower and also _does_ need "cros-ec-spi-pre-delay"):
> > >   md5sum /dev/zero &
> > >   md5sum /dev/zero &
> > >   md5sum /dev/zero &
> > >   md5sum /dev/zero &
> > >   while true; do
> > >     cat /sys/class/power_supply/sbs-20-000b/charge_now > /dev/null;
> > >   done
> > > ...before this patch you'll see boatloads of errors.  After this patch I
> > > don't see any in the testing I did.
> > >
> > > The way this patch works is by effectively boosting the priority of
> > > the cros_ec transfers.  As far as I know there is no simple way to
> > > just boost the priority of the current process temporarily so the way
> > > we accomplish this is by creating a "WQ_HIGHPRI" workqueue and doing
> > > the transfers there.
> > >
> > > NOTE: this patch relies on the fact that the SPI framework attempts to
> > > push the messages out on the calling context (which is the one that is
> > > boosted to high priority).  As I understand from earlier (long ago)
> > > discussions with Mark Brown this should be a fine assumption.  Even if
> > > it isn't true sometimes this patch will still not make things worse.
> > >
> > > [1] https://crbug.com/678675
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/platform/chrome/cros_ec_spi.c | 107 ++++++++++++++++++++++++--
> > >  1 file changed, 101 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > > index ffc38f9d4829..101f2deb7d3c 100644
> > > --- a/drivers/platform/chrome/cros_ec_spi.c
> > > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > >
> > > ...
> > >
> > > +static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> > > +                             struct cros_ec_command *ec_msg)
> > > +{
> > > +     struct cros_ec_spi *ec_spi = ec_dev->priv;
> > > +     struct cros_ec_xfer_work_params params;
> > > +
> > > +     INIT_WORK(&params.work, cros_ec_pkt_xfer_spi_work);
> > > +     params.ec_dev = ec_dev;
> > > +     params.ec_msg = ec_msg;
> > > +
> > > +     queue_work(ec_spi->high_pri_wq, &params.work);
> > > +     flush_workqueue(ec_spi->high_pri_wq);
> >
> > IIRC dedicated workqueues should be avoided unless they are needed. In
> > this case it seems you could use system_highpri_wq + a
> > completion. This would add a few extra lines to deal with the
> > completion, in exchange the code to create the workqueue could be
> > removed.
> 
> I'm not convinced using the "system_highpri_wq" is a great idea here.
> Using flush_workqueue() on the "system_highpri_wq" seems like a recipe
> for deadlock but I need to flush to get the result back.  See the
> comments in flush_scheduled_work() for some discussion here.
> 
> I guess you're suggesting using a completion instead of the flush but
> I think the deadlock potentials are the same.  If we're currently
> running on the "system_highpri_wq" (because one of our callers
> happened to be on it) or there are some shared resources between
> another user of the "system_highpri_wq" and us then we'll just sitting
> waiting for the completion, won't we?

I'm no workqueue expert, but I think the deadlock potential isn't the same:

With flush_workqueue() the deadlock would occur when running as work
item of the the same workqueue, i.e. the work is waiting for itself.

If we are running on "system_highpri_wq", schedule a new work on this
workqueue and wait for it, the Concurrency Managed Workqueue (cmwq)
will launch a worker for our work, which can run while we are waiting
for the work and be woken up when it is done.

(https://www.kernel.org/doc/html/v5.0/core-api/workqueue.html)

Other users of "system_highpri_wq" shouldn't cause long delays, unless
they are CPU hogs, which could/should be considered a bug.

> I would bet that currently nobody actually ends up in this situation
> because there aren't lots of users of the "system_highpri_wq", but it
> still doesn't seem like a good design.  Is it really that expensive to
> have our own workqueue?

I don't think it's excessively expensive, but why use the extra
resources and lifetime management code if it doesn't provide any
significant advantages? In terms of deadlocks I even have the
impression the wq + completion is a more robust solution.

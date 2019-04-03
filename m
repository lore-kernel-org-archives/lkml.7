Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E62084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCIcCIbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDCEPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:15:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38629 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCEPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:15:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id s2so8094590vsi.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg1FPZXXVgZDjNH4sgboqtfIRS3WGdP/5zKXfzBgPEw=;
        b=BCIcCIbnf9qkcxqBLbVl10LQaI/kbA083JcUDAH7vZeDfa5szBI62+JQijYiFWO9PJ
         Mn6GnrE7HjhHlRa7N07F50eyLZQwXUMdzrcf5l5EAsaOkLTg6961JlhXl3IwNjv8q7KP
         45g2F0qhrfUWtMmmGqnaaYp7rGk9ZT7AjBRyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg1FPZXXVgZDjNH4sgboqtfIRS3WGdP/5zKXfzBgPEw=;
        b=sLEUe/9YMhD0IOIVlX35j5kfHHva5i7wUgCuFNVHqJBB/bfBD8oll5ndDXuKIwjt7y
         CPLHER+V815/Sf17JjNff4rTjQN1weKj/Kkb14ppoAYa3Ba56Gjxv76JpqZlRJ+kDTBc
         jmNWVx3QX3xgvksqyzl9rSTeH3iVaeG58rAGdGYu9DWm65nrk4chzGw8RRTYVgkT4JPJ
         jjQZ4pridCTvYbyHwtPvYtp5buUWiiVYteeXMPCG9inf55YW4DafB5zIlii5//VCIbrv
         ne97N58PtYBLbTIU7Po3LnSnXwHnwu9ypp5BtUGlWqqGT/IciGDiVOJ/32wYuv/FCmdt
         NAsA==
X-Gm-Message-State: APjAAAUB3Pi3ACqDya8QfEPuIHvg0IVWGzzZlgiLBQRtG/rD6KHhLh/3
        M+JhKGHWrAx7ZeID70fsd473Jeg/O8s=
X-Google-Smtp-Source: APXvYqxPdZhE2iZbT3g4nc8B7Ezzm/JdSNyOXsl4XLiZ5wJIXqiNQwBWxE8UOj2C/4XJuaJSqgZ1vA==
X-Received: by 2002:a67:f30d:: with SMTP id p13mr31330512vsf.73.1554264922881;
        Tue, 02 Apr 2019 21:15:22 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id s78sm1146126vke.17.2019.04.02.21.15.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 21:15:21 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id j184so9146616vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:15:21 -0700 (PDT)
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr32800655vsn.207.1554264920987;
 Tue, 02 Apr 2019 21:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190402224445.64823-1-dianders@chromium.org> <20190402231917.GL112750@google.com>
 <CAD=FV=V3S7=GNrA8JnUE+wHin8UwFTeL22EBMuDr4AFTu1nKsw@mail.gmail.com> <CABXOdTcE1d2mURSkTAUQda9vcYZhGnmT+Y_NH6xQU9begDh+Qw@mail.gmail.com>
In-Reply-To: <CABXOdTcE1d2mURSkTAUQda9vcYZhGnmT+Y_NH6xQU9begDh+Qw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Apr 2019 21:15:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEhyzZYFr3VcWa9aGYm+GpDuQfz8NuJCPkNbeSvFfCJQ@mail.gmail.com>
Message-ID: <CAD=FV=WEhyzZYFr3VcWa9aGYm+GpDuQfz8NuJCPkNbeSvFfCJQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Transfer messages at high priority
To:     Guenter Roeck <groeck@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 2, 2019 at 8:17 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Apr 2, 2019 at 4:38 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 2, 2019 at 4:19 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Tue, Apr 02, 2019 at 03:44:44PM -0700, Douglas Anderson wrote:
> > > > The software running on the Chrome OS Embedded Controller (cros_ec)
> > > > handles SPI transfers in a bit of a wonky way.  Specifically if the EC
> > > > sees too long of a delay in a SPI transfer it will give up and the
> > > > transfer will be counted as failed.  Unfortunately the timeout is
> > > > fairly short, though the actual number may be different for different
> > > > EC codebases.
> > > >
> > > > We can end up tripping the timeout pretty easily if we happen to
> > > > preempt the task running the SPI transfer and don't get back to it for
> > > > a little while.
> > > >
> > > > Historically this hasn't been a _huge_ deal because:
> > > > 1. On old devices Chrome OS used to run PREEMPT_VOLUNTARY.  That meant
> > > >    we were pretty unlikely to take a big break from the transfer.
> > > > 2. On recent devices we had faster / more processors.
> > > > 3. Recent devices didn't use "cros-ec-spi-pre-delay".  Using that
> > > >    delay makes us more likely to trip this use case.
> > > > 4. For whatever reasons (I didn't dig) old kernels seem to be less
> > > >    likely to trip this.
> > > > 5. For the most part it's kinda OK if a few transfers to the EC fail.
> > > >    Mostly we're just polling the battery or doing some other task
> > > >    where we'll try again.
> > > >
> > > > Even with the above things, this issue has reared its ugly head
> > > > periodically.  We could solve this in a nice way by adding reliable
> > > > retries to the EC protocol [1] or by re-designing the code in the EC
> > > > codebase to allow it to wait longer, but that code doesn't ever seem
> > > > to get changed.  ...and even if it did, it wouldn't help old devices.
> > > >
> > > > It's now time to finally take a crack at making this a little better.
> > > > This patch isn't guaranteed to make every cros_ec SPI transfer
> > > > perfect, but it should improve things by a few orders of magnitude.
> > > > Specifically you can try this on a rk3288-veyron Chromebook (which is
> > > > slower and also _does_ need "cros-ec-spi-pre-delay"):
> > > >   md5sum /dev/zero &
> > > >   md5sum /dev/zero &
> > > >   md5sum /dev/zero &
> > > >   md5sum /dev/zero &
> > > >   while true; do
> > > >     cat /sys/class/power_supply/sbs-20-000b/charge_now > /dev/null;
> > > >   done
> > > > ...before this patch you'll see boatloads of errors.  After this patch I
> > > > don't see any in the testing I did.
> > > >
> > > > The way this patch works is by effectively boosting the priority of
> > > > the cros_ec transfers.  As far as I know there is no simple way to
> > > > just boost the priority of the current process temporarily so the way
> > > > we accomplish this is by creating a "WQ_HIGHPRI" workqueue and doing
> > > > the transfers there.
> > > >
> > > > NOTE: this patch relies on the fact that the SPI framework attempts to
> > > > push the messages out on the calling context (which is the one that is
> > > > boosted to high priority).  As I understand from earlier (long ago)
> > > > discussions with Mark Brown this should be a fine assumption.  Even if
> > > > it isn't true sometimes this patch will still not make things worse.
> > > >
> > > > [1] https://crbug.com/678675
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/platform/chrome/cros_ec_spi.c | 107 ++++++++++++++++++++++++--
> > > >  1 file changed, 101 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > > > index ffc38f9d4829..101f2deb7d3c 100644
> > > > --- a/drivers/platform/chrome/cros_ec_spi.c
> > > > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > > >
> > > > ...
> > > >
> > > > +static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> > > > +                             struct cros_ec_command *ec_msg)
> > > > +{
> > > > +     struct cros_ec_spi *ec_spi = ec_dev->priv;
> > > > +     struct cros_ec_xfer_work_params params;
> > > > +
> > > > +     INIT_WORK(&params.work, cros_ec_pkt_xfer_spi_work);
> > > > +     params.ec_dev = ec_dev;
> > > > +     params.ec_msg = ec_msg;
> > > > +
> > > > +     queue_work(ec_spi->high_pri_wq, &params.work);
> > > > +     flush_workqueue(ec_spi->high_pri_wq);
> > >
> > > IIRC dedicated workqueues should be avoided unless they are needed. In
> > > this case it seems you could use system_highpri_wq + a
> > > completion. This would add a few extra lines to deal with the
> > > completion, in exchange the code to create the workqueue could be
> > > removed.
> >
> > I'm not convinced using the "system_highpri_wq" is a great idea here.
> > Using flush_workqueue() on the "system_highpri_wq" seems like a recipe
> > for deadlock but I need to flush to get the result back.  See the
> > comments in flush_scheduled_work() for some discussion here.
> >
>
> Given that high priority workqueues are used all over the place, and
> system_highpri_wq is only rarely used, hijacking the latter doesn't
> seem to be such a good idea to me either. I also recall that we had to
> drop using system qorkqueues at a previous company and replace them
> with local workqueues because we got into timing trouble when using
> system workqueues.

I think I need to dig into workqueues more after reading Matthias's
comments.  Presumably I'm misunderstanding something about them.  I
think I expecting that there was just one worker or one worker per CPU
and thus we'd be blocking others, but I guess I was just confused.


> Having said that, the combination of queue_work() immediately followed
> by flush_workqueue() seems odd and appears to violate the wole idea of
> work _queues_.

Yeah, this is talked about a little in the commit message where I say:
"The way this patch works is by effectively boosting the priority of
the cros_ec transfers.  As far as I know there is no simple way to
just boost the priority of the current process temporarily so the way
we accomplish this is by creating a "WQ_HIGHPRI" workqueue and doing
the transfers there."

...if there is a better way to boost the priority of the transfer then
I'm all ears, but last I checked it wasn't considered OK to just mess
with/restore the current task's priority.


> I wonder if there is a better solution available to
> solve problems like this. I also wonder if we solve a problem here, or
> if we work around its symptoms. AFAICS, the delay translates into a
> udelay(), meaning an active wait loop. Has anyone an understanding why
> this translates into a spi transfer error, and how using a workqueue
> (which I guess may offload the active wait to another CPU) solves that
> problem ?

People have done digging on this in the past and I can try to find all
the research, but basically what was found out was that the task
running the SPI transfer can get preempted out.  If the CPU is busy it
might be a while before it gets the CPU again.  ...and the longer we
spend in the transfer (AKA if we have cros-ec-spi-pre-delay) the
bigger chance of this happening.  As per stuff in the commit message,
it's known that the EC is very sensitive to delays like this and will
give up on the transfer.  Yes, the EC ought to be more lenient but it
just isn't and we definitely can't change the old ECs.

I know for sure people did logic analyzer traces to show this.  They
saw these big delays and the only explanation was this preemption.


> Also, are we sure that this isn't a problem with the SPI
> driver ?

I'm 99.9% sure that this is not a problem with the SPI driver.  The
cros_ec protocol is just weird and to do a transfer the cros_ec SPI
code has to string together several separate SPI transfers.  Each of
these separate transfers is something where the CPU needs to get
involved and take the next step.


-Doug

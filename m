Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89057C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C546205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WryULD3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:03:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36804 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:03:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8633909pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3dCQcjMWcilEsgfOjBlczLje+wPiEtLmxhCfFYGTdU=;
        b=WryULD3/K23FUMsKf5aze7F9LmGglb6PjFM8OBJ2nPs8U/yFJZY8JeORBkHw2nQ6oY
         t1xlqgOxRs3tSk1YTiW/ZtzonBnCxZDOZU3n49ynjHlR3NOB4KmeqmK6g7DayjwFWGeh
         wc70yNnu6LwDUWydsJEGtin+D2eG+AkIFEFco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3dCQcjMWcilEsgfOjBlczLje+wPiEtLmxhCfFYGTdU=;
        b=ga4lD4vS9iisnL3TRhYzGyvde/7/UvkxvETFGns56wU9BMERkTrr80Vs+H8V5pC9re
         ZiOegfb5SGMub5jvTrRDTH0BhNCGCXcQjq9yWqR4qymiQWovO1PTGRjqXnf5rQyaG5Ox
         Sm1zjkWt3gsUxLjz5ULeLLzBCf85+c5YPvZ52bNd9ykHEq0Yzb6kSsF56Pj7/3u29yPn
         4OFFpkG+wan1slSloiJ85fivMg8YzHa97pQkD9oUt8mmOEa2WM/KehmJcGZTroUc7+Qm
         QBs3EubbKuHV4JhYgRB5jsdUn8vS7JRFXS0dKAEfqBfOoc/+TzFn0L3e7XDSaA7KkaP9
         ErXg==
X-Gm-Message-State: APjAAAUNHx6tGY7X99K8SzEJILJ3a2eBjlWvCntrDrGT0UuhyU7jEA8Z
        KfxlKT9f7oEWXnWH+iRRYcR+HQ==
X-Google-Smtp-Source: APXvYqzUE5xaHBJaGLcO4VZt3ZV/F16JHy/AX5ER8ePTFxnMjLc/MOqSpkEYNrVO/ERhrzprdfmNxw==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr722174pgs.356.1554310992247;
        Wed, 03 Apr 2019 10:03:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x24sm22763720pfn.128.2019.04.03.10.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 10:03:11 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:03:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
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
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Transfer messages at high
 priority
Message-ID: <20190403170311.GP112750@google.com>
References: <20190402224445.64823-1-dianders@chromium.org>
 <20190402231917.GL112750@google.com>
 <CAD=FV=V3S7=GNrA8JnUE+wHin8UwFTeL22EBMuDr4AFTu1nKsw@mail.gmail.com>
 <CABXOdTcE1d2mURSkTAUQda9vcYZhGnmT+Y_NH6xQU9begDh+Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXOdTcE1d2mURSkTAUQda9vcYZhGnmT+Y_NH6xQU9begDh+Qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:17:03PM -0700, Guenter Roeck wrote:
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
> seem to be such a good idea to me either.

It *might* be that system_highpri_wq is used less often because it was
introduced later than high priority workqueues in general, also many
folks might still think of workqueues as 'one thread per CPU' (like
myself until I was recently pointed to cmwq) and prefer to have their
own wq for this reason.

> I also recall that we had to drop using system qorkqueues at a
> previous company and replace them with local workqueues because we
> got into timing trouble when using system workqueues.

IIUC this shouldn't be an issue with cwmq (which has worker pools),
unless a work is a CPU hog, in which case it probably shouldn't use
a system workqueue in the first place.

Not saying that the problem you mentioned didn't exist, just sharing
what is my current understanding, maybe somebody will point out that
I'm plain wrong and I/we learn something new about wqs ;-)

Matthias

Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0E7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8070B20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRKoZku4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfI3P3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:29:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41249 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfI3P3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:29:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so7360514lfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcQj6Rd9F3KLevHVxis1OmxH3WVUvsmgXjMTIJqkIFg=;
        b=YRKoZku4KnTPIutFbWgtdiIEXuEq2kFBYAHLjWVBAEIc7HkbxZtYTWPaO8ybwJfh/G
         uFAGnzV940ibk70MdpNMBMwiYmlhz6ySOXR2VA7v7BaWU1ZYGh9ZMzdHPwCBbBWX5O1f
         gWW4L64pcsKVCOfVF2OPnqp5LyGYrfKIUos4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcQj6Rd9F3KLevHVxis1OmxH3WVUvsmgXjMTIJqkIFg=;
        b=MHjtVjst2mDmYPJJUOyOiXpeAtcupy3a7il2AmtwFNR90pisPeSIpX11biHgJTZEL1
         svG0lt5B1N63+GBaSoPgbcfDDhkYOFPazGVzLsbcZ05g33ZHcaJhR5HVm2sEyfa3JFf7
         YVWtmKDWehbDpr+e0/+57z1eUIYeYUna4Jb2bOj7Bo0POSuJpM0G7TjACFenJPl3ZmGs
         ypA+Glxnld1Oz32sGpyUTMC+8QE7470F6CgrmR1SobCOC540wvst3WG7V73KASO74hWz
         8AfAlSmmLxfw7B5t0Aw9qF/lTZV23mdq0RzL4jVwpgu0TxukYDI7zJgnMPdbVsridbGG
         1ZIA==
X-Gm-Message-State: APjAAAW7NBTmsmzUKjPkJYk98yIqO3in0SpbjbMQth9EO/f1jwzz+RtL
        tLegqgfifrPOAuOMYWOkH8//7X2F7AY=
X-Google-Smtp-Source: APXvYqw5aD6YrBd/rPp87/QQdqYRnbHJDxvemF91iiOctmLfuLwBviaUsscs66jnyw6K4GNjfVeYJw==
X-Received: by 2002:a19:2c1:: with SMTP id 184mr11862060lfc.100.1569857385725;
        Mon, 30 Sep 2019 08:29:45 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o2sm3316895lfl.20.2019.09.30.08.29.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 08:29:44 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id j19so9991628lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:29:44 -0700 (PDT)
X-Received: by 2002:a2e:9f12:: with SMTP id u18mr12939698ljk.23.1569857383671;
 Mon, 30 Sep 2019 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190924215238.184750-1-evgreen@chromium.org> <20190928001626.GT237523@dtor-ws>
In-Reply-To: <20190928001626.GT237523@dtor-ws>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 30 Sep 2019 08:29:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft46VXLL5z2o5QEnTBMOrzDnK_uuFiK4NMQV21PBpLxmfQ@mail.gmail.com>
Message-ID: <CAE=gft46VXLL5z2o5QEnTBMOrzDnK_uuFiK4NMQV21PBpLxmfQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Disable IRQ across suspend
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Nick Dyer <nick@shmanahar.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Evan,
>
> On Tue, Sep 24, 2019 at 02:52:38PM -0700, Evan Green wrote:
> > Across suspend and resume, we are seeing error messages like the following:
> >
> > atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
> > atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)
> >
> > This occurs because the driver leaves its IRQ enabled. Upon resume, there
> > is an IRQ pending, but the interrupt is serviced before both the driver and
> > the underlying I2C bus have been resumed. This causes EREMOTEIO errors.
> >
> > Disable the IRQ in suspend, and re-enable it on resume. If there are cases
> > where the driver enters suspend with interrupts disabled, that's a bug we
> > should fix separately.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> > Changes in v2:
> >  - Enable and disable unconditionally (Dmitry)
> >
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 24c4b691b1c9..a58092488679 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -3155,6 +3155,7 @@ static int __maybe_unused mxt_suspend(struct device *dev)
> >               mxt_stop(data);
> >
> >       mutex_unlock(&input_dev->mutex);
> > +     disable_irq(data->irq);
> >
> >       return 0;
> >  }
> > @@ -3174,6 +3175,7 @@ static int __maybe_unused mxt_resume(struct device *dev)
> >               mxt_start(data);
> >
> >       mutex_unlock(&input_dev->mutex);
> > +     enable_irq(data->irq);
>
> At least for older devices that do soft reset on resume we need
> interrupts to already work when we call mxt_start().
>
> In general, order of resume steps should mirror suspend.

Ok, I can move the enable_irq up towards the top of resume. I was
worried that a pending IRQ might not get handled correctly if
mxt_start() hadn't been called yet. But if we need IRQs for
mxt_start() to run anyway, then I guess it should be handled.
-Evan

Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36A1206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MZwcDUi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfGaW7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:59:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36537 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfGaW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:59:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id q4so22887314oij.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvayO7XeLTy4X/5U3hiq/uu/ecirEncxcxFHnyvxXOY=;
        b=MZwcDUi4tR1G4oOJB4TqUTN5aSX1GloRDcsyDdkg9pgM6Y4OOeIdzBZz+5e9apI2TF
         SfqkvWNFv8Hp7X83FA7vjkoOPtJiWY9tLmmHUvhcyo+lyjS1ZCHoS2x74bE1dX8YEFPl
         WAHZ8LyXqJ63ftyyerKaspMAHnrCjY6J5lgp3VSKoHklPJwMsP6DlW2EKdgqv2gg1OmK
         bdapoa0TuPAT5F5ZICJwjifRuzY7TWULCwViKgLADIwKMa1pOo9W5Mm2T4Tg4ZebCfDH
         RGeJxb2rwYX219Fyq3lT1DzNEDCkEitB6etiQCdh5Pm2hZyIEE7513zhXdcjE/fH7lGD
         wnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvayO7XeLTy4X/5U3hiq/uu/ecirEncxcxFHnyvxXOY=;
        b=hGHnETiobpRsX80dyXqCf3/NGdDwn7sY+TmAtoSHNePlkrey0R8QvgDFT9XFRPdIyY
         mpkun1KslNQmx9CbHArka2lv7glbevJ+Gqm41h7cj0lGf1YnjDZMUnlUWeONPQvWjV1P
         x6EfexvzkIu19R0Am9TKyXHfLsnXuGvOWPahAbyVNDzTLQ/+1A3he5s2iNQGNzaihc/8
         8FkQ6sKcRjqAsYotNqMTvbL5nIeODE7OOXnr/JbnXVm4M7mH4TB3C2Z1Yc8ZfnQx5+gn
         8I3tFd56oKbotlBwL3jVfhDHQeO8NAha2w/VVvQAgq+5Uw8utj4kM58c2Lzogg+Qq98L
         w9VQ==
X-Gm-Message-State: APjAAAUAfX+VdjqrNgsMmMFRLxEpXWKoTg6/YA8cEfMqXd90EQmG27/g
        pjyOcOnJr2NG3NDmA712nQXsQ2EFZzyYqfdgmX8=
X-Google-Smtp-Source: APXvYqyUMhMQGrPCnz4Km3SI1BL8a++DrhrK10Cd3/evsUszLBjGzYJ96bkzEQgPGssDRVfcF2DZTFh6Eh/vfDu63eU=
X-Received: by 2002:aca:af55:: with SMTP id y82mr59277816oie.172.1564613944162;
 Wed, 31 Jul 2019 15:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher>
In-Reply-To: <6987393.M0uybTKmdI@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 15:58:53 -0700
Message-ID: <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > +/**
> > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > + */
> > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > +{
> > > > > +       struct device *dev;
> > > > > +       int id;
> > > > > +
> > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > >
> > > So can anyone remind me why the IDA thing is needed here at all?
> >
> > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > among wakeup_sources. That is what ends up in
> > /sys/class/wakeup/ws<ID>/* path.
>
> That's not my point (see below).
>
> > > > > +       if (id < 0)
> > > > > +               return id;
> > > > > +       ws->id = id;
> > > > > +
> > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > +                                       wakeup_source_groups, "ws%d",
> > > >
> > > > I thought the name was going to still be 'wakeupN'?
> > >
> > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> >
> > "ws%d" here is the name in the sysfs path rather than the name of the
> > wakeup source. Wakeup source name is not altered in this patch.
> >
>
> So why wouldn't something like this suffice:
>
> dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
>                                 wakeup_source_groups, "wakeup:%s", ws->name);
>
> ?

ws->name is inherited from the device name. IIUC device names are not
guaranteed to be unique. So if different devices with the same name
register wakeup sources, there is an error.

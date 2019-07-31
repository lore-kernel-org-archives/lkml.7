Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0DF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="v47GlmL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfGaX1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:27:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34044 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfGaX1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:27:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so52144381oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tl5pYeZ72qtvUfn4lyn1cjKCDdQYMVgYKeR/aYm1DhE=;
        b=v47GlmL8kD1utdUfl8QhSsYQ4Ycd1eqmlLIHQozoHfiH8imsFoYdxlYhZfXBlHKFOj
         uc6mUixJlfqK2Ks7KZrES+UXs3+sQ+cRBxjYePOuqQaWoYycbs3/Uee7taScQRy8QISM
         3owBKhe1Przm4WbIC7G+XSYIy/zAqp8IlFfNkg17DwlXCEoPRmT/hvTqqsFF2nA57OYy
         XH++6DrmmoxUbh+d6ESIDCalkrsni5GDPUaMhoLe+JHbWReauiXTwZUKmosfI3M//lT5
         o9UOiMzDqvjjctii9bqV4cS9Ej+khBG6LKgnKtr6NkUqgvP3cFHkcQW/BHJTthIuY1px
         kgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl5pYeZ72qtvUfn4lyn1cjKCDdQYMVgYKeR/aYm1DhE=;
        b=EVG048jwrSCfxdjBlL0b9NjelnuxZBgrcUna6ZuomtTKCrG4JnG1IRoPrAJLAeH3uS
         VDFuqVDBlWsSrqinM6Q46Rkqyd3dfTWrEwpKzmdE13xRgrmvqjDXt8Nobqqy+zNczBcY
         Eug9+40KFq5JBcGQrJYBfY2LIRwQu2visaCOicFHFfxIMISDRJkO/a9y0sXoIg15F9k+
         ZtaOBTuYOLosqmoDhMBRZIneiFY44PbaIeRoMq7QqinpIUr0Y7tFXC7Y25+lB9IINSW0
         0soh08/xIdFDsmIovU3/iSCZEBPLC6FPeEnW1iq5lnF5WiTBOdhP8OgaHlpBLcy3plvG
         0JvQ==
X-Gm-Message-State: APjAAAUS8YOrsX1mHnHFDq8HeWHFUhzzsaznYoPfOJRhmt2C7nm2JhaK
        Pw2hi+dywUmI81h3Dllq9PptUYEDrUwCoeoXMhU=
X-Google-Smtp-Source: APXvYqyppFnT/zO2PIEGT6+0P4UqCcqPeWL48szxnJE54BD9KxbK4wyAaRAVfkEEU0cRzX4ZhboJkbq9bcf/MYP1XpA=
X-Received: by 2002:aca:3509:: with SMTP id c9mr64322694oia.179.1564615654731;
 Wed, 31 Jul 2019 16:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 16:27:23 -0700
Message-ID: <CANA+-vDikTE21qOYcvtduqaqPkEaK+8d46A1ReV5VDEZ_O49ww@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Wed, Jul 31, 2019 at 4:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > > > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > > > +/**
> > > > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > > > + */
> > > > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > > > +{
> > > > > > > +       struct device *dev;
> > > > > > > +       int id;
> > > > > > > +
> > > > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > > > >
> > > > > So can anyone remind me why the IDA thing is needed here at all?
> > > >
> > > > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > > > among wakeup_sources. That is what ends up in
> > > > /sys/class/wakeup/ws<ID>/* path.
> > >
> > > That's not my point (see below).
> > >
> > > > > > > +       if (id < 0)
> > > > > > > +               return id;
> > > > > > > +       ws->id = id;
> > > > > > > +
> > > > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > > +                                       wakeup_source_groups, "ws%d",
> > > > > >
> > > > > > I thought the name was going to still be 'wakeupN'?
> > > > >
> > > > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> > > >
> > > > "ws%d" here is the name in the sysfs path rather than the name of the
> > > > wakeup source. Wakeup source name is not altered in this patch.
> > > >
> > >
> > > So why wouldn't something like this suffice:
> > >
> > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > >
> > > ?
> >
> > ws->name is inherited from the device name. IIUC device names are not
> > guaranteed to be unique. So if different devices with the same name
> > register wakeup sources, there is an error.
>
> OK
>
> So I guess the names are retained for backwards compatibility with
> existing user space that may be using them?

Yes, in Android we do rely on the name to aggregate statistics across
a fleet of devices. That wouldn't be possible with just the id, as
those are generated at dynamically runtime.
>
> That's kind of fair enough, but having two different identification
> schemes for wakeup sources will end up confusing.

It's not without precedent though. rtc, input, and other devices have
a similar scheme.

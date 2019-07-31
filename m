Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D2CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927D020679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfGaWm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:42:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47294 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfGaWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:42:28 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 08c6e24a98894a9b; Thu, 1 Aug 2019 00:42:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tri Vo <trong@android.com>
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
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
Date:   Thu, 01 Aug 2019 00:42:25 +0200
Message-ID: <6987393.M0uybTKmdI@kreacher>
In-Reply-To: <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > +/**
> > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > + * @ws: Wakeup source to be added in sysfs.
> > > > + */
> > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > +{
> > > > +       struct device *dev;
> > > > +       int id;
> > > > +
> > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> >
> > So can anyone remind me why the IDA thing is needed here at all?
> 
> IDA is used to generate the directory name ("ws%d", ID) that is unique
> among wakeup_sources. That is what ends up in
> /sys/class/wakeup/ws<ID>/* path.

That's not my point (see below).

> > > > +       if (id < 0)
> > > > +               return id;
> > > > +       ws->id = id;
> > > > +
> > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > +                                       wakeup_source_groups, "ws%d",
> > >
> > > I thought the name was going to still be 'wakeupN'?
> >
> > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> 
> "ws%d" here is the name in the sysfs path rather than the name of the
> wakeup source. Wakeup source name is not altered in this patch.
> 

So why wouldn't something like this suffice:

dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
                                wakeup_source_groups, "wakeup:%s", ws->name);

?




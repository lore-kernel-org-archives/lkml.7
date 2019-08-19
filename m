Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DA0C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4AB2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfHSJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:36:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:36:23 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id deaf8b5fbe7e8fca; Mon, 19 Aug 2019 11:36:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Tri Vo <trong@android.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] PM / wakeup: Register wakeup class kobj after device is added
Date:   Mon, 19 Aug 2019 11:36:20 +0200
Message-ID: <5294923.DGcXRFdkBH@kreacher>
In-Reply-To: <5d57242c.1c69fb81.bba86.14f6@mx.google.com>
References: <20190816145602.231163-1-swboyd@chromium.org> <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com> <5d57242c.1c69fb81.bba86.14f6@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 16, 2019 11:46:19 PM CEST Stephen Boyd wrote:
> Quoting Tri Vo (2019-08-16 14:27:35)
> > On Fri, Aug 16, 2019 at 7:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > index 1b9c281cbe41..27ee00f50bd7 100644
> > > --- a/drivers/base/power/sysfs.c
> > > +++ b/drivers/base/power/sysfs.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/pm_qos.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/pm_wakeup.h>
> > >  #include <linux/atomic.h>
> > >  #include <linux/jiffies.h>
> > >  #include "power.h"
> > > @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
> > >                 if (rc)
> > >                         goto err_runtime;
> > >         }
> > > +       if (dev->power.wakeup) {
> > 
> > This conditional checks for the situation when wakeup source
> > registration have been previously attempted, but failed at
> > wakeup_source_sysfs_add(). My concern is that it's not easy to
> > understand what this check does without knowing exactly what
> > device_wakeup_enable() does to dev->power.wakeup before we reach this
> > point.
> 
> Oh, actually this is wrong. It should be a check for
> dev->power.wakeup->dev being non-NULL. That's the variable that's set by
> wakeup_source_sysfs_add() upon success. So I should make it:
> 
> 	if (dev->power.wakeup && !dev->power.wakeup->dev)
> 
> And there's the problem that CONFIG_PM_SLEEP could be unset. Let me fix
> it up with a new inline function like device_has_wakeup_dev().

OK, fix that and resend the patch.  I'll restore the series then.




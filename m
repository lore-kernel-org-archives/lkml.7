Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA991206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDWGPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:15:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:19207 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWGPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:15:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 23:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="318152017"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2019 23:15:32 -0700
Message-ID: <1556000129.26198.50.camel@intel.com>
Subject: Re: [PATCH] thermal: core: skip update disabled thermal zones after
 suspend
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Apr 2019 14:15:29 +0800
In-Reply-To: <CAGXk5yoXgzYyK9eJMHietgqPqyT_QHXAby6+G_fSwXL-tKfd=Q@mail.gmail.com>
References: <20190416170701.50333-1-wvw@google.com>
         <1555923800.26198.30.camel@intel.com>
         <CAGXk5yoXgzYyK9eJMHietgqPqyT_QHXAby6+G_fSwXL-tKfd=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-04-22 at 09:44 -0700, Wei Wang wrote:
> On Mon, Apr 22, 2019 at 2:03 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > On 二, 2019-04-16 at 10:07 -0700, Wei Wang wrote:
> > > 
> > > It is unnecessary to update disabled thermal zones post suspend
> > > and
> > > sometimes leads error/warning in bad behaved thermal drivers.
> > > 
> > a good catch, and in fact, there are more issues about thermal
> > handling
> > for disabled thermal zones, like we're able to read the temperature
> > of
> > disabled thermal zones, either via sysfs or via function calls like
> > thermal_zone_device_update.
> Thanks Rui for following up. Yes, we noticed the same behavior. Right
> now, individual thermal driver can still respect set_mode and present
> value meaningful or return error when thermal zone disabled, and
> that's what we do locally.
> Currently, sysfs-api documents "Preventing kernel thermal zone driver
> actions upon trip points so that user application can take full
> charge
> of the thermal management.", so is it intended for some other agents
> in kernel or user land polling temperature with function call or
> sysfs
> respectively?

hmmm, here we have three cases,
1). we can read the temperature and we can take cooling actions.
2). we can read the temperature only
3). we can not read the temperature

we do have a case for 3), e.g. the wifi device, which registers a
thermal zone, but it does not work if wifi firmware is unloaded. And
IMO, we should set the thermal zone mode to disable for this case.

I'm not sure if there is any case for 2), but if we do, it seems to me
that we should set its governor to nop, rather then the way we're
describing in the sys-abi file.

we should fix the code and doc to use "mode" attribute to handle case
3) instead.

thanks,
rui
> 
> Thanks!
> -Wei
> > 
> > For this patch, I will take it as it fixes one of the problem.
> > 
> > thanks,
> > rui
> > 
> > > 
> > > Signed-off-by: Wei Wang <wvw@google.com>
> > > ---
> > >  drivers/thermal/thermal_core.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c
> > > index 6590bb5cb688..5baf5cfab999 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct
> > > notifier_block *nb,
> > >                            unsigned long mode, void *_unused)
> > >  {
> > >       struct thermal_zone_device *tz;
> > > +     enum thermal_device_mode tz_mode;
> > > 
> > >       switch (mode) {
> > >       case PM_HIBERNATION_PREPARE:
> > > @@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct
> > > notifier_block *nb,
> > >       case PM_POST_SUSPEND:
> > >               atomic_set(&in_suspend, 0);
> > >               list_for_each_entry(tz, &thermal_tz_list, node) {
> > > +                     tz_mode = THERMAL_DEVICE_ENABLED;
> > > +                     if (tz->ops->get_mode)
> > > +                             tz->ops->get_mode(tz, &tz_mode);
> > > +
> > > +                     if (tz_mode == THERMAL_DEVICE_DISABLED)
> > > +                             continue;
> > > +
> > >                       thermal_zone_device_init(tz);
> > >                       thermal_zone_device_update(tz,
> > >                                                  THERMAL_EVENT_UN
> > > S
> > > PECIFIED);

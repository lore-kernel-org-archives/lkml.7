Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711EC4CED0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AFA20882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfISONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:13:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:36657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732259AbfISONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:13:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 07:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,523,1559545200"; 
   d="scan'208";a="199405265"
Received: from honglili-mobl3.ccr.corp.intel.com ([10.255.29.241])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2019 07:13:35 -0700
Message-ID: <e229e18cd02cbfb0b3d0623cf477b8c968ae621b.camel@intel.com>
Subject: Re: [PATCH 1/5] thermal: Initialize thermal subsystem earlier
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Thu, 19 Sep 2019 22:13:34 +0800
In-Reply-To: <CAP245DVOX_x0e-CAzzG2cdpBeMdk=J7Tbgx4hpLXEavQwjRRAg@mail.gmail.com>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
         <97b6f861e6e6a2ac7b50efb7211f3c8e7fe872b0.1568240476.git.amit.kucheria@linaro.org>
         <6920d231-73cf-d83d-2cc7-f29e5f73192c@linaro.org>
         <CAP245DVOX_x0e-CAzzG2cdpBeMdk=J7Tbgx4hpLXEavQwjRRAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 14:48 +0530, Amit Kucheria wrote:
> On Tue, Sep 17, 2019 at 1:30 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > 
> > On 12/09/2019 00:32, Amit Kucheria wrote:
> > > From: Lina Iyer <ilina@codeaurora.org>
> > > 
> > > Now that the thermal framework is built-in, in order to
> > > facilitate
> > > thermal mitigation as early as possible in the boot cycle, move
> > > the
> > > thermal framework initialization to core_initcall.
> > > 
> > > However, netlink initialization happens only as part of
> > > subsys_initcall.
> > > At this time in the boot process, the userspace is not available
> > > yet. So
> > > initialize the netlink events later in fs_initcall.
> > 
> > Why not kill directly the netlink part, no one is using it in the
> > kernel?
> 
> That's a good point. I wasn't sure if anybody was using it, but I can
> remove it completely since no driver seems to be using the
> thermal_generate_netlink_event() api.

Interesting, I recalled that thermal_generate_netlink_event() is indeed
used by some thermal driver, but it's true that no one is using it now.

let's remove it and see if we get any complains.

thanks,
rui
> 
> Regards,
> Amit
> 
> $ git grep thermal_generate_netlink_event
> Documentation/thermal/sysfs-api.rst:just need to call
> thermal_generate_netlink_event() with two arguments viz
> drivers/thermal/thermal_core.c:int
> thermal_generate_netlink_event(struct thermal_zone_device *tz,
> drivers/thermal/thermal_core.c:EXPORT_SYMBOL_GPL(thermal_generate_net
> link_event);
> include/linux/thermal.h:extern int
> thermal_generate_netlink_event(struct thermal_zone_device *tz,
> include/linux/thermal.h:static inline int
> thermal_generate_netlink_event(struct thermal_zone_device *tz,


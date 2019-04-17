Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5034C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfDQHwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:52:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:65161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQHwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:52:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 00:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="135043743"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2019 00:52:45 -0700
Date:   Wed, 17 Apr 2019 15:36:54 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 15/17] fpga: dfl: fme: add power management support
Message-ID: <20190417073654.GB23258@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-16-git-send-email-hao.wu@intel.com>
 <CANk1AXTji9qm0Nfbme+2=nR-PNavnv__GwzDRazhH78hYkWN6g@mail.gmail.com>
 <20190412025019.GA27997@hao-dev>
 <CANk1AXRv+2cv1sJTyHD3ajgHVvda7y7t6DVvw47vAnTp4KF0yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRv+2cv1sJTyHD3ajgHVvda7y7t6DVvw47vAnTp4KF0yw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:17:48PM -0500, Alan Tull wrote:
> On Thu, Apr 11, 2019 at 10:06 PM Wu Hao <hao.wu@intel.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 03:07:35PM -0500, Alan Tull wrote:
> > > On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:
> > >
> > > Hi Hao,
> > >
> > > >
> > > > This patch adds support for power management private feature under
> > > > FPGA Management Engine (FME), sysfs interfaces are introduced for
> > > > different power management functions, users could use these sysfs
> > > > interface to get current number of consumed power, throttling
> > >
> > > How about
> > > s/number/measurement/
> > > ?
> >
> > Sounds better. : )
> >
> > >
> > > > thresholds, threshold status and other information, and configure
> > > > different value for throttling thresholds too.
> > > >
> > > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-platform-dfl-fme |  56 +++++
> > > >  drivers/fpga/dfl-fme-main.c                      | 257 +++++++++++++++++++++++
> > > >  2 files changed, 313 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > > index d3aeb88..4b6448f 100644
> > > > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > > @@ -100,3 +100,59 @@ Description:       Read-only. Read this file to get the policy of temperature
> > > >                 threshold1. It only supports two value (policy):
> > > >                     0 - AP2 state (90% throttling)
> > > >                     1 - AP1 state (50% throttling)
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/consumed
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-only. It returns current power consumed by FPGA.
> > >
> > > What are the units?
> > >
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold1
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-Write. Read/Write this file to get/set current power
> > > > +               threshold1 in Watts.
> > >
> > > Perhaps document error codes here and for threshold2 below.
> > >
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold2
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-Write. Read/Write this file to get/set current power
> > > > +               threshold2 in Watts.
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold1_status
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-only. It returns 1 if power consumption reaches the
> > > > +               threshold1, otherwise 0.
> > >
> > > I'm used to things like this requiring user to reset the status, so it
> > > may be worth making it explicit that it will return to zero if
> > > consumption drops below threshold if that's what's happening here.
> > > If it's correct, perhaps could just say something like 'returns 1 if
> > > power consumption is currently at or above threshold1, otherwise 0'
> > >
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold2_status
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-only. It returns 1 if power consumption reaches the
> > > > +               threshold2, otherwise 0.
> > >
> > > Same here.
> >
> > Sure, will fix all above comments in this sysfs doc.
> >
> > >
> > > > +
> > > > +What:          /sys/bus/platform/devices/dfl-fme.0/power_mgmt/ltr
> > > > +Date:          March 2019
> > > > +KernelVersion:  5.2
> > > > +Contact:       Wu Hao <hao.wu@intel.com>
> > > > +Description:   Read-only. Read this file to get current Latency Tolerance
> > > > +               Reporting (ltr) value, it's only valid for integrated
> > > > +               solution as it blocks CPU on low power state.
> > >
> > > If we're not on the integrated solution, it returns a value but it is
> > > not really real?
> >
> > Currently only integrated solution is implementing this private feature, other
> > devices e.g. Intel PAC card is not using this private feature, so user will
> > not see these sysfs interfaces at all.
> 
> OK then perhaps the "it's only valid for integrated solution as it
> blocks CPU on low power state" explanation doesn't need to be here and
> can lead to confusion.
> 

Sure, will fix it in the next version. Thanks!

Hao


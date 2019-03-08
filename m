Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B92081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCHAEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:04:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:52050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfCHAEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:04:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 16:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,453,1544515200"; 
   d="scan'208";a="153058463"
Received: from spandruv-mobl3.jf.intel.com ([10.252.200.83])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 16:04:29 -0800
Message-ID: <3914af3f82d8aad8c22d814a20af4be654f8ad43.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>
Date:   Thu, 07 Mar 2019 16:04:28 -0800
In-Reply-To: <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
         <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
         <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
         <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
         <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
         <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
         <54d2b8e6-332b-117a-b982-77a535152246@redhat.com>
         <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 15:07 -0800, Rajat Jain wrote:
> Hello,
> 
> On Thu, Mar 7, 2019 at 12:37 PM Hans de Goede <hdegoede@redhat.com>
> wrote:
> > 
> > Hi,
> > 
> > On 07-03-19 21:27, Gwendal Grignou wrote:
> > > Srinivas,
> > > 
> > > I am looking at problem on a laptop machine that suspends to
> > > S01x, but
> > > link_management is set to max_performance, because the machine is
> > > connected to a charger.
> > 
> > What is setting it to max_performance when charging?  I assume
> > chrome-os is
> > running something in userspace to do this (like TLP, but I guess
> > you are not
> > using TLP) ?
> 
> Yes, we have a udev script that does this.
> 
> > 
> > Have you run benchmarks with max_performance vs the default?
> > I seriously doubt there will be a significant difference, esp.
> > with a chrome-os style workload.
> > 
> > > Given DVLSP must be set before the laptop suspends ["""One of the
> > > requirement for modern x86 system to enter lowest power
> > > mode  (SLP_S0)
> > > is SATA IP block to be off."""], the machine never reaches S01x.
> > > Does it make sense to change the target_lpm_policy at suspend
> > > (ata_port_suspend()) to min_power and bring it back to the
> > > original
> > > value on resume?
> > 
> > If userspace messes with the setting, then userspace should also
> > put it back before suspending...
> > 
> > The upstream kernel's default behavior is to have the target level
> > set
> > to a fixed level independent of the charging state. Could it be
> > this
> > fixed level is actually max-performance ? If that is the default
> > the
> > kernel comes up with, that would indicate a kernel bug.
> 
> Side note: max-performance indeed can be the default forced by the
> kernel for some (broken) SATA devices:
> 
>         if (dev->horkage & ATA_HORKAGE_NOLPM) {
>                 ata_dev_warn(dev, "LPM support broken, forcing
> max_power\n");
>                 dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>         }
> 
> So definitely these systems won't be able to go into S0ix today.
> 
> But I think the main idea that we are asking is:
> 
> 1) Yes, we acknowledge that the userspace has set it max-performance.
> 
> 2) However, given that the kernel already knows that:
>        - while in suspend, there is no real value in retaining the
> max-performance.
>        - On the contrary, we know system will fail to go into lower
> power mode because of max-suspend.
> 
> 3) Does it not make sense to use this knowledge and switch to
> min_power when we are actually going to suspend (even if user
> specified max-performance), and restore max-performance on resume?

It is all about regressions. Hence we added multiple conditions for
setting default to min power.
It may cause issues for some SATAs, which may not recover once enters
slumber or DEVSLP. There is also case where user having issues with
default LPM policy hence he changed policy to max performance. We can't
detect that.
So it will be much safer if user space change policy to default before
calling suspend.

Thanks,
Srinivas

> 
> Or may be there are issues that this causes, that we're not aware of?
> Can you please provide us some pointers?
> 
> Thanks,
> 
> Rajat
> 
> > 
> > Regards,
> > 
> > Hans
> > 
> > 
> > 
> > > 
> > > Gwendal.
> > > 
> > > 
> > > On Mon, Jul 30, 2018 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
> > > > 
> > > > On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 30-07-18 17:22, Tejun Heo wrote:
> > > > > > On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas
> > > > > > Pandruvada wrote:
> > > > > > > Hi Tejan,
> > > > > > > 
> > > > > > > On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada
> > > > > > > wrote:
> > > > > > > > Some minor fixes to be able to correctly set devslp
> > > > > > > > register
> > > > > > > > to optimize power.
> > > > > > > > 
> > > > > > > > Srinivas Pandruvada (2):
> > > > > > > >    ata: libahci: Correct setting of DEVSLP register
> > > > > > > >    ata: libahci: Allow reconfigure of DEVSLP register
> > > > > > > > 
> > > > > > > 
> > > > > > > Are you applying this series?
> > > > > > 
> > > > > > I was waiting for Hans's reviews.  Hans, what do you think?
> > > > > 
> > > > > Ah I missed that this was another series. With the caveat
> > > > > that
> > > > > I do not really know that much about devslp, both patches
> > > > > seem sensible to me, so both are:
> > > > > 
> > > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > 
> > > > Applied 1-2 to libata/for-4.19.
> > > > 
> > > > Thanks.
> > > > 
> > > > --
> > > > tejun
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-ide" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  
> > > > http://vger.kernel.org/majordomo-info.html


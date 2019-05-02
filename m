Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AA0206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:05:12 -0400
Received: from foss.arm.com ([217.140.101.70]:42414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfEBJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:05:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E5E374;
        Thu,  2 May 2019 02:05:12 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5893F5AF;
        Thu,  2 May 2019 02:05:10 -0700 (PDT)
Date:   Thu, 2 May 2019 10:05:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: PSCI version 1.1 and SYSTEM_RESET2
Message-ID: <20190502090507.GC12498@e107155-lin>
References: <24970f7101952f347bd4046c9a980473@codeaurora.org>
 <efee74624f986a358b8986ae3085fba2@codeaurora.org>
 <20190501094953.GA21851@e107155-lin>
 <3ceb06c36ecb745e2befaeaefe49be19@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ceb06c36ecb745e2befaeaefe49be19@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 11:43:00AM -0700, Sodagudi Prasad wrote:
> On 2019-05-01 02:49, Sudeep Holla wrote:
> > On Tue, Apr 30, 2019 at 05:07:31PM -0700, Sodagudi Prasad wrote:
> > > On 2019-04-30 14:44, Sodagudi Prasad wrote:

[...]

> > >
> > > It would nice if there is a config option to reboot the device
> > > either in
> > > warm or cold in the case of kernel panic.
> >
> > I presume you prefer to do warm boot in case of panic to get a dump of
> > the memory to inspect ? If so, is kexec/kdump not the mechanism to
> > achieve that ?
>
> Hi Sudeep,
>
> Thanks for your response and sharing details about your patch.
>
> > If so, is kexec/kdump not the mechanism to achieve that?
> >
> Qualcomm is having vendor specific solution to capture ram contents and for
> offline analysis.
>

Ah OK.

> >
> > I am just trying to understand the use case. Xilinx asked for the same
> > but never got to understand their use case.
>
> Here is the background -
> Usually, power off drivers are overriding arm_pm_restart and pm_power_off
> callbacks and registering with reboot notifier with  some priority for the
> reboot operations.  Here is the Qualcomm poweroff driver for reference.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/reset/msm-poweroff.c
>
> Before vendor chip set specific power off driver is probed, arm_pm_restart
> functions pointer holds the psci_sys_reset function. Once vendor power off
> driver is probed,  vendor drivers can override the arm_pm_restart function
> pointer.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci.c#n562
>
> Once vendor driver is probed, drivers can take care of devices warm or hard
> reset configuration part properly.  But there is a window from
> start_kernel() to vendor specific driver probed, devices are getting cold
> resets even if kernel crashed.  This is due to arm_pm_restart points to
> psci_sys_reset function by default.  Is this problem clear now?
>

Too specific use case IMO and I am not sure if we need a generic solution
to deal with this. Anyways, I don't see any check in arch/psci specific
code for what you want, just ensure reboot_mode is set appropriately.
Post a patch and see what people have to say.

> Qualcomm downstream kernel has a lot of use cases with respect device reset
> sequence and the downstream driver is much different from upstream drivers.
> I think, the above-mentioned problem is common for all the chipset vendors
> and it is not specific Qualcomm use cases.  I have one downstream solution
> to this problem but thought to bring up this problem to the upstream
> community for a common solution, so that all the vendors can use it.
>

May be or may be not, post the patch and let's see.

> I have modified below flow to avoid cold restart in the case of early kernel
> panic.
> panic() --> emergency_restart() --> machine_emergency_restart() -->
> machine_restart(NULL);
>
> -Thanks, Prasad
>
> >
> > --
> > Regards,
> > Sudeep
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> Linux Foundation Collaborative Project

Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE24C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1265C205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D6AcNdPb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NX8//c4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIBim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:38:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEIBil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:38:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 868ED60A05; Thu,  9 May 2019 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557365920;
        bh=4Ht87dHBqAzcwQ0kRXGlxzlr4w5kuIJqcWk5Du00ZJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6AcNdPbUOkqgiT9cjhJb2kQCS3mko0gIkXla4MQ7lubKIW0trHoM3efJ8gl2O7Xn
         jhMsRXvITvfdjiAZLGoeCR/Ld6z7nUVsM+VYsRneCoJd/WhcviwtBdBWnoE0J6ZqD8
         CRvxJPYumVEq1bgxcoHf6bXrOGpNLNsQIMZxqJEM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C09AB6016D;
        Thu,  9 May 2019 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557365919;
        bh=4Ht87dHBqAzcwQ0kRXGlxzlr4w5kuIJqcWk5Du00ZJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NX8//c4nlLdgspVnETddzTr74XRcwdiyl+1hK275wEEhZaxhsEvvfXOAaBsOdn2HW
         7K/dQC755WzACbOmYOk1etkJIfhVzuFUp16BTLVMv1qAyaFX/POOhhzvUP9gVGeH2R
         Q0AdWDEgtaF2uaKl8YfQ+6h52ZKw6shRznisoIVo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 May 2019 18:38:39 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: PSCI version 1.1 and SYSTEM_RESET2
In-Reply-To: <20190502090507.GC12498@e107155-lin>
References: <24970f7101952f347bd4046c9a980473@codeaurora.org>
 <efee74624f986a358b8986ae3085fba2@codeaurora.org>
 <20190501094953.GA21851@e107155-lin>
 <3ceb06c36ecb745e2befaeaefe49be19@codeaurora.org>
 <20190502090507.GC12498@e107155-lin>
Message-ID: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-02 02:05, Sudeep Holla wrote:
> On Wed, May 01, 2019 at 11:43:00AM -0700, Sodagudi Prasad wrote:
>> On 2019-05-01 02:49, Sudeep Holla wrote:
>> > On Tue, Apr 30, 2019 at 05:07:31PM -0700, Sodagudi Prasad wrote:
>> > > On 2019-04-30 14:44, Sodagudi Prasad wrote:
> 
> [...]
> 
>> > >
>> > > It would nice if there is a config option to reboot the device
>> > > either in
>> > > warm or cold in the case of kernel panic.
>> >
>> > I presume you prefer to do warm boot in case of panic to get a dump of
>> > the memory to inspect ? If so, is kexec/kdump not the mechanism to
>> > achieve that ?
>> 
>> Hi Sudeep,
>> 
>> Thanks for your response and sharing details about your patch.
>> 
>> > If so, is kexec/kdump not the mechanism to achieve that?
>> >
>> Qualcomm is having vendor specific solution to capture ram contents 
>> and for
>> offline analysis.
>> 
> 
> Ah OK.
> 
>> >
>> > I am just trying to understand the use case. Xilinx asked for the same
>> > but never got to understand their use case.
>> 
>> Here is the background -
>> Usually, power off drivers are overriding arm_pm_restart and 
>> pm_power_off
>> callbacks and registering with reboot notifier with  some priority for 
>> the
>> reboot operations.  Here is the Qualcomm poweroff driver for 
>> reference.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/reset/msm-poweroff.c
>> 
>> Before vendor chip set specific power off driver is probed, 
>> arm_pm_restart
>> functions pointer holds the psci_sys_reset function. Once vendor power 
>> off
>> driver is probed,  vendor drivers can override the arm_pm_restart 
>> function
>> pointer.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci.c#n562
>> 
>> Once vendor driver is probed, drivers can take care of devices warm or 
>> hard
>> reset configuration part properly.  But there is a window from
>> start_kernel() to vendor specific driver probed, devices are getting 
>> cold
>> resets even if kernel crashed.  This is due to arm_pm_restart points 
>> to
>> psci_sys_reset function by default.  Is this problem clear now?
>> 
> 
> Too specific use case IMO and I am not sure if we need a generic 
> solution
> to deal with this. Anyways, I don't see any check in arch/psci specific
> code for what you want, just ensure reboot_mode is set appropriately.
> Post a patch and see what people have to say.

Hi Sudeep,

Yes. With your system_reset2 command support addition, just configuring 
the reboot_mode is good enough.

-Thanks, Prasad

> 
>> Qualcomm downstream kernel has a lot of use cases with respect device 
>> reset
>> sequence and the downstream driver is much different from upstream 
>> drivers.
>> I think, the above-mentioned problem is common for all the chipset 
>> vendors
>> and it is not specific Qualcomm use cases.  I have one downstream 
>> solution
>> to this problem but thought to bring up this problem to the upstream
>> community for a common solution, so that all the vendors can use it.
>> 
> 
> May be or may be not, post the patch and let's see.
> 
>> I have modified below flow to avoid cold restart in the case of early 
>> kernel
>> panic.
>> panic() --> emergency_restart() --> machine_emergency_restart() -->
>> machine_restart(NULL);
>> 
>> -Thanks, Prasad
>> 
>> >
>> > --
>> > Regards,
>> > Sudeep
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project

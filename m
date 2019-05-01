Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1CAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A97420652
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K9L7ldtQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oVjexLeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEASnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:43:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEASnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:43:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 178876083E; Wed,  1 May 2019 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556736181;
        bh=yzlxHbc9Bvt+Q3uG2Hf7NalbgMIKbFyBV0j0pUBHNKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K9L7ldtQDqt9HBJ9Kty/bKeG3WATmcTbijYEhFr765L8ymZmzUCLHiuRHQ7cXR7zw
         ahBc6sZFqzkYjAaXNVFKBdapNfSC3fS6OsUErY2VLl7Q6ZwjGGbf8jn83DKeXhjqP3
         jUp405/EQg9K+jR+zP3XS7zAdFmMuWR/NAfrOL6g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44CA56013C;
        Wed,  1 May 2019 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556736180;
        bh=yzlxHbc9Bvt+Q3uG2Hf7NalbgMIKbFyBV0j0pUBHNKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVjexLeT41ojgDbZQP8x+mW2fEauvKXJBmzcIAHBKRjREx9UQQgjJ3KJ313cyshJq
         7pkOD+k0F2KIgqIqCz487i2CJQPlnFz0nV6vYMP14X2oSuCd5WEM8/MF//AYu+ORYY
         1/t8sG5gisvBe5dv2pqUz+HScCIlMwj2V+jcx0/M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 May 2019 11:43:00 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: PSCI version 1.1 and SYSTEM_RESET2
In-Reply-To: <20190501094953.GA21851@e107155-lin>
References: <24970f7101952f347bd4046c9a980473@codeaurora.org>
 <efee74624f986a358b8986ae3085fba2@codeaurora.org>
 <20190501094953.GA21851@e107155-lin>
Message-ID: <3ceb06c36ecb745e2befaeaefe49be19@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-01 02:49, Sudeep Holla wrote:
> On Tue, Apr 30, 2019 at 05:07:31PM -0700, Sodagudi Prasad wrote:
>> On 2019-04-30 14:44, Sodagudi Prasad wrote:
>> +Sudeep
>> 
>> > Hi Mark/Will,
>> >
>> > I would like to understand whether ARM linux community have plans to
>> > support PSCI version 1.1 or not.
>> > PSCI_1_1 specification introduced support for SYSTEM_RESET2 command
>> > and this new command helps mobile devices to SYSTEM_WARM_RESET
>> > support. Rebooting devices with warm reboot helps to capture the
>> > snapshot of the ram contents for post-mortem analysis.
>> 
>> I think, there is a recent discussion from Sudeep for the 
>> SYSTEM_RESET2
>> support.
>> https://patchwork.kernel.org/patch/10884345/
>> 
> 
> This has landed in -next, and hopefully must appear in v5.2
> 
>> 
>> Hi Sudeep,
>> 
>> I was going through your discussion in the below list -
>> https://lore.kernel.org/lkml/d73d3580-4ec1-a281-4585-5c776fc08c79@xilinx.com/
>> 
>> There is no provision to set up reboot mode dynamically instead kernel
>> command line parameter.
>> Looking for options to reboot device with warm reboot option when 
>> kernel
>> crashed.
>> 
>> panic() --> emergency_restart() --> machine_emergency_restart() -->
>> machine_restart(NULL);
>> 
>> It would nice if there is a config option to reboot the device either 
>> in
>> warm or cold in the case of kernel panic.
> 
> I presume you prefer to do warm boot in case of panic to get a dump of
> the memory to inspect ? If so, is kexec/kdump not the mechanism to
> achieve that ?

Hi Sudeep,

Thanks for your response and sharing details about your patch.
<Sudeep>  If so, is kexec/kdump not the mechanism to achieve that?
Qualcomm is having vendor specific solution to capture ram contents and 
for offline analysis.

> 
> I am just trying to understand the use case. Xilinx asked for the same
> but never got to understand their use case.

Here is the background -
Usually, power off drivers are overriding arm_pm_restart and 
pm_power_off callbacks and registering with reboot notifier with  some 
priority for the reboot operations.  Here is the Qualcomm poweroff 
driver for reference.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/reset/msm-poweroff.c

Before vendor chip set specific power off driver is probed, 
arm_pm_restart functions pointer holds the psci_sys_reset function. Once 
vendor power off driver is probed,  vendor drivers can override the 
arm_pm_restart function pointer.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci.c#n562

Once vendor driver is probed, drivers can take care of devices warm or 
hard reset configuration part properly.  But there is a window from 
start_kernel() to vendor specific driver probed, devices are getting 
cold resets even if kernel crashed.  This is due to arm_pm_restart 
points to psci_sys_reset function by default.  Is this problem clear 
now?

Qualcomm downstream kernel has a lot of use cases with respect device 
reset sequence and the downstream driver is much different from upstream 
drivers. I think, the above-mentioned problem is common for all the 
chipset vendors and it is not specific Qualcomm use cases.  I have one 
downstream solution to this problem but thought to bring up this problem 
to the upstream community for a common solution, so that all the vendors 
can use it.

I have modified below flow to avoid cold restart in the case of early 
kernel panic.
panic() --> emergency_restart() --> machine_emergency_restart() --> 
machine_restart(NULL);

-Thanks, Prasad

> 
> --
> Regards,
> Sudeep

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project

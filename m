Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D74A206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mIs/fIOB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="frBkZH4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfC1KjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:39:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:39:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F14A61AC9; Thu, 28 Mar 2019 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553769551;
        bh=I0xBig3THQpYLXzVCwGSwa0RjxmkCishKfa4gu/oidI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mIs/fIOBB/8Zam2pndPwJiqoHlXqyA+NHKUGgYgFhQVKDc5jrlpIFwzWzW+YFrdDq
         QQ2ZKm2/RWqmYrcFiQv22KZnTzDn22/7atp6mJYH1u3B7nuEFLwrRl6BcRHbqc2bVP
         p3DO3v2ziRiB2YX9LAIQJRzvYglGLcni4mIuGZZs=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4658861AAE;
        Thu, 28 Mar 2019 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553769529;
        bh=I0xBig3THQpYLXzVCwGSwa0RjxmkCishKfa4gu/oidI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=frBkZH4vKTksm6/ryOSSEQupr/YG2J+m35cdiClZyaugKWf7h0/0BI3429y3u/v4H
         J93KNSGHGusiaAQqc/XLvBf8J5WEZuTTNZMBC9bP32bpgWpSEy4qkaKK+BoMQADPhG
         aadIrlGqx8R65Z0uViDLD2+Mcj65QsjBRRQ2uu8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4658861AAE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Misplaced driver_sysfs_remove in really_probe?
To:     Jiri Slaby <jslaby@suse.cz>, Greg KH <gregkh@linuxfoundation.org>,
        rafael@kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <582bf3ba-3733-eb38-cb9c-5b0d329fb068@suse.cz>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c7344584-7dca-648a-8a98-8a47806dd6a5@codeaurora.org>
Date:   Thu, 28 Mar 2019 16:08:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <582bf3ba-3733-eb38-cb9c-5b0d329fb068@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 3:36 PM, Jiri Slaby wrote:
> Hi,
>
> since commit 1901fb2604fbcd53201f38725182ea807581159e
> Author: Kay Sievers <kay.sievers@novell.com>
> Date:   Sat Oct 7 21:55:55 2006 +0200
>
>      Driver core: fix "driver" symlink timing
>
> driver_sysfs_remove seems to be misplaced in the fail path of
> really_probe. When driver_sysfs_add fails (or anything which is
> currently above it in dd.c -- be it pinctrl_bind_pins or
> dev->bus->dma_configure), driver_sysfs_remove is called. Given
> dev->driver is set, attempt to remove sysfs device and driver links is
> performed, but it is supposed to fail, as the links do not exist yet.
>
> I am dealing with a Syzkaller WARNING from SLE15-SP1 (4.12) which
> corresponds to the described scenario. Perhaps Syzkaller fault-injected
> a kzalloc failure to pinctrl_bind_pins as I cannot reproduce the report
> at all:
>> WARNING: CPU: 1 PID: 2091 at ../fs/kernfs/dir.c:1481
> kernfs_remove_by_name_ns+0xfa/0x120 fs/kernfs/dir.c:1480
>> Supported: No, Unreleased kernel
>> CPU: 1 PID: 2091 Comm: systemd-udevd Not tainted 4.12.14-396-default
> #1 SLE15-SP1 (unreleased)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-0-ga698c89-prebuilt.qemu.org 04/01/2014
>> task: ffff880053794fc0 task.stack: ffff880040ea0000
>> RIP: 0010:kernfs_remove_by_name_ns+0xfa/0x120 fs/kernfs/dir.c:1480
>> RSP: 0018:ffff880040ea7488 EFLAGS: 00010282
>> RAX: 000000000000002d RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 000000000000002d RSI: 1ffff100081d4e48 RDI: ffffed00081d4e85
>> RBP: ffffffffa772a380 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffffffffaa1872c4 R11: 0000000000000000 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000037
>> FS:  00007f0d24dc0f80(0000) GS:ffff88005e080000(0000)
> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000045c061 CR3: 000000003b878006 CR4: 0000000000060ee0
>> Call Trace:
>>   driver_sysfs_remove+0xb0/0x110 drivers/base/dd.c:290
>>   really_probe drivers/base/dd.c:433 [inline]
>>   driver_probe_device+0x2b3/0x1200 drivers/base/dd.c:530
>>   __driver_attach+0x1dc/0x280 drivers/base/dd.c:763
>>   bus_for_each_dev+0x146/0x1e0 drivers/base/bus.c:316
>>   bus_add_driver+0x40f/0x850 drivers/base/bus.c:710
>>   driver_register+0x1c9/0x410 drivers/base/driver.c:168
>>   __hid_register_driver+0x1e0/0x2d0 drivers/hid/hid-core.c:2974
>>   ? 0xffffffffc1510000
>>   do_one_initcall+0xb7/0x300 init/main.c:808
>>   do_init_module+0x23e/0x641 kernel/module.c:3515
>>   load_module+0x47d6/0x60b0 kernel/module.c:3867
>>   SYSC_finit_module+0x239/0x2a0 kernel/module.c:3980
>>   do_syscall_64+0x26c/0x6e0 arch/x86/entry/common.c:284
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> I believe it survived from 2.6.20 to the current tree.
>
> Does it look correct to you? This should help IMO and if you agree I
> will send a proper patch:
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -496,7 +496,7 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>          if (driver_sysfs_add(dev)) {
>                  printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>                          __func__, dev_name(dev));
> -               goto probe_failed;
> +               goto sysfs_failed;
>          }
>
>          if (dev->pm_domain && dev->pm_domain->activate) {
> @@ -546,6 +546,8 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>          goto done;
>
>   probe_failed:
> +       driver_sysfs_remove(dev);
> +sysfs_failed:
>          arch_teardown_dma_ops(dev);
>   dma_failed:
>          if (dev->bus)
> @@ -554,7 +556,6 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>   pinctrl_bind_failed:
>          device_links_no_driver(dev);
>          devres_release_all(dev);
> -       driver_sysfs_remove(dev);
>          dev->driver = NULL;
>          dev_set_drvdata(dev, NULL);
>          if (dev->pm_domain && dev->pm_domain->dismiss)


Nice observation.
Please send a proper patch.


Cheers,
Mukesh

>
>
>
>
> thanks,

Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C91C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C345E216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556609073;
	bh=6x1GCJaAdMsIQQnKZPHn5d72WB2B7azuT42r9aB1XYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WxzJPk47nixpfR+JolSzRD/xZc6RzVu9IklnZZN+Vg+razTooWDxp2aRPY9R6iGOK
	 EMZJ2MYJEzT+t5SMN0mP0zV/giAOcxwM044leVFcAMiLXr9uKet2MajJ76tiUw8ej/
	 dVy55j9Cj4/9g2W/7kwSn1uaOifXkTZEn8lrIysc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfD3HYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3HYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:24:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE762080C;
        Tue, 30 Apr 2019 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556609070;
        bh=6x1GCJaAdMsIQQnKZPHn5d72WB2B7azuT42r9aB1XYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmyITc9SpvpyfGULC2AwWrzAbx+1ZF5lHwhujFzkXJfswVRfZKuhNw8VKGzs2aTCB
         cT2XEHKyJAA+FCD51IyxooeXQDAARyhGZUQE6xQ0FGAvZpMSBUHbJYws110bQ0vdTR
         3LJsOGgUc5kUm9f3AKFh/XKCvNMLhR/1+Gco26w0=
Date:   Tue, 30 Apr 2019 09:24:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        davem@davemloft.net, alexander.deucher@amd.com,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        jshriram@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: Fix the usage of platform device
 name(pdev->name)
Message-ID: <20190430072427.GA20059@kroah.com>
References: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
 <20190429182058.GA31126@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429182058.GA31126@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:20:58AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Apr 22, 2019 at 05:16:29PM -0700, Venkata Narendra Kumar Gutta wrote:
> > Platform core is using pdev->name as the platform device name to do
> > the binding of the devices with the drivers. But, when the platform
> > driver overrides the platform device name with dev_set_name(),
> > the pdev->name is pointing to a location which is freed and becomes
> > an invalid parameter to do the binding match.
> > 
> > use-after-free instance:
> > 
> > [   33.325013] BUG: KASAN: use-after-free in strcmp+0x8c/0xb0
> > [   33.330646] Read of size 1 at addr ffffffc10beae600 by task modprobe
> > [   33.339068] CPU: 5 PID: 518 Comm: modprobe Tainted:
> > 			G S      W  O      4.19.30+ #3
> > [   33.346835] Hardware name: MTP (DT)
> > [   33.350419] Call trace:
> > [   33.352941]  dump_backtrace+0x0/0x3b8
> > [   33.356713]  show_stack+0x24/0x30
> > [   33.360119]  dump_stack+0x160/0x1d8
> > [   33.363709]  print_address_description+0x84/0x2e0
> > [   33.368549]  kasan_report+0x26c/0x2d0
> > [   33.372322]  __asan_report_load1_noabort+0x2c/0x38
> > [   33.377248]  strcmp+0x8c/0xb0
> > [   33.380306]  platform_match+0x70/0x1f8
> > [   33.384168]  __driver_attach+0x78/0x3a0
> > [   33.388111]  bus_for_each_dev+0x13c/0x1b8
> > [   33.392237]  driver_attach+0x4c/0x58
> > [   33.395910]  bus_add_driver+0x350/0x560
> > [   33.399854]  driver_register+0x23c/0x328
> > [   33.403886]  __platform_driver_register+0xd0/0xe0
> > 
> > So, use dev_name(&pdev->dev), which fetches the platform device name from
> > the kobject(dev->kobj->name) of the device instead of the pdev->name.
> > 
> > Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> 
> This patch results in a large number of crashes (statistics: total: 349
> pass: 244 fail: 105) in my boot tests (https://kerneltests.org/builders).
> Affected architectures are (at least) arm, m68k, mips, ppc, and sh.
> The reason for the crash is different for each architecture. Sometimes
> the boot will stall, sometimes there is a crash, and sometimes the system
> will fail to restart.
> 
> Here is an example for a log message, seen on arm (and m68k, but with ttyS
> instead of ttySA).
> 
> WARNING: CPU: 0 PID: 1 at drivers/tty/tty_io.c:1349 tty_init_dev+0x14c/0x1a4
> tty_init_dev: ttySA driver does not set tty->port. This will crash the kernel later. Fix the driver!
> 
> This is then indeed followed by a crash in tty_init_dev().
> 
> Bisect log for m68k attached below. Reverting this patch fixes the
> problem at least for arm, m68k, and mips images.
> 
> Guenter
> 
> ---
> # bad: [3d17a1de96a233cf89bfbb5a77ebb1a05c420681] Add linux-next specific files for 20190429
> # good: [085b7755808aa11f78ab9377257e1dad2e6fa4bb] Linux 5.1-rc6
> git bisect start 'HEAD' 'v5.1-rc6'
> # good: [48ea994d711ca2e66038741e549f3ebd3072e215] Merge remote-tracking branch 'crypto/master'
> git bisect good 48ea994d711ca2e66038741e549f3ebd3072e215
> # good: [2d49c5dbbd93045625927b6acf54bf43f86f97fd] Merge remote-tracking branch 'spi/for-next'
> git bisect good 2d49c5dbbd93045625927b6acf54bf43f86f97fd
> # bad: [7d38461c1c19569f7952c66913b38a78b2c51828] Merge remote-tracking branch 'staging/staging-next'
> git bisect bad 7d38461c1c19569f7952c66913b38a78b2c51828
> # bad: [b827800209cf30ed4e2d3a503044014b56f2b06f] Merge remote-tracking branch 'tty/tty-next'
> git bisect bad b827800209cf30ed4e2d3a503044014b56f2b06f
> # good: [e643fe145f03134a9de2b8996e11e03b8a0cd90a] Merge remote-tracking branch 'tip/auto-latest'
> git bisect good e643fe145f03134a9de2b8996e11e03b8a0cd90a
> # good: [cac573af020fbe8b16c1c769ed692126b8eceb69] Merge remote-tracking branch 'ipmi/for-next'
> git bisect good cac573af020fbe8b16c1c769ed692126b8eceb69
> # good: [ad74b8649beaf1a22cf8641324e3321fa0269d16] usb: typec: ucsi: Preliminary support for alternate modes
> git bisect good ad74b8649beaf1a22cf8641324e3321fa0269d16
> # bad: [9dc730c74af21b8403a9befba0f5f2e3bd9d6be4] Merge remote-tracking branch 'usb/usb-next'
> git bisect bad 9dc730c74af21b8403a9befba0f5f2e3bd9d6be4
> # good: [ab3a9f2ccc080d27873f76869c9a780be45e581e] acpi/hmat: fix an uninitialized memory_target
> git bisect good ab3a9f2ccc080d27873f76869c9a780be45e581e
> # good: [70283454c918f1d65de0ec50c45ef592d781bcae] livepatch: Replace klp_ktype_patch's default_attrs with groups
> git bisect good 70283454c918f1d65de0ec50c45ef592d781bcae
> # good: [33e39350ebd20fe6a77a51b8c21c3aa6b4a208cf] usb: xhci: add Immediate Data Transfer support
> git bisect good 33e39350ebd20fe6a77a51b8c21c3aa6b4a208cf
> # good: [5afa0a5ed3da85f64f27613a38daa1c4f69dd8ff] usb: xhci: add endpoint context tracing when an endpoint is added
> git bisect good 5afa0a5ed3da85f64f27613a38daa1c4f69dd8ff
> # bad: [a85b96e9e11d97a1fb4a683030d6aa98e1a872e8] Merge remote-tracking branch 'driver-core/driver-core-next'
> git bisect bad a85b96e9e11d97a1fb4a683030d6aa98e1a872e8
> # bad: [edb16da34b084c66763f29bee42b4e6bb33c3d66] driver core: platform: Fix the usage of platform device name(pdev->name)
> git bisect bad edb16da34b084c66763f29bee42b4e6bb33c3d66
> # first bad commit: [edb16da34b084c66763f29bee42b4e6bb33c3d66] driver core: platform: Fix the usage of platform device name(pdev->name)

Sorry, this was reverted from my tree about an hour before your message
as others also had problems.  The next linux next should have the revert
in it.

thanks,

greg k-h

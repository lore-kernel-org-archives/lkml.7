Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34546C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18F213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCSMSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:18:15 -0400
Received: from foss.arm.com ([217.140.101.70]:50612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCSMSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DF71596;
        Tue, 19 Mar 2019 05:18:14 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF373F59C;
        Tue, 19 Mar 2019 05:18:12 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:18:07 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex
 initialisation
Message-ID: <20190319121807.68c858f7@why.wild-wind.fr.eu.org>
In-Reply-To: <20190319114511.GS7752@kuha.fi.intel.com>
References: <20190318174906.10429-1-marc.zyngier@arm.com>
        <20190319114511.GS7752@kuha.fi.intel.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 13:45:11 +0200
Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:

> On Mon, Mar 18, 2019 at 05:49:06PM +0000, Marc Zyngier wrote:
> > Running a kernel with the fusb302 driver and lockdep enabled
> > leads to an unpleasant warning:
> > 
> > [    4.617477] INFO: trying to register non-static key.
> > [    4.617930] the code is fine but needs lockdep annotation.
> > [    4.618418] turning off the locking correctness validator.
> > [    4.618913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc1-00007-g3542533f3fc9 #13
> > [    4.619620] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2019.04-rc3-00124-g2feec69fb1 03/15/2019
> > [    4.620454] Call trace:
> > [    4.620693]  dump_backtrace+0x0/0x138
> > [    4.621028]  show_stack+0x24/0x30
> > [    4.621336]  dump_stack+0xbc/0x104
> > [    4.621649]  register_lock_class+0x594/0x598
> > [    4.622036]  __lock_acquire+0x80/0x11b8
> > [    4.622384]  lock_acquire+0xdc/0x260
> > [    4.622711]  __mutex_lock+0x90/0x8a0
> > [    4.623037]  mutex_lock_nested+0x3c/0x50
> > [    4.623394]  _fusb302_log+0x88/0x1f0
> > [    4.623721]  fusb302_log+0x7c/0xa0
> > [    4.624033]  tcpm_init+0x5c/0x190
> > [    4.624336]  tcpm_init+0x3c/0x130
> > [    4.624640]  tcpm_register_port+0x574/0x878
> > [    4.625019]  fusb302_probe+0x2c8/0x590
> > 
> > Despite what the message says, the code isn't fine, as it tries to
> > make use of the fusb302_log facility pretty early. This requires the
> > logbuffer_lock mutex to be initialised, but that only happens much
> > later. Boo.
> > 
> > Hoist the fusb302_debugfs_init call before tcpm_register_port so that
> > we can enjoy a working mutex. At Guenter's request, also add teardown
> > of the debugfs facility on the error path.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>  
> 
> After applying this there was no more "fusb302" debugfs directory, and
> attempt to unload the fusb302 module dead locked. Also, attempt to
> reboot caused this to happen on my GDPWin board after applying the
> patch:
> 
>         BUG: Dentry 0000000012f2a05d{i=149,n=i2c-fusb302}  still in use (1) [unmount of sysfs sysfs]
>         WARNING: CPU: 3 PID: 1639 at fs/dcache.c:1529 umount_check.cold.55+0x2e/0x3a
>         Modules linked in: intel_xhci_usb_role_switch roles pi3usb30532 typec i915 intel_gtt intel_cht_int33fe [last unloaded: tcpm]
>         CPU: 3 PID: 1639 Comm: umount Not tainted 5.1.0-rc1-heikki+ #916
>         Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
>         RIP: 0010:umount_check.cold.55+0x2e/0x3a
>         ...

OK, that's interesting. On my system, I do have the debugfs file:

root@city-of-tiny-lites:~# cat /sys/kernel/debug/fusb302/4-0022 
[    4.517682] sw reset
[    4.520379] fusb302 device ID: 0x81
[    4.523544] pd := off
[    4.523593] vbus is already Off
[    4.523603] charge is already Off
[    4.523615] vconn is already Off
[    4.524274] pd header := Sink, Device
[    4.525948] cc1=Open, cc2=Open
[    4.530345] pd := off
[    4.530378] vbus is already Off
[    4.530388] charge is already Off
[    4.530405] vconn is already Off
[    4.530931] pd header := Sink, Device
[    4.533773] cc := Open
[    4.642347] start drp toggling

I don't use any module though, so maybe there is something there. I'll
investigate.
 
> Note. Your patch has also a conflict with patches from Hans, I
> think with this one: https://patchwork.kernel.org/patch/10847275/
> I can take care of that, but you can also rebase the next version on
> top of my typec-next branch to solve that problem:
> https://github.com/krohei/linux/commits/typec-next
> 
> I think I need to add that to the MAINTAINERS file.

Fair enough. I'll come back once I know what happens here...

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

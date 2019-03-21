Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A9C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A8921874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfCUQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:02:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfCUQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:02:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33268374;
        Thu, 21 Mar 2019 09:02:33 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BAD33F575;
        Thu, 21 Mar 2019 09:02:31 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:02:27 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex
 initialisation
Message-ID: <20190321160227.32d32bba@why.wild-wind.fr.eu.org>
In-Reply-To: <20190321132418.GE7752@kuha.fi.intel.com>
References: <20190318174906.10429-1-marc.zyngier@arm.com>
        <20190319114511.GS7752@kuha.fi.intel.com>
        <20190320160708.5f31ff10@why.wild-wind.fr.eu.org>
        <20190320163433.GD7752@kuha.fi.intel.com>
        <20190321132418.GE7752@kuha.fi.intel.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 15:24:18 +0200
Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:

> Hi,
> 
> On Wed, Mar 20, 2019 at 06:34:33PM +0200, Heikki Krogerus wrote:
> > > > After applying this there was no more "fusb302" debugfs directory, and
> > > > attempt to unload the fusb302 module dead locked. Also, attempt to
> > > > reboot caused this to happen on my GDPWin board after applying the
> > > > patch:
> > > > 
> > > >         BUG: Dentry 0000000012f2a05d{i=149,n=i2c-fusb302}  still in use (1) [unmount of sysfs sysfs]
> > > >         WARNING: CPU: 3 PID: 1639 at fs/dcache.c:1529 umount_check.cold.55+0x2e/0x3a
> > > >         Modules linked in: intel_xhci_usb_role_switch roles pi3usb30532 typec i915 intel_gtt intel_cht_int33fe [last unloaded: tcpm]
> > > >         CPU: 3 PID: 1639 Comm: umount Not tainted 5.1.0-rc1-heikki+ #916
> > > >         Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> > > >         RIP: 0010:umount_check.cold.55+0x2e/0x3a
> > > >         ...
> > > > 
> > > > Note. Your patch has also a conflict with patches from Hans, I
> > > > think with this one: https://patchwork.kernel.org/patch/10847275/
> > > > I can take care of that, but you can also rebase the next version on
> > > > top of my typec-next branch to solve that problem:
> > > > https://github.com/krohei/linux/commits/typec-next  
> > > 
> > > OK, this is very weird. I can't reproduce any of the issues you're
> > > reporting:
> > > 
> > > - the patch applies cleanly on top of typec-next
> > > - removing the fusb302 module works
> > > - I see the debugfs file whenever fsusb302 is inserted
> > > 
> > > Maybe you were trying this on another branch?  
> > 
> > No, the branch is correct. Actually, I tested this on top of mainline
> > and linux-next. I saw that happen on both.
> > 
> > On these Intel Cherrytrail based boards like my GDBWin, fusb302 is one
> > of the functions of a weir MFD device (the driver for that device is
> > drivers/platform/x86/intel_cht_int33fe.c). It's entirely possible that
> > we are doing something wrong in that driver, and your patch just makes
> > the problem visible.
> > 
> > I'll continue debugging.  
> 
> I figured out what's the problem. It seems that the driver does not
> probe successfully, which is why I don't see that "fusb302" debugfs
> directory.
> 
> The reason is that if tcpm_register_port() returns with -EPROBE_DEFER,
> we end up with that rootdir already pointing to something, even though
> the entry is destroyed in that case. So next time the driver is
> probed, that "fusb302" directory does get created as rootdir has a
> value, and debugfs_create_file() fails.
> 
> I think the correct fix is to just initialize the mutex earlier.
> Something like this should work:
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 261b82900fec..8e43ea27f26d 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -211,7 +211,6 @@ static struct dentry *rootdir;
>  
>  static void fusb302_debugfs_init(struct fusb302_chip *chip)
>  {
> -       mutex_init(&chip->logbuffer_lock);
>         if (!rootdir)
>                 rootdir = debugfs_create_dir("fusb302", NULL);
>  
> @@ -1667,6 +1666,7 @@ static int fusb302_probe(struct i2c_client *client,
>         chip->tcpc_config = fusb302_tcpc_config;
>         chip->tcpc_dev.config = &chip->tcpc_config;
>         mutex_init(&chip->lock);
> +       mutex_init(&chip->logbuffer_lock);
>  
>         chip->tcpc_dev.fwnode =
>                 device_get_named_child_node(dev, "connector");

Looks good to me, although you probably want to make that conditional
on CONFIG_DEBUG_FS being set.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

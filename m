Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA204C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B074921874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfCUNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:24:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:51074 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfCUNYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:24:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="157044589"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Mar 2019 06:24:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Mar 2019 15:24:18 +0200
Date:   Thu, 21 Mar 2019 15:24:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex initialisation
Message-ID: <20190321132418.GE7752@kuha.fi.intel.com>
References: <20190318174906.10429-1-marc.zyngier@arm.com>
 <20190319114511.GS7752@kuha.fi.intel.com>
 <20190320160708.5f31ff10@why.wild-wind.fr.eu.org>
 <20190320163433.GD7752@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320163433.GD7752@kuha.fi.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 20, 2019 at 06:34:33PM +0200, Heikki Krogerus wrote:
> > > After applying this there was no more "fusb302" debugfs directory, and
> > > attempt to unload the fusb302 module dead locked. Also, attempt to
> > > reboot caused this to happen on my GDPWin board after applying the
> > > patch:
> > > 
> > >         BUG: Dentry 0000000012f2a05d{i=149,n=i2c-fusb302}  still in use (1) [unmount of sysfs sysfs]
> > >         WARNING: CPU: 3 PID: 1639 at fs/dcache.c:1529 umount_check.cold.55+0x2e/0x3a
> > >         Modules linked in: intel_xhci_usb_role_switch roles pi3usb30532 typec i915 intel_gtt intel_cht_int33fe [last unloaded: tcpm]
> > >         CPU: 3 PID: 1639 Comm: umount Not tainted 5.1.0-rc1-heikki+ #916
> > >         Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> > >         RIP: 0010:umount_check.cold.55+0x2e/0x3a
> > >         ...
> > > 
> > > Note. Your patch has also a conflict with patches from Hans, I
> > > think with this one: https://patchwork.kernel.org/patch/10847275/
> > > I can take care of that, but you can also rebase the next version on
> > > top of my typec-next branch to solve that problem:
> > > https://github.com/krohei/linux/commits/typec-next
> > 
> > OK, this is very weird. I can't reproduce any of the issues you're
> > reporting:
> > 
> > - the patch applies cleanly on top of typec-next
> > - removing the fusb302 module works
> > - I see the debugfs file whenever fsusb302 is inserted
> > 
> > Maybe you were trying this on another branch?
> 
> No, the branch is correct. Actually, I tested this on top of mainline
> and linux-next. I saw that happen on both.
> 
> On these Intel Cherrytrail based boards like my GDBWin, fusb302 is one
> of the functions of a weir MFD device (the driver for that device is
> drivers/platform/x86/intel_cht_int33fe.c). It's entirely possible that
> we are doing something wrong in that driver, and your patch just makes
> the problem visible.
> 
> I'll continue debugging.

I figured out what's the problem. It seems that the driver does not
probe successfully, which is why I don't see that "fusb302" debugfs
directory.

The reason is that if tcpm_register_port() returns with -EPROBE_DEFER,
we end up with that rootdir already pointing to something, even though
the entry is destroyed in that case. So next time the driver is
probed, that "fusb302" directory does get created as rootdir has a
value, and debugfs_create_file() fails.

I think the correct fix is to just initialize the mutex earlier.
Something like this should work:

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 261b82900fec..8e43ea27f26d 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -211,7 +211,6 @@ static struct dentry *rootdir;
 
 static void fusb302_debugfs_init(struct fusb302_chip *chip)
 {
-       mutex_init(&chip->logbuffer_lock);
        if (!rootdir)
                rootdir = debugfs_create_dir("fusb302", NULL);
 
@@ -1667,6 +1666,7 @@ static int fusb302_probe(struct i2c_client *client,
        chip->tcpc_config = fusb302_tcpc_config;
        chip->tcpc_dev.config = &chip->tcpc_config;
        mutex_init(&chip->lock);
+       mutex_init(&chip->logbuffer_lock);
 
        chip->tcpc_dev.fwnode =
                device_get_named_child_node(dev, "connector");

thanks,

-- 
heikki

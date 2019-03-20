Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B059BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8827020850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCTQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:34:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:32608 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfCTQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:34:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 09:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="156739860"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Mar 2019 09:34:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:34:33 +0200
Date:   Wed, 20 Mar 2019 18:34:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex initialisation
Message-ID: <20190320163433.GD7752@kuha.fi.intel.com>
References: <20190318174906.10429-1-marc.zyngier@arm.com>
 <20190319114511.GS7752@kuha.fi.intel.com>
 <20190320160708.5f31ff10@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320160708.5f31ff10@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Mar 20, 2019 at 04:07:08PM +0000, Marc Zyngier wrote:
> On Tue, 19 Mar 2019 13:45:11 +0200
> Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> 
> Heikki,
> 
> > On Mon, Mar 18, 2019 at 05:49:06PM +0000, Marc Zyngier wrote:
> > > Running a kernel with the fusb302 driver and lockdep enabled
> > > leads to an unpleasant warning:
> > > 
> > > [    4.617477] INFO: trying to register non-static key.
> > > [    4.617930] the code is fine but needs lockdep annotation.
> > > [    4.618418] turning off the locking correctness validator.
> > > [    4.618913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc1-00007-g3542533f3fc9 #13
> > > [    4.619620] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2019.04-rc3-00124-g2feec69fb1 03/15/2019
> > > [    4.620454] Call trace:
> > > [    4.620693]  dump_backtrace+0x0/0x138
> > > [    4.621028]  show_stack+0x24/0x30
> > > [    4.621336]  dump_stack+0xbc/0x104
> > > [    4.621649]  register_lock_class+0x594/0x598
> > > [    4.622036]  __lock_acquire+0x80/0x11b8
> > > [    4.622384]  lock_acquire+0xdc/0x260
> > > [    4.622711]  __mutex_lock+0x90/0x8a0
> > > [    4.623037]  mutex_lock_nested+0x3c/0x50
> > > [    4.623394]  _fusb302_log+0x88/0x1f0
> > > [    4.623721]  fusb302_log+0x7c/0xa0
> > > [    4.624033]  tcpm_init+0x5c/0x190
> > > [    4.624336]  tcpm_init+0x3c/0x130
> > > [    4.624640]  tcpm_register_port+0x574/0x878
> > > [    4.625019]  fusb302_probe+0x2c8/0x590
> > > 
> > > Despite what the message says, the code isn't fine, as it tries to
> > > make use of the fusb302_log facility pretty early. This requires the
> > > logbuffer_lock mutex to be initialised, but that only happens much
> > > later. Boo.
> > > 
> > > Hoist the fusb302_debugfs_init call before tcpm_register_port so that
> > > we can enjoy a working mutex. At Guenter's request, also add teardown
> > > of the debugfs facility on the error path.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>  
> > 
> > After applying this there was no more "fusb302" debugfs directory, and
> > attempt to unload the fusb302 module dead locked. Also, attempt to
> > reboot caused this to happen on my GDPWin board after applying the
> > patch:
> > 
> >         BUG: Dentry 0000000012f2a05d{i=149,n=i2c-fusb302}  still in use (1) [unmount of sysfs sysfs]
> >         WARNING: CPU: 3 PID: 1639 at fs/dcache.c:1529 umount_check.cold.55+0x2e/0x3a
> >         Modules linked in: intel_xhci_usb_role_switch roles pi3usb30532 typec i915 intel_gtt intel_cht_int33fe [last unloaded: tcpm]
> >         CPU: 3 PID: 1639 Comm: umount Not tainted 5.1.0-rc1-heikki+ #916
> >         Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> >         RIP: 0010:umount_check.cold.55+0x2e/0x3a
> >         ...
> > 
> > Note. Your patch has also a conflict with patches from Hans, I
> > think with this one: https://patchwork.kernel.org/patch/10847275/
> > I can take care of that, but you can also rebase the next version on
> > top of my typec-next branch to solve that problem:
> > https://github.com/krohei/linux/commits/typec-next
> 
> OK, this is very weird. I can't reproduce any of the issues you're
> reporting:
> 
> - the patch applies cleanly on top of typec-next
> - removing the fusb302 module works
> - I see the debugfs file whenever fsusb302 is inserted
> 
> Maybe you were trying this on another branch?

No, the branch is correct. Actually, I tested this on top of mainline
and linux-next. I saw that happen on both.

On these Intel Cherrytrail based boards like my GDBWin, fusb302 is one
of the functions of a weir MFD device (the driver for that device is
drivers/platform/x86/intel_cht_int33fe.c). It's entirely possible that
we are doing something wrong in that driver, and your patch just makes
the problem visible.

I'll continue debugging.


thanks,

-- 
heikki

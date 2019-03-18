Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD5C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A5520863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCRQTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:19:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:20153 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfCRQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:19:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 09:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126439052"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 09:19:51 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h5uzN-0003vY-V6; Mon, 18 Mar 2019 18:19:49 +0200
Date:   Mon, 18 Mar 2019 18:19:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Wang Hai <wanghai26@huawei.com>, davem@davemloft.net,
        idosch@mellanox.com, alexander.h.duyck@intel.com,
        tyhicks@canonical.com, f.fainelli@gmail.com,
        amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190318161949.GX9224@smile.fi.intel.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
 <20190318085724.1e0c017b@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318085724.1e0c017b@shemminger-XPS-13-9360>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:57:24AM -0700, Stephen Hemminger wrote:
> On Tue, 19 Mar 2019 01:06:57 -0400
> Wang Hai <wanghai26@huawei.com> wrote:
> 
> > When registering struct net_device, it will call
> > 	register_netdevice ->
> > 		netdev_register_kobject ->
> > 			device_add(dev)
> > 			register_queue_kobjects(ndev)
> > 
> > If device_add(dev) or register_queue_kobjects(ndev) fails.
> > Register_netdevice() will return error, causing netdev_freemem(ndev)
> > to be called to free net_device, however (&ndev->dev)->kobj.name will
> > not be freed, resulting in a memory leak.
> > 
> > syzkaller report this:
> > BUG: memory leak
> > unreferenced object 0xffff8881f4fad168 (size 8):
> > comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
> > hex dump (first 8 bytes):
> >   77 70 61 6e 30 00 ff ff                          wpan0...
> > backtrace:
> >   [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
> >   [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
> >   [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:281
> >   [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
> >   [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/net-sysfs.c:1727
> >   [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:8711
> >   [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [ieee802154]
> >   [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee802154]
> >   [<00000000e4b3df51>] 0xffffffffc1500e0e
> >   [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/platform.c:614
> >   [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
> >   [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd.c:671
> >   [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/dd.c:945
> >   [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:1022
> >   [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
> >   [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:645
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")
> > Signed-off-by: Wang Hai <wanghai26@huawei.com>
> > ---
> >  net/core/net-sysfs.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 4ff661f..f0e53dc 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -1745,17 +1745,22 @@ int netdev_register_kobject(struct net_device *ndev)
> >  
> >  	error = device_add(dev);
> >  	if (error)
> > -		return error;
> > +		goto device_add_error;
> >  
> >  	error = register_queue_kobjects(ndev);
> > -	if (error) {
> > -		device_del(dev);
> > -		return error;
> > -	}
> > +	if (error)
> > +		goto register_error;
> >  
> >  	pm_runtime_set_memalloc_noio(dev, true);
> >  
> > +out:
> >  	return error;
> > +
> > +register_error:
> > +	device_del(dev);
> > +device_add_error:
> > +	kfree_const(dev->kobj.name);
> 
> This looks a bug in device_add() not here.
> In general, it is better for an api to clean up after itself.
> Since dev->kobj.name is created in device_add and normally freed
> in device_del; why is device_add leaving it behind?

It's more likely the bug in syzkaller.

Look at the kobject_cleanup() last lines of code...

-- 
With Best Regards,
Andy Shevchenko



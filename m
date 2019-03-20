Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCTJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:41:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:57145 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfCTJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:41:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 02:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="135821623"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2019 02:41:29 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6Xiy-0006Ho-DE; Wed, 20 Mar 2019 11:41:28 +0200
Date:   Wed, 20 Mar 2019 11:41:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     davem@davemloft.net, idosch@mellanox.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190320094128.GW9224@smile.fi.intel.com>
References: <20190320182505.18642-1-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320182505.18642-1-wanghai26@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:25:05PM -0400, Wang Hai wrote:
> When registering struct net_device, it will call
> 	register_netdevice ->
> 		netdev_register_kobject ->
> 			device_initialize(dev);
> 			dev_set_name(dev, "%s", ndev->name)
> 			device_add(dev)
> 			register_queue_kobjects(ndev)
> 
> In netdev_register_kobject(), if device_add(dev) or
> register_queue_kobjects(ndev) failed. Register_netdevice()
> will return error, causing netdev_freemem(ndev) to be
> called to free net_device, however put_device(&dev->dev)->..->
> kobject_cleanup() won't be called, resulting in a memory leak.
> 
> syzkaller report this:
> BUG: memory leak
> unreferenced object 0xffff8881f4fad168 (size 8):
> comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
> hex dump (first 8 bytes):
>   77 70 61 6e 30 00 ff ff                          wpan0...
> backtrace:
>   [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
>   [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
>   [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:281
>   [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
>   [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/net-sysfs.c:1727
>   [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:8711
>   [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [ieee802154]
>   [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee802154]
>   [<00000000e4b3df51>] 0xffffffffc1500e0e
>   [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/platform.c:614
>   [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
>   [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd.c:671
>   [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/dd.c:945
>   [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:1022
>   [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
>   [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:645
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Wang Hai <wanghai26@huawei.com>
> ---
> v2 -> v3:
>  - Change kfree_const(dev->kobj.name) to put_device(dev), fix the
>    problem of freeing kobj
>  - Improve the description of the cause of the bug
> 
> v1 -> v2:
>  - Fix the commit id of Fixes
>  - Improve the description of the cause of the bug, no code changes.
> ---
>  net/core/net-sysfs.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 4ff661f..8e568422 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1745,16 +1745,20 @@ int netdev_register_kobject(struct net_device *ndev)
>  
>  	error = device_add(dev);
>  	if (error)
> -		return error;
> +		goto error_put_device;
>  
>  	error = register_queue_kobjects(ndev);
> -	if (error) {
> -		device_del(dev);
> -		return error;
> -	}
> +	if (error)
> +		goto error_device_del;
>  
>  	pm_runtime_set_memalloc_noio(dev, true);
>  
> +	return 0;
> +
> +error_device_del:
> +	device_del(dev);
> +error_put_device:
> +	put_device(dev);
>  	return error;
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A833C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCSOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:00:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:64664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfCSOAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:00:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 07:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="128274296"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2019 07:00:20 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6FHv-0005nR-GJ; Tue, 19 Mar 2019 16:00:19 +0200
Date:   Tue, 19 Mar 2019 16:00:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        davem@davemloft.net, idosch@mellanox.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190319140019.GG9224@smile.fi.intel.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
 <20190318085724.1e0c017b@shemminger-XPS-13-9360>
 <20190318161949.GX9224@smile.fi.intel.com>
 <c1c266af-7aaa-00a7-aa7a-e61c65665741@huawei.com>
 <20190319103037.GD9224@smile.fi.intel.com>
 <18553079-7bbd-fcfe-ef1c-6717e963e0a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18553079-7bbd-fcfe-ef1c-6717e963e0a5@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 08:17:01PM +0800, wanghai (M) wrote:
> 在 2019/3/19 18:30, Andy Shevchenko 写道:
> > On Tue, Mar 19, 2019 at 11:19:24AM +0800, wanghai (M) wrote:
> > > 在 2019/3/19 0:19, Andy Shevchenko 写道:

> > > If device_add(dev) or register_queue_kobjects(ndev) fails,
> > > In register_netdevice(), dev-> reg_state = NETREG_UNINITIALIZED and returns
> > > an error, causing put_device(&dev-> dev) -> ..-> kobject_cleanup() not to be
> > > called.
> > OK, that's true, but your patch is wrong.
> > See error handling in device_create_groups_vargs() for example.

> Hi Andy
> Thanks for your advice. I understand the problem of my patch.
> Can you help me see if it can be fixed like this?
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 4ff661f..6fe5b8e 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1745,17 +1745,21 @@ int netdev_register_kobject(struct net_device *ndev)
> 
>         error = device_add(dev);
>         if (error)
> -               return error;
> +               goto device_add_error;

This part seems correct now.

>         error = register_queue_kobjects(ndev);
> -       if (error) {
> -               device_del(dev);
> -               return error;
> -       }
> +       if (error)
> +               goto register_error;

Yes, seems correct order here, i.e. device_del() followed by put_device().

> 
>         pm_runtime_set_memalloc_noio(dev, true);
> 

> +out:

Better

	return 0;

>         return error;
> +register_error:

Better to describe what you will do here, i.e.

error_device_del:

> +       device_del(dev);

> +device_add_error:

Ditto.

error_put_device:

> +       put_device(dev);

> +       goto out;

Better

	return error;

>  }

-- 
With Best Regards,
Andy Shevchenko



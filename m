Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB046C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E3120879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCYQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:10:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:24889 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:10:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="130026252"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 09:10:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8SBD-0007fW-Pu; Mon, 25 Mar 2019 18:10:31 +0200
Date:   Mon, 25 Mar 2019 18:10:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     syzbot <syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com>,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        f.fainelli@gmail.com, idosch@mellanox.com, joe@perches.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com,
        tyhicks@canonical.com, yuehaibing@huawei.com
Subject: Re: kernel BUG at net/core/net-sysfs.c:LINE!
Message-ID: <20190325161031.GH9224@smile.fi.intel.com>
References: <000000000000e644ba0584bdf7e8@google.com>
 <20190323171621.GF9224@smile.fi.intel.com>
 <280fdb18-4948-968d-faa6-23197cd2b23e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <280fdb18-4948-968d-faa6-23197cd2b23e@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:20:01PM +0800, wanghai (M) wrote:
> thanks , Can it be fixed like this?

I dunno. I think no, it can't.

As far as I can see the issue happened due to freeing entire network device at
the point of putting reference count to the device (struct device is embedded
into struct net_device).

When it happens the access to _any_ field of struct net_device will crash the
system.

Basically it means that put_device() should be carefully placed case-by-case,
because on real hardware the actual device is parent and usually no-one does
access to the child without need. On the contrary the tunX devices are
artificial and are controlled by the network stack.

So, it means we need to do something like

ret = register_netdev(...);
if (ret) {
	put_device(&ndev->dev);
	...
}

But as I mentioned, it would be tricky to not break something else.

P.S. It might be I have missed something, I'm not an expert in network stack.

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 4ff661f..e609c8d 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1745,16 +1745,21 @@ int netdev_register_kobject(struct net_device *ndev)
> 
>         error = device_add(dev);
>         if (error)
> -               return error;
> +               goto error_put_device;
> 
>         error = register_queue_kobjects(ndev);
> -       if (error) {
> -               device_del(dev);
> -               return error;
> -       }
> +       if (error)
> +               goto error_device_del;
> 
>         pm_runtime_set_memalloc_noio(dev, true);
> 
> +       return 0;
> +
> +error_device_del:
> +       device_del(dev);
> +error_put_device:
> +       ndev->reg_state = NETREG_RELEASED;
> +       put_device(dev);
>         return error;
>  }
> 
> 在 2019/3/24 1:16, Andy Shevchenko 写道:
> > Nice.
> > 
> > I looked briefly in the flow of this report and it looks like the patch above
> > should be reverted.
> > 
> > The problem is not so easy to fix. One approach is to initialize device
> > (and thus kobject) somewhere in alloc_netdev() and put device in free_netdev()
> > respectively, but this might produce more interesting regressions.
> 

-- 
With Best Regards,
Andy Shevchenko



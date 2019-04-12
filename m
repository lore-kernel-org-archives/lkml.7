Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D920C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2572084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfDLIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:39:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:35546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfDLIjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:39:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 01:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="290937984"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2019 01:38:59 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hEri5-0003No-OW; Fri, 12 Apr 2019 11:38:57 +0300
Date:   Fri, 12 Apr 2019 11:38:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     davem@davemloft.net, idosch@mellanox.com, eric.dumazet@gmail.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, viro@zeniv.linux.org.uk,
        amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "net-sysfs: Fix memory leak in
 netdev_register_kobject"
Message-ID: <20190412083857.GH9224@smile.fi.intel.com>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-2-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412203634.30392-2-wanghai26@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 04:36:33PM -0400, Wang Hai wrote:
> This reverts commit 6b70fc94afd165342876e53fc4b2f7d085009945.
> 
> The reverted bugfix will cause another issue.
> Reported by syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com.
> See https://syzkaller.appspot.com/x/log.txt?x=1737671b200000 for
> details.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wang Hai <wanghai26@huawei.com>
> ---
>  net/core/net-sysfs.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index f8f9430..8f8b7b6 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1747,20 +1747,16 @@ int netdev_register_kobject(struct net_device *ndev)
>  
>  	error = device_add(dev);
>  	if (error)
> -		goto error_put_device;
> +		return error;
>  
>  	error = register_queue_kobjects(ndev);
> -	if (error)
> -		goto error_device_del;
> +	if (error) {
> +		device_del(dev);
> +		return error;
> +	}
>  
>  	pm_runtime_set_memalloc_noio(dev, true);
>  
> -	return 0;
> -
> -error_device_del:
> -	device_del(dev);
> -error_put_device:
> -	put_device(dev);
>  	return error;
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
With Best Regards,
Andy Shevchenko



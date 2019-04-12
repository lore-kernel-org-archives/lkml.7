Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8422FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5827E2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDLNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:20:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:38303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfDLNUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:20:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 06:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="148861152"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2019 06:20:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hEw66-0006ON-5C; Fri, 12 Apr 2019 16:20:02 +0300
Date:   Fri, 12 Apr 2019 16:20:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Wang Hai <wanghai26@huawei.com>, davem@davemloft.net,
        idosch@mellanox.com, alexander.h.duyck@intel.com,
        tyhicks@canonical.com, f.fainelli@gmail.com,
        viro@zeniv.linux.org.uk, amritha.nambiar@intel.com,
        joe@perches.com, dmitry.torokhov@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190412132002.GU9224@smile.fi.intel.com>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
 <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 06:03:27AM -0700, Eric Dumazet wrote:
> On 04/12/2019 01:36 PM, Wang Hai wrote:
> > When registering struct net_device, it will call
> >         register_netdevice ->
> >                 netdev_register_kobject ->
> >                         device_initialize(dev);
> >                         dev_set_name(dev, "%s", ndev->name)
> >                         device_add(dev)
> >                         register_queue_kobjects(ndev)
> > 
> > In netdev_register_kobject(), if device_add(dev) or
> > register_queue_kobjects(ndev) failed. Register_netdevice()
> > will return error, causing netdev_freemem(ndev) to be
> > called to free net_device, however put_device(&dev->dev)->..->
> > kobject_cleanup() won't be called, resulting in a memory leak
> > which is alloced by dev_set_name()
> > 
> >
> 
> 
> Having two patches with exact same title is rather confusing for bug trackers.
> 
> Instead of revert + another_patch, why not just send a cumulative fix ?

The second patch is a reincarnation of the first version of the fix which has
been discussed as not a correct approach. But revert should be applied sooner
as the original commit brought a regression.


-- 
With Best Regards,
Andy Shevchenko



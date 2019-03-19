Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5F1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCSKao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:30:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:60720 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfCSKan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:30:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 03:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="283924880"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2019 03:30:39 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6C0z-0003lf-VI; Tue, 19 Mar 2019 12:30:37 +0200
Date:   Tue, 19 Mar 2019 12:30:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        davem@davemloft.net, idosch@mellanox.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190319103037.GD9224@smile.fi.intel.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
 <20190318085724.1e0c017b@shemminger-XPS-13-9360>
 <20190318161949.GX9224@smile.fi.intel.com>
 <c1c266af-7aaa-00a7-aa7a-e61c65665741@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c266af-7aaa-00a7-aa7a-e61c65665741@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:19:24AM +0800, wanghai (M) wrote:
> 
> 在 2019/3/19 0:19, Andy Shevchenko 写道:
> > On Mon, Mar 18, 2019 at 08:57:24AM -0700, Stephen Hemminger wrote:
> > > On Tue, 19 Mar 2019 01:06:57 -0400
> > > Wang Hai <wanghai26@huawei.com> wrote:

> > > This looks a bug in device_add() not here.
> > > In general, it is better for an api to clean up after itself.
> > > Since dev->kobj.name is created in device_add and normally freed
> > > in device_del; why is device_add leaving it behind?
> > It's more likely the bug in syzkaller.
> > 
> > Look at the kobject_cleanup() last lines of code...
> If device_add(dev) or register_queue_kobjects(ndev) fails,
> In register_netdevice(), dev-> reg_state = NETREG_UNINITIALIZED and returns
> an error, causing put_device(&dev-> dev) -> ..-> kobject_cleanup() not to be
> called.

OK, that's true, but your patch is wrong.
See error handling in device_create_groups_vargs() for example.

-- 
With Best Regards,
Andy Shevchenko



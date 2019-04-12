Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68070C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6BB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfDLIil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:38:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:56987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfDLIil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:38:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 01:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="135179111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2019 01:38:37 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hErhj-0003NY-Ha; Fri, 12 Apr 2019 11:38:35 +0300
Date:   Fri, 12 Apr 2019 11:38:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     davem@davemloft.net, idosch@mellanox.com, eric.dumazet@gmail.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, viro@zeniv.linux.org.uk,
        amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190412083835.GG9224@smile.fi.intel.com>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412203634.30392-3-wanghai26@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 04:36:34PM -0400, Wang Hai wrote:

> +error_register:
> +	device_del(dev);
> +error_device_add:
> +	kfree_const(dev->kobj.name);
>  	return error;

When put_device() will be called on this it will go to double free (in case of
dynamically allocated dev->kobj.name.

Al Viro and me suggested earlier that the correct fix is to call put_device()
in a places where it is appropriate.

-- 
With Best Regards,
Andy Shevchenko



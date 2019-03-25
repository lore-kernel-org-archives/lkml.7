Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EAE20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfCYFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:54:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28909
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729400AbfCYFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:54:39 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549926000"; 
   d="scan'208";a="300570127"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:54:35 +0100
Date:   Mon, 25 Mar 2019 06:54:35 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kangjie Lu <kjlu@umn.edu>
cc:     kjlu@umn.edu, pakki001@umn.edu,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: Re: [PATCH] usb: sierra: fix a missing check of device_create_file
 (fwd)
Message-ID: <alpine.DEB.2.21.1903250653300.2742@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be a possible double free.

julia

---------- Forwarded message ----------
Date: Mon, 25 Mar 2019 12:21:18 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] usb: sierra: fix a missing check of device_create_file

CC: kbuild-all@01.org
In-Reply-To: <20190324223920.961-1-kjlu@umn.edu>
References: <20190324223920.961-1-kjlu@umn.edu>
TO: Kangjie Lu <kjlu@umn.edu>
CC: kjlu@umn.edu, pakki001@umn.edu, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
CC: pakki001@umn.edu, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.1-rc2 next-20190322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/usb-sierra-fix-a-missing-check-of-device_create_file/20190325-101328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> drivers/usb/storage/sierra_ms.c:199:8-16: ERROR: reference preceded by free on line 194

# https://github.com/0day-ci/linux/commit/04d66f3d072c3d14308aebecdbc0f2983ce443d2
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 04d66f3d072c3d14308aebecdbc0f2983ce443d2
vim +199 drivers/usb/storage/sierra_ms.c

32fe5e393 Kevin Lloyd  2008-07-10  126
32fe5e393 Kevin Lloyd  2008-07-10  127  int sierra_ms_init(struct us_data *us)
32fe5e393 Kevin Lloyd  2008-07-10  128  {
32fe5e393 Kevin Lloyd  2008-07-10  129  	int result, retries;
32fe5e393 Kevin Lloyd  2008-07-10  130  	struct swoc_info *swocInfo;
32fe5e393 Kevin Lloyd  2008-07-10  131  	struct usb_device *udev;
32fe5e393 Kevin Lloyd  2008-07-10  132  	struct Scsi_Host *sh;
32fe5e393 Kevin Lloyd  2008-07-10  133
32fe5e393 Kevin Lloyd  2008-07-10  134  	retries = 3;
32fe5e393 Kevin Lloyd  2008-07-10  135  	result = 0;
32fe5e393 Kevin Lloyd  2008-07-10  136  	udev = us->pusb_dev;
32fe5e393 Kevin Lloyd  2008-07-10  137
32fe5e393 Kevin Lloyd  2008-07-10  138  	sh = us_to_host(us);
0220a3f01 Alan Cox     2012-09-19  139  	scsi_get_host_dev(sh);
32fe5e393 Kevin Lloyd  2008-07-10  140
32fe5e393 Kevin Lloyd  2008-07-10  141  	/* Force Modem mode */
32fe5e393 Kevin Lloyd  2008-07-10  142  	if (swi_tru_install == TRU_FORCE_MODEM) {
191648d03 Joe Perches  2013-04-19  143  		usb_stor_dbg(us, "SWIMS: Forcing Modem Mode\n");
32fe5e393 Kevin Lloyd  2008-07-10  144  		result = sierra_set_ms_mode(udev, SWIMS_SET_MODE_Modem);
32fe5e393 Kevin Lloyd  2008-07-10  145  		if (result < 0)
191648d03 Joe Perches  2013-04-19  146  			usb_stor_dbg(us, "SWIMS: Failed to switch to modem mode\n");
32fe5e393 Kevin Lloyd  2008-07-10  147  		return -EIO;
32fe5e393 Kevin Lloyd  2008-07-10  148  	}
32fe5e393 Kevin Lloyd  2008-07-10  149  	/* Force Mass Storage mode (keep CD-Rom) */
32fe5e393 Kevin Lloyd  2008-07-10  150  	else if (swi_tru_install == TRU_FORCE_MS) {
191648d03 Joe Perches  2013-04-19  151  		usb_stor_dbg(us, "SWIMS: Forcing Mass Storage Mode\n");
32fe5e393 Kevin Lloyd  2008-07-10  152  		goto complete;
32fe5e393 Kevin Lloyd  2008-07-10  153  	}
32fe5e393 Kevin Lloyd  2008-07-10  154  	/* Normal TRU-Install Logic */
32fe5e393 Kevin Lloyd  2008-07-10  155  	else {
191648d03 Joe Perches  2013-04-19  156  		usb_stor_dbg(us, "SWIMS: Normal SWoC Logic\n");
32fe5e393 Kevin Lloyd  2008-07-10  157
32fe5e393 Kevin Lloyd  2008-07-10  158  		swocInfo = kmalloc(sizeof(struct swoc_info),
32fe5e393 Kevin Lloyd  2008-07-10  159  				GFP_KERNEL);
191648d03 Joe Perches  2013-04-19  160  		if (!swocInfo)
32fe5e393 Kevin Lloyd  2008-07-10  161  			return -ENOMEM;
32fe5e393 Kevin Lloyd  2008-07-10  162
32fe5e393 Kevin Lloyd  2008-07-10  163  		retries = 3;
32fe5e393 Kevin Lloyd  2008-07-10  164  		do {
32fe5e393 Kevin Lloyd  2008-07-10  165  			retries--;
32fe5e393 Kevin Lloyd  2008-07-10  166  			result = sierra_get_swoc_info(udev, swocInfo);
32fe5e393 Kevin Lloyd  2008-07-10  167  			if (result < 0) {
191648d03 Joe Perches  2013-04-19  168  				usb_stor_dbg(us, "SWIMS: Failed SWoC query\n");
32fe5e393 Kevin Lloyd  2008-07-10  169  				schedule_timeout_uninterruptible(2*HZ);
32fe5e393 Kevin Lloyd  2008-07-10  170  			}
32fe5e393 Kevin Lloyd  2008-07-10  171  		} while (retries && result < 0);
32fe5e393 Kevin Lloyd  2008-07-10  172
32fe5e393 Kevin Lloyd  2008-07-10  173  		if (result < 0) {
191648d03 Joe Perches  2013-04-19  174  			usb_stor_dbg(us, "SWIMS: Completely failed SWoC query\n");
32fe5e393 Kevin Lloyd  2008-07-10  175  			kfree(swocInfo);
32fe5e393 Kevin Lloyd  2008-07-10  176  			return -EIO;
32fe5e393 Kevin Lloyd  2008-07-10  177  		}
32fe5e393 Kevin Lloyd  2008-07-10  178
191648d03 Joe Perches  2013-04-19  179  		debug_swoc(&us->pusb_dev->dev, swocInfo);
32fe5e393 Kevin Lloyd  2008-07-10  180
f0183a338 Felipe Balbi 2016-04-18  181  		/*
f0183a338 Felipe Balbi 2016-04-18  182  		 * If there is not Linux software on the TRU-Install device
32fe5e393 Kevin Lloyd  2008-07-10  183  		 * then switch to modem mode
32fe5e393 Kevin Lloyd  2008-07-10  184  		 */
32fe5e393 Kevin Lloyd  2008-07-10  185  		if (!containsFullLinuxPackage(swocInfo)) {
191648d03 Joe Perches  2013-04-19  186  			usb_stor_dbg(us, "SWIMS: Switching to Modem Mode\n");
32fe5e393 Kevin Lloyd  2008-07-10  187  			result = sierra_set_ms_mode(udev,
32fe5e393 Kevin Lloyd  2008-07-10  188  				SWIMS_SET_MODE_Modem);
32fe5e393 Kevin Lloyd  2008-07-10  189  			if (result < 0)
191648d03 Joe Perches  2013-04-19  190  				usb_stor_dbg(us, "SWIMS: Failed to switch modem\n");
32fe5e393 Kevin Lloyd  2008-07-10  191  			kfree(swocInfo);
32fe5e393 Kevin Lloyd  2008-07-10  192  			return -EIO;
32fe5e393 Kevin Lloyd  2008-07-10  193  		}
32fe5e393 Kevin Lloyd  2008-07-10 @194  		kfree(swocInfo);
32fe5e393 Kevin Lloyd  2008-07-10  195  	}
32fe5e393 Kevin Lloyd  2008-07-10  196  complete:
32fe5e393 Kevin Lloyd  2008-07-10  197  	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
04d66f3d0 Kangjie Lu   2019-03-24  198  	if (result) {
04d66f3d0 Kangjie Lu   2019-03-24 @199  		kfree(swocInfo);
04d66f3d0 Kangjie Lu   2019-03-24  200  		return result;
04d66f3d0 Kangjie Lu   2019-03-24  201  	}
32fe5e393 Kevin Lloyd  2008-07-10  202
be475d902 Alan Stern   2009-05-21  203  	return 0;
32fe5e393 Kevin Lloyd  2008-07-10  204  }
32fe5e393 Kevin Lloyd  2008-07-10  205

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

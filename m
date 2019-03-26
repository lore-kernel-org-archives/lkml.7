Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7F820830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ExewmT0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:19:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:19:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8Dqpt136689;
        Tue, 26 Mar 2019 08:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=JtIGH4+9/c6cTyJvObA7CYZ2plDPcL5EYdqH6QgXHaE=;
 b=ExewmT0WZ5kmaCdZ0hH+wIhr76zl7U9/cQy1fbJtAfxbzAyp+Rk9JexeZ2fTWCIBva3x
 CbK3cCOD0rzvg5aP+i3BefJbjG+Vn5+2ayIn5fHXYhsO+gvELSzijNoit3H/ktGk2ObO
 p/+DNmNvve3tnGiSCrxt1VRXA8WyN0iHn62T4bdcgSIRKD2xqqqBlxafZzlSVZ4VRqvB
 XxTCjAnbdvhtTBaZaLoNM6ukwM4JAZvlTova+CUHgfjjH3m5R8HxK1t19FMq/bY3eFLN
 Gxx0OsCn81NFd0zM/fLVKsHv2CayU2suEBZrmPJHRUcDh5vPxKnEiFo1L6ACSJdZO2rH Og== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6dj8sd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:18:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8IlI5009685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:18:47 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q8IihD010823;
        Tue, 26 Mar 2019 08:18:44 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 01:18:43 -0700
Date:   Tue, 26 Mar 2019 11:18:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Kangjie Lu <kjlu@umn.edu>
Cc:     kbuild-all@01.org, kjlu@umn.edu, pakki001@umn.edu,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: sierra: fix a missing check of device_create_file
Message-ID: <20190326081831.GF32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324223920.961-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/usb-sierra-fix-a-missing-check-of-device_create_file/20190325-101328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

smatch warnings:
drivers/usb/storage/sierra_ms.c:199 sierra_ms_init() error: double free of 'swocInfo'

# https://github.com/0day-ci/linux/commit/04d66f3d072c3d14308aebecdbc0f2983ce443d2
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 04d66f3d072c3d14308aebecdbc0f2983ce443d2
vim +/swocInfo +199 drivers/usb/storage/sierra_ms.c

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
32fe5e393 Kevin Lloyd  2008-07-10  194  		kfree(swocInfo);
                                                        ^^^^^^^^^^^^^^^^

32fe5e393 Kevin Lloyd  2008-07-10  195  	}

break statement?

32fe5e393 Kevin Lloyd  2008-07-10  196  complete:
32fe5e393 Kevin Lloyd  2008-07-10  197  	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
04d66f3d0 Kangjie Lu   2019-03-24  198  	if (result) {
04d66f3d0 Kangjie Lu   2019-03-24 @199  		kfree(swocInfo);
                                                        ^^^^^^^^^^^^^^^
Double free.

04d66f3d0 Kangjie Lu   2019-03-24  200  		return result;
04d66f3d0 Kangjie Lu   2019-03-24  201  	}
32fe5e393 Kevin Lloyd  2008-07-10  202  
be475d902 Alan Stern   2009-05-21  203  	return 0;
32fe5e393 Kevin Lloyd  2008-07-10  204  }
32fe5e393 Kevin Lloyd  2008-07-10  205  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

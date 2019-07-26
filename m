Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20AC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAFE22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGZKY2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:24:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:38943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfGZKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:24:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 03:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="370022667"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2019 03:24:25 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 03:24:25 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 03:24:25 -0700
Received: from shsmsx107.ccr.corp.intel.com ([169.254.9.65]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.204]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 18:24:23 +0800
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Li, Lili" <lili.li@intel.com>
Subject: RE: [PATCH] platform: release resource itself instead of resource
 tree
Thread-Topic: [PATCH] platform: release resource itself instead of resource
 tree
Thread-Index: AQHVQu5PiIIVSehJMkWgCcRVEVUpkqbcq93Q
Date:   Fri, 26 Jul 2019 10:24:22 +0000
Message-ID: <840F6BCBBBA89F46BAD0D7D6EF39E6E350F5072A@SHSMSX107.ccr.corp.intel.com>
References: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
 <20190725133850.GB11115@kroah.com>
In-Reply-To: <20190725133850.GB11115@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTcwMTY1NWQtODI4Zi00ZDQwLTg2NWItMmVmYTVkNTAwOTQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQTJQTnlyNEJcL0ZjMFwvMUFuVkVla0Y4Q2xOaW52RGhic3hLcmFzcUh2dWt0eWUwYjBiaE5FOFJFMFhnRDR2UHorIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for looking at it.

Below example is simplified description. Our detail problem is:
1. ACPI driver registers a MEM resource during bootup;
2. Our PUNIT(Intel CPU power management module) platform device reads ACPI driver's resource, and registers same MEM resource;
3. According to current resource management logic, if two resources are same, later registered resource will be parent. That is, PUNIT platform device's resource will be ACPI driver resource's parent.
4. PUNIT kernel module is removed, its resource will be removed. If we use original API "release_resource", ACPI driver's resource will be released as well because it is PUNIT device's child;
5. Next time PUNIT platform device kernel module is inserted, it might read wrong ACPI MEM resource because it has been released in step 4.

How should we handle this case? :) 
We should not register same MEM resource in step 2? Or, make change in resource management logic, if two resources are same, later registered resource should be child instead of parent?

Thanks,
Junxiao

-----Original Message-----	
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Thursday, July 25, 2019 9:39 PM
To: Chang, Junxiao <junxiao.chang@intel.com>
Cc: linux-kernel@vger.kernel.org; rafael@kernel.org; Li, Lili <lili.li@intel.com>
Subject: Re: [PATCH] platform: release resource itself instead of resource tree

On Thu, Apr 25, 2019 at 02:24:18PM +0800, junxiao.chang@intel.com wrote:
> From: Junxiao Chang <junxiao.chang@intel.com>
> 
> When platform device is deleted or there is error in adding device, 
> platform device resources should be released. Currently API 
> release_resource is used to release platform device resources.
> However, this API releases not only platform resource itself but also 
> its child resources. It might release resources which are still in 
> use. Calling remove_resource only releases current resource itself, 
> not resource tree, it moves its child resources to up level.

But shouldn't the parent device not get removed until all of the children are removed?  What is causing this "inversion" to happen?

> 
> For example, platform device 1 and device 2 are registered, then only 
> device 1 is unregistered in below code:
> 
>   ...
>   // Register platform test device 1, resource 0xfed1a000 ~ 0xfed1afff
>   pdev1 = platform_device_register_full(&pdevinfo1);
> 
>   // Register platform test device 2, resource 0xfed1a200 ~ 0xfed1a2ff
>   pdev2 = platform_device_register_full(&pdevinfo2);
> 
>   // Now platform device 2 resource should be device 1 resource's 
> child
> 
>   // Unregister device 1 only
>   platform_device_unregister(pdev1);
>   ...

Don't do that.  :)

You created this mess of platform devices, so you need to keep track of them.


> Platform device 2 resource will be released as well because its parent 
> resource(device 1's resource) is released, this is not expected.
> If using API remove_resource, device 2 resource will not be released.
> 
> This change fixed an intel pmc platform device resource issue when 
> intel pmc ipc kernel module is inserted/removed for twice.

Why not fix that kernel module instead?  It seems like that is the real problem here, not a driver core issue.

thanks,

greg k-h

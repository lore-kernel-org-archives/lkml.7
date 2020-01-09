Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB453C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BF120673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgAII3B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:29:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:37574 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgAII3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:29:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 00:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="223807148"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 09 Jan 2020 00:29:00 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 00:29:00 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 00:29:00 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.201]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.38]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 10:28:57 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: bus: use simple sprintf for sysfs
Thread-Topic: [char-misc-next] mei: bus: use simple sprintf for sysfs
Thread-Index: AQHVpD4rc6pNNd3uI0Gbg1zkUnbit6fiQG+g
Date:   Thu, 9 Jan 2020 08:28:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DD64927@hasmsx108.ger.corp.intel.com>
References: <20191126123002.4835-1-tomas.winkler@intel.com>
In-Reply-To: <20191126123002.4835-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Replace scnprintf with simple sprintf for sysfs files.
> it is implicitly known that the buffer is big enough for the variables to fit in.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Hi Greg, hope you have great holiday,  has anything changed in the misc-char dev process,
no patches were staged including this one?
Thanks
Tomas


> ---
>  drivers/misc/mei/bus.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> a0a495c95e3c..8d468e0a950a 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -765,7 +765,7 @@ static ssize_t uuid_show(struct device *dev, struct
> device_attribute *a,
>  	struct mei_cl_device *cldev = to_mei_cl_device(dev);
>  	const uuid_le *uuid = mei_me_cl_uuid(cldev->me_cl);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%pUl", uuid);
> +	return sprintf(buf, "%pUl", uuid);
>  }
>  static DEVICE_ATTR_RO(uuid);
> 
> @@ -775,7 +775,7 @@ static ssize_t version_show(struct device *dev, struct
> device_attribute *a,
>  	struct mei_cl_device *cldev = to_mei_cl_device(dev);
>  	u8 version = mei_me_cl_ver(cldev->me_cl);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%02X", version);
> +	return sprintf(buf, "%02X", version);
>  }
>  static DEVICE_ATTR_RO(version);
> 
> @@ -797,7 +797,7 @@ static ssize_t max_conn_show(struct device *dev,
> struct device_attribute *a,
>  	struct mei_cl_device *cldev = to_mei_cl_device(dev);
>  	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d", maxconn);
> +	return sprintf(buf, "%d", maxconn);
>  }
>  static DEVICE_ATTR_RO(max_conn);
> 
> @@ -807,7 +807,7 @@ static ssize_t fixed_show(struct device *dev, struct
> device_attribute *a,
>  	struct mei_cl_device *cldev = to_mei_cl_device(dev);
>  	u8 fixed = mei_me_cl_fixed(cldev->me_cl);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d", fixed);
> +	return sprintf(buf, "%d", fixed);
>  }
>  static DEVICE_ATTR_RO(fixed);
> 
> @@ -817,7 +817,7 @@ static ssize_t max_len_show(struct device *dev, struct
> device_attribute *a,
>  	struct mei_cl_device *cldev = to_mei_cl_device(dev);
>  	u32 maxlen = mei_me_cl_max_len(cldev->me_cl);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u", maxlen);
> +	return sprintf(buf, "%u", maxlen);
>  }
>  static DEVICE_ATTR_RO(max_len);
> 
> --
> 2.21.0


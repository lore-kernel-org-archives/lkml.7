Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63702133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfJCVF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:05:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58274 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbfJCVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:05:58 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iG8IN-0001ua-S7
        for linux-kernel@vger.kernel.org; Thu, 03 Oct 2019 21:05:56 +0000
Received: by mail-pl1-f197.google.com with SMTP id f10so2508587plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pPlZt26qb0wHIw5ND/7Lf7nkXVZUbxI2YbcdOEBwCa4=;
        b=SSjJOA/oTFuh7oHWhc5oQVs5H6eCJ3SHKfBU9eRm7zum8nn+svzI1vrodoFMptINl7
         GERx/TXIFRrFBALr/uHgIpvbSqzEv56bCMirqGJXzv4V9y7qhwju7YCsocfy4CN6dfSN
         /u7GTCfNo2w4dW4CACJ9OrhoPY4Dcs4oZqFPvXWRoy5CzZwDEu5OmKGmx4cbUncF05vJ
         hxM+YTBkLRMAujZMH5AJ2aOBCWjRpQFwVTy/2ny4RnnbSFAQK3Us+LbrgCDYG05CFVPs
         eNBupRKbrTRJEKKf7yf5jqJRGzcArjQAnz4kXuZRK7eITP4QCynXOdMb1aTtnarkZIU5
         hefQ==
X-Gm-Message-State: APjAAAU+nImw1NVKRfg9I9K507VjZdkpH6fNd3uj12zITh7XUl+/3HC1
        TXP/2PVgI4vl5GZ1sY56se4ASujMuh4PqP/xeX9cqzsY/HehguH9RB9q10+ESKiV0O3hjDnPdsk
        csboprVJcvgR2lqBK9EZXLUZcfkYqj2ZBZTBV1fWwcw==
X-Received: by 2002:a63:161b:: with SMTP id w27mr11299787pgl.38.1570136753865;
        Thu, 03 Oct 2019 14:05:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1vA2sZlC3AuL9ZEpvvNi1p+Y6bOBTKrE3e5foppaeS60K7VOI7xCsNMrU/KlIn8K2gJr2UQ==
X-Received: by 2002:a63:161b:: with SMTP id w27mr11299756pgl.38.1570136753514;
        Thu, 03 Oct 2019 14:05:53 -0700 (PDT)
Received: from [192.168.0.179] (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id s1sm3781165pjs.31.2019.10.03.14.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:05:52 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: fix null dereference when kzalloc
 fails
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190927214415.899-1-connor.kuehl@canonical.com>
 <20191001131122.GC22609@kadam>
From:   Connor Kuehl <connor.kuehl@canonical.com>
Message-ID: <ac882530-4197-7813-ca24-49738eebb0c8@canonical.com>
Date:   Thu, 3 Oct 2019 14:05:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001131122.GC22609@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 6:11 AM, Dan Carpenter wrote:
> 
> There is another one earlier in the function as well.
> 
> drivers/staging/rtl8188eu/os_dep/usb_intf.c
>     336
>     337          pnetdev = rtw_init_netdev(padapter);
>     338          if (!pnetdev)
>     339                  goto free_adapter;
>     340          SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
>     341          padapter = rtw_netdev_priv(pnetdev);
>     342
>     343          if (padapter->registrypriv.monitor_enable) {
>     344                  pmondev = rtl88eu_mon_init();
>     345                  if (!pmondev)
>     346                          netdev_warn(pnetdev, "Failed to initialize monitor interface");
> 
> goto free_adapter.
> 
>     347                  padapter->pmondev = pmondev;
>     348          }
>     349
>     350          padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
>     351          if (!padapter->HalData)
>     352                  DBG_88E("cant not alloc memory for HAL DATA\n");
>     353
> 
>>   	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
>> -	if (!padapter->HalData)
>> -		DBG_88E("cant not alloc memory for HAL DATA\n");
>> +	if (!padapter->HalData) {
>> +		DBG_88E("Failed to allocate memory for HAL data\n");
> 
> Remove this debug printk.
> 
>> +		goto free_adapter;
>> +	}

Hi Dan,

Sorry for such a late response! By the time I saw the e-mail with your 
feedback I also saw another e-mail saying this patch was accepted into a 
staging-linus tree. I'll address your comments in a separate patch.

Thank you,

Connor


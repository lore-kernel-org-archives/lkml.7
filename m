Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C33C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF26214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfB1BT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:19:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730234AbfB1BT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:19:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D3B50513674B9E508D69;
        Thu, 28 Feb 2019 09:19:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 09:19:51 +0800
Subject: Re: [PATCH] appletalk: Fix use-after-free in atalk_proc_exit
To:     David Miller <davem@davemloft.net>
References: <20190227145900.28808-1-yuehaibing@huawei.com>
 <20190227.101459.1829634170038511470.davem@davemloft.net>
CC:     <joe@perches.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <0a430e08-b7ad-1f87-19a7-40429c09bba0@huawei.com>
Date:   Thu, 28 Feb 2019 09:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190227.101459.1829634170038511470.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/28 2:14, David Miller wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Wed, 27 Feb 2019 22:59:00 +0800
> 
>> @@ -1925,7 +1925,10 @@ static int __init atalk_init(void)
>>  
>>  	register_netdevice_notifier(&ddp_notifier);
>>  	aarp_proto_init();
>> -	atalk_proc_init();
>> +	rc = atalk_proc_init();
>> +	if (rc)
>> +		goto out;
>> +
>>  	atalk_register_sysctl();
>>  out:
> 
> This leaves the netdevice notifier registered etc.  You need to add a proper
> error cleanup code path.

Oh, yes, I will do it.

Thanks!

> 
> .
> 


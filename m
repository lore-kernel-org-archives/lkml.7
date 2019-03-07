Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95776C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6420661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCGCJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:09:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfCGCJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:09:29 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A55D589D0820E1F171AC;
        Thu,  7 Mar 2019 10:09:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 10:09:21 +0800
Subject: Re: [PATCH] appletalk: Correctly handle return value of
 register_snap_client
To:     David Miller <davem@davemloft.net>
References: <20190306072740.18760-1-yuehaibing@huawei.com>
 <20190306.101739.246616987743523058.davem@davemloft.net>
CC:     <joe@perches.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ef564906-fdb7-d167-1dbd-12f4321ad9f2@huawei.com>
Date:   Thu, 7 Mar 2019 10:09:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190306.101739.246616987743523058.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/7 2:17, David Miller wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Wed, 6 Mar 2019 15:27:40 +0800
> 
>> @@ -879,15 +879,17 @@ static struct notifier_block aarp_notifier = {
>>  
>>  static unsigned char aarp_snap_id[] = { 0x00, 0x00, 0x00, 0x80, 0xF3 };
>>  
>> -void __init aarp_proto_init(void)
>> +int __init aarp_proto_init(void)
>>  {
>>  	aarp_dl = register_snap_client(aarp_snap_id, aarp_rcv);
>> -	if (!aarp_dl)
>> -		printk(KERN_CRIT "Unable to register AARP with SNAP.\n");
>> +	if (!aarp_dl) {
>> +		pr_crit("Unable to register AARP with SNAP.\n");
>> +		return -ENOMEM;
>> +	}
>>  	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
>>  	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
>>  	add_timer(&aarp_timer);
>> -	register_netdevice_notifier(&aarp_notifier);
>> +	return register_netdevice_notifier(&aarp_notifier);
>>  }
>>  
> 
> Your error paths in the caller of aarp_proto_init() do not handle the case
> where aarp_dl is created by register_netdevice_notifier() fails.  You have
> to unregister aarp_dl if it is non-NULL.

Thanks, will fix this.

> 
> So your out_dev label path needs to handle aarp_dl if non-NULL.
> 
> Probably best is to jump to out_aarp: instead and make aarp_cleanup_module
> able to handle partial cleanups.
> 
> .
> 


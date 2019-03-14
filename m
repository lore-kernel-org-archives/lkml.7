Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6671720854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCNDSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:18:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfCNDSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:18:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 674919C719B5DB493064;
        Thu, 14 Mar 2019 11:18:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Mar 2019
 11:18:44 +0800
Subject: Re: [PATCH] appletalk: Fix potential NULL pointer dereference in
 unregister_snap_client
To:     David Miller <davem@davemloft.net>
References: <20190312020426.4824-1-yuehaibing@huawei.com>
 <20190313.140324.1217171685315730689.davem@davemloft.net>
CC:     <joe@perches.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <30fa0130-1a4d-39a1-05d7-130545d274e1@huawei.com>
Date:   Thu, 14 Mar 2019 11:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190313.140324.1217171685315730689.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/14 5:03, David Miller wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Tue, 12 Mar 2019 10:04:26 +0800
> 
>>  	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
>>  	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
>>  	add_timer(&aarp_timer);
>> -	register_netdevice_notifier(&aarp_notifier);
>> +	rc = register_netdevice_notifier(&aarp_notifier);
>> +	if (rc)
>> +		unregister_snap_client(aarp_dl);
>> +	return rc;
> 
> You've left the timer running in this error path.

Oops, sorry, I'll resend to fix it.
> 
> .
> 


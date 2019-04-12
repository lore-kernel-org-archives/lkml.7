Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E074C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDLN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLN3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CEA72C18AA1A5D68EE3;
        Fri, 12 Apr 2019 21:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.184.227.228) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 21:29:12 +0800
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Eric Dumazet <eric.dumazet@gmail.com>, <davem@davemloft.net>,
        <idosch@mellanox.com>, <alexander.h.duyck@intel.com>,
        <tyhicks@canonical.com>, <f.fainelli@gmail.com>,
        <viro@zeniv.linux.org.uk>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
 <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
From:   "wanghai (M)" <wanghai26@huawei.com>
Message-ID: <6108464a-fef4-c1c9-49ad-c2dd456476e9@huawei.com>
Date:   Fri, 12 Apr 2019 21:28:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/4/12 21:03, Eric Dumazet 写道:
>
> On 04/12/2019 01:36 PM, Wang Hai wrote:
>> When registering struct net_device, it will call
>>          register_netdevice ->
>>                  netdev_register_kobject ->
>>                          device_initialize(dev);
>>                          dev_set_name(dev, "%s", ndev->name)
>>                          device_add(dev)
>>                          register_queue_kobjects(ndev)
>>
>> In netdev_register_kobject(), if device_add(dev) or
>> register_queue_kobjects(ndev) failed. Register_netdevice()
>> will return error, causing netdev_freemem(ndev) to be
>> called to free net_device, however put_device(&dev->dev)->..->
>> kobject_cleanup() won't be called, resulting in a memory leak
>> which is alloced by dev_set_name()
>>
>>
>
> Having two patches with exact same title is rather confusing for bug trackers.
>
> Instead of revert + another_patch, why not just send a cumulative fix ?
>
Thanks, if I fix it, I will send a cumulative fix again



Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A920872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCSDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:40:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfCSDki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:40:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F3DFAC7685A2A99BC2A4;
        Tue, 19 Mar 2019 11:40:35 +0800 (CST)
Received: from [127.0.0.1] (10.184.227.228) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 11:40:31 +0800
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190319050657.61327-1-wanghai26@huawei.com>
 <20190318085724.1e0c017b@shemminger-XPS-13-9360>
 <cfc4b528-8bda-6823-cdf8-f4d12eb95c85@huawei.com>
 <20190318201546.7675e5ec@shemminger-XPS-13-9360>
From:   "wanghai (M)" <wanghai26@huawei.com>
Message-ID: <bff1b8d2-ee8a-ca5b-abab-06c3a876b170@huawei.com>
Date:   Tue, 19 Mar 2019 11:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318201546.7675e5ec@shemminger-XPS-13-9360>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/3/19 11:15, Stephen Hemminger 写道:
> On Tue, 19 Mar 2019 11:03:54 +0800
> "wanghai (M)" <wanghai26@huawei.com> wrote:
>
>> 在 2019/3/18 23:57, Stephen Hemminger 写道:
>>> On Tue, 19 Mar 2019 01:06:57 -0400
>>> Wang Hai <wanghai26@huawei.com> wrote:
>>>   
>>>> When registering struct net_device, it will call
>>>> 	register_netdevice ->
>>>> 		netdev_register_kobject ->
>>>> 			device_add(dev)
>>>> 			register_queue_kobjects(ndev)
>>>>
>>>> If device_add(dev) or register_queue_kobjects(ndev) fails.
>>>> Register_netdevice() will return error, causing netdev_freemem(ndev)
>>>> to be called to free net_device, however (&ndev->dev)->kobj.name will
>>>> not be freed, resulting in a memory leak.
>>>>
>>>> syzkaller report this:
>>>> BUG: memory leak
>>>> unreferenced object 0xffff8881f4fad168 (size 8):
>>>> comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
>>>> hex dump (first 8 bytes):
>>>>     77 70 61 6e 30 00 ff ff                          wpan0...
>>>> backtrace:
>>>>     [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
>>>>     [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
>>>>     [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:281
>>>>     [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
>>>>     [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/net-sysfs.c:1727
>>>>     [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:8711
>>>>     [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [ieee802154]
>>>>     [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee802154]
>>>>     [<00000000e4b3df51>] 0xffffffffc1500e0e
>>>>     [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/platform.c:614
>>>>     [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
>>>>     [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd.c:671
>>>>     [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/dd.c:945
>>>>     [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:1022
>>>>     [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
>>>>     [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:645
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")
>>>> Signed-off-by: Wang Hai <wanghai26@huawei.com>
>>>> ---
>>>>    net/core/net-sysfs.c | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>>>> index 4ff661f..f0e53dc 100644
>>>> --- a/net/core/net-sysfs.c
>>>> +++ b/net/core/net-sysfs.c
>>>> @@ -1745,17 +1745,22 @@ int netdev_register_kobject(struct net_device *ndev)
>>>>    
>>>>    	error = device_add(dev);
>>>>    	if (error)
>>>> -		return error;
>>>> +		goto device_add_error;
>>>>    
>>>>    	error = register_queue_kobjects(ndev);
>>>> -	if (error) {
>>>> -		device_del(dev);
>>>> -		return error;
>>>> -	}
>>>> +	if (error)
>>>> +		goto register_error;
>>>>    
>>>>    	pm_runtime_set_memalloc_noio(dev, true);
>>>>    
>>>> +out:
>>>>    	return error;
>>>> +
>>>> +register_error:
>>>> +	device_del(dev);
>>>> +device_add_error:
>>>> +	kfree_const(dev->kobj.name);
>>> This looks a bug in device_add() not here.
>>> In general, it is better for an api to clean up after itself.
>>> Since dev->kobj.name is created in device_add and normally freed
>>> in device_del; why is device_add leaving it behind?\
>> When registering struct net_device, it will call
>> register_netdevice ->
>>       netdev_register_kobject ->
>>           dev_set_name(dev, "%s", ndev->name)
>>            device_add(dev)
>>            register_queue_kobjects(ndev)
>>
>> The dev->kobj.name that causes the memory leak is created in
>> dev_set_name(dev, "%s", ndev-> name) in the function
>> netdev_register_kobject(), not in device_add(dev). If device_add(dev) or
>> register_queue_kobjects(ndev) fails, it should release dev-> kobj.name
>> in netdev_register_kobject()
> Good catch, dev_set_name is using asprintf to allocate new memory
> for the name. The problem with your patch is that device_del()
> already cleans up the device (including name). The device object
> should really not be touched after device_del.
>
> Where is the name freed in the normal case?
>
>
> .
Device_del just delete device from system, but do not clean up 
dev->kobj.name. In normal case,     the name is freed  in 
free_netdev(dev)->put_device(&dev->dev)->kobject_put(&dev->kobj)->kobject_cleanup() 
,not in device_del()


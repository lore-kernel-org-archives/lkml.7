Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E12C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9CE2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDLNei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:34:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbfDLNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:34:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 031D15F6F2AFFF48D216;
        Fri, 12 Apr 2019 21:34:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.227.228) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 21:34:30 +0800
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <viro@zeniv.linux.org.uk>,
        <amritha.nambiar@intel.com>, <joe@perches.com>,
        <dmitry.torokhov@gmail.com>, <stephen@networkplumber.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
 <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
 <20190412132002.GU9224@smile.fi.intel.com>
From:   "wanghai (M)" <wanghai26@huawei.com>
Message-ID: <de6a274c-a638-9ee8-83bc-b785857f0f0e@huawei.com>
Date:   Fri, 12 Apr 2019 21:33:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190412132002.GU9224@smile.fi.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/4/12 21:20, Andy Shevchenko Ð´µÀ:
> On Fri, Apr 12, 2019 at 06:03:27AM -0700, Eric Dumazet wrote:
>> On 04/12/2019 01:36 PM, Wang Hai wrote:
>>> When registering struct net_device, it will call
>>>          register_netdevice ->
>>>                  netdev_register_kobject ->
>>>                          device_initialize(dev);
>>>                          dev_set_name(dev, "%s", ndev->name)
>>>                          device_add(dev)
>>>                          register_queue_kobjects(ndev)
>>>
>>> In netdev_register_kobject(), if device_add(dev) or
>>> register_queue_kobjects(ndev) failed. Register_netdevice()
>>> will return error, causing netdev_freemem(ndev) to be
>>> called to free net_device, however put_device(&dev->dev)->..->
>>> kobject_cleanup() won't be called, resulting in a memory leak
>>> which is alloced by dev_set_name()
>>>
>>>
>>
>> Having two patches with exact same title is rather confusing for bug trackers.
>>
>> Instead of revert + another_patch, why not just send a cumulative fix ?
> The second patch is a reincarnation of the first version of the fix which has
> been discussed as not a correct approach. But revert should be applied sooner
> as the original commit brought a regression.

Thanks for letting me know. Now should I resend a separate revert, or do 
you just review the first patch?



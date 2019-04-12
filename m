Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333DAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0084320652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDLMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:09:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLMJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:09:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AF99B06097FA454D7BE;
        Fri, 12 Apr 2019 20:09:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.227.228) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 20:09:28 +0800
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <eric.dumazet@gmail.com>, <alexander.h.duyck@intel.com>,
        <tyhicks@canonical.com>, <f.fainelli@gmail.com>,
        <viro@zeniv.linux.org.uk>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
 <20190412083835.GG9224@smile.fi.intel.com>
From:   "wanghai (M)" <wanghai26@huawei.com>
Message-ID: <1c9542c4-08ba-24e6-6bb3-1aecc9741eec@huawei.com>
Date:   Fri, 12 Apr 2019 20:08:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190412083835.GG9224@smile.fi.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/4/12 16:38, Andy Shevchenko Ð´µÀ:
> On Fri, Apr 12, 2019 at 04:36:34PM -0400, Wang Hai wrote:
>
>> +error_register:
>> +	device_del(dev);
>> +error_device_add:
>> +	kfree_const(dev->kobj.name);
>>   	return error;
> When put_device() will be called on this it will go to double free (in case of
> dynamically allocated dev->kobj.name.
>
> Al Viro and me suggested earlier that the correct fix is to call put_device()
> in a places where it is appropriate.
Thanks. I'll take a closer look at the code to see when it's time to 
call put_device(). It's really not easy to fix.


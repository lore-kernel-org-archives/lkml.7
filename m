Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF7D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfDHEKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:10:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38418 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDHEKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:10:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55C5DACF789DC3F79613;
        Mon,  8 Apr 2019 12:10:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 12:10:39 +0800
Message-ID: <5CAAC9BD.5080400@huawei.com>
Date:   Mon, 8 Apr 2019 12:10:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <akpm@linux-foundation.org>, <rafael@kernel.org>,
        <david@redhat.com>, <rafael.j.wysocki@intel.com>,
        <mhocko@suse.com>, <osalvador@suse.de>
CC:     <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>,
        <bsingharora@gmail.com>, <gregkh@linuxfoundation.org>,
        <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memory_hotplug: Do not unlock when fails to take the
 device_hotplug_lock
References: <1554696012-9254-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1554696012-9254-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry,  It is incorrect.  please ignore the patch.  I will resent it.

Thanks,
zhong jiang
On 2019/4/8 12:00, zhong jiang wrote:
> When adding the memory by probing memory block in sysfs interface, there is an
> obvious issue that we will unlock the device_hotplug_lock when fails to takes it.
>
> That issue was introduced in Commit 8df1d0e4a265
> ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
>
> We should drop out in time when fails to take the device_hotplug_lock.
>
> Fixes: 8df1d0e4a265 ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
> Reported-by: Yang yingliang <yangyingliang@huawei.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/base/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index d9ebb89..8b0cec7 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -507,7 +507,7 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
> -		goto out;
> +		goto ret;
>  
>  	nid = memory_add_physaddr_to_nid(phys_addr);
>  	ret = __add_memory(nid, phys_addr,



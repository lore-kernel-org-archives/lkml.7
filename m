Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3678C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346A20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCYPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:20:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfCYPUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:20:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D811CBEAF8702F401B7;
        Mon, 25 Mar 2019 23:20:27 +0800 (CST)
Received: from [127.0.0.1] (10.184.227.228) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 23:20:19 +0800
Subject: Re: kernel BUG at net/core/net-sysfs.c:LINE!
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com>
CC:     <alexander.h.duyck@intel.com>, <amritha.nambiar@intel.com>,
        <davem@davemloft.net>, <dmitry.torokhov@gmail.com>,
        <f.fainelli@gmail.com>, <idosch@mellanox.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <stephen@networkplumber.org>, <syzkaller-bugs@googlegroups.com>,
        <tyhicks@canonical.com>, <yuehaibing@huawei.com>
References: <000000000000e644ba0584bdf7e8@google.com>
 <20190323171621.GF9224@smile.fi.intel.com>
From:   "wanghai (M)" <wanghai26@huawei.com>
Message-ID: <280fdb18-4948-968d-faa6-23197cd2b23e@huawei.com>
Date:   Mon, 25 Mar 2019 23:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190323171621.GF9224@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks , Can it be fixed like this?

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4ff661f..e609c8d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1745,16 +1745,21 @@ int netdev_register_kobject(struct net_device *ndev)

         error = device_add(dev);
         if (error)
-               return error;
+               goto error_put_device;

         error = register_queue_kobjects(ndev);
-       if (error) {
-               device_del(dev);
-               return error;
-       }
+       if (error)
+               goto error_device_del;

         pm_runtime_set_memalloc_noio(dev, true);

+       return 0;
+
+error_device_del:
+       device_del(dev);
+error_put_device:
+       ndev->reg_state = NETREG_RELEASED;
+       put_device(dev);
         return error;
  }

在 2019/3/24 1:16, Andy Shevchenko 写道:
> Nice.
>
> I looked briefly in the flow of this report and it looks like the patch above
> should be reverted.
>
> The problem is not so easy to fix. One approach is to initialize device
> (and thus kobject) somewhere in alloc_netdev() and put device in free_netdev()
> respectively, but this might produce more interesting regressions.


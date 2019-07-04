Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B8C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E162082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfGDEIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:08:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfGDEIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:08:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B0E9EF083ED150DA5E5;
        Thu,  4 Jul 2019 12:08:11 +0800 (CST)
Received: from [127.0.0.1] (10.65.94.163) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 12:08:03 +0800
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <20190704120235.5914499b@canb.auug.org.au>
 <20190704020418.GC32502@mellanox.com>
From:   wangxi <wangxi11@huawei.com>
Message-ID: <df072872-d0c3-a030-2237-d275f1147106@huawei.com>
Date:   Thu, 4 Jul 2019 12:07:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190704020418.GC32502@mellanox.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.94.163]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/7/4 10:04, Jason Gunthorpe Ð´µÀ:
> On Thu, Jul 04, 2019 at 12:02:35PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Mon, 1 Jul 2019 14:14:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Hi all,
>>>
>>> After merging the rdma tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
>>> see include/linux/module.h for more information
>> 	.
>> 	.
>> 	.
>>> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
>> 	.
>> 	.
>> 	.
>>> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
>>>
>>> Presumably caused by commit
>>>
>>>   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
>>>
>>> I have used the rdma tree from next-20190628 for today.
>>
>> I am still getting these errors/warnings.
> 
> I have not got a fixing patch from HNS team.
> 
> At this late date I will revert the problematic HNS patch tomorrow.
> There is indeed a mistake, I will append a patch as soon as possible.

The patch sent before has a problem caused by the merge of the local code. The correct one
should be as follows :

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index b956cf4..b06125f 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -9,8 +9,8 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
        hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o

 ifdef CONFIG_INFINIBAND_HNS_HIP06
-hns-roce-hw-v1-objs := hns_roce_hw_v1.o
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o $(hns-roce-objs)
+hns-roce-hw-v1-objs := hns_roce_hw_v1.o $(hns-roce-objs)
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o
 endif

> Jason
> .
> 


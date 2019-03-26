Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B562084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfCZJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:12:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbfCZJM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:12:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 17B4019390D44155C723;
        Tue, 26 Mar 2019 17:12:25 +0800 (CST)
Received: from [127.0.0.1] (10.184.212.80) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 17:12:13 +0800
Subject: Re: [PATCH] perf machine: Update kernel map address and re-order
 properly
To:     <acme@redhat.com>
CC:     Jiri Olsa <jolsa@redhat.com>, <jolsa@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <dsahern@gmail.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kim.phillips@arm.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
References: <20190228092003.34071-1-liwei391@huawei.com>
 <20190228112838.GC18636@krava>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <16b9191e-c444-8bdc-d23b-c4267440b3f2@huawei.com>
Date:   Tue, 26 Mar 2019 17:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228112838.GC18636@krava>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.212.80]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Please shoot a glance at this modification, i think this issue is influential.

On 2019/2/28 19:28, Jiri Olsa Wrote:
> On Thu, Feb 28, 2019 at 05:20:03PM +0800, Wei Li wrote:
>> Since commit 1fb87b8e9599 ("perf machine: Don't search for active kernel
>> start in __machine__create_kernel_maps"), the __machine__create_kernel_maps()
>> just create a map what start and end are both zero. Though the address will be
>> updated later, the order of map in the rbtree may be incorrect.
>>
>> The commit ee05d21791db ("perf machine: Set main kernel end address properly")
>> fixed the logic in machine__create_kernel_maps(), but it's still wrong in
>> function machine__process_kernel_mmap_event().
>>
>> To reproduce this issue, we need an environment which the module address
>> is before the kernel text segment. I tested it on an aarch64 machine with
>> kernel 4.19.25:
> 
> so that was the missing piece.. nice
> 
>>
>> [root@localhost hulk]# grep _stext /proc/kallsyms 
>> ffff000008081000 T _stext
>> [root@localhost hulk]# grep _etext /proc/kallsyms 
>> ffff000009780000 R _etext
>> [root@localhost hulk]# tail /proc/modules 
>> hisi_sas_v2_hw 77824 0 - Live 0xffff00000191d000
>> nvme_core 126976 7 nvme, Live 0xffff0000018b6000
>> mdio 20480 1 ixgbe, Live 0xffff0000018ab000
>> hisi_sas_main 106496 1 hisi_sas_v2_hw, Live 0xffff000001861000
>> hns_mdio 20480 2 - Live 0xffff000001822000
>> hnae 28672 3 hns_dsaf,hns_enet_drv, Live 0xffff000001815000
>> dm_mirror 40960 0 - Live 0xffff000001804000
>> dm_region_hash 32768 1 dm_mirror, Live 0xffff0000017f5000
>> dm_log 32768 2 dm_mirror,dm_region_hash, Live 0xffff0000017e7000
>> dm_mod 315392 17 dm_mirror,dm_log, Live 0xffff000001780000
>> [root@localhost hulk]# 
>>
>> Before fix:
>>
>> [root@localhost bin]# perf record sleep 3
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
>> [root@localhost bin]# perf buildid-list -i perf.data 
>> 4c4e46c971ca935f781e603a09b52a92e8bdfee8 [vdso]
>> [root@localhost bin]# perf buildid-list -i perf.data -H
>> 0000000000000000000000000000000000000000 /proc/kcore
>> [root@localhost bin]# 
>>
>> After fix:
>>
>> [root@localhost tools]# ./perf/perf record sleep 3
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
>> [root@localhost tools]# ./perf/perf buildid-list -i perf.data 
>> 28a6c690262896dbd1b5e1011ed81623e6db0610 [kernel.kallsyms]
>> 106c14ce6e4acea3453e484dc604d66666f08a2f [vdso]
>> [root@localhost tools]# ./perf/perf buildid-list -i perf.data -H
>> 28a6c690262896dbd1b5e1011ed81623e6db0610 /proc/kcore
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> good catch, thanks
> jirka
> 

Thanks,
Wei


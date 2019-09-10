Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949F0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A2A2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfIJK7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:59:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfIJK7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:59:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AE8AF3E82A8CAEC040C;
        Tue, 10 Sep 2019 18:59:20 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 18:59:12 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <mhocko@kernel.org>,
        <linuxarm@huawei.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
Date:   Tue, 10 Sep 2019 18:58:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190910093114.GA19821@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 17:31, Greg KH wrote:
> On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
>> On 2019/9/9 17:53, Greg KH wrote:
>>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
>>>> Currently a device does not belong to any of the numa nodes
>>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
>>>> specified by fw nor by virtual device layer and the device has
>>>> no parent device.
>>>
>>> Is this really a problem?
>>
>> Not really.
>> Someone need to guess the node id when it is not specified, right?
> 
> No, why?  Guessing guarantees you will get it wrong on some systems.
> 
> Are you seeing real problems because the id is not being set?  What
> problem is this fixing that you can actually observe?

When passing the return value of dev_to_node() to cpumask_of_node()
without checking the node id if the node id is not valid, there is
global-out-of-bounds detected by KASAN as below:

there are different checking to return value of dev_to_node(), I though
it is better to consistently do checking in cpumask_of_node(), then
discussion [1] [2] led to do the checking in device_add().

[   42.970381] ==================================================================
[   42.977595] BUG: KASAN: global-out-of-bounds in __bitmap_weight+0x48/0xb0
[   42.984370] Read of size 8 at addr ffff20008cdf8790 by task kworker/0:1/13
[   42.991230]
[   42.992712] CPU: 0 PID: 13 Comm: kworker/0:1 Tainted: G           O      5.2.0-rc4-g8bde06a-dirty #3
[   43.001830] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA BIOS 2280-A CS V2.B050.01 08/08/2019
[   43.011298] Workqueue: events work_for_cpu_fn
[   43.015643] Call trace:
[   43.018078]  dump_backtrace+0x0/0x1e8
[   43.021727]  show_stack+0x14/0x20
[   43.025031]  dump_stack+0xc4/0xfc
[   43.028335]  print_address_description+0x178/0x270
[   43.033113]  __kasan_report+0x164/0x1b8
[   43.036936]  kasan_report+0xc/0x18
[   43.040325]  __asan_load8+0x84/0xa8
[   43.043801]  __bitmap_weight+0x48/0xb0
[   43.047552]  hclge_init_ae_dev+0x988/0x1e78 [hclge]
[   43.052418]  hnae3_register_ae_dev+0xcc/0x278 [hnae3]
[   43.057467]  hns3_probe+0xe0/0x120 [hns3]
[   43.061464]  local_pci_probe+0x74/0xf0
[   43.065200]  work_for_cpu_fn+0x2c/0x48
[   43.068937]  process_one_work+0x3c0/0x878
[   43.072934]  worker_thread+0x400/0x670
[   43.076670]  kthread+0x1b0/0x1b8
[   43.079885]  ret_from_fork+0x10/0x18
[   43.083446]
[   43.084925] The buggy address belongs to the variable:
[   43.090052]  numa_distance+0x30/0x40
[   43.093613]
[   43.095091] Memory state around the buggy address:
[   43.099870]  ffff20008cdf8680: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 fa fa
[   43.107078]  ffff20008cdf8700: fa fa fa fa 04 fa fa fa fa fa fa fa 00 fa fa fa
[   43.114286] >ffff20008cdf8780: fa fa fa fa 00 00 00 00 00 00 00 00 fa fa fa fa
[   43.121494]                          ^
[   43.125230]  ffff20008cdf8800: 01 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
[   43.132439]  ffff20008cdf8880: fa fa fa fa fa fa fa fa 00 00 fa fa fa fa fa fa
[   43.139646] ==================================================================


[1] https://lore.kernel.org/patchwork/patch/1122081/
[2] https://lore.kernel.org/patchwork/patch/1122516/
> 
> thanks,
> 
> greg k-h
> 
> .
> 


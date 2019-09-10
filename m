Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE420872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbfIJGou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:44:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729634AbfIJGou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:44:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72061FB1A8AC2ACEDA3A;
        Tue, 10 Sep 2019 14:44:48 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 14:44:39 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <mhocko@kernel.org>,
        <linuxarm@huawei.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
Date:   Tue, 10 Sep 2019 14:43:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190909095347.GB6314@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/9 17:53, Greg KH wrote:
> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
>> Currently a device does not belong to any of the numa nodes
>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
>> specified by fw nor by virtual device layer and the device has
>> no parent device.
> 
> Is this really a problem?

Not really.
Someone need to guess the node id when it is not specified, right?
This patch chooses to guess the node id in the driver core.

> 
>> According to discussion in [1]:
>> Even if a device's numa node is not specified, the device really
>> does belong to a node.
> 
> But as we do not know the node, can we cause more harm by randomly
> picking one (i.e. putting it all in node 0)?
If we do not pick node 0 for device with invalid node, then caller need
to check the node id and pick one, and currently different callers
does a different checking:

1) some does " < 0" check;
2) some does "== NUMA_NO_NODE" check;
3) some does ">= MAX_NUMNODES" check;
4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.

and caller of dev_to_node() may pick one node based on below if the
dev_to_node() return a invalid node based on above checking:
1) based on numa_mem_id().
2) pick a random one like in workqueue_select_cpu_near().

If we pick node 0 for device with invalid node in device_add(), we
may avoid the above different checking and picking for caller, but we
may lose some caller context info, for example, user may use node of the
cpu on which the process is using the device to allocate the resource
close to the process, or user may pick a random one if they know what
they are doing.

It seems there is trade off here, as I can see, we can guess and pick the
node at different stage when it is not specified.
1. guess and pick node 0 at device_add(), it has the advantage of ensure
   all devices will have a valid node at very begin of device creation,
   so the user does not have to check and guess one, but user might lose
   the opportunity to do their own guessing and picking.

2. Maybe provide a dev_to_valid_node() to always return a valid node id,
   for example return numa_mem_id() if dev->numa_node is not valid.
   User know what they are doing can still use dev_to_node().

3. Caller of dev_to_node() do their own checking and picking, which
   might lead to adding more different and reduplicate checking as above.


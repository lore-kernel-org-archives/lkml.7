Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA6CC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB52089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfIKLEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:04:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfIKLEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:04:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C7FF3505FC5728DA15A;
        Wed, 11 Sep 2019 19:04:50 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 19:04:42 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Michal Hocko <mhocko@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <linuxarm@huawei.com>
References: <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz> <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz> <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
 <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
 <20190911073451.GM4023@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d828d48c-cae7-f3c2-fb2e-c8b25995cbef@huawei.com>
Date:   Wed, 11 Sep 2019 19:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190911073451.GM4023@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/11 15:34, Michal Hocko wrote:
> On Wed 11-09-19 15:22:30, Yunsheng Lin wrote:
> [...]
>> It seems that there is no protection that prevent setting the node
>> of device to an invalid node.
>> And the kernel does have a few different check now:
>> 1) some does " < 0" check;
>> 2) some does "== NUMA_NO_NODE" check;
>> 3) some does ">= MAX_NUMNODES" check;
>> 4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.
>>
>> We need to be consistent about the checking, right?
> 
> You can try and chase each of them and see what to do with them. I
> suspect they are a result of random attempts to fortify the code in many
> cases. Consistency is certainly good but spreading more checks all over
> the place just adds more cargo cult. Each check should be reasonably
> justified.

Ok, Let me focus on making the node_to_cpumask_map() NUMA_NO_NODE aware
by only checking "node == NUMA_NO_NODE" first.

> 


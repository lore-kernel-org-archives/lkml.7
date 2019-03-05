Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFA020823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCEBEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:04:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfCEBEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:04:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2556FCABBDA4635AD8E3;
        Tue,  5 Mar 2019 09:04:14 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Mar 2019
 09:04:07 +0800
Subject: Re: [PATCH net] net: hns3: add rmb() for rx description
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <shenjian15@huawei.com>
References: <1551516570-1067-1-git-send-email-tanhuazhong@huawei.com>
 <20190303.211518.1265133811120263144.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <2ca7e5e9-2d6a-4a76-8a33-eab28679a957@huawei.com>
Date:   Tue, 5 Mar 2019 09:04:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190303.211518.1265133811120263144.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/4 13:15, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Sat, 2 Mar 2019 16:49:30 +0800
> 
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> HW can not guarantee complete write desc->rx.size, even though
>> HNS3_RXD_VLD_B has been set. Driver needs to add rmb() instruction
>> to make sure desc->rx.size is always valid.
>>
>> Fixes: e55970950556 ("net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll")
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> 
> dma_rmb() is more appropriate here and more efficient.
> 

Thanks, will send V2  to fix it.

> .
> 


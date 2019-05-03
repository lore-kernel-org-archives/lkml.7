Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFAAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A06D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfECDNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:13:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:56144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbfECDNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:13:43 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 673BBD8C518546284565;
        Fri,  3 May 2019 11:13:40 +0800 (CST)
Received: from dggeme757-chm.china.huawei.com (10.3.19.103) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 3 May 2019 11:13:39 +0800
Received: from [127.0.0.1] (10.63.173.108) by dggeme757-chm.china.huawei.com
 (10.3.19.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 3
 May 2019 11:13:39 +0800
Reply-To: <lipeng321@huawei.com>
Subject: Re: [PATCH net-next 1/3] net: hns3: add support for multiple media
 type
References: <1556679944-100941-1-git-send-email-lipeng321@huawei.com>
 <1556679944-100941-2-git-send-email-lipeng321@huawei.com>
 <20190501123750.GA9844@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <1d7faec8-22f7-0e8f-7e38-9ad600134a7c@huawei.com>
Date:   Fri, 3 May 2019 11:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190501123750.GA9844@lunn.ch>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.173.108]
X-ClientProxiedBy: dggemx701-chm.china.huawei.com (10.1.199.48) To
 dggeme757-chm.china.huawei.com (10.3.19.103)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/1 20:37, Andrew Lunn wrote:
> On Wed, May 01, 2019 at 11:05:42AM +0800, Peng Li wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> Previously, we can only identify copper and fiber type, the
>> supported link modes of port information are always showing
>> SR type. This patch adds support for multiple media types,
>> include SR, LR CR, KR. Driver needs to query the media type
>> from firmware periodicly, and updates the port information.
>>
>> The new port information looks like this:
>> Settings for eth0:
>>          Supported ports: [ FIBRE ]
>>          Supported link modes:   25000baseCR/Full
>>                                  25000baseSR/Full
>>                                  1000baseX/Full
>>                                  10000baseCR/Full
>>                                  10000baseSR/Full
>>                                  10000baseLR/Full
>>          Supported pause frame use: Symmetric
>>          Supports auto-negotiation: No
>>          Supported FEC modes: None BaseR
>>          Advertised link modes:  25000baseCR/Full
>>                                  25000baseSR/Full
>>                                  1000baseX/Full
>>                                  10000baseCR/Full
>>                                  10000baseSR/Full
>>                                  10000baseLR/Full
> Hi Peng
>
> If it does not support auto-negotiation, do these advertised link
> modes make any sense? Does it really advertise, or is it all fixed
> configured?
>
> 	Andrew
>
> .
Hi Andrew:

it makes no sense when auto-negotiation is not supported.
I should handle it differently with the case supports auto-negotiation
and not supports auto-negotiation.

I will fix it in next version, result like below:
Settings for eth0:
         Supported ports: [ FIBRE ]
         Supported link modes:   25000baseCR/Full
                                 25000baseSR/Full
                                 1000baseX/Full
                                 10000baseCR/Full
                                 10000baseSR/Full
                                 10000baseLR/Full
         Supported pause frame use: Symmetric
         Supports auto-negotiation: No
         Supported FEC modes: None BaseR
         Advertised link modes:  Not reported
         Advertised pause frame use: No
         Advertised auto-negotiation: No
         Advertised FEC modes: Not reported
         Speed: 10000Mb/s
         Duplex: Full
         Port: FIBRE
         PHYAD: 0
         Transceiver: internal
         Auto-negotiation: off
         Current message level: 0x00000036 (54)
                                probe link ifdown ifup
         Link detected: yes

         Wish I have understood your comments correctly.


Thanks!


>



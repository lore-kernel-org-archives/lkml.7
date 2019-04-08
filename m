Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16552C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FA120879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDHB7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:59:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHB7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:59:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E6C88DD9DAC0FDAC442;
        Mon,  8 Apr 2019 09:59:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 09:59:00 +0800
Subject: Re: [PATCH net v2] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     David Ahern <dsa@cumulusnetworks.com>
CC:     Shrijeet Mukherjee <shrijeet@gmail.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>
References: <c0ee938d-479d-5c92-93ce-e06c24057b62@huawei.com>
 <18b082d4-cef9-bb39-0680-8187f6951bbc@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <e5440a50-e3b1-ec6c-d120-3680ca48f2b8@huawei.com>
Date:   Mon, 8 Apr 2019 09:58:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <18b082d4-cef9-bb39-0680-8187f6951bbc@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/7 22:30, David Ahern wrote:
> On 4/6/19 11:46 PM, linmiaohe wrote:
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 7c1430ed0244..4d35d37f225a 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -43,6 +43,12 @@
>>
>>  #define FIB_RULE_PREF  1000       /* default preference for FIB rules */
>>
>> +/* The MTU is really irrelevant for VRF except for odd cases, so limit it
>> + * to a reasonable range which both works for IPV4 and IPV6.
>> + */
>> +#define VRF_MIN_MTU	1280      /* same as IPV6_MIN_MTU */
>> +#define VRF_MAX_MTU	0xFFFFU   /* same as IP_MAX_MTU */
> 
> Since VRF does not care about MTU, there is no reason for VRF specific
> macros.
> 
>> +
>>  static unsigned int vrf_net_id;
>>
>>  struct net_vrf {
>> @@ -1274,8 +1280,8 @@ static void vrf_setup(struct net_device *dev)
>>  	/* default to no qdisc; user can add if desired */
>>  	dev->priv_flags |= IFF_NO_QUEUE;
>>
>> -	dev->min_mtu = 0;
>> -	dev->max_mtu = 0;
>> +	dev->min_mtu = VRF_MIN_MTU;
>> +	dev->max_mtu = VRF_MAX_MTU;
> 
> Set these to IPV6_MIN_MTU and ETH_MAX_MTU and add a comment that VRF
> devices do not care about MTU, but if the MTU is set too low then the
> ipv4 and ipv6 protocols are disabled which breaks networking.
> 
> 

Thanks a lot for your advice. I will send v3 latter.


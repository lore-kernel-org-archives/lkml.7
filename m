Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7586C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87877218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCWB6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:58:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbfCWB6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 21:58:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 936248CA12DE31206AB4;
        Sat, 23 Mar 2019 09:58:44 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 23 Mar 2019
 09:58:35 +0800
Subject: Re: [PATCH net] net: vrf: remove redundant vrf neigh entry
To:     David Ahern <dsa@cumulusnetworks.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
References: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
 <ad33efdf-2627-2b5e-978b-886e4771db49@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <d14e5c38-ca0c-1733-73dc-58bb7efc16cf@huawei.com>
Date:   Sat, 23 Mar 2019 09:58:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ad33efdf-2627-2b5e-978b-886e4771db49@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/22 23:50, David Ahern wrote:
> On 3/22/19 3:10 PM, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> When vrf->rth is created, it wouldn't change in his lifetime.And in
>> func vrf_finish_output, we always create a neigh with ip_hdr(skb)->daddr
>> as key because rth->rt_gateway is equal to 0. But I think we only need
>> one vrf neigh entry because we strip the ethernet header and reset the
>> dst_entry in vrf_process_v4_outbound.
>> So I set rth->rt_gateway to loopback addr(It's ok to set any other
>> valid ip address, just choose one.). And we would only create one vrf
>> neigh entry. This helps saving some memory and improving the hitting
>> rate of neigh lookup.
>> If there is something I misunderstand, it's very nice of you to
>> let me know. Thanks a lot.
>>
>> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
>> ---
>>  drivers/net/vrf.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 7c1430ed0244..2b0227fb8f53 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -738,6 +738,7 @@ static int vrf_rtable_create(struct net_device *dev)
>>  		return -ENOMEM;
>>
>>  	rth->dst.output	= vrf_output;
>> +	rth->rt_gateway = htonl(INADDR_LOOPBACK);
>>
>>  	rcu_assign_pointer(vrf->rth, rth);
>>
> 
> Did you investigate how neighbor entries are getting created? The vrf
> device has IFF_NOARP set, so neigh entries should not be created.
> 
> .
> 

Thanks a lot. I searched for how IFF_NOARP works, but I haven't
investigated how neighbor entries are getting created. I will pay
more effort to study neighbor subsystem and thanks for pointing out
that.


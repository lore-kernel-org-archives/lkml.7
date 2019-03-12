Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79547C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B47C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfCLGBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:01:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfCLGBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:01:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B09B1B46315D10A65593;
        Tue, 12 Mar 2019 14:01:45 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 14:01:38 +0800
Subject: Re: [PATCH net] net: sit: fix UBSAN Undefined behaviour in check_6rd
To:     David Miller <davem@davemloft.net>
CC:     <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingfangsen@huawei.com>
References: <694fb074-53a3-af60-6561-57c022445a48@huawei.com>
 <20190311.102937.1716496269975009682.davem@davemloft.net>
 <20190311.103037.1736601922338617214.davem@davemloft.net>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <09b205d5-c22c-377c-31af-effc68884098@huawei.com>
Date:   Tue, 12 Mar 2019 14:01:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311.103037.1736601922338617214.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's very nice of you. Thank you very much.

On 2019/3/12 1:30, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Mon, 11 Mar 2019 10:29:37 -0700 (PDT)
> 
>> From: linmiaohe <linmiaohe@huawei.com>
>> Date: Mon, 11 Mar 2019 16:29:32 +0800
>>
>>> @@ -778,8 +778,9 @@ static bool check_6rd(struct ip_tunnel *tunnel, const struct in6_addr *v6dst,
>>>  		pbw0 = tunnel->ip6rd.prefixlen >> 5;
>>>  		pbi0 = tunnel->ip6rd.prefixlen & 0x1f;
>>>
>>> -		d = (ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
>>> -		    tunnel->ip6rd.relay_prefixlen;
>>> +		d = tunnel->ip6rd.relay_prefixlen < 32 ?
>>> +			(ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
>>> +		    tunnel->ip6rd.relay_prefixlen : 0;
>>>
>>
>> I hate the fact that we have to guard against something which the rest
>> of the code makes sure NEVER EVER happens.
>>
>> Every assignment of ->relay_prefixlen is guarded by a check against 32.
> 
> Sorry, I now understand, it can equal 32.
> 
> I'll apply this, thank you.
> 
> .
> 


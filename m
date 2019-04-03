Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D881C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682892084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDCBdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:33:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfDCBdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:33:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [10.3.19.213])
        by Forcepoint Email with ESMTP id 9CB0B24D6067CA4EE54E;
        Wed,  3 Apr 2019 09:33:43 +0800 (CST)
Received: from [127.0.0.1] (10.184.191.73) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 09:33:36 +0800
Subject: Re: [PATCH v3 net] ipv6: Fix dangling pointer when ipv6 fragment
To:     Martin Lau <kafai@fb.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <mingfangsen@huawei.com>, <liuzhiqiang26@huawei.com>
References: <44e8dcf8-bf64-0407-65bb-122d0853c672@huawei.com>
 <201904021813.GLngbeGC%lkp@intel.com>
 <20190402153413.wyg5w4x33qvzqpm6@kafai-mbp.dhcp.thefacebook.com>
From:   hujunwei <hujunwei4@huawei.com>
Message-ID: <e86af888-a0aa-f725-2f1b-6eeee1c779a3@huawei.com>
Date:   Wed, 3 Apr 2019 09:32:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402153413.wyg5w4x33qvzqpm6@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.191.73]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/2 23:34, Martin Lau wrote:
> On Tue, Apr 02, 2019 at 06:49:03PM +0800, kbuild test robot wrote:
>> Hi hujunwei,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on net/master]
>>
>>
>> vim +/prevhdr +609 net//ipv6/ip6_output.c
>>
>>    594	
>>    595	int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>    596			 int (*output)(struct net *, struct sock *, struct sk_buff *))
>>    597	{
>>    598		struct sk_buff *frag;
>>    599		struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
>>    600		struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
>>    601					inet6_sk(skb->sk) : NULL;
>>    602		struct ipv6hdr *tmp_hdr;
>>    603		struct frag_hdr *fh;
>>    604		unsigned int mtu, hlen, left, len, nexthdr_offset;
>>    605		int hroom, troom;
>>    606		__be32 frag_id;
>>    607		int ptr, offset = 0, err = 0;
>>    608		u8 *prevhdr, nexthdr = 0;
>>  > 609		nexthdr_offset = prevhdr - skb_network_header(skb);
> hmm... This line has been moved up since v2. :(

Hi Martin,
Thank you for your remind, I sorry for this, i send the patch v4 yesterday.


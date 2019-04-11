Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1507EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7AD2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDKDjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:39:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbfDKDju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:39:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25B7BAA98A231BACCAC7;
        Thu, 11 Apr 2019 11:39:48 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 11:39:38 +0800
Subject: Re: [PATCH net] net: vrf: remove redundant vrf neigh entry
To:     David Ahern <dsa@cumulusnetworks.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
References: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
 <ad33efdf-2627-2b5e-978b-886e4771db49@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <c954d3b7-6ff7-a884-bbbb-fba4e9409b6f@huawei.com>
Date:   Thu, 11 Apr 2019 11:39:28 +0800
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
Hi,David A.,I investigate how neighbor entries are getting created recently.
But I can't find where neigh entries is not created when vrf device has
IFF_NOARP set.
So I add some printk info,and I ping the different host, here is the output:

[root@localhost ~]# ip vrf exec vrf1 ping 10.0.0.2
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.78 ms
^C
--- 10.0.0.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.776/1.776/1.776/0.000 ms
[root@localhost ~]# ip vrf exec vrf1 ping 11.0.0.2
PING 11.0.0.2 (11.0.0.2) 56(84) bytes of data.
64 bytes from 11.0.0.2: icmp_seq=1 ttl=64 time=1.59 ms
^C
--- 11.0.0.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.591/1.591/1.591/0.000 ms
[root@localhost ~]# ip vrf exec vrf1 ping 11.0.0.3
PING 11.0.0.3 (11.0.0.3) 56(84) bytes of data.
^C
--- 11.0.0.3 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

Apr 11 11:01:48 localhost kernel: [  337.311270] VRF: IFF_NOARP is set
Apr 11 11:01:48 localhost kernel: [  337.311279] VRF: nexthop = 200000a
Apr 11 11:01:48 localhost kernel: [  337.311284] VRF: neigh =           (null) after lookup
Apr 11 11:01:48 localhost kernel: [  337.311294] VRF: we create a neigh 000000001e8acd79
Apr 11 11:01:51 localhost kernel: [  340.026623] VRF: IFF_NOARP is set
Apr 11 11:01:51 localhost kernel: [  340.026627] VRF: nexthop = 200000b
Apr 11 11:01:51 localhost kernel: [  340.026631] VRF: neigh =           (null) after lookup
Apr 11 11:01:51 localhost kernel: [  340.026637] VRF: we create a neigh 00000000a0ad96da
Apr 11 11:01:56 localhost kernel: [  345.157529] VRF: IFF_NOARP is set
Apr 11 11:01:56 localhost kernel: [  345.157539] VRF: nexthop = 300000b
Apr 11 11:01:56 localhost kernel: [  345.157544] VRF: neigh =           (null) after lookup
Apr 11 11:01:56 localhost kernel: [  345.157556] VRF: we create a neigh 00000000a5167b56

And here is the printk code:

if (vrf_dev->flags & IFF_NOARP) {
    printk(KERN_ERR "VRF: IFF_NOARP is set\n");
    rth = rcu_dereference(vrf->rth);
    nexthop = (__force u32)rt_nexthop(rth, ip_hdr(skb)->daddr);
    printk(KERN_ERR "VRF: nexthop = %x\n", nexthop);
    neigh = __ipv4_neigh_lookup_noref(vrf_dev, nexthop);
    printk(KERN_ERR "VRF: neigh = %p after lookup\n", (void *)neigh);
    if (unlikely(!neigh)) {
        neigh = __neigh_create(&arp_tbl, &nexthop, vrf_dev, false);
        printk(KERN_ERR "VRF: we create a neigh %p\n", (void *)neigh);
    }
}

Could you please tell me if I was misunderstanding something again? It's very nice
of you if you can figure me out that. Thanks a lot.I am looking forward to your reply.


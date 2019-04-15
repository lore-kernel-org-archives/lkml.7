Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988BA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="fi9JWwAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfDOTZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33661 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbfDOTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so9049888pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u5cVf37ZSBSrmFmZ1QHquBZ0dAcfuAsJNF/mAhYOQi0=;
        b=fi9JWwAYPBjrScJAmLrkQZtHlLowhuti0lrs8I2kqvgQ6U1kUEufnqFmfndrEYMni0
         stuoRS4mi2JBTA5q0ToURWg5gvto2dyhtzJ4YCCrVm3cQOG8mwYtzmdKlpyQF3VTMPvk
         5E43X/++Bq697ACGKoPC/+DnDgrY8FgVkEElE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u5cVf37ZSBSrmFmZ1QHquBZ0dAcfuAsJNF/mAhYOQi0=;
        b=RKhmZvBe5bbrvQItNL0QmadDiGPE+VzsrxShHk+wMCsKcZYZPoRV/xa6S6o1wRODWz
         DWcjIfXBgk0mqoDqtffCSjlxliBNFz+IoLHXBn1wLm1MnwZhZ3hOWU+IXbmRq3DeZFgn
         s5DjDpk3iyrMGLqrdK43EzuYEIZaWWqtr9ugkvHaZRM4/dlZbESj0QuTQWMuMWnxyFHW
         Z6d2CUUUwLfRXfJF/973oOQegEnCbuMLl1o6Hh4s+YCIKbBCqL0lqBvuzWvklPYPCGWJ
         GAO1Y3lfY+GkA7niBE9CTs1Eow/Jr/oowcmSzVgbhmgy+3NPtl4CNFcafon+vHDk01t/
         ZWKQ==
X-Gm-Message-State: APjAAAWxm/LHFklWKeFD4Ni+bLW8jCTuJxhu5ZzONb0p55Th6thm1TJb
        Bx93uXGnaWhjNouNdpOEQSKslw==
X-Google-Smtp-Source: APXvYqwN4nJZSJxXA1fDFjhAIfOWCsn2mSlaDELFUJtm8cFX733Mn0I5ZhVT9aqj/IcI9+bz417BqA==
X-Received: by 2002:a63:af0a:: with SMTP id w10mr47197612pge.67.1555355108159;
        Mon, 15 Apr 2019 12:05:08 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:91ac:460f:1e02:116c? ([2601:282:800:fd80:91ac:460f:1e02:116c])
        by smtp.googlemail.com with ESMTPSA id l184sm119889775pfc.98.2019.04.15.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:05:07 -0700 (PDT)
Subject: Re: [PATCH net] net: vrf: remove redundant vrf neigh entry
To:     linmiaohe <linmiaohe@huawei.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
 <ad33efdf-2627-2b5e-978b-886e4771db49@cumulusnetworks.com>
 <c954d3b7-6ff7-a884-bbbb-fba4e9409b6f@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <d74701c7-852e-fe43-c747-b9954e2597e4@cumulusnetworks.com>
Date:   Mon, 15 Apr 2019 13:05:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c954d3b7-6ff7-a884-bbbb-fba4e9409b6f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 9:39 PM, linmiaohe wrote:
> 
> On 2019/3/22 23:50, David Ahern wrote:
>> On 3/22/19 3:10 PM, linmiaohe wrote:
>>> From: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> When vrf->rth is created, it wouldn't change in his lifetime.And in
>>> func vrf_finish_output, we always create a neigh with ip_hdr(skb)->daddr
>>> as key because rth->rt_gateway is equal to 0. But I think we only need
>>> one vrf neigh entry because we strip the ethernet header and reset the
>>> dst_entry in vrf_process_v4_outbound.
>>> So I set rth->rt_gateway to loopback addr(It's ok to set any other
>>> valid ip address, just choose one.). And we would only create one vrf
>>> neigh entry. This helps saving some memory and improving the hitting
>>> rate of neigh lookup.
>>> If there is something I misunderstand, it's very nice of you to
>>> let me know. Thanks a lot.
>>>
>>> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
>>> ---
>>>  drivers/net/vrf.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>> index 7c1430ed0244..2b0227fb8f53 100644
>>> --- a/drivers/net/vrf.c
>>> +++ b/drivers/net/vrf.c
>>> @@ -738,6 +738,7 @@ static int vrf_rtable_create(struct net_device *dev)
>>>  		return -ENOMEM;
>>>
>>>  	rth->dst.output	= vrf_output;
>>> +	rth->rt_gateway = htonl(INADDR_LOOPBACK);
>>>
>>>  	rcu_assign_pointer(vrf->rth, rth);
>>>
>>
>> Did you investigate how neighbor entries are getting created? The vrf
>> device has IFF_NOARP set, so neigh entries should not be created.
>>
>> .
>>
> Hi,David A.,I investigate how neighbor entries are getting created recently.
> But I can't find where neigh entries is not created when vrf device has
> IFF_NOARP set.
> So I add some printk info,and I ping the different host, here is the output:
> 
> [root@localhost ~]# ip vrf exec vrf1 ping 10.0.0.2
> PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
> 64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.78 ms
> ^C
> --- 10.0.0.2 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 1.776/1.776/1.776/0.000 ms
> [root@localhost ~]# ip vrf exec vrf1 ping 11.0.0.2
> PING 11.0.0.2 (11.0.0.2) 56(84) bytes of data.
> 64 bytes from 11.0.0.2: icmp_seq=1 ttl=64 time=1.59 ms
> ^C
> --- 11.0.0.2 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 1.591/1.591/1.591/0.000 ms
> [root@localhost ~]# ip vrf exec vrf1 ping 11.0.0.3
> PING 11.0.0.3 (11.0.0.3) 56(84) bytes of data.
> ^C
> --- 11.0.0.3 ping statistics ---
> 1 packets transmitted, 0 received, 100% packet loss, time 0ms
> 
> Apr 11 11:01:48 localhost kernel: [  337.311270] VRF: IFF_NOARP is set
> Apr 11 11:01:48 localhost kernel: [  337.311279] VRF: nexthop = 200000a
> Apr 11 11:01:48 localhost kernel: [  337.311284] VRF: neigh =           (null) after lookup
> Apr 11 11:01:48 localhost kernel: [  337.311294] VRF: we create a neigh 000000001e8acd79
> Apr 11 11:01:51 localhost kernel: [  340.026623] VRF: IFF_NOARP is set
> Apr 11 11:01:51 localhost kernel: [  340.026627] VRF: nexthop = 200000b
> Apr 11 11:01:51 localhost kernel: [  340.026631] VRF: neigh =           (null) after lookup
> Apr 11 11:01:51 localhost kernel: [  340.026637] VRF: we create a neigh 00000000a0ad96da
> Apr 11 11:01:56 localhost kernel: [  345.157529] VRF: IFF_NOARP is set
> Apr 11 11:01:56 localhost kernel: [  345.157539] VRF: nexthop = 300000b
> Apr 11 11:01:56 localhost kernel: [  345.157544] VRF: neigh =           (null) after lookup
> Apr 11 11:01:56 localhost kernel: [  345.157556] VRF: we create a neigh 00000000a5167b56
> 
> And here is the printk code:
> 
> if (vrf_dev->flags & IFF_NOARP) {
>     printk(KERN_ERR "VRF: IFF_NOARP is set\n");
>     rth = rcu_dereference(vrf->rth);
>     nexthop = (__force u32)rt_nexthop(rth, ip_hdr(skb)->daddr);
>     printk(KERN_ERR "VRF: nexthop = %x\n", nexthop);
>     neigh = __ipv4_neigh_lookup_noref(vrf_dev, nexthop);
>     printk(KERN_ERR "VRF: neigh = %p after lookup\n", (void *)neigh);
>     if (unlikely(!neigh)) {
>         neigh = __neigh_create(&arp_tbl, &nexthop, vrf_dev, false);
>         printk(KERN_ERR "VRF: we create a neigh %p\n", (void *)neigh);
>     }
> }
> 
> Could you please tell me if I was misunderstanding something again? It's very nice
> of you if you can figure me out that. Thanks a lot.I am looking forward to your reply.
> 

In the above statements you are passing vrf_dev to neigh_create, so of
course it is creating an entry against that device. That should not be
happening. When dst->dev is a vrf device it is for local traffic only
(locally originated to a local address) and there are no neighbor
entries for that. Otherwise, it is an enslaved device and the
neigh_create is always done with it.

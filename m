Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4670C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756A42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDCGwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:52:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfDCGwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:52:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [10.3.19.203])
        by Forcepoint Email with ESMTP id 8439B8A8C59DC589C27B;
        Wed,  3 Apr 2019 14:47:50 +0800 (CST)
Received: from [127.0.0.1] (10.184.191.73) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 14:47:39 +0800
Subject: Re: [PATCH v3 net] ipv6: Fix dangling pointer when ipv6 fragment
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@01.org>
CC:     <kbuild-all@01.org>, <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingfangsen@huawei.com>
References: <20190403050109.GH32613@kadam>
From:   hujunwei <hujunwei4@huawei.com>
Message-ID: <75978908-fbb7-764a-cac6-8be8ceff3ce4@huawei.com>
Date:   Wed, 3 Apr 2019 14:47:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403050109.GH32613@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.191.73]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/3 13:01, Dan Carpenter wrote:
> Hi hujunwei,
> 
> url:    https://github.com/0day-ci/linux/commits/hujunwei/ipv6-Fix-dangling-pointer-when-ipv6-fragment/20190402-175602
> 
> New smatch warnings:
> net/ipv6/ip6_output.c:609 ip6_fragment() error: uninitialized symbol 'prevhdr'.
> 
> Old smatch warnings:
> net/ipv6/ip6_output.c:247 ip6_xmit() error: we previously assumed 'np' could be null (see line 241)
> 
> # https://github.com/0day-ci/linux/commit/7f25fe5b3011737e52e4d8b4a2dfcafd46677115
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 7f25fe5b3011737e52e4d8b4a2dfcafd46677115
> vim +/prevhdr +609 net/ipv6/ip6_output.c
> 
> ^1da177e4 Linus Torvalds             2005-04-16  594  
> 7d8c6e391 Eric W. Biederman          2015-06-12  595  int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
> 7d8c6e391 Eric W. Biederman          2015-06-12  596  		 int (*output)(struct net *, struct sock *, struct sk_buff *))
> ^1da177e4 Linus Torvalds             2005-04-16  597  {
> ^1da177e4 Linus Torvalds             2005-04-16  598  	struct sk_buff *frag;
> adf30907d Eric Dumazet               2009-06-02  599  	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
> f60e5990d hannes@stressinduktion.org 2015-04-01  600  	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
> f60e5990d hannes@stressinduktion.org 2015-04-01  601  				inet6_sk(skb->sk) : NULL;
> ^1da177e4 Linus Torvalds             2005-04-16  602  	struct ipv6hdr *tmp_hdr;
> ^1da177e4 Linus Torvalds             2005-04-16  603  	struct frag_hdr *fh;
> 7f25fe5b3 Junwei Hu                  2019-04-02  604  	unsigned int mtu, hlen, left, len, nexthdr_offset;
> a7ae19922 Herbert Xu                 2011-11-18  605  	int hroom, troom;
> 286c2349f Martin KaFai Lau           2015-05-22  606  	__be32 frag_id;
> ^1da177e4 Linus Torvalds             2005-04-16  607  	int ptr, offset = 0, err = 0;
> ^1da177e4 Linus Torvalds             2005-04-16  608  	u8 *prevhdr, nexthdr = 0;
>                                                             ^^^^^^^^
> 7f25fe5b3 Junwei Hu                  2019-04-02 @609  	nexthdr_offset = prevhdr - skb_network_header(skb);
>                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> .
> 
Hi Dan,
Thank you for your remind, I sorry for this, i send the patch v4 yesterday. You can get it from the mail list.


Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B91C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F602206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DykLcDOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDCFGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:06:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDCFGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:06:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3354KWv171482;
        Wed, 3 Apr 2019 05:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=pZjVFXJWyd6UlS6QJIL5FiQ7IGJXcKe5DU8mUeBqtX8=;
 b=DykLcDOHl2z4/ILyAvopBqvyBSI/noP5FWTidSxSmeouhke0jkfiS3I18g9eWoNyq1u6
 OMHAS4koymXJKFvGTgOJ77VYyYHqnOwd6yyMEJ/hL9AVpQEvGqSY30PYkCqubuEFJViZ
 r6heexzxKqE9OT0R0NE1LXmQ8hVYwg9agQbFQWYqGz3yMqx7QOgSmB+dIByhDl6Nwils
 D1d88dPXE85yQI9erUp2uyNiDhjJFqsvqkBHlwSrMwNOb01kN7PuyrihhT5LTUgnwhjS
 sn+hEtYkNmnAEMGj38XFOR8kGrEwfm0N0G41aVTpRMofuUiBV4TRQibu5Ppv6CFS6DrH sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2rj0dnntk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 05:05:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x334xZ4W019174;
        Wed, 3 Apr 2019 05:01:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rm8f5vu81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 05:01:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3351Ksp017868;
        Wed, 3 Apr 2019 05:01:20 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 22:01:19 -0700
Date:   Wed, 3 Apr 2019 08:01:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, hujunwei <hujunwei4@huawei.com>
Cc:     kbuild-all@01.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com,
        liuzhiqiang26@huawei.com, zhangwenhao8@huawei.com,
        wangxiaogang3@huawei.com
Subject: Re: [PATCH v3 net] ipv6: Fix dangling pointer when ipv6 fragment
Message-ID: <20190403050109.GH32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e8dcf8-bf64-0407-65bb-122d0853c672@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030032
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hujunwei,

url:    https://github.com/0day-ci/linux/commits/hujunwei/ipv6-Fix-dangling-pointer-when-ipv6-fragment/20190402-175602

New smatch warnings:
net/ipv6/ip6_output.c:609 ip6_fragment() error: uninitialized symbol 'prevhdr'.

Old smatch warnings:
net/ipv6/ip6_output.c:247 ip6_xmit() error: we previously assumed 'np' could be null (see line 241)

# https://github.com/0day-ci/linux/commit/7f25fe5b3011737e52e4d8b4a2dfcafd46677115
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 7f25fe5b3011737e52e4d8b4a2dfcafd46677115
vim +/prevhdr +609 net/ipv6/ip6_output.c

^1da177e4 Linus Torvalds             2005-04-16  594  
7d8c6e391 Eric W. Biederman          2015-06-12  595  int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
7d8c6e391 Eric W. Biederman          2015-06-12  596  		 int (*output)(struct net *, struct sock *, struct sk_buff *))
^1da177e4 Linus Torvalds             2005-04-16  597  {
^1da177e4 Linus Torvalds             2005-04-16  598  	struct sk_buff *frag;
adf30907d Eric Dumazet               2009-06-02  599  	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
f60e5990d hannes@stressinduktion.org 2015-04-01  600  	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
f60e5990d hannes@stressinduktion.org 2015-04-01  601  				inet6_sk(skb->sk) : NULL;
^1da177e4 Linus Torvalds             2005-04-16  602  	struct ipv6hdr *tmp_hdr;
^1da177e4 Linus Torvalds             2005-04-16  603  	struct frag_hdr *fh;
7f25fe5b3 Junwei Hu                  2019-04-02  604  	unsigned int mtu, hlen, left, len, nexthdr_offset;
a7ae19922 Herbert Xu                 2011-11-18  605  	int hroom, troom;
286c2349f Martin KaFai Lau           2015-05-22  606  	__be32 frag_id;
^1da177e4 Linus Torvalds             2005-04-16  607  	int ptr, offset = 0, err = 0;
^1da177e4 Linus Torvalds             2005-04-16  608  	u8 *prevhdr, nexthdr = 0;
                                                            ^^^^^^^^
7f25fe5b3 Junwei Hu                  2019-04-02 @609  	nexthdr_offset = prevhdr - skb_network_header(skb);
                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
^1da177e4 Linus Torvalds             2005-04-16  610  
7dd7eb951 David S. Miller            2017-05-17  611  	err = ip6_find_1stfragopt(skb, &prevhdr);
                                                                                       ^^^^^^^^
7dd7eb951 David S. Miller            2017-05-17  612  	if (err < 0)
2423496af Craig Gallek               2017-05-16  613  		goto fail;
7dd7eb951 David S. Miller            2017-05-17  614  	hlen = err;
^1da177e4 Linus Torvalds             2005-04-16  615  	nexthdr = *prevhdr;
^1da177e4 Linus Torvalds             2005-04-16  616  
628a5c561 John Heffner               2007-04-20  617  	mtu = ip6_skb_dst_mtu(skb);
b881ef760 John Heffner               2007-04-20  618  
b881ef760 John Heffner               2007-04-20  619  	/* We must not fragment if the socket is set to force MTU discovery

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

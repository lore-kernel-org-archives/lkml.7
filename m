Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022D320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kh20bPJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfCFUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:25:06 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58912 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:25:06 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4CEE9891AF;
        Thu,  7 Mar 2019 09:25:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551903903;
        bh=daaW0MLXbAXvRvVtikSqxJR2yQKsYnPTwbJNM0RisC4=;
        h=From:To:CC:Subject:Date:References;
        b=kh20bPJF10Z1FLarO9EOlKAzu0gVOYDLGGl2dD//m321FFYVkFLycsxR2lT2I/UYC
         /TogMGusEJtKU9DpXRufoS4xiH81ViW/AWv4nw8uBDLUOyQkZUNfIN8vjMjjbd0wti
         sa4pKYWDU8tAz8NrUzOwgbZHeg5j8g7Fve4UgLEsm9fZR8uCygX/GyEPYXC0RK/DFm
         b4RIx7PzGcp3PI+4EBuQCypH+ErXG+i3u6sflC8YEVv1W88GgEvfmt47rTsC6zlEkq
         lIIYAyQfiQA6gOHa6vRd6VdREPo3VOMozRhnhNx7Q+UkkPZCk3yZ0j3C9O3alIzmb3
         lf/ssMvF+NzWw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c802c9f0001>; Thu, 07 Mar 2019 09:25:03 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 7 Mar 2019 09:25:03 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 7 Mar 2019 09:25:03 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Brodie Greenfield <Brodie.Greenfield@alliedtelesis.co.nz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luuk Paulussen" <Luuk.Paulussen@alliedtelesis.co.nz>
Subject: Re: [PATCH 2/2] ip6mr: Make cache queue length configurable
Thread-Topic: [PATCH 2/2] ip6mr: Make cache queue length configurable
Thread-Index: AQHU1FoDNb1gh95Ta0OWaTZ7nknt0w==
Date:   Wed, 6 Mar 2019 20:25:02 +0000
Message-ID: <f78eb1a745a74b81a10db4cc5ce3fb87@svr-chch-ex1.atlnz.lc>
References: <20190306201956.30248-1-brodie.greenfield@alliedtelesis.co.nz>
 <20190306201956.30248-3-brodie.greenfield@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/03/19 9:20 AM, Brodie Greenfield wrote:=0A=
> We want to be able to keep more spaces available in our queue for=0A=
> processing incoming IPv6 multicast traffic (adding (S,G) entries) - this=
=0A=
> lets us learn more groups faster, rather than dropping them at this stage=
.=0A=
> =0A=
> Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>=
=0A=
> ---=0A=
>   Documentation/networking/ip-sysctl.txt | 8 ++++++++=0A=
>   include/net/netns/ipv6.h               | 1 +=0A=
>   net/ipv6/af_inet6.c                    | 1 +=0A=
>   net/ipv6/ip6mr.c                       | 4 +++-=0A=
>   net/ipv6/sysctl_net_ipv6.c             | 7 +++++++=0A=
>   5 files changed, 20 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/netwo=
rking/ip-sysctl.txt=0A=
> index 02f77e932adf..68eada3ca915 100644=0A=
> --- a/Documentation/networking/ip-sysctl.txt=0A=
> +++ b/Documentation/networking/ip-sysctl.txt=0A=
> @@ -1481,6 +1481,14 @@ skip_notify_on_dev_down - BOOLEAN=0A=
>   	on userspace caches to track link events and evict routes.=0A=
>   	Default: false (generate message)=0A=
>   =0A=
> +ip_mr_cache_queue_length - INTEGER=0A=
=0A=
Should be "ip6_mr_cache_queue_length" for this patch.=0A=
=0A=
> +	Limit the number of multicast packets we can have in the queue to be=0A=
> +	resolved.=0A=
> +	Bear in mind that when an unresolved multicast packet is received,=0A=
> +	there is an O(n) traversal of the queue. This should be considered=0A=
> +	if increasing.=0A=
> +	Default: 10=0A=
> +=0A=
>   IPv6 Fragmentation:=0A=
>   =0A=
>   ip6frag_high_thresh - INTEGER=0A=
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h=0A=
> index ef1ed529f33c..84b58424c799 100644=0A=
> --- a/include/net/netns/ipv6.h=0A=
> +++ b/include/net/netns/ipv6.h=0A=
> @@ -46,6 +46,7 @@ struct netns_sysctl_ipv6 {=0A=
>   	int max_hbh_opts_len;=0A=
>   	int seg6_flowlabel;=0A=
>   	bool skip_notify_on_dev_down;=0A=
> +	unsigned int ip6_mr_cache_queue_length;=0A=
>   };=0A=
>   =0A=
>   struct netns_ipv6 {=0A=
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c=0A=
> index d99753b5e39b..6551bb63e5a2 100644=0A=
> --- a/net/ipv6/af_inet6.c=0A=
> +++ b/net/ipv6/af_inet6.c=0A=
> @@ -856,6 +856,7 @@ static int __net_init inet6_net_init(struct net *net)=
=0A=
>   	net->ipv6.sysctl.max_hbh_opts_cnt =3D IP6_DEFAULT_MAX_HBH_OPTS_CNT;=0A=
>   	net->ipv6.sysctl.max_dst_opts_len =3D IP6_DEFAULT_MAX_DST_OPTS_LEN;=0A=
>   	net->ipv6.sysctl.max_hbh_opts_len =3D IP6_DEFAULT_MAX_HBH_OPTS_LEN;=0A=
> +	net->ipv6.sysctl.ip6_mr_cache_queue_length =3D 10;=0A=
>   	atomic_set(&net->ipv6.fib6_sernum, 1);=0A=
>   =0A=
>   	err =3D ipv6_init_mibs(net);=0A=
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c=0A=
> index cc01aa3f2b5e..bb445871437e 100644=0A=
> --- a/net/ipv6/ip6mr.c=0A=
> +++ b/net/ipv6/ip6mr.c=0A=
> @@ -1135,6 +1135,7 @@ static int ip6mr_cache_report(struct mr_table *mrt,=
 struct sk_buff *pkt,=0A=
>   static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,=0A=
>   				  struct sk_buff *skb, struct net_device *dev)=0A=
>   {=0A=
> +	struct net *net =3D dev_net(dev);=0A=
>   	struct mfc6_cache *c;=0A=
>   	bool found =3D false;=0A=
>   	int err;=0A=
> @@ -1153,7 +1154,8 @@ static int ip6mr_cache_unresolved(struct mr_table *=
mrt, mifi_t mifi,=0A=
>   		 *	Create a new entry if allowable=0A=
>   		 */=0A=
>   =0A=
> -		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D 10 ||=0A=
> +		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D=0A=
> +		    net->ipv6.sysctl.ip6_mr_cache_queue_length ||=0A=
>   		    (c =3D ip6mr_cache_alloc_unres()) =3D=3D NULL) {=0A=
>   			spin_unlock_bh(&mfc_unres_lock);=0A=
>   =0A=
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c=0A=
> index e15cd37024fd..a27299d4cc34 100644=0A=
> --- a/net/ipv6/sysctl_net_ipv6.c=0A=
> +++ b/net/ipv6/sysctl_net_ipv6.c=0A=
> @@ -159,6 +159,13 @@ static struct ctl_table ipv6_table_template[] =3D {=
=0A=
>   		.mode		=3D 0644,=0A=
>   		.proc_handler	=3D proc_dointvec=0A=
>   	},=0A=
> +	{=0A=
> +		.procname	=3D "ip6_mr_cache_queue_length",=0A=
> +		.data		=3D &init_net.ipv6.sysctl.ip6_mr_cache_queue_length,=0A=
> +		.maxlen		=3D sizeof(int),=0A=
> +		.mode		=3D 0644,=0A=
> +		.proc_handler	=3D proc_dointvec=0A=
> +	},=0A=
>   	{ }=0A=
>   };=0A=
>   =0A=
> =0A=
=0A=

Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63538C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8121852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="C4TZ9EfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZLPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:15:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:15:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so54006366wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E7BasOFtlQFe4XW94Jqld+ckhXHp1SQC8I6+9qrklUE=;
        b=C4TZ9EfHkoWGJWuZe6ayE8JaaFIZNeL9+UD1H3fhSDiJm0066aDQZ20qupKny6cyzz
         4A8NSI2rFyQfHNyKdxYslD/g8ZkOZqruxwjXNsU4aGe9iIC70Q+eNojLnw79hHRVOhXf
         vtukS7lb0wAzY59+oYpj62qMuKn1hpp/lxesI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7BasOFtlQFe4XW94Jqld+ckhXHp1SQC8I6+9qrklUE=;
        b=brEQWW26gSNmXJFMtHCgWI4WAQNM6mQ+YGWHIZ5PMgGc1kt0jozN9lVx3E7mgR77Wr
         t4DIGYK4WfVtGLN2l7RfWDrh1VtUrj1mM2VXdGmxxqzZ9/jP99RBx598bl708iMDzPiL
         5OiutALPfUms7nsp/jDe8EAMbryOLcnbUHf8m7K8hTrqC4FSYbg5mkgp3s3Lwo+RLunj
         UjA5oqNLe5YUF1N6Xv0CeQFcxyYOtVO9bRWSI8RTbU4J/BR8aHkLA/QBTZ674BPdx9Tx
         bnpeFow1mPw6FnHQd/8/eYe2RXnM7AaJ2YNz5QBhB8R2QUnyJ/jk+P5TScmfsDWfCNgg
         A9Uw==
X-Gm-Message-State: APjAAAXA05dKPryh4uBxu7R7L2N+wBtBVyArjYgCkePpHZO3DlH2YdGT
        rXjkvFb5u+Tt792BjXCGcRTXzQ==
X-Google-Smtp-Source: APXvYqzcKpOmbNbutKT36OrxXTcQ/eiCgrUI+llMm0RJpP1au9/nkPjo7SKfJ6wef4NUKEptJo6hZA==
X-Received: by 2002:adf:de90:: with SMTP id w16mr4681653wrl.217.1564139731493;
        Fri, 26 Jul 2019 04:15:31 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id z25sm56120034wmf.38.2019.07.26.04.15.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 04:15:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] ipmr: Make cache queue length configurable
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To:     Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>,
        davem@davemloft.net, stephen@networkplumber.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz
References: <20190725204230.12229-1-brodie.greenfield@alliedtelesis.co.nz>
 <20190725204230.12229-2-brodie.greenfield@alliedtelesis.co.nz>
 <e5606cf7-6848-1109-6cbe-63d94868ed65@cumulusnetworks.com>
Message-ID: <6e8c51a0-cd34-e14a-7661-6fa5945f278b@cumulusnetworks.com>
Date:   Fri, 26 Jul 2019 14:15:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e5606cf7-6848-1109-6cbe-63d94868ed65@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 14:05, Nikolay Aleksandrov wrote:
> On 25/07/2019 23:42, Brodie Greenfield wrote:
>> We want to be able to keep more spaces available in our queue for
>> processing incoming multicast traffic (adding (S,G) entries) - this lets
>> us learn more groups faster, rather than dropping them at this stage.
>>
>> Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
>> ---
>>  Documentation/networking/ip-sysctl.txt | 8 ++++++++
>>  include/net/netns/ipv4.h               | 1 +
>>  net/ipv4/af_inet.c                     | 1 +
>>  net/ipv4/ipmr.c                        | 4 +++-
>>  net/ipv4/sysctl_net_ipv4.c             | 7 +++++++
>>  5 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
>> index acdfb5d2bcaa..02f77e932adf 100644
>> --- a/Documentation/networking/ip-sysctl.txt
>> +++ b/Documentation/networking/ip-sysctl.txt
>> @@ -887,6 +887,14 @@ ip_local_reserved_ports - list of comma separated ranges
>>  
>>  	Default: Empty
>>  
>> +ip_mr_cache_queue_length - INTEGER
>> +	Limit the number of multicast packets we can have in the queue to be
>> +	resolved.
>> +	Bear in mind that when an unresolved multicast packet is received,
>> +	there is an O(n) traversal of the queue. This should be considered
>> +	if increasing.
>> +	Default: 10
>> +
> 
> Hi,
> You've said it yourself - it has linear traversal time, but doesn't this patch allow any netns on the
> system to increase its limit to any value, thus possibly affecting others ?
> Though the socket limit will kick in at some point. I think that's where David
> was going with his suggestion back in 2018:
> https://www.spinics.net/lists/netdev/msg514543.html
> 
> If we add this sysctl now, we'll be stuck with it. I'd prefer David's suggestion
> so we can rely only on the receive queue queue limit which is already configurable. 
> We still need to be careful with the defaults though, the NOCACHE entry is 128 bytes
> and with the skb overhead currently on my setup we end up at about 277 entries default limit.

I mean that people might be surprised if they increased that limit by default, that's the
only problem I'm not sure how to handle. Maybe we need some hard limit anyway.
Have you done any tests what value works for your setup ?

In the end we might have to go with this patch, but perhaps limit the per-netns sysctl
to the init_ns value as maximum (similar to what we did for frags) or don't make it per-netns
at all.

> 
> Cheers,
>  Nik
> 
>>  ip_unprivileged_port_start - INTEGER
>>  	This is a per-namespace sysctl.  It defines the first
>>  	unprivileged port in the network namespace.  Privileged ports
>> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
>> index 104a6669e344..3411d3f18d51 100644
>> --- a/include/net/netns/ipv4.h
>> +++ b/include/net/netns/ipv4.h
>> @@ -187,6 +187,7 @@ struct netns_ipv4 {
>>  	int sysctl_igmp_max_msf;
>>  	int sysctl_igmp_llm_reports;
>>  	int sysctl_igmp_qrv;
>> +	unsigned int sysctl_ip_mr_cache_queue_length;
>>  
>>  	struct ping_group_range ping_group_range;
>>  
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 0dfb72c46671..8e25538bdb1e 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1827,6 +1827,7 @@ static __net_init int inet_init_net(struct net *net)
>>  	net->ipv4.sysctl_igmp_llm_reports = 1;
>>  	net->ipv4.sysctl_igmp_qrv = 2;
>>  
>> +	net->ipv4.sysctl_ip_mr_cache_queue_length = 10;
>>  	return 0;
>>  }
>>  
>> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
>> index ddbf8c9a1abb..c6a6c3e453a9 100644
>> --- a/net/ipv4/ipmr.c
>> +++ b/net/ipv4/ipmr.c
>> @@ -1127,6 +1127,7 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>>  				 struct sk_buff *skb, struct net_device *dev)
>>  {
>>  	const struct iphdr *iph = ip_hdr(skb);
>> +	struct net *net = dev_net(dev);
>>  	struct mfc_cache *c;
>>  	bool found = false;
>>  	int err;
>> @@ -1142,7 +1143,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>>  
>>  	if (!found) {
>>  		/* Create a new entry if allowable */
>> -		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
>> +		if (atomic_read(&mrt->cache_resolve_queue_len) >=
>> +		    net->ipv4.sysctl_ip_mr_cache_queue_length ||
>>  		    (c = ipmr_cache_alloc_unres()) == NULL) {
>>  			spin_unlock_bh(&mfc_unres_lock);
>>  
>> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
>> index ba0fc4b18465..78ae86e8c6cb 100644
>> --- a/net/ipv4/sysctl_net_ipv4.c
>> +++ b/net/ipv4/sysctl_net_ipv4.c
>> @@ -784,6 +784,13 @@ static struct ctl_table ipv4_net_table[] = {
>>  		.proc_handler	= proc_dointvec
>>  	},
>>  #ifdef CONFIG_IP_MULTICAST
>> +	{
>> +		.procname	= "ip_mr_cache_queue_length",
>> +		.data		= &init_net.ipv4.sysctl_ip_mr_cache_queue_length,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec
>> +	},
>>  	{
>>  		.procname	= "igmp_qrv",
>>  		.data		= &init_net.ipv4.sysctl_igmp_qrv,
>>
> 


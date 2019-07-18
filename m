Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C749C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1B21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVybyDuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391506AbfGRWMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:12:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39271 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:12:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so14585651pls.6;
        Thu, 18 Jul 2019 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L/vMBz0gKnDGWIBpHaUwZO2m9oAQAiDwzG+wKapV5/Q=;
        b=gVybyDuC2n3eMfkAefaFlUXrdWd3Mo7xsiB0WsZsrYcbWz+rbFNseuDWQtnBEtgZys
         soMYBS/qS9hRBVnHbiAqpqh4teMp5iblh+CdHe3zMn85t0ORATz1XV+amMC2jdXEEig6
         1k2lBXVY6wFTdVwmn41/QzXxiZ375MQ3AtCYKMQmU7jKCbeADNyUeFUptaZnbUC7UU9n
         W4Z9Ax8yx6Sk0lGnRnozfnbCZAf9hNtszurlznEombj6NDqNbHrndkD7GAqZJs+vCKih
         Qci+/VwhiXtp4mxOI6etOwDeZVwCs5Mo4BqDxe5AFg4vV30UGOm26dlTexAGgAQslw45
         A4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L/vMBz0gKnDGWIBpHaUwZO2m9oAQAiDwzG+wKapV5/Q=;
        b=S9eh9bu+or4iig0O5dZ+6P06G38slEFBHrjOVIsuJxK0IODn0UURFqIp4iIwQVdrsl
         E7ZkeuB+SVsel17xekMCqKsEnJQxQYd1oJ/1I7oq0Jf0PVj7iicPm0i2StXTW0fGaTER
         zUBKWBAsITOFr3iyVf5rtH01TOiajt2AlezUk/H4/e+PIwllJ/UFpNOWrcERU9wdFb82
         6jkvAqY+FbJ4QhBN/IpvF/NfUQAO768Xx1d4or6u9mpKV1zBLP4As+ptTEbTmSSy/qmm
         F2Qhl6LXlcfIMR7YsVg7WKKApOPQ1A9WCzkTcH3vkRZutTnSYWrzNzMF3mbslnEnIIN0
         OZOA==
X-Gm-Message-State: APjAAAUIhmRkXJHUQ7sGV2ksNANYIOYGIiGqebkng5mwJnAEQyHVeE+R
        EG7jDY6lSQge0q0P3wC0RjfcqgWm
X-Google-Smtp-Source: APXvYqyHtZ8S2jkiyXV6GCBLDCKazxSrCXu8T+rQHac346xoL2SmZAxYy5p3790nH0uYew+aQggeZQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr50346469plb.316.1563487965642;
        Thu, 18 Jul 2019 15:12:45 -0700 (PDT)
Received: from [192.168.0.16] ([97.115.142.179])
        by smtp.gmail.com with ESMTPSA id j128sm13832489pfg.28.2019.07.18.15.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 15:12:45 -0700 (PDT)
Subject: Re: [PATCH] openvswitch: Fix a possible memory leak on dst_cache
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1563466028-2531-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
From:   Gregory Rose <gvrose8192@gmail.com>
Message-ID: <9b231232-dd6e-5733-2af9-e2fb3d6ae0a4@gmail.com>
Date:   Thu, 18 Jul 2019 15:12:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563466028-2531-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2019 9:07 AM, Haishuang Yan wrote:
> dst_cache should be destroyed when fail to add flow actions.
>
> Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
>   net/openvswitch/flow_netlink.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index d7559c6..1fd1cdd 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2608,6 +2608,7 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
>   			 sizeof(*ovs_tun), log);
>   	if (IS_ERR(a)) {
>   		dst_release((struct dst_entry *)tun_dst);
> +		dst_cache_destroy(&tun_dst->u.tun_info.dst_cache);
>   		return PTR_ERR(a);
>   	}
>   

Nack.

dst_release will decrement the ref count and will 
call_rcu(&dst->rcu_head, dst_destroy_rcu) if the ref count is zero.  No 
other net drivers call dst_destroy SFAICT.

Haishuang,

are you trying to fix some specific problem here?

Thanks,

- Greg



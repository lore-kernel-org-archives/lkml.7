Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61194C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC392238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FH1O0W8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGZJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:15:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfGZJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:15:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so53731112wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9r9uyuQRxfZKsoTfi+2znRv6sD15zYzQ2hWxzsI8gkU=;
        b=FH1O0W8U9KDswyjDE9zBBKyiW+8HqfR5iTgIt4qJ9Y3AGO+xa5LRQKGEPJ0seda+4v
         HI+s51qtGlL3qrvNl8cMfjrZNb57Bj0BioHtSus10VSR5cQsEcQA5S3iwfpwBIlvoYm3
         P3U8b4ZpT3T8QnLmGboYhMHszdu3Y9s3gwcSmPgolImcipQBpTkidyJNeMXy9o+8msfI
         mgAGuPxuMU5sRLjLUes9hrVEkUssc0vwOw4IIhoV1t5MNgV4H8CF4e8Pf/LXRUmjRt0w
         ozpM2Q1hmcRGR2fwAJ7Qqub+f1zyeq7jr8/GmNhA9Pa3kOSKbxN5m0YE9iw04Iv7La7J
         sYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9r9uyuQRxfZKsoTfi+2znRv6sD15zYzQ2hWxzsI8gkU=;
        b=c4roqAgWYPjWtGc9V7YJK+UMnY0a6Kh2FVK6f8LkjF48Ds/DgFaSvAcSjmJmjx/7BZ
         e6Bd9cL6wvHPT2diVE2xGeE9EY8hD/3zPq3UMqnOjEwCH8g/8dLJQEIC5YzNAAZMLIne
         VdhngJfZnMbaLP1VKlUcVq3cGyqlDCrRj6hHIec3HCHh7kohrqJdbuqwcj4W8ULLYy28
         SPzr/jkkBGaRrE1KGzgjtstUKhuj8E9j05ICoMSVh+G6AylaM1VptQMK6zuBULHUd6i/
         2ArVBbNfyBnbX9zTLPYFPzohals/opEYd3k8g7pSJbxp7ljGAZv6K8UVGC5pBxs/ST6E
         zStA==
X-Gm-Message-State: APjAAAV/i9yrE0BlhHzFnna59HL6V6LUtE8Oi2J3uj+IffxlNHxZFTL5
        gmhhF1jRdR3YtlnI52hmnP8RSG0F1fY=
X-Google-Smtp-Source: APXvYqxz+P+obXJh82sven9XrOIR1qZjORt5FUejMPL60HgvSTlqEnklEnW7LYq1aLEaXt1KO3iw5g==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr33329547wrq.110.1564132556971;
        Fri, 26 Jul 2019 02:15:56 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:9d:caad:2868:a68c? ([2a01:e35:8b63:dc30:9d:caad:2868:a68c])
        by smtp.gmail.com with ESMTPSA id f12sm57268364wrg.5.2019.07.26.02.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:15:56 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 1/2] net: ipv4: Fix a possible null-pointer dereference in
 inet_csk_rebuild_route()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190726022534.24994-1-baijiaju1990@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <64986d3e-3ee8-896f-0261-3d9cc595ba11@6wind.com>
Date:   Fri, 26 Jul 2019 11:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726022534.24994-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/07/2019 à 04:25, Jia-Ju Bai a écrit :
> In inet_csk_rebuild_route(), rt is assigned to NULL on line 1071.
> On line 1076, rt is used:
>     return &rt->dst;
> Thus, a possible null-pointer dereference may occur.>
> To fix this bug, rt is checked before being used.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index f5c163d4771b..27d9d80f3401 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1073,7 +1073,10 @@ static struct dst_entry *inet_csk_rebuild_route(struct sock *sk, struct flowi *f
>  		sk_setup_caps(sk, &rt->dst);
>  	rcu_read_unlock();
>  
> -	return &rt->dst;
> +	if (rt)
> +		return &rt->dst;
> +	else
> +		return NULL;
Hmm, ->dst is the first field (and that will never change), thus &rt->dst is
NULL if rt is NULL.
I don't think there is a problem with the current code.


Regards,
Nicolas

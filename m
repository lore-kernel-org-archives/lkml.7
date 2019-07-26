Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAEC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036E020659
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hAj9bL7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGZJVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:21:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:21:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so28571542wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rg6liGE7Xe5Eny9GwF05J9Y2Gg6qiVmmlIS0z2M9AS8=;
        b=hAj9bL7hkhKsw30qHY5Nf36Mnyp4gFKJayMwRRo87NbpAmNaqhN4nAtCzD0OYZnKSJ
         WFuv/LaD35l2w5wQnh1WuC2YcDm0YowhoTreeJ5vzUO/h4IVEEwNLk5SmTH+9AcgtPxh
         zUTV2UfAT5jte3+kgEO4mliLieXj8K7DmWrf88NwExCRpzbMx6jGZfl7rRhvLIkK+wMR
         mt0RhTLInWnXYOYJ2YSPHHggEYe5eZNQeoq9rLX9PmLCXqgLXVSCJK7g1DQCphAWXzvN
         F9PcVhhZeiaGTzWd/KfBbI13D/j1QDk+N7h7vZ3qc4b9uDX+Ieq3OueuI+ZkK5Ng7qHS
         ynow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rg6liGE7Xe5Eny9GwF05J9Y2Gg6qiVmmlIS0z2M9AS8=;
        b=jQpFKwEnOiP3EPaWnvRhlHWCm92BZULcOIhMoHMglUrA+OQrwvfgbhESb8egFR8b3B
         kgrmZeb5JgrUHUSVCxtzxU8Kmay32sQ3/2mW3nT0f+HDMa6aCvWGSSQg5xxpFp2wnBSg
         tepfd6a9C+2GXzgFJxmQsGczyxLP5VIubrb8H2n7BAYVIQHxKOkhHxItng2gly0Gtt2O
         53bjp2rjZJNVE8iwXyLVmmBIbdq6UnzMhzMYrc5j2WjR63XiLlgvsgDc92PJM6OZb+r0
         SlpJPzVx6kFISPexZFW/ktpoAYsqX2TnTvOGTx3H9lKaQHSERRTF1B+6Rfa32NRgi5dz
         ojTA==
X-Gm-Message-State: APjAAAUJpUe4dUXyZ6iuw6efWblWOcB2zV5b54KPBrlT6+KFingOkheH
        YtfnLP+eenc1B1Ku5SUDM31OnnAhEoo=
X-Google-Smtp-Source: APXvYqwDO4urFG+RW2RDSJPPmyJAWpxvecy/fGHur6arOBQcJDc593v3T70IgrP1yS6jyEzh6slVeA==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr15300851wrn.171.1564132879891;
        Fri, 26 Jul 2019 02:21:19 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:9d:caad:2868:a68c? ([2a01:e35:8b63:dc30:9d:caad:2868:a68c])
        by smtp.gmail.com with ESMTPSA id t24sm46674717wmj.14.2019.07.26.02.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:21:18 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 2/2] net: ipv6: Fix a possible null-pointer dereference in
 vti6_link_config()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190726080321.4466-1-baijiaju1990@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <6b583833-bbb1-dd59-2c83-eda747a58481@6wind.com>
Date:   Fri, 26 Jul 2019 11:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726080321.4466-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/07/2019 à 10:03, Jia-Ju Bai a écrit :
> In vti6_link_config(), there is an if statement on line 649 to check
> whether rt is NULL:
>     if (rt)
> 
> When rt is NULL, it is used on line 651:
>     ip6_rt_put(rt);
>         dst_release(&rt->dst);
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, ip6_rt_put() is called when rt is not NULL.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  net/ipv6/ip6_vti.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index 024db17386d2..572647205c52 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -646,9 +646,10 @@ static void vti6_link_config(struct ip6_tnl *t, bool keep_mtu)
>  						 &p->raddr, &p->laddr,
>  						 p->link, NULL, strict);
>  
> -		if (rt)
> +		if (rt) {
>  			tdev = rt->dst.dev;
> -		ip6_rt_put(rt);
> +			ip6_rt_put(rt);
> +		}
Please, look at ip6_rt_put(), it is explicitly stated that it can be called with
rt == NULL.

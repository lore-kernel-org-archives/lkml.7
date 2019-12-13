Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0204C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B7824671
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLJp+lxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLMVJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:09:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32782 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:09:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id y206so2126993pfb.0;
        Fri, 13 Dec 2019 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+TUXztuga5A213JEcA90cIY8cUeQjO98uwNxtYgKoO8=;
        b=mLJp+lxyIcMsmoIvnTbdtwhTuQvxnR8TdvxTGzjjbmUrccq6DJRh5SWY1xpS5EM5di
         AkCfdblv+SiB/aFMCNQezSHMhRxtEqt/TbQcqaAn8m9jqTLVhsDZd9ZqE62oTpIZS7wu
         slOalUrRlRgSuiFAI8eQBeMKZ13Zt2AqK4X5PqNtudyo6tXyvHLRjkI4QdLBbddsKQUu
         HrXjhDOIIdWTgyiDNfH8ZS8wg4RMp5R8BREPmnObGj21VHK1wtJ7+IFYbLknQIzkBjJ0
         sBp6cy3QB04fpx1i0QusXBNGRBaI49AvyMYjsG6ri5dYmcXOJ3+Q7EB+gG3+RL9wjE1u
         EOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+TUXztuga5A213JEcA90cIY8cUeQjO98uwNxtYgKoO8=;
        b=F7LWKFlxUf4Jgy6NulzCNRh60apZWSTGDt/3KYpRKfW0eZoX7OgyjKsAi/r2ouWlpr
         l5Mg4EhqiPmPHdfRQr/9jiv6jn6//pVLLFU9SKsXU7T9DID7r14TAJbGhOLRKDnF/bMC
         MJVAiD6tLpDKu3bBzYnJDdaEofrM6kNoL67oA98/eMK1AzIImCQEygrnp0YiPX0Y0BD+
         W9xy2MHGwBt4O219ABbMmy26zvnxxkCsUn+5RPLsNP4XZ3/hnfwo04SoCP30leMZWAmZ
         40Kd+G7H2MYoGaHQu0lKrw7QSaWbfbPwW/QPxKBQO5K2HEAs0t/X3aogBaQtSJX7AHD7
         45Hw==
X-Gm-Message-State: APjAAAWwWQgSLpl7LUiawjiBjIHyxjc7XLQJ9ePByZ99e8reV12ic9lU
        igbdZWC6jDhnp97EfH+Szkw=
X-Google-Smtp-Source: APXvYqwFhi12CyNeIQATqxuF18VfgmCL0rKmVR00cSNIPV42aOKU0GavMtROxRmKjJVamRecUlmk1g==
X-Received: by 2002:a62:486:: with SMTP id 128mr1674843pfe.236.1576271354411;
        Fri, 13 Dec 2019 13:09:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t11sm10884949pjf.30.2019.12.13.13.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 13:09:13 -0800 (PST)
Subject: Re: [PATCH bpf v2] bpf: clear skb->tstamp in bpf_redirect when
 necessary
To:     Lorenz Bauer <lmb@cloudflare.com>, ast@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com
References: <20191213154634.27338-1-lmb@cloudflare.com>
 <20191213180817.2510-1-lmb@cloudflare.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5e7ccc2c-cb6b-0154-15bf-fa93d374266e@gmail.com>
Date:   Fri, 13 Dec 2019 13:09:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213180817.2510-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/19 10:08 AM, Lorenz Bauer wrote:
> Redirecting a packet from ingress to egress by using bpf_redirect
> breaks if the egress interface has an fq qdisc installed. This is the same
> problem as fixed in 'commit 8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")
> 
> Clear skb->tstamp when redirecting into the egress path.
> 
> Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
> Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f1e703eed3d2..d914257763b5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2055,6 +2055,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
>  	}
>  
>  	skb->dev = dev;
> +	skb->tstamp = 0;
>  
>  	dev_xmit_recursion_inc();
>  	ret = dev_queue_xmit(skb);
> 

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>


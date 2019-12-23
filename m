Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FB0206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="avrYXnWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLWJga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:36:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44966 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLWJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:36:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so12073764lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oZMn7o1oy69KXnBYV9LaAvQrLEGDsj3NY515SvELtas=;
        b=avrYXnWBKOPWaYgT8LTFhU+8vzomKUx2Sl96gHd/iwNBc4P3GDX1FfFnkZcnKICY+e
         Slbq/3v/7ycDaahDn38eQ9oSjXTJ6ULqiO3QZMglc0oSpktPadcxb7eUCiodL68diTwR
         HnEDVBNViAuPHot021sCNjg050IlPRdxwr/J2sFitaZu9ahgkKyfE2pmDsPDQOA4Ps9x
         wa2Mpv7mi50qIahge36tbWPp7ZK49PcoiZu6gmrsWScckY1EdfW49k9GJOLbQK/1BpHc
         2fgu5iKtLX5MnanjJEpFkUze5Jijl9owFY7Gq8VvHxCQH06aD9rFm4Brqt7bM3kNXtZ6
         at+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZMn7o1oy69KXnBYV9LaAvQrLEGDsj3NY515SvELtas=;
        b=jNfVx3PGabNehT+5bzPmTjJmerL8k+zBFineGdcWAwm4dLQYMoQ+AkWuramb/qv8eO
         TxI+EzeOYAecb9hEWWnbvGrjQShDYp1M88VsNX72l9JSA8dfhzcARHySDCZ7B5M/l80f
         YuMWX+uoID66bLevKj9Bh5/93j9uK93CwLkGuS9HDUd2eNOEW9MNPl2/YUm+GXtFrcx5
         +EQXwbFtQ7BHNc1TZ6mPaFmUI03LGYKR3ccHiVWTICRGa94FnSsBA6Ulf1UZpV1xcG9B
         /7RR/7KinCMwhJzjjNCJuBqmxPTlRB01y6pjiLCJ44ZFdSp2LQbxXP4Lsdifidv2D4GB
         uQQQ==
X-Gm-Message-State: APjAAAV71bMz8RWqo3T3FhE9iz5nd0At92BW7euKBtwX5UohwvbZxzvR
        WKVe7YQNlmq3KZabKN8zemZoCg==
X-Google-Smtp-Source: APXvYqzpwoVgjOExyFx7a0NvdeU+5teMlq/PIN4Ppuh7OZligwpt7aMlbtAXk3vXBz+T5ohldr/tlw==
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr16050434lfg.81.1577093786041;
        Mon, 23 Dec 2019 01:36:26 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4292:b2b4:35ce:e1fb:80c2:d584? ([2a00:1fa0:4292:b2b4:35ce:e1fb:80c2:d584])
        by smtp.gmail.com with ESMTPSA id p15sm7921857lfo.88.2019.12.23.01.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 01:36:25 -0800 (PST)
Subject: Re: [PATCH] xfrm: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
To:     Yi Wang <wang.yi59@zte.com.cn>, steffen.klassert@secunet.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
References: <1577065982-25751-1-git-send-email-wang.yi59@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1d8007f1-15ab-a173-a3ed-cf2235cd2cea@cogentembedded.com>
Date:   Mon, 23 Dec 2019 12:36:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577065982-25751-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23.12.2019 4:53, Yi Wang wrote:

> From: Huang Zijiang <huang.zijiang@zte.com.cn>
> 
> Use kmem_cache_zalloc instead of manually setting kmem_cache_alloc
> with flag GFP_ZERO since kzalloc sets allocated memory
> to zero.
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>   net/xfrm/xfrm_state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index a5dc319..adfa279 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -612,7 +612,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>   {
>       struct xfrm_state *x;
>   
> -    x = kmem_cache_alloc(xfrm_state_cache, GFP_ATOMIC | __GFP_ZERO);
> +x = kmem_cache_zalloc(xfrm_state_cache, GFP_ATOMIC);

    You ate the indentation. :-)

[...]

MBR, Sergei

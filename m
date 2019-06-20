Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5472084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="oqo/RX2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfFTIyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:54:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37371 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfFTIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:54:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so1939922ljf.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XV+YrUigCDDIRUveyB1XDbziMO/ZiZxaiH7FYVcJoGA=;
        b=oqo/RX2HVGGth+PchSW9tgaJlBbosx7yeOeKiv2xpeptiCb0zw8dSM60I9Qk5CjNLl
         uhvO5+S8++Yv3BfNO7ZQzBgjcAZnkHAPscqBDhxJvetgYLWbosZ4l927qqQa/chrJtR7
         A3uKtCybx70wqQmW4ObJCkVb6c1dRTESQzCN8dE66a2j6mY989zO0eu89/Guino7kOID
         N6Db8x+eP/gyGsXv73A59ly40QRQjjHD4uFuUiGLgDjgGRKQl+reY4gVhqjKShU9QtQ3
         nV6zmcOuPFlVnSz4E8yPjoExAiD5USTpr3PZsyY6cNa2uhF7yDpBQVuljOF0vdXVqHVZ
         biOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XV+YrUigCDDIRUveyB1XDbziMO/ZiZxaiH7FYVcJoGA=;
        b=K+NnklwSKg4l7PZMYLSuDKjzUOPCEnAo/gu+khMACflfMtlmAmTQ3CnrsrG/XrjF2j
         TlNy0jt06zpv54HX9C/4d7DnDnZbeSgRqR+nJ82IHV6znA0dZC7qVSTWrEuEPA0b7db4
         XnOwqekMxucS3pqZD9/D1eTgceKYeMqVYi1vw4AlmpMEJyMvWivcmkgeJIz5chgfYO+M
         Uejmq4QAHcuEgn7MSfqR1c0a0QYETqGWhlB1qDxwO9ezTRxqf6R0FuTd5eHZOEgV89cb
         aR4gr9+rSKQhBkbLxAPnDoFNbOO8FmCxX6c586QylwNqiNgwuo/UcFtHPyJbwiaayIJ9
         CW8w==
X-Gm-Message-State: APjAAAUNwd/VjC2mrpV9qKub8uqvBmNz/d0ycMiytZcQ6zfmJBqETfLI
        51Ks6PFJV9gPRPu1hn5PqySZ9AsMd30=
X-Google-Smtp-Source: APXvYqyJjdTh32uiq2m1OlJfja/u0w5AOiM1eNFaRWsQXrUo9GwtQy8LhikCB+Bm2QgsDSkFzZt1HA==
X-Received: by 2002:a2e:8082:: with SMTP id i2mr7925357ljg.121.1561020859602;
        Thu, 20 Jun 2019 01:54:19 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.13])
        by smtp.gmail.com with ESMTPSA id 137sm3429314ljj.46.2019.06.20.01.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 01:54:19 -0700 (PDT)
Subject: Re: [PATCH] mlxsw: spectrum_ptp: fix 32-bit build
To:     Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Shalom Toledo <shalomt@mellanox.com>,
        Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190619133128.2259960-1-arnd@arndb.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <099199e8-bf5a-4124-d850-0bb5a764f17a@cogentembedded.com>
Date:   Thu, 20 Jun 2019 11:53:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619133128.2259960-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 19.06.2019 16:31, Arnd Bergmann wrote:

> On 32-bit architectures, we cannot easily device 64-bit numbers:

    s/device/divide/?

> ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_spectrum.ko] undefined!
> 
> Use do_div() to annotate the fact that we know this is an

    div_u64() really?

> expensive operation.
> 
> Fixes: 992aa864dca0 ("mlxsw: spectrum_ptp: Add implementation for physical hardware clock operations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> index 2a9bbc90225e..618e329e1490 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> @@ -87,7 +87,7 @@ mlxsw_sp1_ptp_phc_settime(struct mlxsw_sp_ptp_clock *clock, u64 nsec)
>   	u32 next_sec;
>   	int err;
>   
> -	next_sec = nsec / NSEC_PER_SEC + 1;
> +	next_sec = div_u64(nsec, NSEC_PER_SEC) + 1;
>   	next_sec_in_nsec = next_sec * NSEC_PER_SEC;
>   
>   	spin_lock(&clock->lock);

MBR, Sergei

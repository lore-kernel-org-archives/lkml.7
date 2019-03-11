Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8315F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4Uy3OzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCKJL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:11:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41554 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfCKJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:11:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so3235789pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pKmOmZCi0nHswOZFqc5YsLrWx3sA7RhPVdHvL7jN08s=;
        b=P4Uy3OzZr/QFGG5Ew/YVhFtkDYVgyKS0/wGIrPLo18QbcMr0G3OtI1YEyoAM87zwwd
         ETG+jcJh96k8+SipM3bHoe3CGu+vvCTucEnf+rg0I2kqOqjSw8BF6VSTTbQI/5WmLouP
         Kco7H8D3hT00NzfACO7yvYpii6weEXh8+BsoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKmOmZCi0nHswOZFqc5YsLrWx3sA7RhPVdHvL7jN08s=;
        b=az1gI9u0btbcXdLjhhhx/2dFTT6Sni0FAeZ+robIzIkP89PaxVQjUgQPNaiBmR+TwW
         yf9tm+wcagSTr0PgWi7KVl7wzoOeGErL7OPrJ/nqceY3b9YMcmpZMh32a2Gm09Y9g0DF
         dzaUbz759SvaXeigFeF1kJUyvD5Kf8uVYL/iMMFUCf0p7vtEQnqigUmSblsUaEdy5W+F
         SnTegXLfCZfrkhKXASOLBz4LvcFIVZZUkwLAwTsAUpAqPE14LTfzxB1vyY5zjeb5MD1R
         NfvqmUllen8fqsegm3JFJ5qglffJ7h3zrXA4ogXQZ2p8/MGdjEgS1b9Jwp/U/bMxufre
         1fFA==
X-Gm-Message-State: APjAAAXap4U2hOl/rLdq95r2NrHjIChyZWPOsVBDbdxTYBfeEUO4wG73
        9AhwjXVdMcvaJ453o4Iihk7NpuWVqmh28c795ffB3I9e9FEnO5B6AEPVfSVqnQX34KrwhLOzGpw
        u7t2mVkVvt6YuRa3N/p4rWqQQyimX9ROqHWZ6ykoDpmP5y5DwV8yIhsJ3nqxN1FzgCAM6KQ8yPm
        9ZoGKyw0Offyc=
X-Google-Smtp-Source: APXvYqyasWsdDVfc4tbSMLlo3gMEB4g0b9LxwEFoX1zNJMjNziXWuawObmkiLVfID4tdm8JVhH2PvA==
X-Received: by 2002:a65:4549:: with SMTP id x9mr29580201pgr.3.1552295486455;
        Mon, 11 Mar 2019 02:11:26 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id q4sm5016441pgn.20.2019.03.11.02.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 02:11:25 -0700 (PDT)
Subject: Re: [PATCH] net: brcm80211: fix potential NULL pointer dereferences
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311073232.30807-1-kjlu@umn.edu>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <9f8b2ff5-9c24-6f7a-ea7a-5b79a24fd280@broadcom.com>
Date:   Mon, 11 Mar 2019 10:11:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190311073232.30807-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2019 8:32 AM, Kangjie Lu wrote:
> In case kmemdup fails, the fix returns -ENOMEM to avoid NULL
> pointer dereferences.

Hi Kangjie Lu,

Are you fixing any reported issue with this? If you looked further you 
would see that this function is called in two places and the return 
value is not checked there. So your patch is not changing anything.

Please sent a V2 addressing my comments below.

Thanks,
Arend

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index e92f6351bd22..d903a45e7b68 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5464,6 +5464,9 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
>   		conn_info->req_ie =
>   		    kmemdup(cfg->extra_buf, conn_info->req_ie_len,
>   			    GFP_KERNEL);
> +		if (!conn_info->req_ie)
> +			return -ENOMEM;

No need to return an error here. Instead set conn_info->req_ie_len to 
zero here.

> +
>   	} else {
>   		conn_info->req_ie_len = 0;
>   		conn_info->req_ie = NULL;
> @@ -5480,6 +5483,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
>   		conn_info->resp_ie =
>   		    kmemdup(cfg->extra_buf, conn_info->resp_ie_len,
>   			    GFP_KERNEL);
> +		if (!conn_info->resp_ie)
> +			return -ENOMEM;

Same here for conn_info->resp_ie_len.

>   	} else {
>   		conn_info->resp_ie_len = 0;
>   		conn_info->resp_ie = NULL;
> 

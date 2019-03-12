Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536822147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="xSX2iaf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCLHib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:38:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39189 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfCLHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:38:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id g80so1367805ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9hhftaVgVrniey3X0IakDynrD/6wVUpVi+JgLVE0q/s=;
        b=xSX2iaf33GvGyEch8HD4cxYiMvXYuWpCsJZyP8hJtqjf2lhhTus4Mc4sIqhSnaaYC7
         TRv4IfFU5amEUJAlGBF+XYHmZX6TYM1lglsUx/XHa7gD4GQcfeZH5Q8ZQXrIrJQIyb3S
         /Aq7ukCZAVD0WkYLgFdG/dpJM9h705eUuDtb3fmNKO8nC58h6eoRsHcAKWvSjFFu+Jsr
         ShmCjNX9ekDU/P/s7thcpHKDE5xPGoJNJuGYB8BgQMxA299hdvtOs0bpGWMrJYwwwvh/
         nIy2kE/SKLYkZRtTtkhKuzjpu4CB7YCT+msZqxrLSJi4zVJuX+BTcpSr6DehLZBDRA2G
         1x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9hhftaVgVrniey3X0IakDynrD/6wVUpVi+JgLVE0q/s=;
        b=jrEHF+5ztEMRRINRN4jSR5K8bso+DNDq3hl69YuwFyMCnmomIYzRLkNcBRJ8wft/F1
         crqZ//MqZq0WnlBJsui40oIQyr3tsz/0vM/trWueEMi7LLY7hPP4pxN/N7NDDEVrHTi0
         hm1T1GKdOHLmApuH/Ravdthd8SKPn4haqzGQexSHJcfQ9w8Iejf8NtSe6mZgtcWTmvIs
         jCHuUlbm2YwthHxcZtciWLqmczR3ozUWO2ssO32sYNSu1BcntOnttyHC/cvLn6Xn3oVA
         8lYaXcV0ZcI0Ys39qofUllSUwvxzU+cei+bGJjE1QMbgdJ7WCvfRdmP4JkquLpYUsX+u
         X5Pw==
X-Gm-Message-State: APjAAAV44svrSUGKBLQCxIxTzp/iANmlfsPGKSMNj14ptf6zDUC3Dbjr
        TbazUKFqUpp9YLI63fciRAzgHzcfK3M=
X-Google-Smtp-Source: APXvYqz4HHX7mcqlYt6rzI1na8X8zajRbd5WOQUlUrFHWmyS0E8ccuHcQlQn03RlRqJO7Ob+KaXSzQ==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr1075127ljh.91.1552376309166;
        Tue, 12 Mar 2019 00:38:29 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.87.174])
        by smtp.gmail.com with ESMTPSA id l21sm1446211lfh.30.2019.03.12.00.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:38:28 -0700 (PDT)
Subject: Re: [PATCH] net: ravb_main: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrew Lunn <andrew@lunn.ch>,
        Magnus Damm <damm+renesas@opensource.se>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312063827.16046-1-kjlu@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <076a4b31-3e83-9e3d-81a7-55bb7f25a37f@cogentembedded.com>
Date:   Tue, 12 Mar 2019 10:38:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312063827.16046-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2019 9:38, Kangjie Lu wrote:

> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> goes to out_release if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index d28c8f9ca55b..791b6842eb12 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1996,6 +1996,7 @@ static int ravb_probe(struct platform_device *pdev)
>   	int error, irq, q;
>   	struct resource *res;
>   	int i;
> +	int ret;

    There's the 'error' variable already for such things, use it.

>   
>   	if (!np) {
>   		dev_err(&pdev->dev,
> @@ -2054,7 +2055,12 @@ static int ravb_probe(struct platform_device *pdev)
>   	spin_lock_init(&priv->lock);
>   	INIT_WORK(&priv->work, ravb_tx_timeout_work);
>   
> -	priv->phy_interface = of_get_phy_mode(np);
> +	ret = of_get_phy_mode(np);
> +	if (ret < 0) {
> +		error = -EINVAL;

    We typically propagate the errors upstream...

[...]

MBR, Sergei

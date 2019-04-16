Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC3AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEED320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlM1Omlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfDPSRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:17:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40658 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:17:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so10724424pgl.7;
        Tue, 16 Apr 2019 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11/Ik9tWqzfiWmt6+T8zjmzssuMU+L+Ewe2SOnd5gr4=;
        b=qlM1OmlkRFXRAJk7tifWCRBRFJmSyD+wE72rfanSf54Xf9Zn6mu6XzI3sQZbwiwera
         cJEU9thOJV0ZByT4FAHVmLwh6UHynL/nkRC/JuWPJygmkMzojYQQ2eI0Eq/aJPVCaLdZ
         rfV1XMKnQG7+4hVRgQWC3JqUT68jZaks+PqA0KH+hItbe/DFGFjoOicDaFL/8exhjCoK
         9Bb/gsiCe67nDWPmJKnTFrDiVFaBpwbF8gua1W/+x8WYT+F72DCPK3FeQ9N43a//61b4
         rb8FXF1Z1bLo8WlMiuzF+KUm4xlXhQVnBX0ivk8sT9VXcAb4naw1gwZd91Br6K5Cb60J
         WP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11/Ik9tWqzfiWmt6+T8zjmzssuMU+L+Ewe2SOnd5gr4=;
        b=cOaqLWEQJlcrSwXStwWr+AHjqcfxp35CLX5H/p8MdCfuVmZlDG1X/gRFr7Xs/7YYkB
         p+mQleNGoUD+QB36c4t1ISmA1VqxPEti988QY9dKs/xVwPSpLblhIoFVdAg7ZL0AFD1c
         xqvfyI0f2L1Hcx7hJCDd8XHJYYIhghmLJKBz5/n+w56yJRsOlDctxtjTSRcjVt6uCeVL
         jt8yzDjRtydooWuV4pdRhuoNlOlJqTmiS/dTW2BL+H0z6AaKDVQO/FySIG+bsdUqY0QM
         K2l4Yhuphr9VNyBK6L7OuvG+rm8onpRlVq8RP9TRAXmhFPjyxmeRIh1zDPEPJxtrFzNG
         lICQ==
X-Gm-Message-State: APjAAAVQU5pfEYtTug1gXqJ6+/QaXqkT287x8NkoVZF5ajN/NTpFzqwR
        nAYhRwIXKYArzz7pZVSnB8wc8aud
X-Google-Smtp-Source: APXvYqzlWc2AQ7QVL41nyA3hBdFicfAfqVj+4HAT5CEoq/a3pqijxNiYM/0bxnnKMtCQo/W2qk9ESw==
X-Received: by 2002:a63:1003:: with SMTP id f3mr75658088pgl.227.1555438631418;
        Tue, 16 Apr 2019 11:17:11 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d187sm60005324pgc.43.2019.04.16.11.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:17:10 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: fix spelling mistake "endpont" -> "endpoint"
To:     Colin King <colin.king@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416111214.22107-1-colin.king@canonical.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2c66cb65-fd22-39f8-4446-fc0cfd611e00@gmail.com>
Date:   Tue, 16 Apr 2019 11:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416111214.22107-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 4/16/19 4:12 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a FAIL message, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  scripts/dtc/checks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 4834e44b37b2..faddf6a57236 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -1714,7 +1714,7 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
>  		return;
>  
>  	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
> -		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
> +		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
>  
>  	check_graph_reg(c, dti, node);
>  
> 

Thanks for catching the error.

This file is imported from an upstream project.  The error is fixed upstream in
commit 4762ad051ee0 ("checks: Fix spelling in check_graph_endpoint") in the
devicetree tools project.  Rob pulls the changes from this project on a
periodic basis.

-Frank

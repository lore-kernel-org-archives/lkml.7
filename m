Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E51C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340A1206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcV2xIg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDKFJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:09:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45011 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKFJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:09:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2824173pfm.11;
        Wed, 10 Apr 2019 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WjpTWS/nBAHfAxR38WCKOfTkke2hLWdpvYeKGUVB66w=;
        b=KcV2xIg+u6qvlWKl+YUMCWNwh1ecKIqpZgE/SVHNDy6egNRWZn8IYZmInZrz6P5HMC
         YS8a65mlkEx0vMeuQ8m6HuTZNml4M71OSrSjIaBD2RUh42+27WvQudkGzWFO7mt/94cs
         vNtSdjoRJTOP/lASfP2aJpfDv9toZYA8CZN+GH1Bg6his7fGcEnJ3OvQZHUzQo9P70hd
         e6LI446H5cTfgBbv/ewPfbFfG6A4AXV5qDOdazrVgP5KfaRdpSDW8XxOb5NvfgqoPwAJ
         +kkW8IXUMg5nFO0l6n2aThkxbmVT/xiRhxhBUJuM7I/vOYsXsXx3kkrZEgPIYyUTG0c9
         02Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjpTWS/nBAHfAxR38WCKOfTkke2hLWdpvYeKGUVB66w=;
        b=f9zI1AfFhP2qP589U082HTGOpjMxUji0Dc3D69O7agOE18xZ4bm+3vsEZpaTafnoRc
         x8M8pglQ0hYYGQlbYIm77HZ+SfbqEmKXyz8kcwYNEMwtqKZ2WN/DJ2dCF2vFyinTb19V
         ECYqpWfYngHaRx1OmtJIvpGqyDUimdXPQq1zAHERRoK+OmCKtPjJutu4QZO1h1/ML6k0
         /0O0LSzVJ/6duFkOycwvaa7lerMo+4NpQv9Lm4Dfex3Fu4KCU7NnKYSF++dEK6I8Hrro
         OAAlnYT6tVvoeZqhxdmQVTHFHJ4idShPEFhzN3Qc7HsUAyhgn8jsBm5RSi6c9fq0/k0P
         cG8A==
X-Gm-Message-State: APjAAAXMt9+LnI+9z9tKYhaWo9sLs260eO8ZAbknu4JmhExioUWNmuOp
        56HhmmKctntUfm7yRvuiGb4=
X-Google-Smtp-Source: APXvYqx0mi/6ssiP/SUPXCas5PFAVcTWY+rXm7WQcziioRQmpjBKSIfKZhk4EZPl5zGcfmIyidtJuQ==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr44790031pgc.238.1554959391987;
        Wed, 10 Apr 2019 22:09:51 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z7sm17143119pgh.81.2019.04.10.22.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:09:51 -0700 (PDT)
Subject: Re: [PATCH] of: del redundant type conversion
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>, robh+dt@kernel.org,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <dbb188f0-2289-6b76-2120-ce0aedb49eac@gmail.com>
Date:   Wed, 10 Apr 2019 22:09:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 1:29 AM, xiaojiangfeng wrote:
> The type of variable l in early_init_dt_scan_chosen is
> int, there is no need to convert to int.
> 
> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4734223..de893c9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  	/* Retrieve command line */
>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p != NULL && l > 0)
> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> +		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>  
>  	/*
>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> 

My first reply to this patch asked for a sparse warning on this line to
also be fixed.  After xiaojiangfeng followed up with a different patch
to try to resolve the issues with this line of code, I see that the
sparse warning was not caused by my first conjecture and this patch
is the correct one to apply.

I will pursue the cause of the sparse warning myself separately.


Reviewed-by: Frank Rowand <frank.rowand@sony.com>

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23426C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C132449D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL66U2tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfEaRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:03:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33321 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:03:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so4391789pgv.0;
        Fri, 31 May 2019 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcbaLo+Rp6rFHIJY4Aw7TNgf1didzT0RQSOWS1nltp4=;
        b=SL66U2txD/EdrZlmqUBPSJDLvY1ap95SD4uBMtVacbkYbJ9szad2xS3g/KzzzN+GV+
         eo1rO3DhAb2ut3hN0DOBLJaEg+4G+MVLx9cVAvKbIuHuQc86xPcQgEZWbJWrRhX2KsJi
         4E5xeoEOjyVm9SFgs/HmG3/zO+6jKGZogV+n1LisdRfs9MDbQaVg/zsof1AoQiFfaIIU
         qzf94cIJxiyPHtpaNKutKfEYQ4zSfz+hnhKmAyY2krptGYq42hYvWsZ1Z/AvArs2ZyO0
         eKivLO9tHMWwa1D5DHKIbweXi18Bf8FK1fWIbYpZ8H8bWWICixozZLxReld7Gw3WUAVg
         YkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcbaLo+Rp6rFHIJY4Aw7TNgf1didzT0RQSOWS1nltp4=;
        b=JONMwsoBkTKZi84KChBU1G2Ziri6sV2DJpVplWiYWqmJGmfCfewnHd8irWzMPRoPAB
         pTuHDraPaWd7kPv5XCCCESuyDN/U1n+OdeSS7uDD57hjTK/VYY1mxXXPf0L3MC7xoLrH
         G9NbALYsG3/oP5v1G3xCScX4GLhJ4ZcWXGB0zXdFqy6vNY32xtNp+Jzsd4wPGAMV/rek
         0DEDKPKtyNqJR+52Mit8frdvdwsW/slxA+tRMgiTGyKl2pn7KoHPPv1XTpZOgatCkJB8
         hFC4oiUEWZiMWIbfIfRiYddB2WHQOQjwHiWvvtkLMhXJ+VvKsJ2qHGAIO9G2kMGYj6cR
         13NQ==
X-Gm-Message-State: APjAAAXghjh0JdIELAP1gn9xvyWzDv7QPr2n36W+10/HcLpjGoW66Qds
        fE/oXp0Saxz+Dh8e45vzDbnZKgED
X-Google-Smtp-Source: APXvYqyYz93AJS+mJD1FYT1GSJeNQ4RTeco0fNZQxryW/PQc72iXkRlipri8sIwc/l0VIsp1UXW07w==
X-Received: by 2002:aa7:930e:: with SMTP id 14mr11014925pfj.262.1559322191419;
        Fri, 31 May 2019 10:03:11 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 2sm5845471pgc.49.2019.05.31.10.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 10:03:10 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: pass early_init_dt_reserve_memory_arch() with
 bool type nomap
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190530103927.20952-1-yamada.masahiro@socionext.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8ebc80b7-edab-c72a-9a6f-aab00318bd20@gmail.com>
Date:   Fri, 31 May 2019 10:03:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530103927.20952-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 3:39 AM, Masahiro Yamada wrote:
> The third argument 'nomap' of early_init_dt_reserve_memory_arch() is
> bool. It is preferred to pass it with a bool type parameter.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/of/fdt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index de893c9616a1..b165e8b3a347 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -551,7 +551,8 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  	phys_addr_t base, size;
>  	int len;
>  	const __be32 *prop;
> -	int nomap, first = 1;
> +	int first = 1;
> +	bool nomap;
>  
>  	prop = of_get_flat_dt_prop(node, "reg", &len);
>  	if (!prop)
> @@ -666,7 +667,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
>  		if (!size)
>  			break;
> -		early_init_dt_reserve_memory_arch(base, size, 0);
> +		early_init_dt_reserve_memory_arch(base, size, false);
>  	}
>  
>  	of_scan_flat_dt(__fdt_scan_reserved_mem, NULL);
> @@ -684,7 +685,7 @@ void __init early_init_fdt_reserve_self(void)
>  	/* Reserve the dtb region */
>  	early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
>  					  fdt_totalsize(initial_boot_params),
> -					  0);
> +					  false);
>  }
>  
>  /**
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

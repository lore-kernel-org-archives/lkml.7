Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A24A2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="WIyeq621"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfD0TCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:02:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37457 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfD0TCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:02:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id h126so4934959lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AZgxJWhbIDvKlGzRsWxiCN2W+xAkX6lkUd7t0yIDidU=;
        b=WIyeq621iyHX/Df/naNbN++OglZ6+VJNZpSAlZCMMzGDen3MlM7ODEgIJQ1XQ2Tsqe
         KoJUHEW44tSNFSyj1vxGoq7osfTu8C31TTPKvFDACvT5BT8pCNdNSulm6+SNzryjG0jJ
         ZHJEhTrup0ZDDiurfGdqH+hNSl0x8iXtHBqp64Hxkwc2ccRvHB3cPcalLC9kC/ghLcRc
         35M5jbvnwnt3gTxeBiJwRtl/Nz9DCtpkHDDFc5i3HECb/37NvQFDD1RM9HKuhymhT1Lg
         2P3C0WmTAv6VIGddHgt9HGv2f178ruKcl3BbINX6FItiTouYD86sr7pKClUmtBG6Mg8y
         GyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AZgxJWhbIDvKlGzRsWxiCN2W+xAkX6lkUd7t0yIDidU=;
        b=ULJWPEQmAtArcVZO6gcBjAsMoR06lZDTI8rJ/etGxN0xy/nX3n+MYyGoZ7TX0m1O3v
         WxqduQ+WDu2QsGh0Uifgr4xOajmMu8x2Haphf1yZfVFd0/hduodrAo2scfaLRCtzid9r
         kTVruULBk+oJ27N6wnUHVCVH81ypLMYwxIXLoKUMG80HRUXkjuOIMpgavfx3stMv+LIT
         U8cWPiRovpV9dzSxgbyz1J1q75mp4N7kPRjBw7jIyeczvmPW2AkcRiz2nhD2PWr+Jzza
         GREufUYIJFVDI6lNq/F7y0dc3y7wuwur0N1YcAmKdFg/60/S3KO3mtgSCwDB0j3bq4ek
         0b/g==
X-Gm-Message-State: APjAAAWMZrS4CliGhOyZIWU5L0uQqriH0B1j3l+lqAkn1fJrIaG2LXi6
        YE7AF6p6j8+k2HO5uQtFFB5h7w==
X-Google-Smtp-Source: APXvYqzzsRMRu10ni8xp9BNlmHXddNxg6m8pR41FcPmRC7oDP+jBy5UZJMOqZ/1dKJN8fNr7zihdcA==
X-Received: by 2002:a19:428c:: with SMTP id p134mr29296072lfa.108.1556391727674;
        Sat, 27 Apr 2019 12:02:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.185])
        by smtp.gmail.com with ESMTPSA id x2sm1199162ljx.13.2019.04.27.12.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 12:02:07 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20190423104814.5762-1-vigneshr@ti.com>
 <20190423104814.5762-2-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <093ef590-ae3d-2db2-09af-573a138a9416@cogentembedded.com>
Date:   Sat, 27 Apr 2019 22:02:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190423104814.5762-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/23/2019 01:48 PM, Vignesh Raghavendra wrote:

> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
> Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
> can be used as is. But these devices do not support DQ polling method of
> determining chip ready/good status. These flashes provide Status
> Register whose bits can be polled to know status of flash operation.
> 
> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
> Extended Query version 1.5. Bit 0 of "Software Features supported" field
> of CFI Primary Vendor-Specific Extended Query table indicates
> presence/absence of status register and Bit 1 indicates whether or not
> DQ polling is supported. Using these bits, its possible to determine
> whether flash supports DQ polling or need to use Status Register.
> 
> Add support for polling Status Register to know device ready/status of
> erase/write operations when DQ polling is not supported.
> Print error messages on erase/program failure by looking at related
> Status Register bits.
> 
> [1] https://www.cypress.com/file/213346/download
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

   Sorry, only superficial review, I'm not an MTD expert. :-)

> ---
>  drivers/mtd/chips/cfi_cmdset_0002.c | 90 +++++++++++++++++++++++++++++
>  include/linux/mtd/cfi.h             |  5 ++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 7b7286b4d81e..55c4d81098d5 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -49,6 +49,16 @@
>  #define SST49LF008A		0x005a
>  #define AT49BV6416		0x00d6
>  
> +/*
> + * Status Register bit description. Used by flash devices that don't
> + * support DQ polling (Eg.: HyperFlash)

   It's "e.g. " :-)

[...]
> @@ -97,6 +107,48 @@ static struct mtd_chip_driver cfi_amdstd_chipdrv = {
>  	.module		= THIS_MODULE
>  };
>  
> +/*
> + * Use status register to poll for Erase/write completion when DQ is not
> + * supported. This is indicated by Bit[1:0] of SoftwareFeatures field in
> + * CFI Primary Vendor-Specific Extended Query table 1.5
> + */
> +static int cfi_use_status_reg(struct cfi_private *cfi)
> +{
> +	struct cfi_pri_amdstd *extp = cfi->cmdset_priv;
> +
> +	return (extp->MinorVersion >= '5') &&

   Parens not needed here, especially as the next operator isn't enclosed.

> +		(extp->SoftwareFeatures & 0x3) == 0x1;
> +}
[...]

MBR, Sergei

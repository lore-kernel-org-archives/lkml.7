Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D021741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Uioip74/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfCXQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:23:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45152 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:23:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so5714018ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Pg6TyKqOEBJ5p2F+vVjKYJQKTqyJO6B+2xoYuenJv4=;
        b=Uioip74/Cvek/C88/GJF9rB6Ct7bPJU7UacdoAMAvEjYXV3X278WXaUoaOoHjJWzbW
         P/QJBKhNokIkciz2/sO9lLL8iQNwzQv4Ep+ETMgzK94Nhnbf2FAtW+fVKqeJX1Ndt27q
         lVOX6GWL3p/3k2U5+fGWQH9327Z9lQhdqWnF5RXOyU9aAcI1cFCh4YgEcB8bqKYUWbn7
         iYrqDm25Iu/AfZDZ4ed5+fb4Ibztylwal1usi+3RBbxFpntBZq0sSu7YVFlGEZMl7KNQ
         VaY2XZ6cItH29TY5hWKV3SkvufipS0ZPMEkC70T2qx+GNzuXaUIEY9QyEpA74FWjjVQl
         uxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Pg6TyKqOEBJ5p2F+vVjKYJQKTqyJO6B+2xoYuenJv4=;
        b=I8ZooBqLAlXGT3lzvIF3XqG3/Vzdf3Fu9pXaGHTp+Jsxcv3kxVbyFDbNqzadHm8w7t
         6dyxASX4sNv0GVvQdS3jcyFZrZuFJ6UoNoKViOGECE/AymkoqtA+RUuwOWfSydVhV/Pl
         os26iNmrZdd+FGjqDyPgwCEgjvWXjfPiMI9c5sozJq8dacTqIn8m4devrW1jOROsET0L
         FTEGqq1d6OY1r74wCzonI5LhYrKsmacZiKdeM8KmGeM/fAwrBAjA30FaFcKdn1NtZmIm
         1KdFtG9hhWaj10+/sXf2Y/h2ZV1R1MDPZ2f5rH0yqxuolEV7tbUeo3F2iXTQ954TFVyu
         oTfg==
X-Gm-Message-State: APjAAAUF6w8m7e/AlDRjYR5mvO8tkAHJGIAY40tLUe25oYkPGWIsImHh
        iawvg0TSqqF3biGf6DV3hNnh0w==
X-Google-Smtp-Source: APXvYqx65heiScyKG8alJoDaHCi5DRZy7K7C5cZitdgwR6mOF6H8fyfI0Nk8MZQsTUtPObWBZwf6cA==
X-Received: by 2002:a2e:9a02:: with SMTP id o2mr1698779lji.179.1553444605756;
        Sun, 24 Mar 2019 09:23:25 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.147])
        by smtp.gmail.com with ESMTPSA id h68sm2881577lfg.77.2019.03.24.09.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:23:24 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tudor.ambarus@microchip.com,
        nsekhar@ti.com, Mason Yang <masonccyang@mxic.com.tw>
References: <20190321174548.9288-1-vigneshr@ti.com>
 <20190321174548.9288-2-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <597bbe8e-65d3-40c6-5d15-544e962be7c3@cogentembedded.com>
Date:   Sun, 24 Mar 2019 19:23:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190321174548.9288-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/21/2019 08:45 PM, Vignesh Raghavendra wrote:

> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
> Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
> can be use as is. But these devices do not support DQ polling method of
> determining chip ready/good status. These flashes provide Status
> Register whose bits can be polled to know status of flash operation.
> 
> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
> Extended Query version 1.5. Bit 0 of "Software Features supported" field
> of CFI Primary Vendor-Specific Extended Query table indicates
> presence/absence of status register and Bit 1 indicates whether or not
> DQ polling is supported. Using these bits, its possible to determine
> whether flash supports DQ polling or need to use Status Register.

   We need?

> Add support for polling status register to know device ready/status of
> erase/write operations when DQ polling is not supported.
> 
> [1] https://www.cypress.com/file/213346/download
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/chips/cfi_cmdset_0002.c | 50 +++++++++++++++++++++++++++++
>  include/linux/mtd/cfi.h             |  5 +++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6bfc47..29987d8e6c6e 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
[...]
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index cbf77168658c..92ac82ac2329 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -233,6 +233,11 @@ struct cfi_pri_amdstd {
>  	uint8_t  VppMin;
>  	uint8_t  VppMax;
>  	uint8_t  TopBottom;
> +	/* Below field are added from version 1.5 */

   The below fields are.

> +	uint8_t  ProgramSuspend;
> +	uint8_t  UnlockBypass;
> +	uint8_t  SecureSiliconSector;
> +	uint8_t  SoftwareFeatures;
>  } __packed;
>  
>  /* Vendor-Specific PRI for Atmel chips (command set 0x0002) */
> 

MBR, Sergei

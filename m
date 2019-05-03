Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95734C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614E6206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFan4mjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfECKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:00:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42177 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECKAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:00:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so7071965wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRAopPWeL4S3euytRS1nMzqnSButv4IeRogp1ulwv8s=;
        b=EFan4mjWaWCv92gpX1vXUlcT4OVZK7FEiDH7p/3bnOqtYHSqenlLxRJQ0wQ0VS2UPY
         NMwFVBJKpK5VE+BWn4wRJGQAFir4CwFKF/+O6Rz/ZDbrdRvHBaONs2NqNkm1aYBiDyNl
         YYQcqzaV/t1hHeRtX5ChguzIoEBRumgA5ga/3XMv/+zl2ifMe2Y+nvP/NmSbnJQRAGcB
         IG6BDtOKCulTUjP4/pPTHXXUot2OAivVAwIhMZHSuHgASaKEXhyO7RS1P5y2ZqVTQT05
         3JlHhydeWGlj2PGITsJeupQtE0sTWcAGQWT2h1Hx5lnjPn9wNnWWJmAxNJ9/tNyGshUd
         uwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRAopPWeL4S3euytRS1nMzqnSButv4IeRogp1ulwv8s=;
        b=kilRnz1DCowqKcy5n8Swi7qHPihC/TV91fWqdX61I6QK67a9nyy2CvDXe7PbAoEw12
         +bZe/+Ll7aDex4Y+u5XROfZfVGFxR8LMUOGQCyluUGEUyG5UXC/J/uISNOAOecuoNlRC
         0oxzAXqrou1FfDEuPQEnbVkNK5bk+1ZfZzqcNj9+klG/QbHLkltI9hKyfhUCez/cp/5+
         N1NqtbGhqxzwKYGZVGvKBi0lgSLQ9x40YpcQOp1jyKNA6rNlnOCtJbf3W4LQWW8wDHBY
         1hwhFyq2m3fowF5UVIZ+KC+nz6658IsCe1kwW/gUhKMckYBECZs6t+UxsbQi9SZj8+PO
         zdTQ==
X-Gm-Message-State: APjAAAVmMoABroAgfyBEFtZa3rMhkELJ6wOlENbpqcdQZspbv+6KAL4F
        SW41j+pVa01Q3l2j+nMEhIA=
X-Google-Smtp-Source: APXvYqyjM73brLAKJq6+yXJVB6DnX6DD1BkXcftrX1JvKTH4WCPo9+xV+HWlboKWD30jUJfk7WS3Bg==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr155345wrv.253.1556877623545;
        Fri, 03 May 2019 03:00:23 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id u11sm2033029wrg.35.2019.05.03.03.00.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 03:00:22 -0700 (PDT)
Subject: Re: [PATCH] mtd: spi-nor: enable 4B opcodes for n25q256a
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20190503085327.5180-1-simon.k.r.goldschmidt@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8161008c-fafd-a89f-d2d8-413224844cd2@gmail.com>
Date:   Fri, 3 May 2019 12:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503085327.5180-1-simon.k.r.goldschmidt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 10:53 AM, Simon Goldschmidt wrote:
> Tested on socfpga cyclone5 where this is required to ensure that the
> boot rom can access this flash after warm reboot.

Are you sure _all_ variants of the N25Q256 support 4NB opcodes ?
I think there were some which didn't, but I might be wrong.

> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> ---
> 
>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index fae147452..4cdec2cc2 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1874,7 +1874,7 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> -	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>  	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
> 


-- 
Best regards,
Marek Vasut

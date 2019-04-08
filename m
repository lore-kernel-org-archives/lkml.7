Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD04C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F5420863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSmq5pBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfDHRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:52:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:52:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id a96so3072535pla.6;
        Mon, 08 Apr 2019 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QNnZho9Ta1Rw1KleEbxa56brUSc+zl1ruj9gmFWgbsc=;
        b=sSmq5pBs17JU0g+09r6+HInrESTm0G7OYF3tt1Csdufe08QQWPqRXCZ0mvx3xaufBo
         yGKnDlYcGb+psgwFEmIB9lrREMgphbT1GcWto/JpHqs9AGnOhIuD0KT4Xu0GtywiBe5Y
         zKPHnK4Ez18fvQl53DBYTPPEJQUDwvqLp9sGOQGnS5UWpCWvp88jevHMCofWrGiUIFpl
         b3tvhkRIHWjFZeLVbseSvEQwI91RdTrld6Ab8i3tAERgJfgR8yA/aBGGfb9DbMlMfsb7
         ERcsnjLeQwfPKBSh9tEVT1mrNCQYiER34H4sA584cQHMdhcGc9bpsXooFJkGmwk2YayW
         R6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QNnZho9Ta1Rw1KleEbxa56brUSc+zl1ruj9gmFWgbsc=;
        b=o/yD8h8XoeGt9MHZgvTrvtF/y7ZpblWrb4BEsH34Uqo+a60aqQjBu3KY/DWm3x5fDR
         ykJUOirpeGS3VASjhApUcdTXb7Twu//fHPZ2ZdSj/cDsjisZj87VkzswUv6VTXSC786c
         ckIys8ZKj7k/tXwWI8lcAu+xCXlF2BhaSBo3hzH3RDs77goLqmw4IG5ZF7YLQtgpzGCt
         iUCuIkLe8xuoejgSjzNhFFEkrgtXbO6dbZ540T+iFDyazqLHwfF0L4mHRNdgaK4ZbjEx
         AOkVWWhb9zd1xBkaChmwLq2wISa98bKETYMBvkhTwnuNVa/7KYO59geUX4aViQFKh8Z4
         znxg==
X-Gm-Message-State: APjAAAVh/vyu7PsOxqAAA3LHo35HX5FKFRP4X/dBrlB7J8vzbN0rEEdF
        GO94tfDPFKCsoOZ5eU5Tw3I=
X-Google-Smtp-Source: APXvYqxZe5KlDJucvOl0aeLUiz+VQclOOyFnsg4wgvzynRSGhY4MhcDjN7hxflQ/EJtdD7ZWDdAfRw==
X-Received: by 2002:a17:902:ea0d:: with SMTP id cu13mr31303737plb.92.1554745920525;
        Mon, 08 Apr 2019 10:52:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12sm49698287pgc.28.2019.04.08.10.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:51:59 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:51:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     broonie@kernel.org, bbrezillon@kernel.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
Message-ID: <20190408175157.GA11988@roeck-us.net>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:29:13PM +0530, Naga Sureshkumar Relli wrote:
> Add support for QSPI controller driver used by Xilinx Zynq SOC.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v2
>  - Updated the driver to call spi_mem_default_supports_op() from
>    ctrl->supports_op()
> Changes in v1
>  - Added COMPILE_TEST macro
>  - converted MASKs to GENMASK() and BIT() macros
>  - Renamed MODEBITS to ZYNQ_QSPI_MODEBITS
>  - Removed checking buswidth() code, as it is already handled by framework
>  - Updated in comments regarding baud rate calculation
> ---
>  drivers/spi/Kconfig         |  10 +-
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-zynq-qspi.c | 761 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 771 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/spi/spi-zynq-qspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..7bf7d38 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -816,9 +816,17 @@ config SPI_XTENSA_XTFPGA
>  	  16 bit words in SPI mode 0, automatically asserting CS on transfer
>  	  start and deasserting on end.
>  
> +config SPI_ZYNQ_QSPI
> +	tristate "Xilinx Zynq QSPI controller"
> +	depends on ARCH_ZYNQ || COMPILE_TEST

This results in

drivers/spi/spi-zynq-qspi.c: In function 'zynq_qspi_write_op':
drivers/spi/spi-zynq-qspi.c:410:3: error: implicit declaration of function 'writesl'; did you mean 'writel'?

drivers/spi/spi-zynq-qspi.c: In function 'zynq_qspi_read_op':
drivers/spi/spi-zynq-qspi.c:436:3: error: implicit declaration of function 'readsl'; did you mean 'readl'?

when building allmodconfig/allyesconfig on architectures not supporting
writesl/readsl (such as alpha or parisc).

Guenter

Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97200C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BA42072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578438265;
	bh=zKdukV38l1KtyXdcWoPM86hXcKY/+oxlv2OrUMNI2vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dGleTzu1hA5OxUlg0fWLvImHQrR5653aOSFDFg+OEf0K7YzEJ6KePw1d/S6mm8MP2
	 BOfWnLo5S7F08P8jmYxDJnLgr3w+K2IADq48B7UCxakYijMTN53xlr1JoiZXREKJHu
	 +kcGpG+Z2TqzJOq4ZPr2SXxmOJ15QWOYAJ+sXf3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgAGXEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgAGXEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:04:24 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599CB2072A;
        Tue,  7 Jan 2020 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578438263;
        bh=zKdukV38l1KtyXdcWoPM86hXcKY/+oxlv2OrUMNI2vE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KGXTtl/x+Q6PPjHP8G3bFP+QfBF+JvWyTeZyG79qarhp5mMcFBzpm5js0OpxdJ2cD
         BoColFbUccjeZ1H6QTqU/twgYno0hGc8+zlUp3+pB6ykVJsPcB5ERfOzA8soTA/67Q
         K1px87lnvxqP9mtIEOVnkwzPvBCH9xacOIl5XdtQ=
Received: by mail-qk1-f179.google.com with SMTP id j9so1050345qkk.1;
        Tue, 07 Jan 2020 15:04:23 -0800 (PST)
X-Gm-Message-State: APjAAAVzkQtbOlZvqiNUW14iU8x/+mfo/7a/F+2467PNOZthzxD0TdLV
        ujt10Z+yRvEMqHmobF4Pr9tsmE6AcR3p3af6Ow==
X-Google-Smtp-Source: APXvYqypMp1YvCAnvRLYK0n8h2AoOEfsjNGRjZvjWA9oVL8NeuOJojQR+6JSl6kEe46bz5HE6afLLdy/0Yk0IElNOTg=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr1538529qkl.119.1578438262529;
 Tue, 07 Jan 2020 15:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20200107220938.2412463-1-arnd@arndb.de>
In-Reply-To: <20200107220938.2412463-1-arnd@arndb.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Jan 2020 17:04:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0bVEkDfUw9+8gf=EVN=xjH4F1uyrmtWQfgc80FsTvew@mail.gmail.com>
Message-ID: <CAL_JsqJ0bVEkDfUw9+8gf=EVN=xjH4F1uyrmtWQfgc80FsTvew@mail.gmail.com>
Subject: Re: [PATCH] of: add dummy of_platform_device_destroy
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Frank Rowand <frowand.list@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The new phy-j721e-wiz driver causes a link failure without CONFIG_OF:
>
> drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
> phy-j721e-wiz.c:(.text+0x40): undefined reference to `of_platform_device_destroy'
>
> Add a dummy version of this function to avoid having to add Kconfig
> dependencies for the driver.
>
> Fixes: 42440de5438a ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/of_platform.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 84a966623e78..2551c263e57d 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -54,11 +54,16 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
>                                          struct device *parent);
>  #ifdef CONFIG_OF
>  extern struct platform_device *of_find_device_by_node(struct device_node *np);
> +extern int of_platform_device_destroy(struct device *dev, void *data);

This is already declared, so don't you want to remove the existing one.

>  #else
>  static inline struct platform_device *of_find_device_by_node(struct device_node *np)
>  {
>         return NULL;
>  }
> +static inline int of_platform_device_destroy(struct device *dev, void *data)
> +{
> +       return 0;
> +}

I'm curious why this is needed, but of_platform_device_create() is not?

>  #endif
>
>  /* Platform devices and busses creation */
> --
> 2.20.0
>

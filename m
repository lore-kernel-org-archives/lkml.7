Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A93C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC552070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUC3kuwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfDBHlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:41:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfDBHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:41:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so6137881pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0DygoCdd8v7Idn0OS/eHsV068yD1YAoIz9JRL6f968Y=;
        b=wUC3kuwF+78TcNsB9XUyOoGfC1otCCNAbFSu8ZpS8yHP+p4eYEOEkKEAQHj9Zw1e3I
         Z1LBVexOuaWlU9O65dfXEoUP1texilH0/VOADyDQKJksMQrj2pLsrIPF2k+mNbL3kmq/
         yanI8cdEtgDzfYvFVXCfCQ/lHtszLmCxdXP1KFWBfatn0KzcTYZS+hYXIsa91tazL4fD
         sArW6gRWzB2aBpPsTpAou5qlfl1VXnIX0Pu92sl9m4stNYaG78zUipba9JGcvtl4RkQv
         PYPO9B3sl2Q56znmdB8ScMzJkEUclAnVSasn2nq1ZwNO8kgHfjSh4o8xo30thVj0d4bR
         ohfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0DygoCdd8v7Idn0OS/eHsV068yD1YAoIz9JRL6f968Y=;
        b=kBJEn2cJ4qNkS5KuSlHGmpn1vNoKONdhO9o4hS8pI9C48WN1mR7WaZxmcJ5LbhaFc2
         tjw38/gsq3Bm08LJpNGCokb2ircrrV6I9nfXJMhnFprl+E/qBJMA7/ezh2vKpZRl/tkH
         zv8yEfPO2XGFPNWu0xqs6DaqyDLUMLJ8E1Jy3b6zBvjqPXyCCFflwLo9EZ8LYgThRzz/
         B+SV2fWbbdeSKcWBvD78G5KHfUcICvqfMWv9QxjS0c7RVO9GfqeY7GQbN4L7qh7LtiKO
         x9ErYgXxoizca5l3ElYl0mXRaxiq8FOFB4MfnFjBzVY9tcucAt+8n6C+ey3HwVGrF/32
         hsxQ==
X-Gm-Message-State: APjAAAUOnblR9cwLcklrbrevqSe2yuBLE/PHOZlx0a9+arMKaBPJ1GBY
        0Zwm8Jgcw96S9f3vM0byHx2zjg==
X-Google-Smtp-Source: APXvYqwIU2EKsOb+GkR7CmnXXTOJFz6V6UxQ1p8yRizr5jm2ahSGCW+lo8VETFezXn1pZWA6RLJqnA==
X-Received: by 2002:aa7:884b:: with SMTP id k11mr6180199pfo.49.1554190871179;
        Tue, 02 Apr 2019 00:41:11 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id 14sm27115895pft.137.2019.04.02.00.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:41:10 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:41:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v6 05/11] mfd: core: document mfd_add_devices()
Message-ID: <20190402074103.GG4187@dell>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318174228.18194-6-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a kernel doc for mfd_add_devices().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mfd/mfd-core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 94e3f32ce935..0898a8db1747 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, int id,
>  	return ret;
>  }
>  
> +/**
> + * mfd_add_devices - register a set of child devices

"register child devices"

> + *
> + * @parent: Parent device for all sub-nodes.
> + * @id: Platform device id. If >= 0, each sub-device will have its cell_id
> + *      added to this number and use it as the platform device id.
> + * @cells: Array of mfd cells describing sub-devices.
> + * @n_devs: Number of sub-devices to register.
> + * @mem_base: Parent register range resource for sub-devices.
> + * @irq_base: Base of the range of virtual interrupt numbers allocated for
> + *            this MFD device. Unused if @domain is specified.
> + * @domain: Interrupt domain used to create mappings for HW interrupt numbers
> + *          specificed in sub-devices' IRQ resources.

Spelling.

> + */
>  int mfd_add_devices(struct device *parent, int id,
>  		    const struct mfd_cell *cells, int n_devs,
>  		    struct resource *mem_base,

How about this:

/**
 * mfd_add_devices - register child devices
 *
 * @parent:	Pointer to parent device.
 * @id:		Can be PLATFORM_DEVID_AUTO to let the Platform API take care
 * 		of device numbering, or will be added to a device's cell_id.
 * @cells:	Array of (struct mfd_cell)s describing child devices.
 * @n_devs:	Number of child devices to register.
 * @mem_base:	Parent register range resource for child devices.
 * @irq_base:	Base of the range of virtual interrupt numbers allocated for
 * 		this MFD device. Unused if @domain is specified.
 * @domain:	Interrupt domain to create mappings for hardware interrupts.
 */


-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A3ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4447721929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/Z1dluM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408308AbfJYIg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:36:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38181 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbfJYIgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:36:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so971043wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zH6fhJDQ4DcI0IvbaRP4GYERWR/GM64+6SCBGVBvvnM=;
        b=D/Z1dluMcIPn/WkbjBQ4ikinQ/eFoxTiylcePish3K0XRbliy8YkkjHzKai4oKWzsZ
         SEtsn+i0PmLwvXF6A8jd75FOGxIsd+mTEmFQ/SPIq7n/QRYA0UF77a7mcvSpxBFQg50L
         Zbbu4zZzULyWMikqJ2QTYTQ95pN6NWzNosoMX0e9lQplGoYT6+D5iYp4vWzgNPfiyGf6
         tMMuMLDC8+qA/ckJB7AlUvASVtvQsHKXDEX/hBia12sMhwKLLnN0vaaOob67en8sRq9X
         NyPBHVmPuseLG7bFTy4dfZKatYU1cITII7F1Acl+SUfyh9Xi/vEhbHEJLIf/tEKAylVp
         TY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zH6fhJDQ4DcI0IvbaRP4GYERWR/GM64+6SCBGVBvvnM=;
        b=j648FqPMGg/BcS6CDIDy2JJf0hp/hhesyUBrvArZHlwqwp3raf/HtG3YqXsa/LnJLK
         WO1k+ofaJ0z/6fy20RLuAoQUc+XqsP0D8mX1FddFeruyNYQ96klEuxAzotqXSu1a6wrj
         2FJvFajarFxe3xOM617un+gDKudhZ/eBVr/KIS4GCXiBtOBer3sCvqo01hsdngoFnoNV
         OiYKB1SS7ukWrOkI+w3BdDrZgLl/WjYdZgxwwUsDBBU7ySmDyaC7iDjgk9057S7VF8Np
         R0YftvFiYFM+RIrwpmjUxzshocgTEmXGs0B1HJz5DkFCaLfKdC5vcILYRpLt0ieYfHJi
         ml6A==
X-Gm-Message-State: APjAAAXMhQFEQxORKfahBYjx6es/7fw8Qgwu/piDQAKZ0Sn9U/J/vEoC
        FzEcSkcNUqbYcaosAVD8YdXLZw==
X-Google-Smtp-Source: APXvYqwkiUM7E12pQJvBKfXuE1sNT+XzGyP73rWBvWClOac5RajXWu6AxvfevVu1SDC1YPoZf9708w==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr2230590wme.144.1571992583821;
        Fri, 25 Oct 2019 01:36:23 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u1sm1215506wmc.38.2019.10.25.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:36:23 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:36:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 02/10] mfd: cs5535-mfd: Remove mfd_cell->id hack
Message-ID: <20191025083621.rwa3wug67vwapdhw@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-3-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:24PM +0100, Lee Jones wrote:
> The current implementation abuses the platform 'id' mfd_cell member
> to index into the correct resources entry.  Seeing as enough resource
> slots are already available, let's just loop through all available
> bars and allocate them to their appropriate slot, even if they happen
> to be zero.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/mfd/cs5535-mfd.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index cda7f5b942e7..b35f1efa01f6 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -63,25 +63,21 @@ static struct resource cs5535_mfd_resources[NR_BARS];
>  
>  static struct mfd_cell cs5535_mfd_cells[] = {
>  	{
> -		.id = SMB_BAR,
>  		.name = "cs5535-smb",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[SMB_BAR],
>  	},
>  	{
> -		.id = GPIO_BAR,
>  		.name = "cs5535-gpio",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[GPIO_BAR],
>  	},
>  	{
> -		.id = MFGPT_BAR,
>  		.name = "cs5535-mfgpt",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[MFGPT_BAR],
>  	},
>  	{
> -		.id = PMS_BAR,
>  		.name = "cs5535-pms",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[PMS_BAR],
> @@ -90,7 +86,6 @@ static struct mfd_cell cs5535_mfd_cells[] = {
>  		.disable = cs5535_mfd_res_disable,
>  	},
>  	{
> -		.id = ACPI_BAR,
>  		.name = "cs5535-acpi",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> @@ -108,23 +103,18 @@ static const char *olpc_acpi_clones[] = {
>  static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		const struct pci_device_id *id)
>  {
> -	int err, i;
> +	int err, bar;
>  
>  	err = pci_enable_device(pdev);
>  	if (err)
>  		return err;
>  
> -	/* fill in IO range for each cell; subdrivers handle the region */
> -	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
> -		int bar = cs5535_mfd_cells[i].id;
> +	for (bar = 0; bar < NR_BARS; bar++) {
>  		struct resource *r = &cs5535_mfd_resources[bar];
>  
>  		r->flags = IORESOURCE_IO;
>  		r->start = pci_resource_start(pdev, bar);
>  		r->end = pci_resource_end(pdev, bar);
> -
> -		/* id is used for temporarily storing BAR; unset it now */
> -		cs5535_mfd_cells[i].id = 0;
>  	}
>  
>  	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
> -- 
> 2.17.1
> 

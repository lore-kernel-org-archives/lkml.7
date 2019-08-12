Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D720684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kMK9Lpmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfHLNKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40201 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbfHLNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so76849230qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=likbUpy+hqGKJ+aVkUc0jeuI5OoHP9NpOwWastRmABc=;
        b=kMK9LpmiWRr60D1T45SSevOv2vlXHiDiuiZf4ulsSujUTJizy0pUz3kKtJ7qNNGElj
         mFCM6EpcfkE6SAynb+2ABW1IUSVqv2ssditwGlUOMmvdLgN1O01qru86vwQGjt+PtEcw
         yCn6ptRF+oQZfo9bCTN+M7VWA/LinJSYRnBoCCzIhLilDCp9A+WNZUvoYIQch03LkiyW
         UCAF0avgTHRqAP6fpSSdLw5TOSHhg0FRWpCrCjIBz6vBgjj5BFqOsozA1HSfhsf37z88
         GlNWxbskvtCvJaIoLD5/kiOmhDqKuvUYuNv8F3UdSBXmES59wTP1s/FuIEgyxkN33U0M
         QDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=likbUpy+hqGKJ+aVkUc0jeuI5OoHP9NpOwWastRmABc=;
        b=HhxX5v+pfrYMm28nEVT31luiFY3uKZmg2OOeFdwGyy++m8XEGtXQKjZ1IbPR2YvZ7m
         yAohPzyv5juavTkZpzOZ7cAenhT8L2Y2ZOpq8oDUsQuSgGjZiTKL7y1yqI37tcpm3Y1A
         b4iIAh182FzPPR39xxPrOQagi9M39a0MrUFxwODG+6KtOWuMCti74LnSfeMgy174R4h0
         QlDN1o4m8z4b+WsiKnibzy+scffUkffwdryma7mu34DtmC9R+cWBVthzJsd74bww8Nwt
         4W4v38QrX5uiBRDSr9ZbSr8ejJugpzd8mWww/POG75ayKQKUcexsi3huiXEDqtQFGV25
         rQ4w==
X-Gm-Message-State: APjAAAW7v3HMtpn7tgKLV5e3eAQTi+BZ/dGKBsqX1B70tlApDfsMMzPt
        RJT6qmHq54DW8ZOSrvZPTJBwHSd8J48=
X-Google-Smtp-Source: APXvYqzGPtJIkSMQQNtzwkSQiuzOThChzk/aOVnFzsP0ZJUn84TcNwpdr4gmvQMUHX5Di1/LtzK0ZA==
X-Received: by 2002:a37:b381:: with SMTP id c123mr30501028qkf.349.1565615404632;
        Mon, 12 Aug 2019 06:10:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm60899009qta.58.2019.08.12.06.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 06:10:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxA5L-0007Yr-Q4; Mon, 12 Aug 2019 10:10:03 -0300
Date:   Mon, 12 Aug 2019 10:10:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ivan.lazeev@gmail.com
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190812131003.GF24457@ziepe.ca>
References: <20190811185218.16893-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811185218.16893-1-ivan.lazeev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 09:52:18PM +0300, ivan.lazeev@gmail.com wrote:
> From: Vanya Lazeev <ivan.lazeev@gmail.com>
> 
> The patch is an attempt to make fTPM on AMD Zen CPUs work.
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> The problem seems to be that tpm_crb driver doesn't expect tpm command
> and response memory regions to belong to different ACPI resources.
> 
> Tested on Asrock ITX motherboard with Ryzen 2600X CPU.
> However, I don't have any other hardware to test the changes on and no
> expertise to be sure that other TPMs won't break as a result.
> Hopefully, the patch will be useful.
> 
> Changes from v1:
> - use list_for_each_safe
> 
> Signed-off-by: Vanya Lazeev <ivan.lazeev@gmail.com>
>  drivers/char/tpm/tpm_crb.c | 146 ++++++++++++++++++++++++++++---------
>  1 file changed, 110 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index e59f1f91d..b0e797464 100644
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -91,7 +91,6 @@ enum crb_status {
>  struct crb_priv {
>  	u32 sm;
>  	const char *hid;
> -	void __iomem *iobase;
>  	struct crb_regs_head __iomem *regs_h;
>  	struct crb_regs_tail __iomem *regs_t;
>  	u8 __iomem *cmd;
> @@ -108,6 +107,13 @@ struct tpm2_crb_smc {
>  	u32 smc_func_id;
>  };
>  
> +struct crb_resource {
> +	struct resource io_res;
> +	void __iomem *iobase;
> +
> +	struct list_head link;
> +};
> +
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  				unsigned long timeout)
>  {
> @@ -432,23 +438,69 @@ static const struct tpm_class_ops tpm_crb = {
>  	.req_complete_val = CRB_DRV_STS_COMPLETE,
>  };
>  
> +static void crb_free_resource_list(struct list_head *resources)
> +{
> +	struct list_head *position, *tmp;
> +
> +	list_for_each_safe(position, tmp, resources)
> +		kfree(list_entry(position, struct crb_resource, link));
> +}
> +
> +/**
> + * Checks if resource @io_res contains range with the specified @start and @size
> + * completely or, when @strict is false, at least it's beginning.
> + * Non-strict match is needed to work around broken BIOSes that return
> + * inconsistent values from ACPI regions vs registers.
> + */
> +static inline bool crb_resource_contains(const struct resource *io_res,
> +					 u64 start, u32 size, bool strict)
> +{
> +	return start >= io_res->start &&
> +		(start + size - 1 <= io_res->end ||
> +		 (!strict && start <= io_res->end));
> +}
> +
> +static struct crb_resource *crb_containing_resource(
> +		const struct list_head *resources,
> +		u64 start, u32 size, bool strict)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, resources) {
> +		struct crb_resource *cres;
> +
> +		cres = list_entry(pos, struct crb_resource, link);
> +		if (crb_resource_contains(&cres->io_res, start, size, strict))
> +			return cres;
> +	}
> +
> +	return NULL;
> +}

This flow seems very strange, why isn't this part of crb_map_res?

>  static int crb_check_resource(struct acpi_resource *ares, void *data)
>  {
> -	struct resource *io_res = data;
> +	struct list_head *list = data;
> +	struct crb_resource *cres;
>  	struct resource_win win;
>  	struct resource *res = &(win.res);
>  
>  	if (acpi_dev_resource_memory(ares, res) ||
>  	    acpi_dev_resource_address_space(ares, &win)) {
> -		*io_res = *res;
> -		io_res->name = NULL;
> +		cres = kzalloc(sizeof(*cres), GFP_KERNEL);
> +		if (!cres)
> +			return -ENOMEM;
> +
> +		cres->io_res = *res;
> +		cres->io_res.name = NULL;
> +
> +		list_add_tail(&cres->link, list);

And why is this allocating memory inside the acpi table walker? It
seems to me like the memory should be allocated once the mapping is
made.

Maybe all the mappings should be created from the ACPI ranges right
away?

> @@ -460,10 +512,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
>  	if (start != new_res.start)
>  		return (void __iomem *) ERR_PTR(-EINVAL);
>  
> -	if (!resource_contains(io_res, &new_res))
> +	if (!cres)
>  		return devm_ioremap_resource(dev, &new_res);
>  
> -	return priv->iobase + (new_res.start - io_res->start);
> +	if (!cres->iobase) {
> +		cres->iobase = devm_ioremap_resource(dev, &cres->io_res);
> +		if (IS_ERR(cres->iobase))
> +			return cres->iobase;
> +	}

It sounds likethe real bug is that the crb_map_res only considers a
single active mapping, while these AMD chips need more than one?

Jason

Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfE3aEL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfJUMd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:33:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:33:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so13357520wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igdzMZW8PEVq+rP0kfzN3gxYjw1q6KE8RoNmwlvNgqk=;
        b=WfE3aEL32Zi1ro2hTyQ62/OxFK0sTG/jK8eWXYlj3sB7EbvRJft+ElmkFRMFrCrAPV
         inr+egfBHoR09V11729xXvbMdlcLSk8hWODchpL6JXNr3FZ2GEEBjVRqiwr8zgBLpSmk
         7gvLOxJ4aon6iYWL2Kax9Mqim/4pXiWWLZbQZVpPG3Zp8QpLbYZwgU297qqUgK3egsAS
         v1q13riJaYZRUs40T45+jQ/ZCH15JbmxbeCO00LPf5WcJ8n83rxOeieLUfx+pT7G4wRO
         SgasXY00ZP/GBwL0qInWjdB7e++T95xLQ/sflEUdr9VwdLdXFNkaysJbZ6F9OtihJjgD
         291A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igdzMZW8PEVq+rP0kfzN3gxYjw1q6KE8RoNmwlvNgqk=;
        b=rdYKIm5Yi7xpEgD1KMP8awHx5/mKjuSacaCJiV1jJL+8bDKi67IZzGkjsT4QM+EoCH
         U3DAAFRXsIJkbX5ys5DeZjCE3U1EuyDPHfYy9on8SbaVAyXdVtA8fPHnDAhMnJY3bjaP
         b4bIhzo+92K5gZFJ1c/U310wNGcLLyLzewoROVHwLEQUTnLEe/AR1EXH4baa2hARTgB0
         /LCFnmyFyUeTUo51XfVZDPHdEFJ6sJa8D+hLNdfJLoybJ4TJfpmycz2gTdd+Gios20ui
         nRFd0AbsrJpThB7YLmSf8LkGf3Q6m3L840RPMohY85q7EAU2qe/GUogjZOfO5hzQMegn
         Kbfg==
X-Gm-Message-State: APjAAAVLr0F/QY0Lwgg0jrrZv/vfG2V1HplMMmrS2JNrIKiBi2sIpmRK
        p0HH7Ap7qm27qiUpQKKJ2c9SnzPAXmokQQ==
X-Google-Smtp-Source: APXvYqx1eTPmS8T+6lx0EnxAAUUL879nCRShMAODGRComRx1+OUZGuCpabLH5079HLTPSpfzNCmvfg==
X-Received: by 2002:adf:cc90:: with SMTP id p16mr5128175wrj.377.1571661235701;
        Mon, 21 Oct 2019 05:33:55 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z1sm14813211wrn.57.2019.10.21.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:33:55 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:33:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 8/9] mfd: mfd-core: Remove usage counting for
 .{en,dis}able() call-backs
Message-ID: <20191021123353.nhb2ynq6d52skoif@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-9-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:21AM +0100, Lee Jones wrote:
> The MFD implementation for reference counting was complex and unnecessary.
> There was only one bona fide user which has now been converted to handle
> the process in a different way. Any future resource protection, shared
> enablement functions should be handed by the parent device, rather than
> through the MFD subsystem API.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/mfd/mfd-core.c   | 57 +++++++---------------------------------
>  include/linux/mfd/core.h |  2 --
>  2 files changed, 9 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 90b43b44a15a..5d56015baeeb 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -26,53 +26,31 @@ static struct device_type mfd_dev_type = {
>  int mfd_cell_enable(struct platform_device *pdev)
>  {
>  	const struct mfd_cell *cell = mfd_get_cell(pdev);
> -	int err = 0;
>  
>  	if (!cell->enable) {
>  		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
>  		return 0;
>  	}
>  
> -	/* only call enable hook if the cell wasn't previously enabled */
> -	if (atomic_inc_return(cell->usage_count) == 1)
> -		err = cell->enable(pdev);
> -
> -	/* if the enable hook failed, decrement counter to allow retries */
> -	if (err)
> -		atomic_dec(cell->usage_count);
> -
> -	return err;
> +	return cell->enable(pdev);
>  }
>  EXPORT_SYMBOL(mfd_cell_enable);
>  
>  int mfd_cell_disable(struct platform_device *pdev)
>  {
>  	const struct mfd_cell *cell = mfd_get_cell(pdev);
> -	int err = 0;
>  
>  	if (!cell->enable) {
>  		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
>  		return 0;
>  	}
>  
> -	/* only disable if no other clients are using it */
> -	if (atomic_dec_return(cell->usage_count) == 0)
> -		err = cell->disable(pdev);
> -
> -	/* if the disable hook failed, increment to allow retries */
> -	if (err)
> -		atomic_inc(cell->usage_count);
> -
> -	/* sanity check; did someone call disable too many times? */
> -	WARN_ON(atomic_read(cell->usage_count) < 0);
> -
> -	return err;
> +	return cell->disable(pdev);
>  }
>  EXPORT_SYMBOL(mfd_cell_disable);
>  
>  static int mfd_platform_add_cell(struct platform_device *pdev,
> -				 const struct mfd_cell *cell,
> -				 atomic_t *usage_count)
> +				 const struct mfd_cell *cell)
>  {
>  	if (!cell)
>  		return 0;
> @@ -81,7 +59,6 @@ static int mfd_platform_add_cell(struct platform_device *pdev,
>  	if (!pdev->mfd_cell)
>  		return -ENOMEM;
>  
> -	pdev->mfd_cell->usage_count = usage_count;
>  	return 0;
>  }
>  
> @@ -144,7 +121,7 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
>  #endif
>  
>  static int mfd_add_device(struct device *parent, int id,
> -			  const struct mfd_cell *cell, atomic_t *usage_count,
> +			  const struct mfd_cell *cell,
>  			  struct resource *mem_base,
>  			  int irq_base, struct irq_domain *domain)
>  {
> @@ -206,7 +183,7 @@ static int mfd_add_device(struct device *parent, int id,
>  			goto fail_alias;
>  	}
>  
> -	ret = mfd_platform_add_cell(pdev, cell, usage_count);
> +	ret = mfd_platform_add_cell(pdev, cell);
>  	if (ret)
>  		goto fail_alias;
>  
> @@ -296,16 +273,9 @@ int mfd_add_devices(struct device *parent, int id,
>  {
>  	int i;
>  	int ret;
> -	atomic_t *cnts;
> -
> -	/* initialize reference counting for all cells */
> -	cnts = kcalloc(n_devs, sizeof(*cnts), GFP_KERNEL);
> -	if (!cnts)
> -		return -ENOMEM;
>  
>  	for (i = 0; i < n_devs; i++) {
> -		atomic_set(&cnts[i], 0);
> -		ret = mfd_add_device(parent, id, cells + i, cnts + i, mem_base,
> +		ret = mfd_add_device(parent, id, cells + i, mem_base,
>  				     irq_base, domain);
>  		if (ret)
>  			goto fail;
> @@ -316,17 +286,15 @@ int mfd_add_devices(struct device *parent, int id,
>  fail:
>  	if (i)
>  		mfd_remove_devices(parent);
> -	else
> -		kfree(cnts);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(mfd_add_devices);
>  
> -static int mfd_remove_devices_fn(struct device *dev, void *c)
> +static int mfd_remove_devices_fn(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev;
>  	const struct mfd_cell *cell;
> -	atomic_t **usage_count = c;
>  
>  	if (dev->type != &mfd_dev_type)
>  		return 0;
> @@ -337,20 +305,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *c)
>  	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
>  					       cell->num_parent_supplies);
>  
> -	/* find the base address of usage_count pointers (for freeing) */
> -	if (!*usage_count || (cell->usage_count < *usage_count))
> -		*usage_count = cell->usage_count;
> -
>  	platform_device_unregister(pdev);
>  	return 0;
>  }
>  
>  void mfd_remove_devices(struct device *parent)
>  {
> -	atomic_t *cnts = NULL;
> -
> -	device_for_each_child_reverse(parent, &cnts, mfd_remove_devices_fn);
> -	kfree(cnts);
> +	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
>  }
>  EXPORT_SYMBOL(mfd_remove_devices);
>  
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index bd8c0e089164..919f09fb07b7 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -30,8 +30,6 @@ struct mfd_cell {
>  	const char		*name;
>  	int			id;
>  
> -	/* refcounting for multiple drivers to use a single cell */
> -	atomic_t		*usage_count;
>  	int			(*enable)(struct platform_device *dev);
>  	int			(*disable)(struct platform_device *dev);
>  
> -- 
> 2.17.1
> 

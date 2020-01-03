Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70651C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EC122314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFbz82Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgACHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:39:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44756 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgACHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:39:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so23057620pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 23:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjtveIW4Cl8kNrXZqHnmr6fnNFiKvYCRuejNL5G2GwA=;
        b=uFbz82UcbCfLMIjitqY2s+Lf/IFr5b/di7TwUd18XW7lu7xxcWBAj7ARLY+CotoDWW
         yiGAQS0F3w1BHdhzdF+AtSWqmHlBAkIcl2c5eSKyB1YKsg+dWtOKhgZqiehTnsyXLGnO
         JPNZnSm+TeooIHjD2gpIjsFM1C8sADgcLsyLAs83Z4qLFiK05PSU82g5gQn+9WyAvK0B
         OeG8s/YAK/hbsMGsPWn13iXxRUst9irRAJ0NPuzrlG0uzYZYh2NDRXnhH9Ug6zRgR30H
         21QwSQ7vSTYpd2EtkOtYXTtVfDodJDeQjKLx/T81AuZA554FOPJR6/wq9E0o1rge9/98
         Ctrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjtveIW4Cl8kNrXZqHnmr6fnNFiKvYCRuejNL5G2GwA=;
        b=Op9kU2HnFveibi+3U1fZ+WElfTz5IKo/TZaF62dSb51KobYH7fk5xnomhMggspu68w
         5ZRG1Txfr/NZwlnyV7SGySpmaTy6sWyTtvL6QPIv//sZbG14fPfDYeVRM9Lb7DNIPDAC
         Wei9prGDxpmZlQ8/YxJefnI2dajlrRt9jogX7pyzV+k3LFbUlrRwfi6wc1wjj30bZ1Zn
         QCckFX0F2YwxFkW5G774c61LX+WaEWQRy1pK0ZdDtQN+Ni3WwkMKBNqumqCW/UCAT0PQ
         zCF/bEG/1w6a7VI50bP5bJ4xbAToQu2Azow4SrWwolaSFc125xUQ+MmPaf0CsZHMZrop
         8x3A==
X-Gm-Message-State: APjAAAX4MiDxvLPDlpK52I4LhtcAihda476PkHDS5E3m9BRRpLbQhM9W
        ELIsesd7JlnXUc8XTWMJ3YcQow==
X-Google-Smtp-Source: APXvYqyyU7kpxL3w14To+lQvT4cnfmqHinwWDkZhr0aaOhBIOoiPbjX7uA+9mJHxSwxrRijEC7CYoQ==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr60567555pfg.51.1578037169173;
        Thu, 02 Jan 2020 23:39:29 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y6sm13245950pjy.1.2020.01.02.23.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 23:39:28 -0800 (PST)
Date:   Thu, 2 Jan 2020 23:39:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] clk: Use parent node pointer during registration if
 necessary
Message-ID: <20200103073926.GM988120@minitux>
References: <20191230190455.141339-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230190455.141339-1-sboyd@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Dec 11:04 PST 2019, Stephen Boyd wrote:

> Sometimes clk drivers are attached to devices which are children of a
> parent device that is connected to a node in DT. This happens when
> devices are MFD-ish and the parent device driver mostly registers child
> devices to match against drivers placed in their respective subsystem
> directories like drivers/clk, drivers/regulator, etc. When the clk
> driver calls clk_register() with a device pointer, that struct device
> pointer won't have a device_node associated with it because it was
> created purely in software as a way to partition logic to a subsystem.
> 
> This causes problems for the way we find parent clks for the clks
> registered by these child devices because we look at the registering
> device's device_node pointer to lookup 'clocks' and 'clock-names'
> properties. Let's use the parent device's device_node pointer if the
> registering device doesn't have a device_node but the parent does. This
> simplifies clk registration code by avoiding the need to assign some
> device_node to the device registering the clk.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> I decided to introduce a new function instead of trying to jam it all
> in the one line where we assign np. This way the function gets the 
> true 'np' as an argument all the time.
> 

Looks better.

>  drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b68e200829f2..a743fffe8e46 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3719,6 +3719,28 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * dev_or_parent_of_node - Get device node of @dev or @dev's parent

()

> + * @dev: Device to get device node of
> + *
> + * Returns: device node pointer of @dev, or the device node pointer of

Return: (no 's')


With that,

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> + * @dev->parent if dev doesn't have a device node, or NULL if neither
> + * @dev or @dev->parent have a device node.
> + */
> +static struct device_node *dev_or_parent_of_node(struct device *dev)
> +{
> +	struct device_node *np;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	np = dev_of_node(dev);
> +	if (!np)
> +		np = dev_of_node(dev->parent);
> +
> +	return np;
> +}
> +
>  /**
>   * clk_register - allocate a new clock, register it and return an opaque cookie
>   * @dev: device that is registering this clock
> @@ -3734,7 +3756,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>   */
>  struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>  {
> -	return __clk_register(dev, dev_of_node(dev), hw);
> +	return __clk_register(dev, dev_or_parent_of_node(dev), hw);
>  }
>  EXPORT_SYMBOL_GPL(clk_register);
>  
> @@ -3750,7 +3772,8 @@ EXPORT_SYMBOL_GPL(clk_register);
>   */
>  int clk_hw_register(struct device *dev, struct clk_hw *hw)
>  {
> -	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_of_node(dev), hw));
> +	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_or_parent_of_node(dev),
> +			       hw));
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_register);
>  
> 
> base-commit: e42617b825f8073569da76dc4510bfa019b1c35a
> -- 
> Sent by a computer, using git, on the internet
> 

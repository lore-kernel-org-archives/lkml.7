Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB34C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4482083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzLY+lLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFEGbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:31:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33003 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:31:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so994496wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kPABpBdEc3JTnMjfzo8eSt1KXnISiocMAZR6O03BAgU=;
        b=HzLY+lLsLj3qaaJ+D2CLUzYc+xbV0JyaiioPbo7bzkOvittl+obBRocrPoRx0ERV/Z
         Sv0jkq6H5Hx8Xv08saYNFTLr9ZSQpwzgLrmrRag/F5JbXHuABntsAg3OD2MJaQY7Tsi/
         t8Sy0/hcpQJu+bYKKzQmxEGCR7CEX1qpOgV3PYW5fyQeF0D7p2qrz+jDM5v/IHOnFYJv
         sIcVHF4dEN47FR7WMSfUQIBOYn7ZBxs0qnSQ+IES3riUsrbczTaunflqF8LDH3BZpUVx
         MinLGEvkZH3GBuw95K85e9L+effbdRnLQCb8BlvVjnfyaTmgnkOysOis9qYjZdoxgS65
         /OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kPABpBdEc3JTnMjfzo8eSt1KXnISiocMAZR6O03BAgU=;
        b=qPxQwm+2VvrkKnovN1JEUmtdmsUYjMRiK6Ke9Z72epD3rq67aAAJswSKVZDzKdLzTw
         x/gnISR9yt0b8crb42fvgsstyojoUDgxaglaW842I9va6ff9pHaZ8Wlhjt/Ncv9y+QbK
         zrzXa1QFUyPOVtOhgWKvQLCW5KNw8w0Nzyk075q54/e/jdmGm6Dwzl2GCKM6SmgxOm1F
         Ycrl9rdd01P8ROcP3LDa5LYCK0zBPpLK+MI9XznvhPdzCbKXBOXvDIVa0yzzkxLA7bD6
         fLvaNOYm/HL+Z1S6u7u9F8w7Hbf0s5dWW3ERvAxTXN3o8BZENEfh32kq4mXMVLGscIz1
         3Utw==
X-Gm-Message-State: APjAAAU5eyJDrCEYyGhciuSiKM2XruPOkP23Dz0RsGCjILpDCb7bY9bl
        Jm6juhgQk99q8nnWisclUpJPDYgqzYE=
X-Google-Smtp-Source: APXvYqykg+6bOQSvazbg0ZZqzdfyZZcBKzc90ulbBm9/kykgr8fehEsw7mfEFIov1bRDI1aH+DVIMA==
X-Received: by 2002:a1c:a648:: with SMTP id p69mr8769189wme.155.1559716269969;
        Tue, 04 Jun 2019 23:31:09 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s11sm14946978wro.17.2019.06.04.23.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 23:31:09 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:31:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: core: Support multiple OF child devices of the
 same type
Message-ID: <20190605063108.GF4797@dell>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Robert Hancock wrote:

> Previously the MFD core supported assigning OF nodes to created MFD
> devices, but relied solely on matching the of_compatible string. This
> would result in devices being potentially assigned the wrong node if
> there are multiple devices with the same compatible string within a
> multifunction device.
> 
> Add support for matching the full name of the node in the MFD cell
> definition, so that we can match against a specific instance of a
> device. If this is not specified, we match just based on the
> compatible string, as before.
> 
> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
> ---
>  drivers/mfd/mfd-core.c   | 5 ++++-
>  include/linux/mfd/core.h | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 1ade4c8..74bc895 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -177,7 +177,10 @@ static int mfd_add_device(struct device *parent, int id,
>  
>  	if (parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> +			if (of_device_is_compatible(np, cell->of_compatible) &&
> +			    (!cell->of_full_name ||
> +			     !strcmp(cell->of_full_name,
> +				     of_node_full_name(np)))) {
>  				pdev->dev.of_node = np;
>  				break;

That is some ugly, squashed up code.

If we end up accepting this, I suggest flattening this out a bit.

... but we'll cross that bridge when we come to it.

> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index 99c0395..470f6cb 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -55,6 +55,9 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
>  
> +	/* Optionally match against a specific device of a given type */
> +	const char		*of_full_name;
> +

Can you give me an example for when this might be useful?

>  	/* Matches ACPI */
>  	const struct mfd_cell_acpi_match	*acpi_match;
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

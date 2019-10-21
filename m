Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F80206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHFpCGNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfJULQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:16:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39645 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJULQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:16:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so1266194wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2kG9pHnFeA6PHcYxK5XIBWye1413OVWPwWivEHaEPxA=;
        b=sHFpCGNpZUr9EgW9RnN3TQG6R2f+xIbwosYwqG+ENfBMv8io6y7yM2d9N6vNuloJF2
         HxsM8JQVm/hKyxFPDvsUQXGaHY4ROjy6Fj89QD433kPOxXfb/7rEwMCPth7/2gUXQ8Bm
         YkJv5oF17JlBd3p9iUSwU+GFDhPdypJMfwxdW2dPs+kk1Run6TuZGTlGR9/p7QxX+jdE
         exlPcYrTvQt2yTfO//swSHyZZxG6MI/vqlJkUa1nLGYxLW/oHJ10IzKJdv3UdoJm8apA
         +rxORZO4/MH8sNtfmnCnRjhVXHqmIJr0pCJZtqE0HhllafHa9gmWQSqv4DQf+nBmwPfA
         oowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kG9pHnFeA6PHcYxK5XIBWye1413OVWPwWivEHaEPxA=;
        b=JWlXoB9b3SBr1xfAeekc7PRVQTCLHgDVepRVkSZ4r71u0M8G1nEmbkKuTBolXD+ZJY
         c/Y7Y4oCtBEntYKbzrQWzvJu54QRRj1S29MJoMjfox3uzR9NbhDjMyk3JFDy0vpq1PsQ
         e2MRxgKNANLg6Bevrg+CC5/Czi/Xb29ZfsQ2C0su03k6BU4kKcZ+8YBY+j3k1vlFsCFJ
         7xOAQ4RffLu+BsJPUm/VBxGvuJY6o12r62zS4KdcYJnNrB/XSP3F6X0QxUwaX+3efVWl
         jmU+QKehaxy1qsDZz1UUhgwkJl610QPwzbyfMlBxbTDoFcmuMMYWatqLKzD97eTYRkAL
         2VYQ==
X-Gm-Message-State: APjAAAWtwP0xKQ/KVtwaK6OefR7VHYTprpc614PJMSkehbtm1mQkQU6V
        MLCpMJuLFOS1VErimKG43yAAdw==
X-Google-Smtp-Source: APXvYqxYf6uO9WVXoizzlTpKAqfTaa9EpMyq3rZnnJ4hcxgDGEwowxOByM3u5FsqQHn2e4sOGazs9A==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr4241896wrp.273.1571656557502;
        Mon, 21 Oct 2019 04:15:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v6sm17556789wru.72.2019.10.21.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:15:56 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:15:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 1/9] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and
 tidy error message
Message-ID: <20191021111555.zsvvdfun3gqhrurw@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-2-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:14AM +0100, Lee Jones wrote:
> In most contexts '-1' doesn't really mean much to the casual observer.
> In almost all cases, it's better to use a human readable define.  In
> this case PLATFORM_DEVID_* defines have already been provided for this
> purpose.
> 
> While we're here, let's be specific about the 'MFD devices' which
> failed.  It will help when trying to distinguish which of the 2 sets
> of sub-devices we actually failed to register.

No objections... but won't the tag added by dev_err() already
disambiguate?
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cs5535-mfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index f1825c0ccbd0..2c47afc22d24 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		cs5535_mfd_cells[i].id = 0;
>  	}
>  
> -	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
> +	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
>  			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
>  	if (err) {
> -		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
> +		dev_err(&pdev->dev,
> +			"Failed to add CS5532 sub-devices: %d\n", err);

                                           ^^^

Typo (and MODULE_DESCRIPTION() says this is a driver for CS5536 too).
Once that is fixed:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

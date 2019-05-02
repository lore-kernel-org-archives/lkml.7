Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C18C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FB62063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556830745;
	bh=bO334ocv9Dm8Tnq5zW8b3qKfmjcRkCcHSJnXp0UWwLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qI9GtnirDFhF4c5WwxtUTXEMYOStMuP04Mo7Di31V/X9Pm7h5/pYBr56BwkyjekHJ
	 LLx9oczZy2gXb6Qr104P8b1ZaMRBxACtGCjcml/O/lBEbpXHvJTrQGYmppl5gTtgXO
	 VvvzLu97HVyiloZib7kN1ZGOQ25KvbOdKlA9U+/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEBU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:59:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43851 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBU7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:59:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id e108so3409234ote.10;
        Thu, 02 May 2019 13:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ek4e6lQQ8IdAaOrNfkdfcyOxoi7Phm/pJmbpKGyfvy8=;
        b=VryFFgmzepF+e03te7jR4pFvLB4xU8BoKRy1H0XVJw+f3Nc6xl0nMI2D5o+3E9CxJT
         Rn+pj4bupoRWXpOPLZHuXsioMZNjVFLJYSVemivWuqnXL3zarcU5fi5xYYj8HOcHGO2g
         sMfuv7dGOjypo7IDkji9B/T6Jf02tnonPbVtOiM8wlzdjzLuzWW21MrJr0OlwKLX9LIh
         3xWxh7/7ySJWB2vhjSbqswCxc1zJeTM1pKMy6+IPCgLPqss5CndUOz7aMTAHU+aGU+y2
         uh5okYKMo5ZnRoMtGORpF/4SMrYBYcLFrUhl2NTPCCdpKfAKc5nPXk9Vy101kLITxJtE
         hwAQ==
X-Gm-Message-State: APjAAAVeTu0dyKqVwwQXRqVjcI0v22NEsHu+YeWH68cZoACEVbqfKwi7
        GtH2DjFy+m7emApUoMEoPQ==
X-Google-Smtp-Source: APXvYqyb+W0LF2urvrVH+CnR4Gxihh+0ucEOZSP/69wdKuINEJLDCa9oqekneXLyTMa5VpRVNUsUVg==
X-Received: by 2002:a9d:5e02:: with SMTP id d2mr3965264oti.222.1556830743357;
        Thu, 02 May 2019 13:59:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k65sm184077oia.16.2019.05.02.13.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:59:02 -0700 (PDT)
Date:   Thu, 2 May 2019 15:59:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, festevam@gmail.com,
        wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de,
        eha@deif.com, linux@rempel-privat.de, sumit.batra@nxp.com,
        l.stach@pengutronix.de, peda@axentia.se
Subject: Re: [PATCH 1/3] dt-bindings: i2c: add optional mul-value property to
 binding
Message-ID: <20190502205901.GA24224@bogus>
References: <20190430043242.29687-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430043242.29687-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:32:40PM +0800, Chuanhua Han wrote:
> NXP Layerscape SoC have up to three MUL options available for all
> divider values, we choice of MUL determines the internal monitor rate
> of the I2C bus (SCL and SDA signals):
> A lower MUL value results in a higher sampling rate of the I2C signals.
> A higher MUL value results in a lower sampling rate of the I2C signals.
> 
> So in Optional properties we added our custom mul-value property in the
> binding to select which mul option for the device tree i2c controller
> node.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> index b967544590e8..ba8e7b7b3fa8 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> @@ -18,6 +18,9 @@ Optional properties:
>  - sda-gpios: specify the gpio related to SDA pin
>  - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
>    bus recovery, call it "gpio" state
> +- mul-value: NXP Layerscape SoC have up to three MUL options available for
> +all I2C divider values, it describes which MUL we choose to use for the driver,
> +the values should be 1,2,4.

Needs a vendor prefix. I don't find 'value' to add anything nor do I 
understand what MUL is.

If it is determined by SoC rather than board, then it should perhaps be 
implied by compatible.

Rob

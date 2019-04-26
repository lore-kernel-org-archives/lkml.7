Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE10C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C002B2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303021;
	bh=mASCdQcdtvrBHo9JPU2wxd7Q3ey4lTIdYXalzgpA4zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FE0nA9HgeUL1M9AKUbdZM64o66FaWrY9CZQ8tY3CuQiT0vQDCVRYSnJIoj0C90xyA
	 R/OxuAiPiYwZyEQNF/I86xpS0sagRwmqgpqa23h53ClaZGZo51ioAYlKq/ZF99da5/
	 9uS5D7TctM8F/Cyjn9GwkS/mP5d2a5j1KYdW3SkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDZSXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:23:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39171 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:23:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so3677045oih.6;
        Fri, 26 Apr 2019 11:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BclqWzR9xQNC3VZkmeZkRjdAcsFivWvX2grYqBpgwlg=;
        b=geVQK/4V/h9PgTxnvoobrcbWvu9jHTNmkiy5zV7nPYdsUOEkOChY5ubsja+xqrny6Z
         SBJ5SpFNKIGJfWC1/iRl1q8JEDWUl8hQz9o2ujMoW+gAb2Vd5iJ9gxG8xOpzhm7noSro
         DUzJ6nQDcqg/tbGJtnu+xUmGW67GO1A0pZeMcYiEluTkUOHkygIuwS55MfWHVMGxCa2F
         EZlXLI/N/ygw7VhgsfTu1LVc90O4ZJzSbbvKurNL1QZxWGgfOl0XkMitPVFhkUMQWmSA
         7lESJROCFZ17TOA4c14bR2TyK1o6jC0L3poyggZ9gcv15wPGj4k3j7zwPqqhCDVFxtsl
         U/DA==
X-Gm-Message-State: APjAAAXJOJZdwZbMjO73WjsVff0xFe8L9CtRqgAxyn5z1SmGxqXe90Zm
        HkI15wvSs7NGNDVOPHSYCA==
X-Google-Smtp-Source: APXvYqy+mNyRq7qWwKHwynV/eXclovN7iyVjta3XvZEMBRmzSNitmmHoTXSt3Vs0ok9iUTsDhR1KyQ==
X-Received: by 2002:aca:bf83:: with SMTP id p125mr7908077oif.47.1556303018852;
        Fri, 26 Apr 2019 11:23:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y9sm10270133otk.20.2019.04.26.11.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:23:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:23:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     megous@megous.com
Cc:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: display: hdmi-connector: Add DDC
 power supply
Message-ID: <20190426182337.GA22245@bogus>
References: <20190413165418.27880-1-megous@megous.com>
 <20190413165418.27880-7-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413165418.27880-7-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 06:54:15PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Some Allwinner SoC using boards (Orange Pi 3 for example) need to enable
> on-board voltage shifting logic for the DDC bus to be usable. Use
> ddc-supply on the hdmi-connector to model this.
> 
> Add binding documentation for optional ddc-supply property.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/display/connector/hdmi-connector.txt     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> index 508aee461e0d..33085aeb0bb9 100644
> --- a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> +++ b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> @@ -9,6 +9,7 @@ Optional properties:
>  - label: a symbolic name for the connector
>  - hpd-gpios: HPD GPIO number
>  - ddc-i2c-bus: phandle link to the I2C controller used for DDC EDID probing
> +- ddc-supply: the power supply for the DDC bus

It's not just for DDC. It powers the chips in bridge dongles for 
example. Pretty much every diagram I find just calls it 5V or +5V.

So how about '5V-supply' or 'v5V-supply'?

Rob

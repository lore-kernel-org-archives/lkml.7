Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F5C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hjqp7yiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFUPVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:21:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43778 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfFUPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4aE0rZwbXnHevxDpP9dbpYGSSeNqkmQd2OB6ZUv5WMk=; b=hjqp7yiEWOImYv7e7Qn7vZcvd
        OZzpO7PpbcUFwWb1Ci2EDfMa0wu759Ud5hPxQHHwGYv2LsbRpkk8dQ88cG8VrtVN3vszVmKSqX2fK
        kOaZeV8ELsts6FM4jNTiOyNzH/Yqt+sMlJ22l+uGlQ028nq2FX0n019nroY9YPHfXmWkHdVRAr2P+
        fz7vpa+jk28mgJbtXsWyrs2t0iBRhzUzlKGlJ0NBpLILrQqrd4YiyWyhroAPCpj25rPRSPVk6qpgL
        cBc+ghf+5K016T5iH/5Ll5LAytSaD5vzKlUBW/sAz5qLu2W41MbLitI63wsZXqen4f4eGwHNGajtA
        5XGpvvoPg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58964)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1heLLS-0006Cw-Pw; Fri, 21 Jun 2019 16:20:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1heLLQ-0003Mx-Oq; Fri, 21 Jun 2019 16:20:52 +0100
Date:   Fri, 21 Jun 2019 16:20:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 2/2] drm/i2c: tda998x: remove indirect
 reg_read/_write() calls
Message-ID: <20190621152052.ja2adc7usqsgyu62@shell.armlinux.org.uk>
References: <20190527191552.10413-1-TheSven73@gmail.com>
 <20190527191552.10413-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527191552.10413-2-TheSven73@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 03:15:52PM -0400, Sven Van Asbroeck wrote:
> -static void
> -reg_set(struct tda998x_priv *priv, u16 reg, u8 val)
> +static int
> +reg_set(struct regmap *regmap, u16 reg, u8 val)

I don't see the point of making this return an 'int' - you don't modify
any of the callsites to check the returned value, so returning a value
is not useful.

>  {
> -	regmap_update_bits(priv->regmap, reg, val, val);
> +	return regmap_update_bits(regmap, reg, val, val);
>  }
>  
> -static void
> -reg_clear(struct tda998x_priv *priv, u16 reg, u8 val)
> +static int
> +reg_clear(struct regmap *regmap, u16 reg, u8 val)

Same here.

> @@ -685,16 +655,18 @@ static void tda998x_detect_work(struct work_struct *work)
>  static irqreturn_t tda998x_irq_thread(int irq, void *data)
>  {
>  	struct tda998x_priv *priv = data;
> -	u8 sta, cec, lvl, flag0, flag1, flag2;
> +	struct regmap *regmap = priv->regmap;
> +	u8 sta, cec, lvl;
> +	unsigned int flag0, flag1, flag2;
>  	bool handled = false;
>  
>  	sta = cec_read(priv, REG_CEC_INTSTATUS);
>  	if (sta & CEC_INTSTATUS_HDMI) {
>  		cec = cec_read(priv, REG_CEC_RXSHPDINT);
>  		lvl = cec_read(priv, REG_CEC_RXSHPDLEV);
> -		flag0 = reg_read(priv, REG_INT_FLAGS_0);
> -		flag1 = reg_read(priv, REG_INT_FLAGS_1);
> -		flag2 = reg_read(priv, REG_INT_FLAGS_2);
> +		regmap_read(regmap, REG_INT_FLAGS_0, &flag0);
> +		regmap_read(regmap, REG_INT_FLAGS_1, &flag1);
> +		regmap_read(regmap, REG_INT_FLAGS_2, &flag2);

Not particularly enamoured by this...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

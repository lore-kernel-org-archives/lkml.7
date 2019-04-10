Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D260C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3146204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WWIAzm+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfDJISw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:18:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbfDJISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:18:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so1758937wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=c/t4IY/MnYrWW5FDOYJfXyPINrnL8V/TKXDd33NmmxA=;
        b=WWIAzm+IdF6YmOw3QUFk1T/4VHAVWI5FTa1EZaWCYSUFXBH000Xp0LrhU+a3qeo1ww
         GBjsulSzrYAT826leLo27rmEyZkNt8XY76cJE6TO9XQW1CJjQneKNRFarAJdjco3goxf
         UFtajIUEG5cv4V6evGEO+5eJaPnStPOlJ8+OimlrVCvYjzwZ91/6SVS6ty+y8/gKLuHp
         AgGR87E7jlpiqrO5hv58mx+fPbVhC3TK1kN+5jBQWWG48lkwv/VYlavqKe6KCf5lA/qc
         cVj/LI9drdl6/79klx16z6ebWa/M3sDzfYIZVuS/uQl9WJlhhz4dfEWJg1tJmgMlkfzL
         d23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=c/t4IY/MnYrWW5FDOYJfXyPINrnL8V/TKXDd33NmmxA=;
        b=Q2gfgysuF2nN1KudFwrtv6iqZKiC7PEEaDh0ZkLYoL5gYvmazS6au9julPwMdCn6Y3
         JeWDdvHn/8gzcx5CHNdjS+yAXmhbLYsTtmJb6U3/SpvZSld0VXOuiYSsCzVFNXjISkUl
         bl9FBQVVgIHHXDH64+Po7dV6bd7jOK47Plk64JHfxOqNPTMUJLZqiV+LwAaxIt46byi/
         dEFAhMC4pW020I9xVwoyZ13uU5sbjxWw1rHrfm7/NYdCQmEUfRcqqO0grUIztPPNnkKa
         8+/qdO6gMV8rHIq53YHgd6LiXsoxGsTBHqj1pCqvHJrdtLALALBM1IFN+MtPpAX0ktJL
         rQaQ==
X-Gm-Message-State: APjAAAW+Gn5RfkbDcYk38R7dpR1DvYNFVT0EsnB7dNl61dt73gjBPLkY
        5YqiWLVbFUj+eS7Pf7sQE19P1A==
X-Google-Smtp-Source: APXvYqwrIvrq3m2W6jy0s7e2Dn9od77lyLi3llLhG1tE+B82TNw7l9/9YXiKXslNPUF8nNc1V3JlkQ==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr25846964wrr.230.1554884330117;
        Wed, 10 Apr 2019 01:18:50 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id c10sm40362252wrt.65.2019.04.10.01.18.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Apr 2019 01:18:49 -0700 (PDT)
Message-ID: <ece510f7d393e4b04c920e88968e9bb41cde6b14.camel@baylibre.com>
Subject: Re: [v2 PATCH 4/4] phy: phy-meson-gxl-usb2: get optional clock by
 devm_clk_get_optional()
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Motoya Tanigawa <tanigawa.motoya@socionext.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Date:   Wed, 10 Apr 2019 10:18:47 +0200
In-Reply-To: <9f04a619e8a2cc44f5b1fe299a08f237f069d56d.1554874961.git.chunfeng.yun@mediatek.com>
References: <a8539bcf66065380069676fbea99a51254309803.1554874961.git.chunfeng.yun@mediatek.com>
         <9f04a619e8a2cc44f5b1fe299a08f237f069d56d.1554874961.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 14:13 +0800, Chunfeng Yun wrote:
> Use devm_clk_get_optional() to get optional clock
> 
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
> v2: add Acked-by Martin Blumenstingl
> ---
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> index 148ef0bdb9c1..4cbee412f2b0 100644
> --- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> @@ -261,14 +261,9 @@ static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> -	priv->clk = devm_clk_get(dev, "phy");
> -	if (IS_ERR(priv->clk)) {
> -		ret = PTR_ERR(priv->clk);
> -		if (ret == -ENOENT)
> -			priv->clk = NULL;
> -		else
> -			return ret;
> -	}
> +	priv->clk = devm_clk_get_optional(dev, "phy");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
>  
>  	priv->reset = devm_reset_control_get_optional_shared(dev, "phy");
>  	if (IS_ERR(priv->reset))



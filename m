Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F2220878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZD7VYFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfDXJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:38:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41400 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDXJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:38:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so17998213wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KIYWXBy0yVdZQntxiMbH9CRQ0LmxGO1cYhntj34UfNc=;
        b=fZD7VYFtUre34XHlMUrfXxQgJvQgeXJxUsS2UIrnEFOOJSUQqr3x13upCLFu9nUvbu
         P+vvzlbVrleng80oUiMu4GlzlXNH6EP7CvMtRckA+LRpN+GF7sdK2ilsfAm/4Lf3pzds
         su15hNylpbtXU1/MGAhLOZubWXY3UTIPRs0XPaI9yLiUGJ0/GXPwjnuWYZfOjyMaRIBj
         MZmqyfY+gccgSErsIBdOYD2Z5BT2oVWt/bP1b6Btc+FZLawf30/khy2fg2Wj16D4A6gu
         wal1Z54UixsE4kU1gk+nym857FItg5jO4Zzx5vyUpMW2rNoDEQnOwbE+vPyldtkBq7yL
         YaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KIYWXBy0yVdZQntxiMbH9CRQ0LmxGO1cYhntj34UfNc=;
        b=MMZK3XwJ1N3EdKsH7Zj/g+bxxJyL6gJstjXpMW7sp8Qqh+a6Tfa1P7qA9cs4AxgQfK
         o/QxscMPRVA4ZFCExA3vTlM3cAzU3Bu1dWLd/gY6VCc3kF7AMzHICocD9TbYUYxe0/Hz
         aEUU7ipAf9ZUffG32nwPaUqiDKDPgk23RHslgIGgPegZCKQddeiEbGAk+VqchOuoT4G7
         BmGZ2erEFlqGqBjhf5eF/FXQMH0kVdFp78sBVYQ9qI93f1jPZwnIE94RsvnZRZG+O5iG
         C6sebwTjSF2G8aInqsaAbLZ+6QFn02v1LmcHADljibzmjlZ69F2aCE/cPuUBwRN6VZOn
         agDg==
X-Gm-Message-State: APjAAAXtcio2MIQeI69cwk0s1IzHsz2M1Onx5Gn1E/45bBaJiHvSKFZr
        GG5Tl9FZZg/DMP0/mAbHv30aqpNCbi8=
X-Google-Smtp-Source: APXvYqwygbb7SyomzzY0uiOv/6g6Um0ZMB8SrVbC6/eYdOMg4ZwVS87VRAPz99KlJjZVGZXzCzcXDg==
X-Received: by 2002:adf:eb0b:: with SMTP id s11mr22259252wrn.140.1556098689066;
        Wed, 24 Apr 2019 02:38:09 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id q3sm1133033wrj.24.2019.04.24.02.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:38:08 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
To:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se,
        geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
        marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com,
        hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com,
        dien.pham.ry@renesas.com, biju.das@bp.renesas.com,
        erosca@de.adit-jv.com, george_davis@mentor.com,
        joshua_frkuska@mentor.com
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-3-jiada_wang@mentor.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d80c874-956f-b2e2-412b-69cc26235606@linaro.org>
Date:   Wed, 24 Apr 2019 11:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424051145.23072-3-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2019 07:11, Jiada Wang wrote:
> Currently IRQ remains enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch disables interrupt in .remove, to ensure irq function
> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 065e16f53285..280230951dfe 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -307,6 +307,9 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  static int rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> +
> +	rcar_thermal_irq_set(priv, false);
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024BE218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q0TBA8sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGCORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:17:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53089 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:17:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so2410784wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ks0bNwYapiN81vVxECStRbRSKzS0XfjKhzZiJiwEzwY=;
        b=Q0TBA8sKjhi4NK59C7tFimG/AiuJj8NjmNS77iU+k2Qmfdlh5Dc/rYAbcd/fDqSnHD
         /tbji06th9Xzvmi6KQ0uXit+8krhr5CAYIpig2H0xEGI/LCLsktoZD3PYI6Rn/QrD1qM
         vbLjZExZoQKayF3xaOkXoR9FF0/sx79SNWx9MGV3qQwP/4bgQ9YKmScXh2ZUf9m/vYCp
         huQ4lLrwpG3T5OrkuEDapgp3jUknzjOiRfKo+KCjpTWTDed2O9fYTFZEDa5/fZz+rHzD
         xRLlKBOUC1tD63wpfzRqC4OVCVX6I3q7Q37ZfKRvMIJ+fzmou0ZnLyEUXul4j+0JhFgW
         xtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ks0bNwYapiN81vVxECStRbRSKzS0XfjKhzZiJiwEzwY=;
        b=HfwVMtHW7CY0H6k9/HAFoW9MH7dG9X22oV29PooxoCG0Zj/SbSbgQ4TP3DO6y0ig9O
         C06XMBTdthOjzmPJqUMWcfBi23ldQ50u1OHHn6nCfds968TrjE7lCCrdMUQyQ7S4ruqY
         /Vx0jTEfBn03jW9IFxhnNttvtSkSzGaao1W+4t/a2Yu9pj/AesjScq8aG0CZM1coK3DR
         6GkWjiqyX5zi6FMx0hBOiGyrZnNagR5QN8BFd+CXbIJAMOmAufhutM5U4SBEAhk+rQDG
         bfYWGN3bRFlQ0TKdWlwVF7DmHxPIgH399ZZsuQa9wT+sfHrvzQ/C0pg5N8wKzbDUajcK
         fnTg==
X-Gm-Message-State: APjAAAWhpib/lNjXX22R4pUWXYIxCalATDEcimwrsme0kEojzC903dhV
        jvpXtK3SPvcRWVPlh8gR78X9lQ==
X-Google-Smtp-Source: APXvYqxmeARZ+dzcLmNlaBGXg9WvX8W+EC2+HrDQkCGX+smg1Bl3ozbQengqGYQ1JBWeO/R5WhX85A==
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr7439597wmj.61.1562163431645;
        Wed, 03 Jul 2019 07:17:11 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x83sm2813879wmb.42.2019.07.03.07.17.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 07:17:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC/RFT v3 04/14] clk: meson: eeclk: add setup callback
In-Reply-To: <20190701091258.3870-5-narmstrong@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-5-narmstrong@baylibre.com>
Date:   Wed, 03 Jul 2019 16:17:10 +0200
Message-ID: <1jh8836w49.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jul 2019 at 11:12, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add a setup() callback in the eeclk structure, to call an optional
> call() function at end of eeclk probe to setup clocks.
>
> It's used for the G12A clock controller to setup the CPU clock
> notifiers.

I'd prefer if you implement the probe function in the related controller
have this probe function call meson_eeclkc_probe() for the common part

In your case, I suppose it means implementing the g12a controller probe
to deal with the notifiers

>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/meson-eeclk.c | 6 ++++++
>  drivers/clk/meson/meson-eeclk.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
> index 6ba2094be257..81fd2abcd173 100644
> --- a/drivers/clk/meson/meson-eeclk.c
> +++ b/drivers/clk/meson/meson-eeclk.c
> @@ -61,6 +61,12 @@ int meson_eeclkc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (data->setup) {
> +		ret = data->setup(pdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>  					   data->hw_onecell_data);
>  }
> diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
> index 9ab5d6fa7ccb..7fdf424f71a6 100644
> --- a/drivers/clk/meson/meson-eeclk.h
> +++ b/drivers/clk/meson/meson-eeclk.h
> @@ -20,6 +20,7 @@ struct meson_eeclkc_data {
>  	const struct reg_sequence	*init_regs;
>  	unsigned int			init_count;
>  	struct clk_hw_onecell_data	*hw_onecell_data;
> +	int				(*setup)(struct platform_device *pdev);
>  };
>  
>  int meson_eeclkc_probe(struct platform_device *pdev);
> -- 
> 2.21.0

Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F66C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759420863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCSgmtO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfEWWzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:55:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42564 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387997AbfEWWzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:55:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so3314545plb.9;
        Thu, 23 May 2019 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=27oT/4g6iIria1a8VEGy3UQ4sbwIVeCLLiSd/9UWd04=;
        b=jCSgmtO/BeBcWImt8/iAItnN7kht6k+7osXxzhQ5D+QB3xNgbz/FUSfC2LqQsBvr/l
         f/m/mIk+7UiQYMVNV9DbXH7qBc/ob629H/7t2a8T9ntAdPOek5vvBGBDONPOUMDBLlns
         dh1+VzJQtPTTP1cQqvxlZ4WtacETA6cjUTNhVCOeVsRjgcE/WEESOjA9RP3AhK37dp/H
         F84INqJDbjsvX9PCQR4ZEoCKMzMbWz772ZGl7hYs20W71s/hD9fPnGKyCtmWO8G2Ke5v
         7EoJCL2YdufhAItIV0ORSdrLPYaHwE+gZV1Nkb9akjyDTUeySjI6RmGJB63xy9dfjdd2
         UnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27oT/4g6iIria1a8VEGy3UQ4sbwIVeCLLiSd/9UWd04=;
        b=kg+62q168Ms6khzvYlTzgbWSO/jWhM/5Z5o6UGQ4zJsuzexHTWtkXp1wkZjpg/mFYj
         FS3alAGsXCd45JuQ/vGH4swOnr4P+gIMhnKTRBAvrkoeMhhz8FyDfHm918HjvdsRli7z
         crrgwxbh4JSUzMfkU01Ga63XKq0nKY8AEry2s9Dw6yLAqxZV8h243zdq09SwEV21hZQj
         tiP05YrF54A8644bwoAXD5mL3wWVagY3kq1TrWjAXLyfUXThqxS890tM+wYY4PXHdtJA
         fw8q20pxCZUjd+URx4HwipN3op/6SE+CpIqygE+Pocm9xKQqXxEHQjdXDzI/Dslg2Pxq
         1A0g==
X-Gm-Message-State: APjAAAVSI3wq+gg94np27gVcel0mviagEEJ27ydEUYAFT7JhzGBij18g
        mheMlTh064JVRLd17rJnc+E=
X-Google-Smtp-Source: APXvYqzt75vj9/47EIZfhyd7iAELswjMnv1hgg/C1pxBoiot4mdCedfhyicycjbWVTlRBPtDNFgzpg==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr101257298plp.260.1558652138370;
        Thu, 23 May 2019 15:55:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u134sm504276pfc.61.2019.05.23.15.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:55:37 -0700 (PDT)
Date:   Thu, 23 May 2019 15:55:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] input: keyboard: mtk-pmic-keys: add MT6392 support
Message-ID: <20190523225536.GE176265@dtor-ws>
References: <20190513142120.6527-1-fparent@baylibre.com>
 <20190513142120.6527-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513142120.6527-2-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 04:21:20PM +0200, Fabien Parent wrote:
> Add support for MT6392 PMIC's keys.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Apparently this depends on not-yet merged MT6392 support in MFD, so
please merge through MFD tree with the rest of it.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 8e6ebab05ab4..aaf68cbf7e5b 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6392/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  #include <linux/module.h>
> @@ -83,6 +84,16 @@ static const struct mtk_pmic_regs mt6323_regs = {
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
>  };
>  
> +static const struct mtk_pmic_regs mt6392_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
> +		0x2, MT6392_INT_MISC_CON, 0x10),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
> +		0x4, MT6392_INT_MISC_CON, 0x8),
> +	.pmic_rst_reg = MT6392_TOP_RST_MISC,
> +};
> +
>  struct mtk_pmic_keys_info {
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_keys_regs *regs;
> @@ -238,6 +249,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt6323-keys",
>  		.data = &mt6323_regs,
> +	}, {
> +		.compatible = "mediatek,mt6392-keys",
> +		.data = &mt6392_regs,
>  	}, {
>  		/* sentinel */
>  	}
> -- 
> 2.20.1
> 

-- 
Dmitry

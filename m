Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9187D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra1A19cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDVLj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:39:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34146 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfDVLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:39:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id h5so8764571lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qy9/XrzvJbcA4ojoeaERqkNAMI5bKiD35hgwsfEA+ko=;
        b=ra1A19cgMHJtOJzXyXNrHCdOaDo9C8xNjabkb0Yf9yOV6pS7kjiJM+M+HANRvfIVMU
         qYXZkaJ5wJb4C8fvCHh17ToLI3a+fFE4zScObbKcQvvwyQb6TBETQliMYiD23ySvnXOf
         U3qVNE6mfianeeqa10qK60noobWUpmDUW7kKi+hNBcl9r36chKvFE/skK+T/R1l36Qdv
         IS04pqwHSHUodQXKuxd/vszSfTFSv1/oNDCorXSJ0LLf/ijWcPwgMjBZgZ2y3AtWsJEo
         Cjwmm/V9mQ2uhnkSXLuJRelbE+Df96FATql66uJDft66oCS26t/nbOrkZsN+Pg5QGbHE
         jUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qy9/XrzvJbcA4ojoeaERqkNAMI5bKiD35hgwsfEA+ko=;
        b=ZpTWmwCbp8apZH8Y6//mEwKGP/BOjejPWawFn5Mc3RQ9+ZPaXKwqakqFe8va5y3vXf
         zVz8uhsYwuvOTfQKsvUD9PDMA8Gi4oIpZ0ouoC0yiA7cgAcz8zfqS70bC9+ZbDmtT9pn
         rK2U7pOtH0XlzOTnHv80oJOpioea2hEnzQ4bzAAcue5qj5aYHwT+XVSX+wC3wBm590uZ
         JpsNUHR7G4AZX1tSeFx2VMOpYdC3171qH4T50w0lascD/KGQyTj/ptWbjG7dgCgjoLYc
         R3nTpPxfGmeH1ukAI8DfSpFVu25l8Sa7R0f9XuWDApBirI29XGK9tIoA2hxZ6PpQl1E1
         MbEA==
X-Gm-Message-State: APjAAAXa7bN3GXqmyVJTORBWqWrhuW/B0IvIAIYPkU03Fx5+4SlHQkja
        g/sDHp/ofgydoPeVdauzR64VMz+x
X-Google-Smtp-Source: APXvYqx8iAtmhwS1cgD2YPqxwa7e42cKtY3cWSrEoFik/PQA/dEkJAVLH8z5K7QGn+//uuQ5ZYdiAQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr10591448lfi.46.1555933165642;
        Mon, 22 Apr 2019 04:39:25 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id b14sm2668782ljf.53.2019.04.22.04.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 04:39:24 -0700 (PDT)
Subject: Re: [PATCH RESEND] regulator: max77620: Fix regulator info setting
 for max20024
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Mark Zhang <markz@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190422053531.23123-1-axel.lin@ingics.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <74253ed2-6b5a-0e59-25f0-05d7d8ce5431@gmail.com>
Date:   Mon, 22 Apr 2019 14:39:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422053531.23123-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.04.2019 8:35, Axel Lin пишет:
> Current code always set pmic->rinfo[id] = &max77620_regs_info[id];
> It should set to either max77620_regs_info or max20024_regs_info
> depends on the chip_id.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This was sent on https://lkml.org/lkml/2019/2/23/482
> 
>  drivers/regulator/max77620-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
> index 1607ac673e44..0ad91a7f9cb9 100644
> --- a/drivers/regulator/max77620-regulator.c
> +++ b/drivers/regulator/max77620-regulator.c
> @@ -803,7 +803,7 @@ static int max77620_regulator_probe(struct platform_device *pdev)
>  			continue;
>  
>  		rdesc = &rinfo[id].desc;
> -		pmic->rinfo[id] = &max77620_regs_info[id];
> +		pmic->rinfo[id] = &rinfo[id];
>  		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
>  		pmic->reg_pdata[id].active_fps_src = -1;
>  		pmic->reg_pdata[id].active_fps_pd_slot = -1;
> 

That is a quite difficult bug to spot because the regulator parameters are mostly identical and the part that differs is usually unused in practice, good catch! Thank you very much!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

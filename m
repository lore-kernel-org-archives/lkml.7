Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF37C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A970214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T19FI9rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfEHLrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:47:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36075 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEHLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:47:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so26812203wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hpWh4FLHfTm12R9a+G2H8ZnndDdHHQh/uKWiEfB41lY=;
        b=T19FI9rr24oxNF0Zfk0svOeBJeAvGES4DG1//cKgfWNlgb6VBV3oaRyzZpMbb0RZ5Z
         uoI+Ga+XALqYCihw/P8BZMzyHv4pu9iYLsqelUWaiNnPglCA9nrRREbulYclR9xqEqe1
         Mbgc94VcdeXAofMAWu/S2k7BCrjXl7JH1Eu4xfJw/98PwHKpGUz5J75+hPrzvPqjFZWl
         JuXl0f9WL3udDhipjOgXn5W49kiBLaCA1GwpGTj7RPqrYXqZsyOWZFnEtQAexqdZLvpV
         rwaHTILwuoa+TYXj7Q9PhN31xGiSaNb7ERcbHtETdwU/1rperT80xjNIQUYG2ecfBU0U
         DYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hpWh4FLHfTm12R9a+G2H8ZnndDdHHQh/uKWiEfB41lY=;
        b=e1FCITvYpQsz6Es1dGhd7Zr5ZbD/VvvYrbBNtIgNuF0cDcYDB6Jx8NGRI076n/sdau
         Y6Y3QvpsTG09vCMiXQp6eOLMaE2OwCJBjbBBxoVFoSDwD11e/PgU7F5vlvy6pFyc2K8u
         5jhPujSdFWkdCnsSkhLW+vEe2YahVEdgchUsWXZ41wejo52k/m237ALIVF5q9UfK4tqH
         N6ua5c0+yYEkUQ/E43RvyMCwJaDzvBnLPVeSI63hVTnZlvOzKrWH7YRs0RUZAZQFbAWE
         D2cRhONwgbvEiEm8bRq++i8n6vsRg6RXbzMdupMaxrFEmdUJPd8YF8uvxyyMqscj+bDG
         uHvA==
X-Gm-Message-State: APjAAAXKBoR2IkAwXdcJ/67POR0uAdFMp67IkIHgd4ndJv+sMVZ51U6o
        r1oZVaOLDtkrazkjKKWYUFAXuQ==
X-Google-Smtp-Source: APXvYqzkNeZZpEjSqk3ZmtqtJh6nNjJqLlgrXUcwmsu96FP/f07PyTMhtwugNqXNkzzOtnla0ED5fQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr20558616wrn.175.1557316069563;
        Wed, 08 May 2019 04:47:49 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g10sm3039010wrw.80.2019.05.08.04.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:47:49 -0700 (PDT)
Date:   Wed, 8 May 2019 12:47:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mfd: max77620: Support Maxim 77663
Message-ID: <20190508114747.GK31645@dell>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505154325.30026-5-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2019, Dmitry Osipenko wrote:

> Add support for Maxim 77663 using the Max77620 driver. The hardware
> is very similar to Max77663/20024, although there are couple minor
> differences.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/max77620.c       | 69 +++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/max77620.h |  1 +
>  2 files changed, 69 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

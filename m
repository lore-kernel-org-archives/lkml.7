Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459E7214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3QJktUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfEHKcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:32:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfEHKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:32:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so2589200wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lTYtWH+vlDq1C8tSZ2s1Nk4aplc77EuzahEQKqSXH1w=;
        b=o3QJktUzhea3lHbIefLX+aNhSNRGeqRunVeT2IHCizVIXFqfS4luvNVPnBU4Lsq0Qi
         rc2thhYpQepQUtsSnj2eMPg2szR+6J8k4+Yolyo8IFppvYYW/bdqj4GRO6Efjo4pI4pj
         jrBu6D3zKyl0TBtGICj41PuFsd+FUSrfIbzVqyobDIaFu/anZw1N3T51qBBSkxLP9d3C
         Us1fIzm2jYVr+ZJoSYMWkaZsChb2XTQ8uIVRswge1AqtWk4ao8SmmIqETb5qYNAxMxX6
         qHG8mgVTKaT+qS2DvV9ME6uSWg8iOUbcr3/ozePgoTr1AilUiQljdYFXt8afs++LW40h
         7CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lTYtWH+vlDq1C8tSZ2s1Nk4aplc77EuzahEQKqSXH1w=;
        b=PzWrmk6Cb+TDPT0ABzdEK+TCvyO9OsaHMiSu8AYYJZpwN8c205yhAvPp4I/4tA+JY0
         vLYrmevdsAKdEgrxm4ucltNkK0pnGTGYwQu8ElvXhLOxSws59FqK3LpEokESEptcDycN
         DhM1lsqhCLATQh0jX6MoGMb/P9g9Ac6MvpZDjUagL12XiRnv1ULNY/1TmdphZGVhWvcO
         WLQRo+nbtf3ZFvrSDNIO/baXGLKkIwqKztSanpd8/ACHsSLVo7EKmylF9IlqiElusDhs
         7v4Nj4eGzzU1T4jNNjXOOThwxgl8kNQs/AcXAwxKd/Kue62YFCAAeb2P6DM+20OQBYuW
         t8cA==
X-Gm-Message-State: APjAAAX3sE+6HDC/7QsRjguf2EOX7mwmOpp0MsBpP7ujrnYVCRo+Zai4
        4Jnul2u1U3K+YWiXhDir5qhSTUac9EE=
X-Google-Smtp-Source: APXvYqyS2UuaH9kJHYVFIWfTSezTKbwt3gNBCgfakaqiMBVfMgfAFs5aOs/71Y4Ld7OaOjbph6TsxQ==
X-Received: by 2002:a1c:b756:: with SMTP id h83mr1245637wmf.64.1557311524716;
        Wed, 08 May 2019 03:32:04 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id f128sm2896834wme.28.2019.05.08.03.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:32:03 -0700 (PDT)
Date:   Wed, 8 May 2019 11:32:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH next 16/25] mfd: Use dev_get_drvdata()
Message-ID: <20190508103202.GJ3995@dell>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-17-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423075020.173734-17-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Kefeng Wang wrote:

> Using dev_get_drvdata directly.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/mfd/ssbi.c     |  2 +-
>  drivers/mfd/t7l66xb.c  | 12 ++++--------
>  drivers/mfd/tc6387xb.c | 12 ++++--------
>  drivers/mfd/tc6393xb.c | 21 +++++++--------------
>  4 files changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
> index 36b96fee4ce6..50f87d0f9151 100644
> --- a/drivers/mfd/ssbi.c
> +++ b/drivers/mfd/ssbi.c
> @@ -80,7 +80,7 @@ struct ssbi {
>  	int (*write)(struct ssbi *, u16 addr, const u8 *buf, int len);
>  };
>  
> -#define to_ssbi(dev)	platform_get_drvdata(to_platform_device(dev))
> +#define to_ssbi(dev)	dev_get_drvdata(dev)

If you could replace 'to_ssbi(dev)' with 'dev_get_drvdata(dev)' it
would be better.

The rest of the changes look fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

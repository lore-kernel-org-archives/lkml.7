Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A733C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B91206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMzQCpyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKL1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:27:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:27:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so14188935wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pa4yLrRRJrTvDCTKV7j9zkWSjluubOWsot5AwNZziFk=;
        b=MMzQCpygtMnyYjiQIFS+/BfIy0BdjWDImAQ8uUehCobiZwfMMM0Y+wSeT7qoOlF5Bf
         A/aIQFgmyPZDM8OWE51brXONTY9KdXqm84kdWxo++lnT33J+AUZL7csqcWNXbHI9q1yW
         EJRrjNaKGqQKfRd/GQPIN0DHabkvGe9nmuCt7XyVUEt5IMtZwzfBDMAGSPXUAfeh6gf2
         p3suvBT3NtWXcCji0jyTgWSS2YHUgTdAWofZsHzH8HFLuDarkeL6GoU/yQiPNEa3OSII
         BdXnPt4UmMssmm30vn1PQClWHkavnKbrlU02B7bMRrtR4rryc0HLwOsUnuQz1Idql8DJ
         NWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pa4yLrRRJrTvDCTKV7j9zkWSjluubOWsot5AwNZziFk=;
        b=B5tqN2KtlPMuLL2MSRmPfgdONXyPtpje8ILqRjOxPM4ca744CA55Ir0tpQcu5iQduz
         gyB05H4OaHyUsD6jH5jftqxLJjnZUbLKJR5WdqnhvTbU6DOYIvzNmM8YGJLJNUcxDAG7
         1FZdL+5H0f2xIqaZsLI9lNqUwMGJpVs5xKVddfmZdH0FWdDK+cc2mh0jq6lD2oCC8R1z
         0PMwi0VDsSV+7kXvf1iLjIKhxXqSq5gq48kK6yKQXyzFfDUOobOsVItKHIUS1iBqc8fj
         J2RNPd0DrC6RXIEnB+/deH8TDEcxshmrs9EqHNSjzESTRwQlyGVp8o3fcfon90L7cF5D
         LC/w==
X-Gm-Message-State: APjAAAXqr7YlUUKUQVEegr9TgCS3G21i9AkgDGV/koAYpCKaMPGgrWsE
        gf5kmdijrooonnMx0HqOLXXQAw==
X-Google-Smtp-Source: APXvYqzU0tWl6tXFwZxpKX/HcCH9W/vDJ+gkXXF3qBjaQgCFCI9igBdHVWfJ4FDKbmiBVNRCezMEow==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr13048781wro.305.1573471618209;
        Mon, 11 Nov 2019 03:26:58 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id b3sm17597864wmh.17.2019.11.11.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:26:57 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:26:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] mfd: ti_am335x_tscadc: Fix static checker warning
Message-ID: <20191111112650.GJ3218@dell>
References: <20191109050618.20637-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191109050618.20637-1-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Nov 2019, Vignesh Raghavendra wrote:

> It is possible that platform_get_resource() might return NULL and
> therefore code needs to check for this condition before
> de-referencing the pointer.
> Therefore move the de-referencing of 'res' pointer after
> devm_ioremap_resource() which would have checked the validity of the
> pointer
> 
> Reported-by: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

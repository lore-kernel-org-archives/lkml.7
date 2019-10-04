Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B8FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1B4207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wG0VPxdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbfJDPUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:20:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36723 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389224AbfJDPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:20:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so6282962wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bDywciZgx2XBGKysVl4djWbACpcmiGhqyGWzjzvget0=;
        b=wG0VPxddvftgOPz6T+sh3Kvv8RV2sb78no+PMklHkJL91sU4fZPTyyaMJ3b31wBzej
         VS5o5TugsO5A4Zgn99Csy0O4H3yFh3IkiDvOl4jyYUXKx8wfkGUO+R6E1ryfnDowdWGb
         5QgUfu5g4roLTjGyhmh/9FLlGNFfzyJKcy5ZlWIEMWnOVotjdnlSw9IhPXCwD3W2mlCh
         B++WBkCAtDVLHGQfARaI9j3d9vp5e2IExBnXFh3eiWWpUrpdnHal7b2VvQ53/IyGZqu2
         xNlMyHy8WfjkwiR3ib0uLFl1PHZNmq6paAbCVWGRvaSTkybjLNiGrG9OshVHYsonJVli
         2SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bDywciZgx2XBGKysVl4djWbACpcmiGhqyGWzjzvget0=;
        b=YSHt17dydO294tLwhBHTQEb2LRloVPv8kN9zsiLR4hjo7MEFnDnbg88Meh7Ogv/OXv
         yky6kAQguDaSgGyk553oYw8SRMmsXJ7rTprSfZCRJ8OgFLGbX3A+q6cBk0uANnGlhTfj
         LPHsgeKVOygJ9yKDfRlE5Ov7GHQDKo5Vd6A/nvQJiraZrI48F53rMSUE0UJc06in9/ql
         e6nGm1CKYR6QIgOQxaSLvUwsSJLxsaJaeJnhU+Gn6uoc1Z947eSgVEh/5ivG9ARyh68A
         9kIOcMwA+N/ud3MmsxUqEj28LJm2MnenNW8O65jUbnB7vu7CGcPx644QSo6depwGFEch
         Hf8g==
X-Gm-Message-State: APjAAAXR2M/QJ0ntd7OZHVDmW98PSlktG5OnZ4cnKnzZZqX+LP0EUnNO
        gnwCdGQ0JoY8F3A2Y9SqlmdsYCpXomU=
X-Google-Smtp-Source: APXvYqxyD6R17KEDZ64D+fBYHZNEsDDN6y+McbrzItzC/6eM7CB0KbH4SCq9b8P2XLWzF4La+9P++A==
X-Received: by 2002:a1c:a853:: with SMTP id r80mr11007913wme.140.1570202402906;
        Fri, 04 Oct 2019 08:20:02 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id y8sm7689041wrm.64.2019.10.04.08.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 08:20:02 -0700 (PDT)
Date:   Fri, 4 Oct 2019 16:20:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Message-ID: <20191004152001.GS18429@dell>
References: <20191003185323.24646-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003185323.24646-1-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019, Frank Wunderlich wrote:

> Part 3 from this series [1] was not merged due to wrong splitting
> and breaks mt6323 pmic on bananapi-r2
> 
> dmesg prints this line and at least switch is not initialized on bananapi-r2
> 
> mt6397 1000d000.pwrap:mt6323: unsupported chip: 0x0
> 
> this patch contains only the probe-changes and chip_data structs
> from original part 3 by Hsin-Hsiung Wang
> 
> Fixes: a4872e80ce7d2a1844328176dbf279d0a2b89bdb mfd: mt6397: Extract IRQ related code from core driver
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=164155
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/mfd/mt6397-core.c | 64 ++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 310dae26ddff..b2c325ead1c8 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -129,11 +129,27 @@ static int mt6397_irq_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
>  			mt6397_irq_resume);
>  
> +struct chip_data {
> +	u32 cid_addr;
> +	u32 cid_shift;
> +};
> +
> +static const struct chip_data mt6323_core = {
> +	.cid_addr = MT6323_CID,
> +	.cid_shift = 0,
> +};
> +
> +static const struct chip_data mt6397_core = {
> +	.cid_addr = MT6397_CID,
> +	.cid_shift = 0,
> +};

Will there be other devices which have a !0 CID shift?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

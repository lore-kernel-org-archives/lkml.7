Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6464DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7C0217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kT8GiffZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfH0E3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:29:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40221 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbfH0E3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:29:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so11108088pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7lmFerACB7Z6QvTYKolUFXR5vC+xKCugzXKrGfIU7mY=;
        b=kT8GiffZSf53a/DI9bdAaYdzUPD1bjgnUX5/rTQA8ZUBkuYGXxeE5JQ3D5vEuD4LoA
         cds+yySpv9nTfnIcYB71WebWf9IAWjpXPT2t/ABvNnTHbF+XzgrEYvT8rBOlf37KXhkX
         mq6vwO/j+4jhQOBOQLViCmm03k/KUnxEDAFGFFyk7Nr3t/MwAr2asYVgq9w1ty5D0dLA
         L1XHGE+tZCbBA1dlKCT3RO7dOU7Rl2enNXTRHMstzTpTHH3S2NhzBQo9pKSWgxDD/m67
         lexXQRD4irGKk/xWpT2Ktn02LIrJcBQkbrP3nkJYxfiNIbCo+qjFoSN3kW30ihZBdOAa
         Nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7lmFerACB7Z6QvTYKolUFXR5vC+xKCugzXKrGfIU7mY=;
        b=g25Z0aiCsY+BuLGrTYbaqUCFSxXt6JQSIgytpNqHRo19D2gCpnKY9OsVMTQrOYLEn4
         a93cdvVOPnfpIfv73JoU5GgeeLFpwi6ZO8jk+vv5xWriY2lQO8HqwJGKhNwepmyugPmc
         yC9rZW04Z0uKrIsZD7fTluCqnWtftAM1oNFOZTYR/jd5qd/AnZGXgBVc197FsLEmKNbO
         nfHEleJBXoAODHVE47WfJUP8wgTQDW4DqkCpXSBYsNhLs+3nknZeDztSmJXL69iW0Afd
         qy264msBSKfjbFZE+mf5aI4XNII0e2c+wam66pOi8kPDGMGuDg1SYVjP4fCIDV9vVGWj
         kYhA==
X-Gm-Message-State: APjAAAU3/niW0U0x892JlnmFxfNa7Q8uqhH4Mc7wi70MBBjEbX01DWf+
        IzY/oaSBcwRMlJ7/TmG3WiT2lQ==
X-Google-Smtp-Source: APXvYqykU9Iv3ReU8naBgaJ2xs2TesTPCnVvwbgNPtQhz7mPxdaOQfoSl6942Idr2I80B5d0YO55Cw==
X-Received: by 2002:a17:902:7c10:: with SMTP id x16mr8041902pll.181.1566880179166;
        Mon, 26 Aug 2019 21:29:39 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g2sm15306925pfm.32.2019.08.26.21.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:29:38 -0700 (PDT)
Date:   Mon, 26 Aug 2019 21:31:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Message-ID: <20190827043129.GB26807@tuxbook-pro>
References: <20190826173120.2971-1-vkoul@kernel.org>
 <20190826173120.2971-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826173120.2971-3-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26 Aug 10:31 PDT 2019, Vinod Koul wrote:

> Convert the rpmh clock driver to use the new parent data scheme by
> specifying the parent data for board clock.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/clk/qcom/clk-rpmh.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index c3fd632af119..35d55aee6a01 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
>  		.hw.init = &(struct clk_init_data){			\
>  			.ops = &clk_rpmh_ops,				\
>  			.name = #_name,					\
> -			.parent_names = (const char *[]){ "xo_board" },	\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +					.fw_name = "xo",		\
> +					.name = "xo_board",		\
> +			},						\
>  			.num_parents = 1,				\
>  		},							\
>  	};								\
> @@ -110,7 +113,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
>  		.hw.init = &(struct clk_init_data){			\
>  			.ops = &clk_rpmh_ops,				\
>  			.name = #_name_active,				\
> -			.parent_names = (const char *[]){ "xo_board" },	\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +					.fw_name = "xo",		\
> +					.name = "xo_board",		\
> +			},						\
>  			.num_parents = 1,				\
>  		},							\
>  	}
> -- 
> 2.20.1
> 

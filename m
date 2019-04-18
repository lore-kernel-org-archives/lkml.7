Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C113421479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIDM6AJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfDRFdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:33:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33262 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDRFdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:33:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id j10so729086otq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXbMAAsszy6FzOVtjRJW6hpyRmmDJ6XtcJWRp7Ah/ZI=;
        b=JIDM6AJ9nVJMI19kVQF4/CdZYyL7un86sPMHP05qLaanWK6R5toEnFKs6bG/KTRn2t
         FgZyXR4DIinoIIo1Sv0EOF/rtMjhSZzZBvyTKJoSjcqO8bZl3+XJ1snMAtbnzQKNtQOR
         ZpRZvpcdZsS+I05LQH2sSb2ZwJSCVvJhUh62SyIloL6Tzoy4BtdtrWzldI9a/WKckAnu
         UocWJoO/nSUVzm6yh+YNIrFf0BvqfyJhPkz/eb0y0WmlS1WJ6Kw9oJP1l02EMjGUgUUd
         LHbzG3xUtxQ2h7cG4aleMut/ypT8KDbSpKx8hoWwme6JKS7D0qGerqF6FzzMR7OqmREa
         dbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXbMAAsszy6FzOVtjRJW6hpyRmmDJ6XtcJWRp7Ah/ZI=;
        b=hvstShpDMtEoV6rvwY7JpcXYDTg7K48WsLmjVIpBCGjvwCB2ar3uxptfW5ewOFeRUn
         cZ4BfVQJk/IlIgWVmom35C/YSawITSwCVtEI30O3VLqj52RekvqEZnPPNbNHKx+lra8h
         oULsL6dV6No2R9gznQNVNUll2DMH8G8GGiWFZB8f595E7MEZ/4PmYkW5SxqE6GlpPV4R
         isb6ROGbf8qdyANf/n4NaHyJ3/S6M2tCH3Ryey7YRBkEaRZbUO9/h7zoVgtEvOC1fXo4
         GETA38MudNWSYeqhT8rhB+FT/lcxjj8WT67zpbTRfYQF+eYDuGb4qRHJ+YJWiAQDH2A7
         9uLA==
X-Gm-Message-State: APjAAAUbqBzbOwKjklnBr1QGru2yssS8d4fTb71pK+er8oR5zhVH7b+O
        664NaHxrZaixJpGP0Wn7JYbK4g==
X-Google-Smtp-Source: APXvYqy5REPUbx3ersiYZ2U8smEkwejsKtgs6FAILobVFGdWcszGDEAP/9RrOS8mFxK1o+W4F/exMA==
X-Received: by 2002:a05:6830:1051:: with SMTP id b17mr2245083otp.341.1555565628459;
        Wed, 17 Apr 2019 22:33:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id 189sm495480oid.35.2019.04.17.22.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 22:33:47 -0700 (PDT)
Date:   Thu, 18 Apr 2019 13:33:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Message-ID: <20190418053339.GA4524@leoy-ThinkPad-X240s>
References: <20190320100508.6950-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320100508.6950-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Stephen,

On Wed, Mar 20, 2019 at 06:05:08PM +0800, Leo Yan wrote:
> clk_gate_ufs_subsys is a system bus clock, turning off it will
> introduce lockup issue during system suspend flow.  Let's mark
> clk_gate_ufs_subsys as critical clock, thus keeps it on during
> system suspend and resume.

Could you pick up this patch?  Or should I resend it?

Thanks,
Leo Yan

> Fixes: d374e6fd5088 ("clk: hisilicon: Add clock driver for hi3660 SoC")
> Cc: stable@vger.kernel.org
> Cc: Zhong Kaihua <zhongkaihua@huawei.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Suggested-by: Dong Zhang <zhangdong46@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/clk/hisilicon/clk-hi3660.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
> index f40419959656..794eeff0d5d2 100644
> --- a/drivers/clk/hisilicon/clk-hi3660.c
> +++ b/drivers/clk/hisilicon/clk-hi3660.c
> @@ -163,8 +163,12 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
>  	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 17, 0, },
>  	{ HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
>  	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
> +	/*
> +	 * clk_gate_ufs_subsys is a system bus clock, mark it as critical
> +	 * clock and keep it on for system suspend and resume.
> +	 */
>  	{ HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
> -	  CLK_SET_RATE_PARENT, 0x50, 21, 0, },
> +	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x50, 21, 0, },
>  	{ HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
>  	  CLK_SET_RATE_PARENT, 0x50, 28, 0, },
>  	{ HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",
> -- 
> 2.17.1
> 

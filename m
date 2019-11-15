Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D21C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lea72v0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKORAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:00:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:00:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id l4so5040956plt.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KJTXmV3nRW8gUbGqQ4GcrDPQULApXAqF7C+3pqi6RM=;
        b=lea72v0aKBO/HzkW9xRW0+gmfuKWuweJm8ZuZhTIE6ZspE9e3DdbgdeOqryeh2WpHs
         69VCzsotxdw11qrFs2/xzVdgNpKaC8lZYDeHIj6pnZlDX4VWEl4FWcoKYqGnAas8lUU4
         1dbEIwD9NKRURLHoHwSslyp2NZXgzpz91sk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KJTXmV3nRW8gUbGqQ4GcrDPQULApXAqF7C+3pqi6RM=;
        b=XBsCA57rzWp17p7ZHyXMQF1Jhw/PJZOpN8zSgJaWDO0ZkpTVACYH/mCcKnlhXXaqBi
         kc9JnPabgwm4s67rB73vezKCl25guvApPoLa6A8qHkpleyP5XltxJ0Pb13adM4ahLOvf
         lkrXkbArJ8krwwwzRrkl/y9NtPvhawp26RzAeI/TLz+hvqyKBAY28KghlqQNzyBG/eQ0
         K0PDQYpS7mNUpYra5q9lmhA08IxLTjKQmTXzemZthTx4sW1Ds8vx60/XYVV5XMN3wtyr
         aMGqUmpdYZg2QDvDeiQrotIokW2j7+CqVQ24seK4WanpkH1OO0evyqO6aNsyQVXYbUDN
         Pkdw==
X-Gm-Message-State: APjAAAV5BUIIeRncoImwUbs22s82ApKtffj1GO/kzJYyfryksFRhyZ+u
        Gr4nSoOipE1fzXBhOffny6an3g==
X-Google-Smtp-Source: APXvYqy13tvuu58lwI0ZashXZBglnAc01GHqKKGLWlQ1kA0mCtTgoAkAcwI/Gc3rB016Is7SqriZWA==
X-Received: by 2002:a17:90a:b393:: with SMTP id e19mr21641421pjr.115.1573837228497;
        Fri, 15 Nov 2019 09:00:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i22sm8907804pjx.1.2019.11.15.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:00:27 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:00:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] clk: clkdev: Replace strlcpy with strscpy
Message-ID: <201911150900.817CDE33@keescook>
References: <1573812819-5030-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573812819-5030-1-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:17:53AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The implementation of strscpy() is more robust and safer.
> 
> The strscpy was introduced to fix some API problems around strlcpy.
> strscpy is preferred to strlcpy() since the API doesn't require
> reading memory from the src string beyond the specified "count" bytes,
> and since the return value is easier to error-check than strlcpy()'s.
> In addition, the implementation is robust to the string changing out
> from underneath it, unlike the current strlcpy() implementation.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/clk/clkdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 0f2e3fcf0f19..ee56109bc0b4 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -165,7 +165,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
>  
>  	cla->cl.clk_hw = hw;
>  	if (con_id) {
> -		strlcpy(cla->con_id, con_id, sizeof(cla->con_id));
> +		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
>  		cla->cl.con_id = cla->con_id;
>  	}
>  
> -- 
> 2.16.4
> 

-- 
Kees Cook

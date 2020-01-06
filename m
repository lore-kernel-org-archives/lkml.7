Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B66C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A54207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9VOlBQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgAFTPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:15:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52532 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:15:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so7944596pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFwzTDfVSEsQlAMMcJbbQMcZerRfZ61wXIEvCkNUZdQ=;
        b=s9VOlBQnwNsApUHOQQ2PUWXHKhgrwqrmhv8WBjlrxXSF27zy+XeWF/hA6zXnaatq0l
         EVDNxLaF77qE9ebp+sEHfaS2d3stCllbQouOS8kipKrzF+/8iS2kFvsNodIiujx7Y3aC
         yZK5gq0y5gtU5NA6PdJ6IM4YDylADfIzFCNmjPU8IGzyzndZhP1OBF+Sk5Vsm50KHwfz
         Yjv9yIKAUl3tsnTB5FPV9EmFZR7cYeoZZhChIWReipv8C5/c3Ido6yZKa1xH3q+Y1fqM
         Ewao0SzZ3Iy1XQw+t7y+5UlkZLf9dB8ZamsB+eh4To0t1SbVWIwVS4REjkxXbwO01/Hc
         fGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFwzTDfVSEsQlAMMcJbbQMcZerRfZ61wXIEvCkNUZdQ=;
        b=ZgG45nUXE14N3u14oVVU+61B2QHGebK7zSowH2uwkmMOWqg+g8sP1ixeU9fqm3hEiX
         g2w+UujsuQeUvMv1fwQk70PKKFX8aZOs/RnMaiDbTAL4i1qx8Ts8K1599zgvw3ON9fcy
         6ZkETACxZ+Ox5Ys9+qLLoeuPG892fqcZbieT9KhzuJKoXviulYs0R2xi5ErnsagBg86F
         rvNslo3ordj0Smaw+B2HYVUs5us171JU8oIS2XjRqPRj9OZGTZrmSw7Z4OcKfY9uQO8T
         4/HDOVHe8mgsRSNFekG7bKeNIgqPe2zVLJjwGPrTsNIJw2LnAEO3i30cWEgUZEvHCaxJ
         InwQ==
X-Gm-Message-State: APjAAAUxwVGSFh6VsAHCvbQsAK/PWTQUOWYzmON3RZDAwVy8XUxtEI1e
        7/5L5sJQ594RLr7zd8Vs22xVDLvIDtM=
X-Google-Smtp-Source: APXvYqxa4AUZrWKk56M6JY/TJLxdtIqbX+Uo+ysj7McsHKpTpJ2onOc3GwFjpLOQcKAu1t9I6vxC0Q==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr109469537pls.1.1578338101538;
        Mon, 06 Jan 2020 11:15:01 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm71718552pgi.94.2020.01.06.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:15:00 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:14:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: avs: fix uninitialized error return on
 failed cpr_read_fuse_uV call
Message-ID: <20200106191458.GV3755841@builder>
References: <20200106120558.37758-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106120558.37758-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jan 04:05 PST 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call cpr_read_fuse_uV returns an error the value in the
> uninitialized variable ret is returned. Fix this by instread returning the
> error value in the variable uV.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/avs/qcom-cpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 9247f53550b3..0321729431a5 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>  		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
>  				      step_volt, drv);
>  		if (uV < 0)
> -			return ret;
> +			return uV;
>  
>  		fuse->min_uV = fdata->min_uV;
>  		fuse->max_uV = fdata->max_uV;
> -- 
> 2.24.0
> 

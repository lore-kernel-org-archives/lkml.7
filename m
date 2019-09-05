Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECACC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54104206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIVl99L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfIEAO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:14:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45410 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIEAO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:14:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so322220pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diieQ8EBqgcQJUrsXwTks6b1z96zAex0NF2Hmz0b35Y=;
        b=WIVl99L8/3T6fM8Qgw/RlwMDG4yQ4lvjWot/XZl5PBbk/kD0JKwwUm56I1dtDYyLwW
         EbNogigWPITfoCAGHHoo2CyZjLbCZ0LZMo79QjpWLEt+kwDH/dFAts4deR8hBKFvIZAH
         7bOOI7qM9Q5BcfwHOaFOkHv5yGdO7+smZzn14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diieQ8EBqgcQJUrsXwTks6b1z96zAex0NF2Hmz0b35Y=;
        b=X5NzzP2ecxsc19q73YTq1WdWCFCguJnwyKGypPkfm/b/vFymnDUw8znltdJHbkkXhe
         zGcEzM/IAukLZleW2nGK/nd3TTRAs7hyjNe4BhKLnOhJGefc+aetbYwrD1xQ5HohgPl1
         CnZ/s8FN+l235TwtV5qlICR7Dmm0648955aJxlpHqlZWIVV6eNQ9ioT7rQwDl3o4ex2u
         FiVR61sqrKpMbtcwCKIPvo0VqVMX47ST3uJ2qBQjAsWLp46tKQoTo0n0fMn+U2i+J8zA
         n/k+j+v6f+VgpDDqLHcV4RpOO8ePYO2IcNSX6LqW2CJA7WQkC0i7+hyyaQ89029GEOWR
         ERnA==
X-Gm-Message-State: APjAAAWmxNU6dUTEKh414VbsBRMSkrj/1ue9qbPheirpHY6pxsS49FTy
        Ezyc7KS5MW0M2hfLJgf+oOzvPStu9pM=
X-Google-Smtp-Source: APXvYqx644/2GrLekucQUWiowFO+GAususlTMvtOyZ2eD2nVHynyZdKXd6+std7V+dgBr1PQJyrzjw==
X-Received: by 2002:a65:6256:: with SMTP id q22mr668090pgv.408.1567642464887;
        Wed, 04 Sep 2019 17:14:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q71sm163292pjb.26.2019.09.04.17.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 17:14:24 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:14:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system
 resume
Message-ID: <20190905001422.GH70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
> 
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index eea52e2c5a0c..f114710e82b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
>  	/* Force setup bus to guarantee available clock output */
>  	dw_mci_setup_bus(host->slot, true);
>  
> +	/* Re-enable SDIO interrupts. */
> +	if (sdio_irq_enabled(host->slot->mmc))
> +		__dw_mci_enable_sdio_irq(host->slot, 1);
> +
>  	/* Now that slots are all setup, we can enable card detect */
>  	dw_mci_enable_cd(host);

Looks reasonable to me, besides the bikeshedding over
'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
if SDIO IRQs is enabled").

One thing I wonder is why this change is only needed for dw_mmc and
mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
newb?

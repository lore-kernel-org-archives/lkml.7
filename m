Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B83BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BF1206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzUa7NKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfIERd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:33:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIERd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:33:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id w22so2196838pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8R3+OmtuDMMstbafhwym94imqZ0Nk5n4dGHFrzndn4=;
        b=YzUa7NKYJ7LuOVtU5RTZpJYn8xXyvlW7tNsK1cAhTCwVpts1tCbVBH+P6E4PDE8RDd
         tT3g+4pO+kc6Y1yHA1IO+YutSQjrI4BYDcoqV+g5xCMpEvgUFs3WNvChFf072tNGCfam
         TROx2NtXkMU1Rmfgh3ZPtHbgXyqle5gX+CMiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8R3+OmtuDMMstbafhwym94imqZ0Nk5n4dGHFrzndn4=;
        b=AYHj7eMJGFWWlOFkvBV4wBjPyfXdMwu9YdbIqesaZ8AB3/Ghps6NpUQ0o+Kq0ZvRxt
         qEncAsBxsJkGwcLu63Zn3Q0/7XdSjTqyi+PzReaiy5kmfrWW+jXp9VoE7L3WKBS2tIna
         3Yd1kWzMMwlsSfOTbbjhYqSQFmXL3SvqqBd9FE6TrzOjVTioV9FSDOzr7kmp+8OWTyxa
         B//xcamfQ6jvBXMSQlG624g+fW1GgRjUMhS13Og5kvRtXWSsOjP947x1W92G8SZtDqg3
         C5YM4mewhstD6SdqJzv84gneQ+U/RhYqB7r70CaKOw5QrWvbC+gWlne0huwH+Cy6ES9V
         6Vdg==
X-Gm-Message-State: APjAAAUSsBRgXFksfSRKUD1W3qfybj9j3Zvb4O+P0jo3axx/zJg2R0Io
        siD5OG7FKerYpbL1K+U29AYySw==
X-Google-Smtp-Source: APXvYqys3sPK99TN513v9cRXEKaBZBoB9eVABz2ZryJ2drDMFQ/3biNgtDT4yzNq9fMsqApSP949NQ==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr5168384pjp.60.1567704836861;
        Thu, 05 Sep 2019 10:33:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a20sm1602694pfo.33.2019.09.05.10.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:33:56 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:33:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
Message-ID: <20190905173354.GK70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-7-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:02PM +0200, Ulf Hansson wrote:
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
> 
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 0962a4357d54..d7965b53a6d2 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
>  		process_sdio_pending_irqs(host);
> -		if (host->ops->ack_sdio_irq)
> -			host->ops->ack_sdio_irq(host);
> +		host->ops->ack_sdio_irq(host);
>  	}
>  	mmc_release_host(host);
>  }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0c0a565c7ff1..ecdc1b0b1313 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -128,6 +128,7 @@ struct mmc_host_ops {
>  	int	(*get_cd)(struct mmc_host *host);
>  
>  	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
> +	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
>  	void	(*ack_sdio_irq)(struct mmc_host *host);
>  
>  	/* optional callback for HC quirks */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

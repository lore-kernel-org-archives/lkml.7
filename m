Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EDF21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fL7Vo58n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:04:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:04:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so4409966pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6mNCX/KX4boUEtiC4AfiPV9MtFO5pIWwbz7PSRKAGA=;
        b=fL7Vo58nzJhGzD6mdJp1QeRvNGKLgdPvqHWFIW8gS1JkcmXyMkkZooq1lWwqynq6jy
         ye9GJKZGGhLs5Gl1BIidWCcJcwsg4S0ZHHYBS64Ac3uKvYlrHTkQ+YaNa+zP4iWIxUyl
         NKdUycwDJ1c5ARuP1+Hb8YD8aOl+oAgsTQ4s5Syi1t0XHfH8GII5MHsizKKYIGa0uj4S
         K0Jrl3XwFs7A2XZMG1qY6oo8LcTv7dHjA6fJPAM+ofy8gUxtLY6AqOsZ+g7CnDF7+caI
         ueNzcWI2NWy5M4toTT7ymIUUoTzAMD2T1uPphNtcdZ8XBjTU7tafFBd5QVB8ZTtOarMA
         MRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6mNCX/KX4boUEtiC4AfiPV9MtFO5pIWwbz7PSRKAGA=;
        b=naqSI8n/Wbs5ERZ4SxraAfyGjmYhIPyIOA4Aaoix0K36v8sF6u6EaqQbRWRoucT7ON
         ycOemNIlhL8LZjEXIRzD5D/b0USZSAHI7F0pJVWpt9DzfTO6RFP6pf/uvBEdkMMKI+Lr
         pgIgOwIxducwA893OCDo1muzYGDeEbNtFYFtFZDTJ89PKaR206OcWp5rqk96OzOSm7By
         YIUWo1wwdOxwkw/BqvCdkN/sG4qtDK/i9DAxg2mVOY564pzyNRBxSWkjUIoq0nIXte05
         PKSZR4TBRvusGc7nG5jP57wzXe2ZfgEKEPSh5DdZULYWvVAJnY33IyPwDKy2l+oeaW8R
         40BQ==
X-Gm-Message-State: APjAAAUkUAaeabyY8wEZoDUSMauJCIAbg1CrRCw7M4UTbWMb0uxc58TT
        6Uu85lgfdP0a+83UjwYycTxVbsSH3ms=
X-Google-Smtp-Source: APXvYqyWTI6bisXzwWbs7tADpWb7qCtkjIYrZwQXbVFK2S/mZ3Li94In+tKU3yps+tF5SFtBvVa+6g==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr32518116pfo.30.1573509860257;
        Mon, 11 Nov 2019 14:04:20 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f19sm11173159pfk.109.2019.11.11.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 14:04:19 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:04:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2] remoteproc: stm32: fix probe error case
Message-ID: <20191111220416.GB3108315@builder>
References: <1570433991-16353-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570433991-16353-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Oct 00:39 PDT 2019, Fabien Dessenne wrote:

> If the rproc driver is probed before the mailbox driver and if the rproc
> Device Tree node has some mailbox properties, the rproc driver probe
> shall be deferred instead of being probed without mailbox support.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
> Changes since v1: test IS_ERR() before checking PTR_ERR()
> ---
>  drivers/remoteproc/stm32_rproc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 2cf4b29..a507332 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -310,7 +310,7 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
>  	}
>  };
>  
> -static void stm32_rproc_request_mbox(struct rproc *rproc)
> +static int stm32_rproc_request_mbox(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
>  	struct device *dev = &rproc->dev;
> @@ -329,10 +329,14 @@ static void stm32_rproc_request_mbox(struct rproc *rproc)
>  
>  		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
>  		if (IS_ERR(ddata->mb[i].chan)) {
> +			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;

If for some reason you get EPROBE_DEFER when i > 0 you need to
mbox_free_channel() channels [0..i) before returning.

Regards,
Bjorn

>  			dev_warn(dev, "cannot get %s mbox\n", name);
>  			ddata->mb[i].chan = NULL;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
> @@ -596,7 +600,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	stm32_rproc_request_mbox(rproc);
> +	ret = stm32_rproc_request_mbox(rproc);
> +	if (ret)
> +		goto free_rproc;
>  
>  	ret = rproc_add(rproc);
>  	if (ret)
> -- 
> 2.7.4
> 

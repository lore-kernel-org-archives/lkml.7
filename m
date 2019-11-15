Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FEEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB0720732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/KXp98I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKOSzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:55:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37335 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:55:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so7118040pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5/DV9l5vjoy566bD7j+28Px5X64vcSjdjpGgZ+iBNys=;
        b=H/KXp98I7VNkHc8aGry+k4qMOXigEvqS5f48d8OiOYilQ4J2JwVhl6GgokzI6hyV62
         XWkMKULwF03dKbwXHrV25fcvG4pFGGEMexDLJ+Yh3PK+hdPhnERKyqc4g3AzSJ3SGCJZ
         OyCkTZIxlmqlvqF1t+Fnyrlxhd1HP2fIBp/M5NcGjSuffzdMZKMyUk70LicNWBtTC9KY
         I3uBGnreTlwa5iuUJWIJvLlCr5Mbzk9WqyHIHjlGMetRB/9asxXqYDEDtQTGCPZIDZNb
         QWoUp0LtC4qbXAZ+ZD7roicUqYHW05JcJu8W8RRz9Xo7s6emVbzQ9YdMKkWyU+qHPNTs
         Oc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/DV9l5vjoy566bD7j+28Px5X64vcSjdjpGgZ+iBNys=;
        b=WYlXtBEuwG+Hw5tW/rAhGs74TBHPXqTqkc6jlikDMtgg8clQLwfi+c7c9NJK9TF9pY
         RvOd9kXoTM9RjG/5XDoeBHWMP6tU/hI6xlcdug632md9kuMFJPNsPpiw+JYkJVQOddIG
         fHnYqy631jZ43CrorakYfsPC1ataEles2v5KV1U8LETHzObwgP8USxWzUEiwsd2F1PaF
         eQDOHB/nRuNMZSMsMtPVlL2yzIjOWOLtpWWyvWAd7yrqAl8I9BhrNFkzv2ezLFqoRaVU
         8j8Q6eaa4futT2F6sAT1JVhz9HOqotj7FPWU1ja0PJo+P0E9Vg5WBPlQmIaT3A+/pDyw
         kTOw==
X-Gm-Message-State: APjAAAWyKDyYRyyhVDNXjxUujQON1FIhGs+liD8qyj/BGlt8UcRUAYTI
        Exuyzz1+sF+tLE+YArcgHgcMgQ==
X-Google-Smtp-Source: APXvYqxiuLVF6hREoHjpiqNAQJjrFwPI2aFPUGj4Kmc+5j35f5RvAklf22Il0U3b+Ud+37gdYfUmww==
X-Received: by 2002:a63:d70e:: with SMTP id d14mr17742459pgg.10.1573844152375;
        Fri, 15 Nov 2019 10:55:52 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l62sm10835645pgl.24.2019.11.15.10.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 10:55:51 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:55:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH v4] remoteproc: stm32: fix probe error case
Message-ID: <20191115185549.GA17332@xps15>
References: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

On Fri, Nov 15, 2019 at 11:03:08AM +0100, Fabien Dessenne wrote:
> If the rproc driver is probed before the mailbox driver and if the rproc
> Device Tree node has some mailbox properties, the rproc driver probe
> shall be deferred instead of being probed without mailbox support.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
> Changes since v3: on error, free mailboxes from stm32_rproc_request_mbox()
> Changes since v2: free other requested mailboxes after one request fails
> Changes since v1: test IS_ERR() before checking PTR_ERR()
> ---
>  drivers/remoteproc/stm32_rproc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 2cf4b29..bcebb78 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -310,11 +310,12 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
>  	}
>  };
>  
> -static void stm32_rproc_request_mbox(struct rproc *rproc)
> +static int stm32_rproc_request_mbox(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
>  	struct device *dev = &rproc->dev;
>  	unsigned int i;
> +	int j;
>  	const unsigned char *name;
>  	struct mbox_client *cl;
>  
> @@ -329,10 +330,20 @@ static void stm32_rproc_request_mbox(struct rproc *rproc)
>  
>  		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
>  		if (IS_ERR(ddata->mb[i].chan)) {
> +			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER)
> +				goto err_probe;
>  			dev_warn(dev, "cannot get %s mbox\n", name);
>  			ddata->mb[i].chan = NULL;
>  		}
>  	}
> +
> +	return 0;
> +
> +err_probe:
> +	for (j = i - 1; j >= 0; j--)
> +		if (ddata->mb[j].chan)
> +			mbox_free_channel(ddata->mb[j].chan);

Do you need to set ddata->mb[i].chan to NULL as it is done in
stm32_rproc_free_mbox?

Also I'm wondering about the error path for this function.  If something goes
wrong in mbox_request_channel_byname() none of the previously allocated channels
are freed and no further actions is taken.  Should we simply abort the probing
of the rproc if any of channels can't be probed?

Regardless of the above and without surprise:

Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org> 

> +	return -EPROBE_DEFER;
>  }
>  
>  static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
> @@ -596,7 +607,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


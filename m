Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701D821872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sqe3U+OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfKLGPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:15:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfKLGPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:15:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id 29so11139398pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRZ0BJA4db3dS/zIFjnsF9DDaNs4fUNGpbTkNxgU/oY=;
        b=Sqe3U+OI365237Ez4qw9i8BXSixdFMZDIkIXMueMovlj/9LaVsZzg7bJKpZuiNvifO
         itI9orDHmxJhQb+AkqEDVwrGGgFYLoyMQMrU6MfYjRGaU3gLvPk2LZEMF/Bpg3i1fw4A
         EVWhs2MFSpL3zDdGOVvUvjcaZltQUaBwE39vmfCoWv9hK4sI5TCtO99RFDvo2RcCBRd4
         4CWo3vnyvkfPXm04f334UvO+mMZYj/98IWoFPTq8kK66Fr9U+L63coxyCjq5WaKQ++0q
         pD1FA6YOy2qhIAh/SO419nIwFFhc/x8YV4BuKRUfu9xeYO6Lr4wmw2wWAhAomQ9kuVUy
         OJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRZ0BJA4db3dS/zIFjnsF9DDaNs4fUNGpbTkNxgU/oY=;
        b=pHFG+5gCpsBSfA/iYZw1Z0BC38Ss3lmI2FgrLxQb+MdtXHBOGOE8kDE2NrLF236TB5
         10Z+XJsnWpd+jLY6+pXIc4OFA/6qPOBiow6sSo/uSa88+seAjcnlCR/iXsjEhesQd4kL
         mhFtzqH2XiYkMNExdaz3yhMqXtnbglqyA2naeiH71xk2jz57mqB2n75iaIrjVnGn6nMZ
         bYFDKk6iNvOWyNLX+k0HjNO/T6mrQrJpxmSHgTodq2Z9TSQu1lRf/FcxewadN5IL22XI
         XoUzKROYHcFf4RBQx4uNHl93eODI3Zj5edHPKZ45XWE3ajgPfJgClCMlXQ1WKIIOKRX5
         gcxQ==
X-Gm-Message-State: APjAAAUMizc3RHqX8bTtRn1Gzm4y+a5yNPPD4u1i8nqdtBL2qfFKVVLf
        Xohlt0MJN2579Lh1Rq3bF9LXFg==
X-Google-Smtp-Source: APXvYqzHPxtYdORBo2xTI6Mtm8MV25+2WYGZWhuxsi/Es2clwrCLIRN1jFgfuGE7IrMqR2cV663fEw==
X-Received: by 2002:a17:90a:5d04:: with SMTP id s4mr3991747pji.137.1573539339521;
        Mon, 11 Nov 2019 22:15:39 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x203sm18749498pgx.61.2019.11.11.22.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 22:15:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 22:15:36 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 13/17] remoteproc/omap: add support for system
 suspend/resume
Message-ID: <20191112061536.GO3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-14-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-14-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
[..]
> +static int _omap_rproc_suspend(struct rproc *rproc)

I think it would make sense to inline this and _omap_rproc_resume() in
their single call sites.

[..]
> +static int _omap_rproc_resume(struct rproc *rproc)
> +{
[..]
> @@ -806,6 +972,14 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  			oproc->num_timers);
>  	}
>  
> +	init_completion(&oproc->pm_comp);
> +
> +	oproc->fck = of_clk_get(np, 0);

devm_clk_get() ? 

Otherwise I think you're lacking a clk_put() in omap_rproc_remove()

Regards,
Bjorn

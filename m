Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D7C32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA4F206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp6cHGV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJEEET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:04:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35394 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfJEEES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:04:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so2581255plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjGNki1OtQEb9lfJ7oq86arnt9zKkyVmO56fkHyMMNA=;
        b=Pp6cHGV1T9C8JGOPqZ5ZlA9zXuRKxXrYBXa6Q2bspKkZUoX386pJe8QJw46fHhziqm
         8j/2teWNFBYM2iCiHz7ob8qRgIdwmV7GC3BZx3x69bactMZ8RjbBVdKIZPUo1w5m5ps4
         ejo/g6edELC3BDyPX/gbtLItFz+PLvNDxaJu687yKIH4PJwSGkl6kFS4jDU14ykmX5nw
         6APu1NGSXU+hNcwJXnyikT+VUBu06OGpl4nyvonvmsNDZsTVz2edgyqHWFT2TUzfqPgj
         JFzpk626GQUK+YX/orjIwdxS80DqzXyIyuHerWR8I/nDx5vWN+mzZa8ki2K3ekV3nK/a
         Wbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjGNki1OtQEb9lfJ7oq86arnt9zKkyVmO56fkHyMMNA=;
        b=KtA5MEFdbh2I0XCt4qcAekBcbEOqJiMlq77oAaw6uiWiOBoVfSH9yWsQ9BqLQ+MalG
         g8eFQCYBlupY+G3+gJE9Tm2yCBkRJSiXsqfHvxCcG5CpZhFgNft2FiXjH8l9YMPdQAT0
         VTd7omB22V/3nEYu/3PaS3PzXv7a3HxRTwk4aIqIBr6Oqasi7YN2MaK4JpHbVugSM/7Y
         3/QhG5VCCVzGeKgCGCnV56DN4yPWAW1/sE2PtNxRkU+0UWHrI7V57y0suhu6w5/BEZpT
         DnR+5CpRv3EZpcSVsyrVqE+A2dTxPgAEtjZbu2vHKuRKgLOr8biTTEuUYLUMGyxZTz5E
         nVQA==
X-Gm-Message-State: APjAAAUcMd2PQpwk5MxUtNPJg1NpRkdEareeLobGQzVb+4umWE9l5CJ6
        lw/oN94X9s8eIUQaHvCYxS9pcQ==
X-Google-Smtp-Source: APXvYqzY08m6btRbimG2q898DgnjetYaB0eC4YSy8klHl9oR6CrMbJJ7A0hsMqeg/pYeKNIZosDu3g==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr18251348plz.140.1570248257806;
        Fri, 04 Oct 2019 21:04:17 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r24sm7824649pfh.69.2019.10.04.21.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 21:04:17 -0700 (PDT)
Date:   Fri, 4 Oct 2019 21:04:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: remove useless typedef
Message-ID: <20191005040415.GC5189@tuxbook-pro>
References: <20191004174424.21898-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004174424.21898-1-cleger@kalray.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Oct 10:44 PDT 2019, Clement Leger wrote:

> rproc_handle_resources_t is not used anymore, remove it.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>

Applied

Thanks,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 48feebd6d0a2..78e00194e72f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -52,8 +52,6 @@
>  static DEFINE_MUTEX(rproc_list_mutex);
>  static LIST_HEAD(rproc_list);
>  
> -typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
> -				struct resource_table *table, int len);
>  typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
>  				 void *, int offset, int avail);
>  
> -- 
> 2.15.0.276.g89ea799
> 

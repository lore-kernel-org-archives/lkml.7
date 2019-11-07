Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C1DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF1F21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LY4v6pcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfKGLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:55:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfKGLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:55:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so2708230wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ayk5We1vI12jLcW3zDErdcAcqNSpWsXr0NVSETpZ+JY=;
        b=LY4v6pcmezZwNcfXllRMIlIjE5qYGtgxeDhF7eBdaYPb609c6eo6pIgq4c6K+FqEoC
         zOxS/HgDxakHr18mXqyWj8cSn4feSZNsUjMXog5Y6AagnyEL9DWa0LKNH27cqIeixJR+
         fvGQ24iVw9AXyh9U+iUKb8ks05Wh9U/iNIMcYtHT7IkZVo+++N7kV68Vs4ATLZ1zA39k
         yT5+8kK4aDbxSp+TxPKeEtBaGAcWxkHoZkGXBZVDzSKz4eUbTR6u+YEx15NmKunp2aGu
         kzLSIWjQX7eTE7XW6L5VLZh2AmZSCk8y5kvmTCuoGrilR1aCC99UOx6jiLjgoV5UztwW
         7Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ayk5We1vI12jLcW3zDErdcAcqNSpWsXr0NVSETpZ+JY=;
        b=O9eE75mcxGihFaXEsxMRz/TIHgKS1qmyKv2PPtvl0MwR6vgA8E+xY3OOY0vqWda826
         pLdt9EsXyv4WnwMcUVDukOpolRu1IzNCMjPT6lLRQFgJfUe55q0ROj80LMFjSoflwz3N
         NOW8wRt5J4t7RSLxev6owm9MIfKXxwxPTaGpfK/bEGfayyn/J3iRSIScM5FjPInKj5HO
         n1V9KjyrrsKvj6o1EhUuGzreWR6Fk2r+L4aCVapMSlQ2IYu87uBxNSKf4+TdqYqNr4i9
         JYcLTGEWvusAfA65+ppQ9S+8eBA7Z3CXUSTsIO3jjhpwpRqLAu96eDER0TrBkIdRMgWH
         T1pw==
X-Gm-Message-State: APjAAAXzx7b/OMQ1arYboq9nDFCD5Odk9620BrKS0DPUfuZXs9yKsz1m
        rxxx+E9ZW6NhwD+NOq78zMkCWw==
X-Google-Smtp-Source: APXvYqxuJubr7r9uEWSKkiOKjKqi6rliFvlqVHCYYa/EMNvKvqAwJaUcEoDweUzbvue1MK61Zb183g==
X-Received: by 2002:adf:e488:: with SMTP id i8mr2465007wrm.302.1573127699748;
        Thu, 07 Nov 2019 03:54:59 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s21sm1895785wmh.28.2019.11.07.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 03:54:58 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:54:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Barry Song <Baohua.Song@csr.com>
Subject: Re: [PATCH 1/1] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
Message-ID: <20191107115456.esxtcgo2pt7eq3v5@holly.lan>
References: <20191107111950.1189-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107111950.1189-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:19:50AM +0000, Lee Jones wrote:
> Until now, MFD has assumed all child devices passed to it (via
> mfd_cells) are to be registered. It does not take into account
> requests from Device Tree and the like to disable child devices
> on a per-platform basis.
> 
> Well now it does.
> 
> Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
> Link: https://lkml.org/lkml/2019/8/22/1350
> 
> Reported-by: Barry Song <Baohua.Song@csr.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/mfd/mfd-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index cb3e0a14bbdd..f5a73af60dd4 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -152,6 +152,11 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
> +				if (!of_device_is_available(np)) {
> +					/* Ignore disabled devices error free */
> +					ret = 0;
> +					goto fail_alias;
> +				}
>  				pdev->dev.of_node = np;
>  				pdev->dev.fwnode = &np->fwnode;
>  				break;
> -- 
> 2.24.0
> 

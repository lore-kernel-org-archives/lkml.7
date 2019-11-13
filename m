Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109A4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17C0222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573606646;
	bh=GP9XXD7ZqGCN3PTKCtWCaRGc0mi2WgNpEW7NgKaQhJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ydn44DvfKjF8Je4MV67R2VO7VRonsDhObBIo2iDl45DdCW5c5pbJompKctih9dxpf
	 Gur5wqrO6FyBl+jMOahdtluWhIzpUCCNKQkftJ5oFw84lRBxvzEsiC9giWD6vNy+Ml
	 4jbasY44krvEytAY3pGkwB/RiyQ/ViZWnVxkmPpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKMA5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:57:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40177 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMA5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:57:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so284678plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=220I2/ElUHylXyQ2K7+j8zEngS8Zy3HJWnMySgkjXUI=;
        b=m+SFQZtojUOZKV8rvw8K8FZAQyoXabF2vbCVdjfoUz1tr79hCjGyL68B/a/v2MB/tT
         Ir3PNU58N39CJONleM++gVdZOjQlh77key61Y50j9cEZJApVdZ9LMQmWoQtclpQGZmaG
         GkjhOg0PEv5mBBDCvXoY9+Q/IvkYECD5xaumzFK9rq3+wGOH+3qhMv35Q4NK4iO6rzqt
         /hQhByGf5eURr0XfJypdsF9kg2Yd/zApPK7o/SadifjKmAIETdkeofgZQA+rSDjKHp0v
         +6Md34vJFZFrhqz48+lqK2Y2XK9OqwYB3sPrKwoeEcPGFgAsf6ziAqGDCV6LmDr3pBFA
         NHMw==
X-Gm-Message-State: APjAAAUpGyJJ/lOuFRRawApA4wkw1/7PgT/BJazbngghBjBWsB2WbEcs
        wO93pTKs54JW7N1pOCviVAzqrjmP
X-Google-Smtp-Source: APXvYqwxjuvKRuDIpJUyRN6Z1/16fJSpZi4PHJhLHmho7QU+Yt1+KkdrYD1KV81PWztz4hjeOSnDpQ==
X-Received: by 2002:a17:902:ba91:: with SMTP id k17mr789293pls.100.1573606644375;
        Tue, 12 Nov 2019 16:57:24 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t12sm204645pgv.45.2019.11.12.16.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 16:57:23 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C3D14403DC; Wed, 13 Nov 2019 00:57:22 +0000 (UTC)
Date:   Wed, 13 Nov 2019 00:57:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: log names of loaded firmware
Message-ID: <20191113005722.GU11244@42.do-not-panic.com>
References: <20191107174353.20625-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107174353.20625-1-robbat2@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:43:53AM -0800, Robin H. Johnson wrote:
> It's non-trivial to figure out names of firmware that was actually
> loaded, add a print statement at the end of _request_firmware that logs
> the name & result of each firmware.
> 
> This is esp. valuable early in boot, before logging of UEVENT is
> available.
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  drivers/base/firmware_loader/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index bf44c79beae9..f0362af16b66 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		fw = NULL;
>  	}
>  
> +	dev_info(device, "%s %s ret=%d\n", __func__, name, ret);
> +

Thanks for your patch!

Sorry but we don't want to always print this. We however can *debug*
a system with dev_dbg() but there is a patch which someone is working
on which will do this. I cc'd you on it.

  Luis

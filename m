Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962CEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3D21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lq4hvAXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfG2Qiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:38:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41610 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfG2Qiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:38:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so28322115pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKlH3Eeb0DeQvX9rl3BIqhT6JzbzUSOYVMt5HGkhl1A=;
        b=Lq4hvAXrfW4ailQU20BQW1ZTXtvTLME1pVxYI8PWBJw8lDl29E2VUvngFBe/txdO7s
         NTfQtb74kj9XotmLHu2vrB3oUZ5Wvfa95vPtLIZG1EACcojUVmbEhQVjqy37X5v7R4Xj
         yCdIW0M/VW3gEVy+cWsnN7wGOx7G4sUEwT4Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKlH3Eeb0DeQvX9rl3BIqhT6JzbzUSOYVMt5HGkhl1A=;
        b=KFQWQbQzAmjKL+2CXVbaTME0p/IzFNRqCnoSbYkPnXdqQGWmtAhI5ujNSQhBB45urA
         MkVAXFrTLEUGER3bzoOcYmxAMPbwaXAISMu+tBGAmdOzt9zg8E6G065Ug/dUBmZuJmwY
         ZPSgOH1b+jLEiArLoeYf/ZcULcMWxEr+oEMTxhyibOUqnFwBeiajKQsmExOeeN3PTr9p
         Aa5ddhW2VZwzF9UvdtCe9Fb+fOSMjRZ4mG5DQx1NSGiA+hzUpLkn36MXmHUsKkIinLy0
         Ud/fNmBhMbE2ezH/ePo9eegAYsuH/EKXXrIhpa5fuhrkn+8+DTVhwY/PzZXx7axy0q8T
         0Zlw==
X-Gm-Message-State: APjAAAUY78WtBBO+DRk6DZyF9y6gEEW2p32jED9RbzjGafq4iJOQ57hs
        jEssZOhH4b71oC3eT9bxfZCvGdbsT1A=
X-Google-Smtp-Source: APXvYqwLIugILnKEI3N4RRnR0x4eYXrRiQNCEjBDx371yRGCbQ1Y+Xs4nBjHnggkW/EZSmiH4ACp/A==
X-Received: by 2002:a17:90a:6097:: with SMTP id z23mr113682930pji.75.1564418334236;
        Mon, 29 Jul 2019 09:38:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1sm72865462pfg.84.2019.07.29.09.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:38:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:38:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Douglas Miller <dougmill@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] net: ehea: Mark expected switch fall-through
Message-ID: <201907290938.3B407BE13C@keescook>
References: <20190729003009.GA25425@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729003009.GA25425@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:30:09PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/net/ethernet/ibm/ehea/ehea_main.c: In function 'ehea_mem_notifier':
> include/linux/printk.h:311:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/ibm/ehea/ehea_main.c:3253:3: note: in expansion of macro 'pr_info'
>    pr_info("memory offlining canceled");
>    ^~~~~~~
> drivers/net/ethernet/ibm/ehea/ehea_main.c:3256:2: note: here
>   case MEM_ONLINE:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
> index 4138a8480347..cca71ba7a74a 100644
> --- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
> +++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
> @@ -3251,7 +3251,7 @@ static int ehea_mem_notifier(struct notifier_block *nb,
>  	switch (action) {
>  	case MEM_CANCEL_OFFLINE:
>  		pr_info("memory offlining canceled");
> -		/* Fall through: re-add canceled memory block */
> +		/* Fall through - re-add canceled memory block */
>  
>  	case MEM_ONLINE:
>  		pr_info("memory is going online");
> -- 
> 2.22.0
> 

-- 
Kees Cook

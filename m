Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034EC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF05206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHZXfnWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfG2QjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:39:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfG2QjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:39:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so22230374pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gIsL3P1o9qKhMBAvJdEIWDk2AVET8Aaaur2YuooL1Qs=;
        b=kHZXfnWXPRBSXQwfFlnLyr4mL2tIpg0byl+z2del5hIiEdVMNTH30dqcAO2sfRae+U
         APCeNAcOqjSnO5WK4swM8h/NL2IISqCBDB9j6aW9A3qrm5w5slJQCHaTgcbr3wqtFa0u
         C2IZ6pehlH6ONkxeUhdaNhGjEQy8+HZe9nvEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gIsL3P1o9qKhMBAvJdEIWDk2AVET8Aaaur2YuooL1Qs=;
        b=SIzCig0xtsSDrZSYCcQ9fqSozxqlKZgq8/In8Bcw1oFBmakZv9H6i3ne1wGcjWwjFm
         Q0Ni3NU4JiJErNlXqnfksGeF7SgtLww+YcZkY36OPTKCBYyDhP+/fPQEmc/lZom64+1r
         db9oqPh4jUXUxO1XNE+h8UYQu/14/6IaZgRC6ub1xA/CFkcJs0GWGkL7QnwrtpCZcc0i
         RBtCtlDuCvs4BcedAlJkRqOHHlOt5mVwTvh6T/nuA0BYNQM9UaRS8xLVKc+0x8jRrTvp
         OKN+z5u38ZC7zwOmM/WbYR/BycpMvyDE4bn+fGPXYqaleQhf2Ams7MtZZRUwXjJUMazn
         4NSQ==
X-Gm-Message-State: APjAAAULmk0SHX+xMxP05ZYsyfg/k+SMS2kQpX7G9LCMk50SVLD6qINL
        bycpKT1QfT7vE/xCcVrfQLuXIA==
X-Google-Smtp-Source: APXvYqyBXqIpqVs0AKK9Spc8yO6L9TQO4zPdJZIh0268QH5XpLDfDnRlFx1iRpISBjHGplyemJ9ouA==
X-Received: by 2002:a65:5348:: with SMTP id w8mr104166567pgr.176.1564418343942;
        Mon, 29 Jul 2019 09:39:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v13sm72076160pfn.109.2019.07.29.09.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:39:03 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:39:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] net: spider_net: Mark expected switch fall-through
Message-ID: <201907290939.794DB730@keescook>
References: <20190729003251.GA25556@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729003251.GA25556@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:32:51PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/net/ethernet/toshiba/spider_net.c: In function 'spider_net_release_tx_chain':
> drivers/net/ethernet/toshiba/spider_net.c:783:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!brutal) {
>        ^
> drivers/net/ethernet/toshiba/spider_net.c:792:3: note: here
>    case SPIDER_NET_DESCR_RESPONSE_ERROR:
>    ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/ethernet/toshiba/spider_net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
> index 5b196ebfed49..0f346761a2b2 100644
> --- a/drivers/net/ethernet/toshiba/spider_net.c
> +++ b/drivers/net/ethernet/toshiba/spider_net.c
> @@ -788,6 +788,7 @@ spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
>  			/* fallthrough, if we release the descriptors
>  			 * brutally (then we don't care about
>  			 * SPIDER_NET_DESCR_CARDOWNED) */
> +			/* Fall through */
>  
>  		case SPIDER_NET_DESCR_RESPONSE_ERROR:
>  		case SPIDER_NET_DESCR_PROTECTION_ERROR:
> -- 
> 2.22.0
> 

-- 
Kees Cook

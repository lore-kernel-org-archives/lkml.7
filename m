Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E94C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07043217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dlcnt0qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfG2QBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:01:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43775 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfG2QBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:01:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so28263801pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPoICl2jmuwVCY4uE1r7Ty38gJq27Q0+J8wDhNw3+vw=;
        b=Dlcnt0qRspsCcVl9UmmGRHgYr4RP8gb3EhYNOi1mJxtY109oeRGiilGa9UL5FRjgOz
         WFYzuai0O8YKnkAfbRVRfTHipf3wlWfcS9NCKuIWzlAPzcw1xZitXrI6lCN95dcYG26+
         rkB2QlbdrSi087t+L8BKx6BbLlqQaiD6DQOGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPoICl2jmuwVCY4uE1r7Ty38gJq27Q0+J8wDhNw3+vw=;
        b=R4MfBDbm/5FXxvRw9002/8xeqt2VMYo1WocGmbtjqkiwieBOPXz+ZM4E6HfKlBJrYu
         hzZpBpUFfWLwu6z/zIq16G3g8QlT1JPBt5FzjnehKbwzm71wwozv8qZ2YAjvWro2DJ+P
         FB0OCth+4FSpCpO5bihAW0QufIIA/0Qvdqpn4wfwiaUx0htIJD5pwv3VR5etTOd7UKmv
         5/O42JE34sSuJjzrvdD1n0QkXN+a/CmUA2Cy3ZF9ohXl5q6yYQIUVVD7bbpxqNTK6NH0
         W4/O30fmq+TCgFptVaMvZPWiqeG8uyxVuj4rD64VdEugA1ckB1YiuCd0NoXds4T2Bjk3
         FA5g==
X-Gm-Message-State: APjAAAUxYnK3z8mF6ABVi+E/v3eVb9ipx6dNWZ76hkflqAeUnBn6WnzP
        2uMgfUB1MSw/LgwmpgYIdbgd/Q==
X-Google-Smtp-Source: APXvYqwnqrWKYQH3ulODk63tjoKMNyGn8GM05K6af1sRp16nZ53h16A7hdXrbMvs3F9Gxsd6NiwMTQ==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr113341053pjb.20.1564416076331;
        Mon, 29 Jul 2019 09:01:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12sm71478789pfn.187.2019.07.29.09.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:01:15 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:01:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arcnet: com20020-isa: Mark expected switch fall-throughs
Message-ID: <201907290901.E15B283F7F@keescook>
References: <20190729142503.GA7917@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729142503.GA7917@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:25:03AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/arcnet/com20020-isa.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 205:13, 203:10, 209:7, 201:11,
> 207:8
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/arcnet/com20020-isa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
> index 28510e33924f..cd27fdc1059b 100644
> --- a/drivers/net/arcnet/com20020-isa.c
> +++ b/drivers/net/arcnet/com20020-isa.c
> @@ -197,16 +197,22 @@ static int __init com20020isa_setup(char *s)
>  	switch (ints[0]) {
>  	default:		/* ERROR */
>  		pr_info("Too many arguments\n");
> +		/* Fall through */
>  	case 6:		/* Timeout */
>  		timeout = ints[6];
> +		/* Fall through */
>  	case 5:		/* CKP value */
>  		clockp = ints[5];
> +		/* Fall through */
>  	case 4:		/* Backplane flag */
>  		backplane = ints[4];
> +		/* Fall through */
>  	case 3:		/* Node ID */
>  		node = ints[3];
> +		/* Fall through */
>  	case 2:		/* IRQ */
>  		irq = ints[2];
> +		/* Fall through */
>  	case 1:		/* IO address */
>  		io = ints[1];
>  	}
> -- 
> 2.22.0
> 

-- 
Kees Cook

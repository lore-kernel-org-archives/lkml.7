Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA9EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3DE216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrmWhqPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfHEUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:18:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35318 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:18:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so5022575pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tjw6rza1ptPRGuXtBmSB7rfUryE1iTlxWybyEMkdZlQ=;
        b=SrmWhqPwtdCRRXfHAtUvVBKUcU9eiBNfK+41ptlvTZ/K23z6re44RYzQ/QPhZhHNBh
         fbXoTxoUzzePS7v3l8I0u6iO3mtQyA9aBdPzpZ8ii0vbqRBSyW/qNjrhZI2+90X+jS1A
         dJlLJPteTrVNLaeI8Un3LiI5jCmGxT8q42M/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tjw6rza1ptPRGuXtBmSB7rfUryE1iTlxWybyEMkdZlQ=;
        b=IeHlGN/XVaYXaoUf8Epf50srBMwxfSmrjC3oS7Yf53MDwzT9uZdg0sv69p0fDIx8Ke
         PqA23v6Wx0L3PiEumD0N1x0cRgsqJ+DN+OL8uKm4Mi9BV7yaO9dfGMqa1wxOKpTUlj8F
         /0VVJBKfAeyvyU3H/wdogQioA/43g+PLfyqjAq6xiqzaYKfaoW7cm58m5Y6D7j0HPRMQ
         /tbtN4qiRuFfk8qooC/Qh4x/Q9BfmVLNF8arhnFO6rly4n7LxZkVUjfJWcBjEFiBy+PB
         5NBIVmIcUD6RZTIJONa3bs8XBWp809P/jqYCVLra3t/FelvCcK1Gq2Y7qSNGU2G7RTr+
         Y4yw==
X-Gm-Message-State: APjAAAWRIDDaJ6K2z36B/MgXe2MlZjdLHLt3bePxjj83zUiypWg79EBm
        RE/oEw3vnwnEAjLibSyP+BTipCSy0XE=
X-Google-Smtp-Source: APXvYqz1+b3sw44gfL4a0Lk4PCEX+UQhl9biuK7/DxHHIcKCbRrLwq4eCt58OpEgls1iWSn++h6RIg==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr26556335pgt.73.1565036338089;
        Mon, 05 Aug 2019 13:18:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7sm76884943pgr.94.2019.08.05.13.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:18:57 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:18:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: db1xxx_ss: Mark expected switch fall-throughs
Message-ID: <201908051318.0884AE3F@keescook>
References: <20190805194942.GA15816@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805194942.GA15816@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:49:42PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: db1xxx_defconfig mips):
> 
> drivers/pcmcia/db1xxx_ss.c:257:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/pcmcia/db1xxx_ss.c:269:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/pcmcia/db1xxx_ss.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
> index eb6168e6ac43..590e594092f2 100644
> --- a/drivers/pcmcia/db1xxx_ss.c
> +++ b/drivers/pcmcia/db1xxx_ss.c
> @@ -255,8 +255,10 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
>  	switch (state->Vcc) {
>  	case 50:
>  		++v;
> +		/* fall through */
>  	case 33:
>  		++v;
> +		/* fall through */
>  	case 0:
>  		break;
>  	default:
> @@ -267,9 +269,11 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
>  	switch (state->Vpp) {
>  	case 12:
>  		++p;
> +		/* fall through */
>  	case 33:
>  	case 50:
>  		++p;
> +		/* fall through */
>  	case 0:
>  		break;
>  	default:
> -- 
> 2.22.0
> 

-- 
Kees Cook

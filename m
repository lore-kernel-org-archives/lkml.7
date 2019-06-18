Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A58C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372692080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTei/vPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfFRIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:16:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFRIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:16:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so2158617wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t/jrlwVbqUGm5LlxED/u8lqvV/TkMHlvG38VrHjMZwM=;
        b=LTei/vPtrKAGo+xiHG938K3xZdc34NOswQ0WZSU7et3BB+FoPlGssMxDzK6esyJSja
         QNoCDNSmTtY1kYZ1bly52+mKA135BDgOFFA6ugJ699DK43sih5uZp8XmvqgIr+LwLRtk
         LPQlyeWJ2hkr5rgaRT3CHorvxpilQW6OvrXFYHyeM1Viz545C2V/QhgMdcVGGVXI3p1d
         JTe27YjN3ZmjGvr6csX7WB6FYvbN1ywUAEKWlDIZg22hBeQ/qkQ+mp//G8FEvqKVaUFE
         tbHm6TLstQTl3vkr+1CBDxhm29P4fndqXWdxYbLcVb9eQQ32K3+qQc04c3/L600uA6Kx
         ezmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t/jrlwVbqUGm5LlxED/u8lqvV/TkMHlvG38VrHjMZwM=;
        b=f+4NAKw6yT+ARKhFNDBjn8lg6BoN4LTHEocq5vY/qIRT7nIfiJs8c32+1UkhegYdjP
         vb3KEl8tIzjD12hVxMxqD8II43XJi/bCAbjeMBULbexMnmr6OFnMMvsKSecIk66Z2AWp
         /OACUgkYKQR7Wfy1s3myChU4SlfhhxGNnkWhtyb3Spqk+Z2P+TppfMCnafPvDmVFaZPl
         /6taUIV6VF2eNrp+e1c8+rQZo+SWsrvt7uOLf5nxtGt/Lf7InoQUgen//3U3K7jIBPto
         9RqlZDatI2Hl9G6ezvli0QvJGypkprj26Gx2sD3RctYFLM8Kkjqe1LflM5ivEywXPR3t
         FRJg==
X-Gm-Message-State: APjAAAXsHnkXr/dziaztE7yz4H2473e6zkH7RSXmcVKwqqBWyv865/H3
        7En56VUq0iVMVfEr9TIexWLOTA==
X-Google-Smtp-Source: APXvYqwYTr5x7DrdrPoLH+qfq4DTqLezqkCP1jdXSp6iYQxgp2pEEprK6f3SFvlWPAjwHdlqgPP9mw==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr2318494wmg.112.1560845807845;
        Tue, 18 Jun 2019 01:16:47 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id k125sm2847763wmf.41.2019.06.18.01.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 01:16:47 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:16:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
Message-ID: <20190618081645.GM16364@dell>
References: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
 <20190617190605.GA21332@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617190605.GA21332@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Dan Carpenter wrote:

> It's not okay to cast a "u32 *" to "unsigned long *" when you are
> doing a for_each_set_bit() loop because that will break on big
> endian systems.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

Ideally we can get a review too.

> Fixes: 386145601b82 ("mfd: stmfx: Uninitialized variable in stmfx_irq_handler()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mfd/stmfx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> index 7c419c078688..857991cb3cbb 100644
> --- a/drivers/mfd/stmfx.c
> +++ b/drivers/mfd/stmfx.c
> @@ -204,6 +204,7 @@ static struct irq_chip stmfx_irq_chip = {
>  static irqreturn_t stmfx_irq_handler(int irq, void *data)
>  {
>  	struct stmfx *stmfx = data;
> +	unsigned long bits;
>  	u32 pending, ack;
>  	int n, ret;
>  
> @@ -222,7 +223,8 @@ static irqreturn_t stmfx_irq_handler(int irq, void *data)
>  			return IRQ_NONE;
>  	}
>  
> -	for_each_set_bit(n, (unsigned long *)&pending, STMFX_REG_IRQ_SRC_MAX)
> +	bits = pending;
> +	for_each_set_bit(n, &bits, STMFX_REG_IRQ_SRC_MAX)
>  		handle_nested_irq(irq_find_mapping(stmfx->irq_domain, n));
>  
>  	return IRQ_HANDLED;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

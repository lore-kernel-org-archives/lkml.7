Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806FEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5522133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hxKU6VAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfEWQyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:54:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:54:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so2987602pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jM8bPKPXf1vLmOMB9nivq9wEiQ5oNGIfwZnpi/tQ11U=;
        b=hxKU6VApctxuI6bY6dYjsrprnDeMIP5e7X4grbMLeGrGi3OgFXCRTAvDudT5aCEu7R
         WMXgnhfgBFoB9zpZTXOT9ElzzM/QqVXsv2qnmehpgJG/rWXdqWGAGGJOOLHkRLslDqo8
         syWoZcRKYdiPgfOwl6Q61f5V18hSqp9CEnRNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jM8bPKPXf1vLmOMB9nivq9wEiQ5oNGIfwZnpi/tQ11U=;
        b=eR8c7ao7hamse3tPQgpYLRu8sxI97TVrbQMi/NdsrIRQk1muhaklZEZTZcoQRhQF4p
         hiG0yw/qxYS3YPwtJJJD9AEeWrTxOEBW3C8Xsr1W2xLKawOvsSs+fDSrH306EQ0IOLi9
         UHacaLixo9oeK5SlKjxE7C6yxX1qzjFx6hcxY+MkmOPjYnG9cJLO0bisCZBGbwvtThS0
         Dsrfq3fj+OPe8IrGa9o19K2IFKKOSGN2I5aFAdO8tgb5uF91ljFsRla04B8uvXITwY/9
         ntPWL9Pt1o39UmItEZIl09jnsRzPOlPoLcxtdqtwJrNA0hBojM4yB6btd2kimJf/75Ok
         zi0g==
X-Gm-Message-State: APjAAAVpXK9SNhFH73gRWm414Miw4YY9vhBlwK6J317Pf6Q3pcIdk/NO
        gD+gjsaYi8+MZkxRmrvLTfjxnA==
X-Google-Smtp-Source: APXvYqzRvW08pcgEQmLH5J2fGe0N3Fb0DAbC67BZi8nxb1q++tB++Q1v4RohqfoylaFhM0Om1QzhYg==
X-Received: by 2002:a17:902:c01:: with SMTP id 1mr59795146pls.142.1558630460533;
        Thu, 23 May 2019 09:54:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm1368984pge.89.2019.05.23.09.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:54:19 -0700 (PDT)
Date:   Thu, 23 May 2019 09:54:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gen Zhang <blackgod016574@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <201905230952.B47ADA17A@keescook>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
 <20190523003452.GB14060@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523003452.GB14060@zhanggen-UX430UQ>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:34:52AM +0800, Gen Zhang wrote:
> In function con_insert_unipair(), when allocation for p2 and p1[n]
> fails, ENOMEM is returned, but previously allocated p1 is not freed, 
> remains as leaking memory. Thus we should free p1 as well when this
> allocation fails.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

As far as I can see this is correct, as it's just restoring the prior
state before the p1 allocation.

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index b28aa0d..79fcc96 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
>  	p2 = p1[n = (unicode >> 6) & 0x1f];
>  	if (!p2) {
>  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
> -		if (!p2) return -ENOMEM;
> +		if (!p2) {
> +			kfree(p1);
> +			p->uni_pgdir[n] = NULL;
> +			return -ENOMEM;
> +		}
>  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
>  	}
>  
> ---

-- 
Kees Cook

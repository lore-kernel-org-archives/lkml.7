Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F5C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066C0217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QRFcfqqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfEUUof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:44:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34704 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:44:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so9003219plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WZpCy0cB1bZa8seHm6gN3ZiBpJveEfAdis7kvbr7t7o=;
        b=QRFcfqqNp4YMTP3CQzPbdPpxYh+8zMOXGy5xbr1EL7hkl0AYpuQ8/XvENLgbeYRrgl
         oKjIPQqb2AboKFjkY2XZbVdZb/25rCRQGAGFoK0/bM7ZVfM9nj6oD9/sWzCG7bIPqX2L
         qvGY6vZ6VO2v9qDpMr/MQim8OodhxbF8CnPNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WZpCy0cB1bZa8seHm6gN3ZiBpJveEfAdis7kvbr7t7o=;
        b=VhlRoQ/DbI2vBD5H3nEam5t13bJJa3QWNtFAV7keSXTy5YUTqg33QCVNLU3L0qzmsM
         yMWvwLklmkN/SYVA4KN5UbMAm2rwV7D5+3d1RfgVAXDwETVZuLoR9m+4k//5zEZTbi54
         4MxTl/4R5AQfADLj2b6iJfgUuZg6tihL3xlah7y5cGUNi9mSylG34Kdq2lL225953Ijz
         AqNcdbfdB8YCb85T0d2Y/iQAG2XQ5mtO1hgqCE3yc9O/lw/xR4qt45YL+/L6fSc6YbGE
         H+YP+qatW+uMdwqBfcni4933Va+kLbKCAvxwJzB93pXdXpC+wErK2OdByGaljbVoJCyj
         72jg==
X-Gm-Message-State: APjAAAUo3hzs2LIq/1O/IsET8R5d3VFlQFHMsX40CW7H3zD2uxLTwaRk
        3Jz0hlJklGTqR3obc8v48P2kmQ==
X-Google-Smtp-Source: APXvYqxNcJp0AUDpl6c0V6HvBquRuHrZtPgRLqzonNg7Nu2zy+jXkzhAGbWdqum3DJfGKA6q14iEcQ==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr82707198pla.239.1558471474521;
        Tue, 21 May 2019 13:44:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 37sm26555753pgn.21.2019.05.21.13.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:44:34 -0700 (PDT)
Date:   Tue, 21 May 2019 13:44:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gen Zhang <blackgod016574@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <201905211342.DE554F0D@keescook>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521092935.GA2297@zhanggen-UX430UQ>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:29:35PM +0800, Gen Zhang wrote:
> In function con_insert_unipair(), when allocation for p2 and p1[n]
> fails, ENOMEM is returned, but previously allocated p1 is not freed, 
> remains as leaking memory. Thus we should free p1 as well when this
> allocation fails.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 
> ---
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index b28aa0d..47fbd73 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -489,7 +489,10 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
>  	p2 = p1[n = (unicode >> 6) & 0x1f];
>  	if (!p2) {
>  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
> -		if (!p2) return -ENOMEM;
> +		if (!p2) {
> +			kfree(p1);
> +			return -ENOMEM;
> +		}

This doesn't look safe to me: p->uni_pgdir[n] will still have a handle
to the freed memory, won't it?

(And please direct these patches to Greg, as he's the current
maintainer; I'm happy to stay CCed, of course.)

-Kees

>  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
>  	}
>  

-- 
Kees Cook

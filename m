Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0707C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BC621743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEUGqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:46:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfEUGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:46:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1585385wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgpTLFoEBK0qAp/AMPVLKVpFtjZQiXWSFLACx+mQKDU=;
        b=Qv8TMK38a13yFG8UTm8Zd/Obcwp9Pn6/wD/hZrsvNkuQb5GTQXT/wuVYIsMp2vKRft
         I50LWTxPHs6mT9OCJF6z0Vko1VhE91VazOv0/feJfqdzdXuwYEW+aaB7+IltKnHXU/nz
         gGGSS6V1Fal3UZ//hJWlOnfp/4pkSAsw8Qp6Ctp/VqCeC1odN6bKiN0i2FTWbsx5WoFC
         otcbrtIF1ZFPsbYZ+OFtTYSQBFA2lCqXc2T/uCF3nEyQyotuaUcOrQdLCuTxgU2oSFj1
         lb05mj/nyVs8HwvMUIAzOvaUW6fGKgp9PjaUHEwMj99LKoNS76Q62aS6ZTM5Tjll9ArX
         wlxw==
X-Gm-Message-State: APjAAAVjxKNSst8edBBavPhjLPFoTEuT/lkFZWROAkwE8KZ0MORjfLlj
        FHHvkqx44Jw/8gUGYPoDcEjJzA==
X-Google-Smtp-Source: APXvYqxY+cEQlz45ZYF7GY+ar/2+uLIZBN5r24uASg5vSq84sNBHbnksjKLFWM20WiBHrp61AxNHRA==
X-Received: by 2002:a1c:20d7:: with SMTP id g206mr1996089wmg.136.1558421169069;
        Mon, 20 May 2019 23:46:09 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a11sm20586018wrx.31.2019.05.20.23.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 23:46:08 -0700 (PDT)
Date:   Tue, 21 May 2019 08:46:07 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        Grzegorz Halat <ghalat@redhat.com>
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521064605.ho7tdwaagt4wow4v@butterfly.localdomain>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521032118.GC5263@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521032118.GC5263@zhanggen-UX430UQ>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing Grzegorz.

On Tue, May 21, 2019 at 11:21:18AM +0800, Gen Zhang wrote:
> On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> > As soon as you release the lock, another thread could come along and 
> > start using the memory pointed by vc_cons[currcons].d you're about to 
> > free here. This is unlikely for an initcall, but still.
> > 
> > You should consider this ordering instead:
> > 
> > err_vc_screenbuf:
> > 	kfree(vc);
> > 	vc_cons[currcons].d = NULL;
> > err_vc:
> > 	console_unlock();
> > 	return -ENOMEM;
> In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> used in the following codes.
> However, when there is a memory allocation error, kzalloc() can fail.
> Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> dereference may happen. And it will cause the kernel to crash. Therefore,
> we should check return value and handle the error.
> Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> include/uapi/linux/vt.h and it is not changed. So there is no need to
> unwind the loop.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 
> ---
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fdd12f8..ea47eb3 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3350,10 +3350,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc)
> +			goto err_vc;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto err_vc_screenbuf;
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> @@ -3375,6 +3379,13 @@ static int __init con_init(void)
>  	register_console(&vt_console_driver);
>  #endif
>  	return 0;
> +err_vc_screenbuf:
> +	kfree(vc);
> +	vc_cons[currcons].d = NULL;
> +err_vc:
> +	console_unlock();
> +	return -ENOMEM;
> +
>  }
>  console_initcall(con_init);
> ---

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

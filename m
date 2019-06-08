Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77947C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D520833
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2qCQIZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfFHQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:01:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33731 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfFHQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:01:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so5065468wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQ2AJUcN8c4n4MbBpUGKpOy63cEfl59xAjHxyDDdc/s=;
        b=i2qCQIZnWSiv70yjcwzzyOiY/1zT2ZySOtxBbwz4bcf+8Hrfx3n6+Zav2YK5AgeGbT
         wXgSrjMYB8PxOuqBlzkQdYrulAj6a+2JJtBXYoyutXQEnurvtWxnwB0l3367rTC+arU+
         W5XuVfJaqrvoJhCSAQW4kdFOs423bNEjr7H1FFUWaltgTcD2xFv8JzYIPHjkpydYV5Gd
         PYrQCWpJk64SQnrsE/XfhNtdhM8skSAo1pX8w3XW0tz3womzSTBnyeDGxAvfy6C9XpEC
         aT+iIXRU2ws/UIvEGBMGrU0UdSD+dGhiH1ONq3AKqITV2mXj18yca+PeXbGOlL5HlT0d
         8AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQ2AJUcN8c4n4MbBpUGKpOy63cEfl59xAjHxyDDdc/s=;
        b=fgd9v0z0xMeCC62mNADP9uyhx2d38BnaLGg+HGRClSz3UY2rr45KnVnzZamX0KlSiA
         IzlGF03njCErNqYNP3vIDtofsBeQDqNbuY3RAIjp8F2ydYhmLP/DNxQL/rA1rB0LVglC
         p20dKpotwL8ZvFlttRolreiDbHlmZ7S1BIGCWtyqAqgRN+lOROJRUyoOXCMHvM7YkeY1
         0VWmzHP+6x5t6HKwhbV1syl88Q61JO5Yaevrf9gzDMgz7wxdHjt4BPgzx8VF/sKFxC+C
         giXz61eVy13RpFg20p4EcZjcdotbZgDGsl4u6DecrvQIgWXWudmRz6IGhNkrFpaAfMbb
         U4SA==
X-Gm-Message-State: APjAAAVMLicG69zyvBCmHP0R+La45s6tyRyfrncNcG7kX6xmNEFmhJTL
        WqIcgjmwcugkR5jLn7CSVRO+oDA1
X-Google-Smtp-Source: APXvYqyNMYXW9w090K1Ty8j3y29UDGHNxzH+ovk14byW8TVxufJ6OwL5/qk1h4hWqMfA+0UiweBIZA==
X-Received: by 2002:adf:e691:: with SMTP id r17mr21378607wrm.67.1560009709107;
        Sat, 08 Jun 2019 09:01:49 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id x16sm3935606wmj.4.2019.06.08.09.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:01:48 -0700 (PDT)
Date:   Sun, 9 Jun 2019 00:01:38 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, nico@fluxnic.net,
        kilobyte@angband.pl, textshell@uchuujin.de, mpatocka@redhat.com,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190608160138.GA3840@zhanggen-UX430UQ>
References: <20190528004529.GA12388@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528004529.GA12388@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:45:29AM +0800, Gen Zhang wrote:
> In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
> following codes. However, kzalloc() returns NULL when fails, and null 
> pointer dereference may happen. And it will cause the kernel to crash. 
> Therefore, we should check the return value and handle the error.
> 
> Further, since the allcoation is in a loop, we should free all the 
> allocated memory in a loop.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> ---
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fdd12f8..d50f68f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3350,10 +3350,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc)
> +			goto fail1;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto fail2;
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> @@ -3375,6 +3379,16 @@ static int __init con_init(void)
>  	register_console(&vt_console_driver);
>  #endif
>  	return 0;
> +fail1:
> +	while (currcons > 0) {
> +		currcons--;
> +		kfree(vc_cons[currcons].d->vc_screenbuf);
> +fail2:
> +		kfree(vc_cons[currcons].d);
> +		vc_cons[currcons].d = NULL;
> +	}
> +	console_unlock();
> +	return -ENOMEM;
>  }
>  console_initcall(con_init);
>  
> ---
Can anyone look into this patch? It's already reviewed by Nicolas Pitre
<nico@fluxnic.net>.

Thanks
Gen

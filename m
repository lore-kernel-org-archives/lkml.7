Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D8C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHJB40d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEUDJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:09:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEUDJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:09:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so8258315pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlVg84AY8ugXg02xlbmBAokwN2Lcn0W+vNZv6kTrf3s=;
        b=uHJB40d9xNnfz1IHMsTSJwl8e7VrbujgRrcHjHx2mhAaKB7/PzuJZXEKkdJJE3iAUQ
         E3PlAqq27yHOKULYb+1ZOhXLOipPgR9/InMzK6NnShpX5X76kc4t6yFhNbeKFI5B91QY
         RcrnyHs+S83SgwzvFT+BLyztcpFxiTqxd2O40m0aUS4RZvsrO3smI2WyeMwlFfeuANBb
         ii1BssR0dBTbAQzjbvbWsEuYrBGRAFKXcnJB1KNjVePboQVxVkqHybvSFOlZivOSye3O
         t6TfhUENJqGV+FuEZ6jWJDpJ3QxN9lKDKk16gWYKUHc9sDAJndz2vzgIETxzg7nrAixJ
         Drsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlVg84AY8ugXg02xlbmBAokwN2Lcn0W+vNZv6kTrf3s=;
        b=Y39yHqUDf0bd1MOtS0Ej2gtfCCi4QU55gh+HOwG0aORk4Uc5YKrkZOdo474CQqRZv3
         Qtcc/3gjQDrjoF91rPtdPN30hs8Lc+3Kgac5jZBa4llKzo5ZTcyIAZaVXWMwgUcoP6OX
         tQwm9k8tEV2E8LapGUhs3dbGO+irDAXVwRR0RxwygkWqbtDjvKvwz+jLgqISYUeTYqdl
         GgMO2QeHraxLMtHMfWzpDkHZpLh8MQnJRW2pXPwiMemxT7Ysx0sz3ckJowLuCnMIP3LV
         BGQBZo5hiOl9a2T+sXIJX50DgzkhvBbV0n8gNDEHO+5rzxOgztgah1WTQQgHxOn5bPLy
         GIUg==
X-Gm-Message-State: APjAAAUGqGXVBvPJ5+Aiq1k9wmTnyOSNZqhqTRkklDEu7L65dr4Onp06
        bz8AZ3NnWpx8UX3CyKMFQodqsOVTm0Y=
X-Google-Smtp-Source: APXvYqweNFk2PpQow3nKboR8yrMVsRTS6XktlyoEcIjCkyeHUL5h3BvEZoos27CgqtNhE5C2jhccWw==
X-Received: by 2002:a62:ed09:: with SMTP id u9mr85836014pfh.23.1558408157749;
        Mon, 20 May 2019 20:09:17 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id r29sm16518643pga.62.2019.05.20.20.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 20:09:17 -0700 (PDT)
Date:   Tue, 21 May 2019 11:09:05 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521030905.GB5263@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> On Tue, 21 May 2019, Gen Zhang wrote:
> 
> > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> > used in the following codes.
> > However, when there is a memory allocation error, kzalloc() can fail.
> > Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> > dereference may happen. And it will cause the kernel to crash. Therefore,
> > we should check return value and handle the error.
> > Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> > include/uapi/linux/vt.h. So there is no need to unwind the loop.
> 
> But what if someone changes that define? It won't be obvious that some 
> code did rely on it to be defined to 1.
I re-examine the source code. MIN_NR_CONSOLES is only defined once and
no other changes to it.

> 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > 
> > ---
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index fdd12f8..b756609 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3350,10 +3350,14 @@ static int __init con_init(void)
> >  
> >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > +		if (!vc_cons[currcons].d || !vc)
> 
> Both vc_cons[currcons].d and vc are assigned the same value on the 
> previous line. You don't have to test them both.
Thanks for this comment!

> 
> > +			goto err_vc;
> >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >  		tty_port_init(&vc->port);
> >  		visual_init(vc, currcons, 1);
> >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > +		if (!vc->vc_screenbuf)
> > +			goto err_vc_screenbuf;
> >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> >  			currcons || !vc->vc_sw->con_save_screen);
> >  	}
> > @@ -3375,6 +3379,14 @@ static int __init con_init(void)
> >  	register_console(&vt_console_driver);
> >  #endif
> >  	return 0;
> > +err_vc:
> > +	console_unlock();
> > +	return -ENOMEM;
> > +err_vc_screenbuf:
> > +	console_unlock();
> > +	kfree(vc);
> > +	vc_cons[currcons].d = NULL;
> > +	return -ENOMEM;
> 
> As soon as you release the lock, another thread could come along and 
> start using the memory pointed by vc_cons[currcons].d you're about to 
> free here. This is unlikely for an initcall, but still.
> 
> You should consider this ordering instead:
> 
> err_vc_screenbuf:
> 	kfree(vc);
> 	vc_cons[currcons].d = NULL;
> err_vc:
> 	console_unlock();
> 	return -ENOMEM;
> 
> 
Thanks for your patient reply, Nicolas!
I will work on this patch and resubmit it.
Thanks
Gen
> >  }
> >  console_initcall(con_init);
> >  
> >  ---
> > 

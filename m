Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC2C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E1920840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJrmg7BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfFHQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:28:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfFHQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:28:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so5049135wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGZIJkWOD5HNBtJMxrjc9eWYDX3fZshEF6L9X8SRgBQ=;
        b=QJrmg7BYuSrMDmsaSjJaJ786HcQ1WBCcJtuTN6pDfVvAT12BXgznpY/gpKTatudvbr
         V7+66/Jt8/T4DRoOKCBhqrhSC5ful5WWnqYbwAprZCrU7Qbj/b0DwMoiirVvOlDVcHy7
         1EBF4Q/Gi0bMzmMKp+s1REtTca+UgE5/9oX6X1sdAj6se8mRzCjdx2kfg5qAeKWNl74l
         PXOd5eI/Q3a3xvyL5Rrx2O7VoefPx/9MpyRx04fi4lDz61ibutot/vKkaHrvWEHsUE86
         J6CnZY63UrxGm/rw9/nOfZrk+aAJ2I4tskosbWM8gD4eUNU8FvFdbkm1112eOcxbMi0+
         zJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGZIJkWOD5HNBtJMxrjc9eWYDX3fZshEF6L9X8SRgBQ=;
        b=n+66/6ONTHlSI6if15BZQBN56dkgrgn+SfKWbHnoftgmQyrhvwu7H5jQILZAOV5klO
         1jmJ2gk58+mn++v8PdkbdD++RzZ2ktAoDbRXDUcHfA48id5x+ZO142EBW4NL2YvLlPaI
         UNb90LXRuutByOxqy4Unx/ZrFSo0kDudw3+AB4AXlm1gxJeFZuZY+NposSrvMgHOsW2N
         SCOFWZwpXXyn0RTIxf80SPJ9f7ai7ZYbAqURK6ZBlTaMhc2a39M5Tf6l/V8WpWrtzbrr
         nm2TDlG36AU1DT+KCYQLRBnsVPNjhVMDb+F7pPUDyv4yAcl6dEMrceJ3NKvzjUqrqu++
         3GcA==
X-Gm-Message-State: APjAAAWx9QsdXS44Ur53vqvwwELhOvs8MmBzPxRmbw+slX5uAz+Z61dp
        wvmGTkZkTTnyFAgwoZtPuiQ=
X-Google-Smtp-Source: APXvYqybB7/G0Ce4i90cr2B4jqQtyBOR/K1lJo1g+j06IFq+yPMqNvzHMtfi88o/oDvDLsNVwTh8DQ==
X-Received: by 2002:adf:ec12:: with SMTP id x18mr6105952wrn.145.1560011284365;
        Sat, 08 Jun 2019 09:28:04 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id k2sm5060032wrx.84.2019.06.08.09.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:28:03 -0700 (PDT)
Date:   Sun, 9 Jun 2019 00:27:54 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, nico@fluxnic.net, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190608162754.GA2387@zhanggen-UX430UQ>
References: <20190528004529.GA12388@zhanggen-UX430UQ>
 <20190608160138.GA3840@zhanggen-UX430UQ>
 <20190608162127.GA11699@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608162127.GA11699@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 06:21:27PM +0200, Greg KH wrote:
> On Sun, Jun 09, 2019 at 12:01:38AM +0800, Gen Zhang wrote:
> > On Tue, May 28, 2019 at 08:45:29AM +0800, Gen Zhang wrote:
> > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
> > > following codes. However, kzalloc() returns NULL when fails, and null 
> > > pointer dereference may happen. And it will cause the kernel to crash. 
> > > Therefore, we should check the return value and handle the error.
> > > 
> > > Further, since the allcoation is in a loop, we should free all the 
> > > allocated memory in a loop.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > > ---
> > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > index fdd12f8..d50f68f 100644
> > > --- a/drivers/tty/vt/vt.c
> > > +++ b/drivers/tty/vt/vt.c
> > > @@ -3350,10 +3350,14 @@ static int __init con_init(void)
> > >  
> > >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> > >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > > +		if (!vc)
> > > +			goto fail1;
> > >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> > >  		tty_port_init(&vc->port);
> > >  		visual_init(vc, currcons, 1);
> > >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > > +		if (!vc->vc_screenbuf)
> > > +			goto fail2;
> > >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> > >  			currcons || !vc->vc_sw->con_save_screen);
> > >  	}
> > > @@ -3375,6 +3379,16 @@ static int __init con_init(void)
> > >  	register_console(&vt_console_driver);
> > >  #endif
> > >  	return 0;
> > > +fail1:
> > > +	while (currcons > 0) {
> > > +		currcons--;
> > > +		kfree(vc_cons[currcons].d->vc_screenbuf);
> > > +fail2:
> > > +		kfree(vc_cons[currcons].d);
> > > +		vc_cons[currcons].d = NULL;
> > > +	}
> > > +	console_unlock();
> > > +	return -ENOMEM;
> > >  }
> > >  console_initcall(con_init);
> > >  
> > > ---
> > Can anyone look into this patch? It's already reviewed by Nicolas Pitre
> > <nico@fluxnic.net>.
> 
> It's in my queue.  But note, given the previous history of your patches,
> it's really low on my piority list at the moment :(
> 
> greg k-h
What? All the patches were revised iteratively according to the 
maintainers' or reviewers' advice. I don't think you should look down
the patches from me. It seems not fair enough. :(

Thanks
Gen

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07820840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+mU/b0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFHQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:34:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45407 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfFHQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:34:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so5059123wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jzfzqAy9Q7YWYQ3O4o69BFU+nR610iH3W0Floz8eF3c=;
        b=o+mU/b0IfyVOWU+1sxdmXXdZHYcg3IH5Nfq4bQ+70X1G0XNOsBKAgT8xICJnb50wLc
         Nf9O/vfhd34RtXzyugwTDUvg+0Gsh7pKLQPggcohaKGvOcHn8IyW6+ATz4DpGyp39dcw
         5zVwyI0H+8DvHe0S7o59GeAv48xjI1bBtSQHhADI+UmgrpNjSQfdsw4nUxkFkLWltHIr
         C5nP/eZHaVREXuhrZiOxmFjIKG/kRlMAgZxHJB3Ijy2Sa0w0UxhnZsh9WnJyCtBpg44m
         ThV/wMwhVszFM9zteZH8ohrgf+hvzc4rJDvBEXOyrWf+9fOTceqMNclRgPIT4IFGGCTr
         MCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jzfzqAy9Q7YWYQ3O4o69BFU+nR610iH3W0Floz8eF3c=;
        b=o8/8V1O8/u0S57pgdhz+Yq1vuQjgDU1OwwuiHAdRg/zmUGYwDx66xFTovHBkkb7Ory
         BqqL74xtHGhJtFdVq2yhDtqLHcPHzLmlsTC/j+6CpgAV8+Xii9R/U0xHWOqH9cQJ0Frx
         hy/hDctXRyyr0g2q1AQq2jwe+tcBVEg/2cB9QV6QRgCfAWRkaGHGGr+rRoLGvcKnsxir
         GS512zwiqwftzp7tmhibKcxxT1Bplq4aj0GTQjmf0EYfG499hewzJQU9MAowMNDqTGYO
         1mLKxsYBkRyu1vz0lHRrstJzJle6Y/FBhPOJYDGaZNVvIt4JRJGU9aY7rwjh1a7VtxKp
         KkQw==
X-Gm-Message-State: APjAAAV2YvP0OUGRKQogMLSfMIxEQNOjDdSn5kA46eSLH5A4JwGAlAAA
        aTNMtmlivsy8xRDW+4KPFl0=
X-Google-Smtp-Source: APXvYqw0lGbvI9fk9Wq27lwuWcpSKjGEok7RuMq2cSbR2S3xtJ51+8CQd26uBaJzlgsGD53R1vpNHA==
X-Received: by 2002:a5d:4a82:: with SMTP id o2mr21423524wrq.154.1560011653697;
        Sat, 08 Jun 2019 09:34:13 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id y2sm5134077wra.58.2019.06.08.09.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:34:13 -0700 (PDT)
Date:   Sun, 9 Jun 2019 00:34:02 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, nico@fluxnic.net, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190608163402.GB2492@zhanggen-UX430UQ>
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
Anyway, I should be honored to be remembered by Greg K-H. :-)

Thanks
Gen

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BEFC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A95920840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WekMWgr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfFHQaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:30:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfFHQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:30:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so5075008wrs.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quef0F8aYAG9qAFtSauA9W3OmlRfJN6ds/RIeMlxias=;
        b=WekMWgr9afHZFY7MNYUSdPYDetpcsmnQ/USAhexWt9lVitfqi2Oj7eXCd6Vc0Ty4rp
         idtj+AKzJXxQPoEvmnzoLBre3I1jvPEJeFRajvxi/kTXTWu7C5zF5ENh+iMMys8WvDQV
         QeFTGKDiX0SgyPRI0d9263ErcyxL+jsWu+ZLHRUTWyIfzfLIWb6ugjSAEN9ihJPC3VCq
         ZW41zVrdqid2wQL3Cp7Nxw487FFFKtzh+M6+Kc8kMIpNmKWdheaNcf9ejv91mAPbbMcy
         n5Iuba1/SpmvhD4wZuXBDAUnzPTVVCTdN+IztemmS/sxgIP0CdecgzW/GXMUE7QtZ/BX
         i6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quef0F8aYAG9qAFtSauA9W3OmlRfJN6ds/RIeMlxias=;
        b=grHAM8sAZ17AmTnbxZ3Ct/I5ygyOqsipPoTEnj2fti4wpWv2tFmPAIAsUd5/FDmKKy
         4+uWql+yyg4QnNUe3028AdfaqA7i7s2ODpV9tof5QluUxhxEkuxdEZHKuT5HNeYM+17X
         ScX+JWcs/hgpeEP8yGy54odGNjfBNcef+vE1zqMDFtNqceJI+IVaAEU7C1JgrOsSBS8D
         jUGM2kmUDQNmJ462rnpRvxdEl3dw3rlSTrnHnesLhWFmOpfWVdlxfR4t0Wy5L2zPC3sG
         ub6SXyhMyhI0PxMTRyGXuV9n5nSyIlX5UnMx64UKQHdESfZMqYslU3rgg32k1iukBx1Z
         iazg==
X-Gm-Message-State: APjAAAVdisSVKnKLUZgjKSSdazPhceQMxR2kd/H8DGhAth4eFMJR54aq
        sWZS29MvqiPLj+sGFI8t8Kc=
X-Google-Smtp-Source: APXvYqxA3sPyG2TK25gLTun1RL8viTUP+3fjceQKvqxvgoLT6QHN8nJiDC6hIXBc96AmRgFA0/hdOg==
X-Received: by 2002:adf:8183:: with SMTP id 3mr24236839wra.181.1560011417538;
        Sat, 08 Jun 2019 09:30:17 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id t63sm9558269wmt.6.2019.06.08.09.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:30:16 -0700 (PDT)
Date:   Sun, 9 Jun 2019 00:30:07 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, nico@fluxnic.net, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190608163007.GA2492@zhanggen-UX430UQ>
References: <20190528004529.GA12388@zhanggen-UX430UQ>
 <20190608160138.GA3840@zhanggen-UX430UQ>
 <20190608162219.GB11699@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608162219.GB11699@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 06:22:19PM +0200, Greg KH wrote:
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
> 
> Wait, will that even work?  You can jump into the middle of a while
> loop?
I felt like the same when I saw reviewer's advice to write in this way.
But I tested, and it did work.
> 
> Ugh, that's beyond ugly.  And please provide "real" names for the
> labels, "fail1" and "fail2" do not tell anything here.

Sure, I can revise that if needed.

Thanks
Gen
> 
> Also, have you actually be able to trigger this?
> 
> thanks,
> 
> greg k-h

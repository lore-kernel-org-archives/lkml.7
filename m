Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D1FC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AE82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiHkTJdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfFJGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:45:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbfFJGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:45:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so4681788pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AXxwZFqkJLSKlo1AKtUaQ/ENUlkKBcpyhgleO3ow388=;
        b=YiHkTJdx7yCQJW8EhCRhbAexTIwEPNmnltUScnOW70LR5R4M0zGWwRb1Azugg0mJKW
         1NA30+nTtQdDYboc8TiR9TieUCKkKkTaYdMz7DS6OCELNzNdmg2HxnOUWymdQ3zfq85E
         bfsgwfd/uS3RMxh83/W534VSOilBSyr0kmQ0X9Iq95QtCCWd1/4cB4VqWzK5Xwrj9Tc5
         zmmhH9ZhZi2uBbk1EEE8Y5CCPprTI/kSMcOTWuTBghacpXttDiXPnnXt45grFnDt7MXu
         VaDUVAbJ8ZgFLxsF4plIJ28cBfq2CMUFkbn8+Ho0M8O08U86avUP+fao+YizCgc2QqS5
         DdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AXxwZFqkJLSKlo1AKtUaQ/ENUlkKBcpyhgleO3ow388=;
        b=tMgM2Tu3yVpHn+nt/1vw5W4FINxrAVgQ/d3Gl//GZwZSDt6yXK0pAup2XoCfg+38Cr
         /UO37Zf2FOSUfNo18quhGs8YZ49tX6q8fUomGwhQAz/d0FwKp6BLYcQEhbWY0+EkybYw
         I+MHJa2BymwCM8leD42T00xFjxE4m2HEXm05PfbKWixEJTU1u5YFVOLkEDDxjxpiIkjH
         7UBiOdvM5J3qCcd+6XwhLFYucM/vY/sIu4c4rP6g+jbDjP6MuZkA+7U46QToI7s5FPME
         0V/jkCeT4/W8w3m876JA2/HF84wX1idmVIar+xqasFhzf8vneLe3ziO+Ljb46OFYEqKr
         79Zg==
X-Gm-Message-State: APjAAAV8z9cayVell3Qa7CUc+b915k7VdgofknYs1uplpb3W/sWgpsvB
        sl0CEEz164OIZVOhKbfp3JouOQHg4MsmnQ==
X-Google-Smtp-Source: APXvYqw08rKgZJAkQBntaYmCPFTNxHfKWkcs3bOrEThz724Nqp1BmapHkmdPOiD5NJuFIDU1d/qeZg==
X-Received: by 2002:a63:5207:: with SMTP id g7mr13953365pgb.356.1560149127632;
        Sun, 09 Jun 2019 23:45:27 -0700 (PDT)
Received: from ubuntu ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s17sm8726251pfm.74.2019.06.09.23.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 23:45:27 -0700 (PDT)
Date:   Sun, 9 Jun 2019 23:45:21 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        kilobyte@angband.pl, textshell@uchuujin.de, mpatocka@redhat.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190610064519.GA3143@ubuntu>
References: <20190528004529.GA12388@zhanggen-UX430UQ>
 <20190608160138.GA3840@zhanggen-UX430UQ>
 <20190608162219.GB11699@kroah.com>
 <nycvar.YSQ.7.76.1906082010430.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1906082010430.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 08:15:46PM -0400, Nicolas Pitre wrote:
> On Sat, 8 Jun 2019, Greg KH wrote:
> 
> > On Sun, Jun 09, 2019 at 12:01:38AM +0800, Gen Zhang wrote:
> > > On Tue, May 28, 2019 at 08:45:29AM +0800, Gen Zhang wrote:
> > > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > > vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
> > > > following codes. However, kzalloc() returns NULL when fails, and null 
> > > > pointer dereference may happen. And it will cause the kernel to crash. 
> > > > Therefore, we should check the return value and handle the error.
> > > > 
> > > > Further, since the allcoation is in a loop, we should free all the 
> > > > allocated memory in a loop.
> > > > 
> > > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > > > ---
> > > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > > index fdd12f8..d50f68f 100644
> > > > --- a/drivers/tty/vt/vt.c
> > > > +++ b/drivers/tty/vt/vt.c
> > > > @@ -3350,10 +3350,14 @@ static int __init con_init(void)
> > > >  
> > > >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> > > >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > > > +		if (!vc)
> > > > +			goto fail1;
> > > >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> > > >  		tty_port_init(&vc->port);
> > > >  		visual_init(vc, currcons, 1);
> > > >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > > > +		if (!vc->vc_screenbuf)
> > > > +			goto fail2;
> > > >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> > > >  			currcons || !vc->vc_sw->con_save_screen);
> > > >  	}
> > > > @@ -3375,6 +3379,16 @@ static int __init con_init(void)
> > > >  	register_console(&vt_console_driver);
> > > >  #endif
> > > >  	return 0;
> > > > +fail1:
> > > > +	while (currcons > 0) {
> > > > +		currcons--;
> > > > +		kfree(vc_cons[currcons].d->vc_screenbuf);
> > > > +fail2:
> > > > +		kfree(vc_cons[currcons].d);
> > > > +		vc_cons[currcons].d = NULL;
> > > > +	}
> > 
> > Wait, will that even work?  You can jump into the middle of a while
> > loop?
> 
> Absolutely.
> 
> > Ugh, that's beyond ugly.
> 
> That was me who suggested to do it like that. To me, this is nicer than 
> the proposed alternatives. For an error path that is rather unlikely to 
> happen, I think this is a very concise and eleguant way to do it.
> 
> > And please provide "real" names for the
> > labels, "fail1" and "fail2" do not tell anything here.
> 
> That I agree with.
> 
> 
> Nicolas
Thanks for your comments. Then am I supposed to revise the patch and
send a v4 version?

Thanks
Gen

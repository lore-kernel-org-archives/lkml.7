Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCEC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EAD2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYq9nAwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfEMJhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:37:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43871 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:37:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so6475507pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHm88wo/N+vOzghngpaW9Rkd4qo0OiGXBvkhfrjWli8=;
        b=kYq9nAwP5X4JY64ZzyhX+3DmSvUXZf99zbJXEssGqlwGfsLeTgAzLTtrLogzcE3b3u
         FXGuZhQd3VPi3IkvlhZ1pjIgN/0VfUeCOL7i3A2krg6oyoDIxKgeSw3N6OyGaiZNdQKH
         zFPsIkUXuxlvqVuR2UySTrYKdW9SoRkZUJYypAiNHMA0SsmbJs9zU0z0w/gyjGSNoA2X
         EqZP8gC3smbnPgcr00VN285W3QlJDdAhbKEEmdkQRTJn0G5llwDCbWFIbYmZOTXrQxwr
         ioENEjSGrXs5sP7u+niTT3tSBQj7kWk3JgIHeWQQ6Ly5smsO7UNuuy8/lMV8N8oUHYGt
         2rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHm88wo/N+vOzghngpaW9Rkd4qo0OiGXBvkhfrjWli8=;
        b=scP6GH4I6vngeqcSFx2ppKhpoZx28NLa6sYHdZiZnUJhDNB7q10G+GcB/vkUhVhzHH
         SBLn/KSS5dnKZgi+O/27YXekJ4ag59cVBvLMXXcMGwheOQdwFTtXsVNkyHzY3aMtz7dp
         aiOXH6Xtkica4joJhkXee/K1aTaQRDXkvXqj7Ki0Zp5AgtLx53BljixAu/DUB1IYWQOe
         yx69pfXst9hu/PmJaPcETBUMwa2msIVrFhS7nQUB2hzie1SZJaSdDxYcHcu6iXlvfUPK
         977mhhKo/WMURdKOfh2idAGp4/zVnpWXTIbPQk9BOftzkuovUtciCnXJL17Wos0aJ8BS
         lWUw==
X-Gm-Message-State: APjAAAWRXyF2ceAV3roySNqGuLGeSeq6JtmIui0nYjIAV0pkJO8vx+Ee
        OjWKhv6l2bu7rAAXpgNpfrw=
X-Google-Smtp-Source: APXvYqzKZPSvwsLEDmVmHx3XcBMbiSty87zPfZnLf8D3IdrKMs08mrElvrphsnVK+SPwiZJkkaCvlA==
X-Received: by 2002:a63:6907:: with SMTP id e7mr29081445pgc.209.1557740271169;
        Mon, 13 May 2019 02:37:51 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 79sm10510231pfz.144.2019.05.13.02.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:37:50 -0700 (PDT)
Date:   Mon, 13 May 2019 17:37:41 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190513093730.GA4487@zhanggen-UX430UQ>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
 <20190512084916.GA4615@zhanggen-UX430UQ>
 <20190513073619.GA5580@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513073619.GA5580@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 09:36:19AM +0200, Greg KH wrote:
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > --- drivers/tty/vt/vt.c
> > +++ drivers/tty/vt/vt.c
> > @@ -3349,10 +3349,14 @@ static int __init con_init(void)
> >  
> >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > +		if (!vc_cons[currcons].d || !vc)
> > +			goto err_vc;
> 
> What about the other memory that was allocated?  You never free that.
> 
> >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >  		tty_port_init(&vc->port);
> >  		visual_init(vc, currcons, 1);
> >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > +		if (!vc->vc_screenbuf)
> > +			goto err_vc_screenbuf;
> 
> Same here, you are now leaking memory.
> 
> Did you test this patch out with a kmalloc function that can fail?  If
> not, please try to do so.
> 
> thanks,
> 
> greg k-h
Hi, Greg
1. I re-examined the source code.
For vc_cons[currcons].d and vc allocation fail, we may need to free
vc->vc_screenbuf from the previous loop. So kfree(vc->vc_screenbuf) 
need to be added to err_vc;
As for vc->vc_screenbuf allocation fail, I don't think there is other
memory need to be freed. Because in function con_init, there's no other 
allocation operations except this two kzalloc functions. And in
err_vc_screenbuf, vc_cons[currcons].d and vc is freed in the patch.

2. I tried to test this patch with a compiled kernel in QEMU but 
failed. Testing this is out of my skills. So is there any other ways
to test this patch?
Thanks
Gen

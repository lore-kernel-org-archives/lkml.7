Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312AC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64A1217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558520949;
	bh=IC/TJBAHLlTsm7Dy4Lh7W88QKbbwL7ZjIr3bx9tQT0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HU0ETu54abL9HnF5grqbj2XFI1DFZVWbsbmyNz32zROgyAxvyXWiaZhhl//YesGD8
	 TTTJgnmlElX7jI6V3BwMZ/8GZQR2pz3xaRqA9s42w84ts9QWf10M0hVUAeSn1tSC1d
	 5qoPLnoKnpOWi24QqbvjuoufYV2bZ+mALzywaDUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfEVK3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:29:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39808 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:29:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id a10so1573299ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 03:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4iqwhTTnks7ZWoL8orRfYu/LYXjL37Ltg/i4vRcZuD8=;
        b=rxO9ZZOEgVVcFtqNdDu7Wvt88hGmVn0YqtDbNPd1afnuKzYBAq97FbakUWFiz58g6+
         1lExi1cw8fVo2niRlZIF9CixpSTE8Y/odBGI8fmPDFV2m2LgKP9DUbRXZAP2fvEsKFtL
         vIN9e7HV4vmYir+t7SNuXMED9asq6dnuK2Sfz/W36/F6S0FYY9yLt0V79GGfl8iunh9C
         EBiHUiiRl9xfMAm5WURx7u/Cr6mm8Nrva3D6wUdjWWIQMhO4xnGEt+JSs2x3i/pAw2n0
         u/tDZImzI1DkEEDpUhS5lzPAP1fPZd/5NRPjuxzRHDqgBa9FfO7gA9gDnqur4t1QtOXc
         XJsg==
X-Gm-Message-State: APjAAAXvSHcQKq+P+XI3qhmjszifaoTx6SaQuKzoZnkibvhg9huBYxs9
        k5x1WTW+nchHfZD7bXf89Bk=
X-Google-Smtp-Source: APXvYqz0uGxa0+R/w1ZJstrgAIjBNFa6UvhJwimaIRsJ/ucaKixjrujjIBPEylJo1B8Tm88d4DRfgA==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr31766658ljg.112.1558520945868;
        Wed, 22 May 2019 03:29:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r136sm972745lfr.34.2019.05.22.03.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 03:29:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTOUW-0002f4-KK; Wed, 22 May 2019 12:29:00 +0200
Date:   Wed, 22 May 2019 12:29:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Gen Zhang <blackgod016574@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522102900.GC2200@localhost>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
 <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:15:56AM +0200, Jiri Slaby wrote:
> On 22. 05. 19, 10:06, Gen Zhang wrote:
> > On Wed, May 22, 2019 at 06:25:36AM +0200, Jiri Slaby wrote:
> >> On 22. 05. 19, 3:40, Gen Zhang wrote:
> >>> In alloc_tty_struct(), tty->dev is assigned by tty_get_device(). And it
> >>> calls class_find_device(). And class_find_device() may return NULL.
> >>> And tty->dev is dereferenced in the following codes. When 
> >>> tty_get_device() returns NULL, dereferencing this tty->dev null pointer
> >>> may cause the kernel go wrong. Thus we should check tty->dev.

Where do you see that the kernel is dereferencing tty->dev without
checking for NULL first? If you can find that, then that would indeed be
a bug that needs fixing.

> >>> Further, if tty_get_device() returns NULL, we should free tty and 
> >>> return NULL.
> >>>
> >>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >>>
> >>> ---
> >>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> >>> index 033ac7e..1444b59 100644
> >>> --- a/drivers/tty/tty_io.c
> >>> +++ b/drivers/tty/tty_io.c
> >>> @@ -3008,6 +3008,10 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
> >>>  	tty->index = idx;
> >>>  	tty_line_name(driver, idx, tty->name);
> >>>  	tty->dev = tty_get_device(tty);
> >>> +	if (!tty->dev) {
> >>> +		kfree(tty);
> >>> +		return NULL;
> >>> +	}
> >>
> >> This is incorrect, you introduced an ldisc reference leak.
> > Thanks for your reply, Jiri!
> > And what do you mean by an ldisc reference leak? I did't get the reason
> > of introducing it.
> 
> Look at the top of alloc_tty_struct: there is tty_ldisc_init. If
> tty_get_device fails here, you have to call tty_ldisc_deinit. Better,
> you should add a failure-handling tail to this function and "goto" there.
> 
> >> And can this happen at all?
> > I think tty_get_device() may happen to return NULL. Because it calls 
> > class_find_device() and there's a chance class_find_device() returns
> > NULL.
> 
> Sure, but can class_find_device return NULL in this tty case here?

Yes, it can and will and that's fine, not all ttys have a struct device
(e.g. ptys). 

This patch is broken and should be dropped.

Johan

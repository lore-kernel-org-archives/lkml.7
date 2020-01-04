Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF0B215A4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3w4MI7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADNJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 08:09:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37988 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgADNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 08:09:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so20071074plj.5;
        Sat, 04 Jan 2020 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pytAZE1wLxvgM4YSYnv0kR/qJALM41c0sm7W1RQJOg8=;
        b=q3w4MI7lHMYVfkdgcXv1fz3H3efAV/xM6iBJsatX1uz1JD514XuVGyeI2R6+P1cxkY
         T8rU4icU68JrgkDNw62vqyUoiGemcguArSH62PRD4VT/AaY9DkHywjK/xK6Bc/T9kmqm
         IH3uZl2CECk06rMAvcjS7oFsaJBnT1mdCVxTEWY3sD6QftgmBdreYr2MNlefH231+7l1
         qkYM6jz2u4lelEFr6qG5nHQGJ+u98p+rk/dBmdwYxcZhZeul6hZTEBFNELCgRbTSaTKp
         3oZBn4aneUdsVXZwA86xDPATdL3O8PuVJtrcH4z3E8hw7nHbt49wlhi+MreMw7Fz41ar
         wG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pytAZE1wLxvgM4YSYnv0kR/qJALM41c0sm7W1RQJOg8=;
        b=tNTM26XFTyuJpizfDgh8RY7fvjXs2YSxKXz4XMioYiymsmcFyqTOMKkTHGKz5g+iij
         W+jbRUjmmKIkdRUDQ7zxI9Rb55aKmlL5Eb1RL+xMPx/EPoYJ2Lgg/7x7kHI/mrsRFv+U
         WTrn+mXTyBdxd5bVQD6mfTb7j8WHr77nQxDeRTY02Sjob2mOvaYXh8ZpgU06xcdwkca8
         wlpiRdboKrXKWgGFH5savcImSBwKJo5E8CU87nZC1MoYXuKjYCU/PZUOhIA4/37p12Nu
         mMsSRj0Ihwb0bzVDdPVnXhbtmZKVfjbOHXBN8FTwwpPLPbmQyJIzZogQ5E0S6QQlZOj+
         VpUQ==
X-Gm-Message-State: APjAAAV23q/c8cxQxQ73Jy4242Z6EqmCyRqhoKkQcfdb/CMeE1p6/6m2
        8u+xdokel4+CeW34BQtdLUM=
X-Google-Smtp-Source: APXvYqzUIQxYHRHTJBEFVdh3yVD2nN8QL8MAhfOlRbyM5yUQVqEEnV9NPS3PgIkdtEiv1bBAe3VA6g==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr71230416plk.269.1578143365194;
        Sat, 04 Jan 2020 05:09:25 -0800 (PST)
Received: from localhost (199.168.140.36.16clouds.com. [199.168.140.36])
        by smtp.gmail.com with ESMTPSA id b1sm18037406pjw.4.2020.01.04.05.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 05:09:24 -0800 (PST)
Date:   Sat, 4 Jan 2020 21:09:21 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: core: Warn about failed to find udc
Message-ID: <20200104130921.GA28574@nuc8i5>
References: <20200104112836.28036-1-zhengdejin5@gmail.com>
 <20200104114530.GA1288021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104114530.GA1288021@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 12:45:30PM +0100, Greg KH wrote:
> On Sat, Jan 04, 2020 at 07:28:36PM +0800, Dejin Zheng wrote:
> > If we do not warn here, the user may not know failed to
> > find udc class driver because it silently fails.
> > Let's print a warning in that case so developers find
> > these problems faster.
> > 
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index 51fa614b4079..9b11046480fe 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -1414,6 +1414,8 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >  	}
> >  
> >  	mutex_unlock(&udc_lock);
> > +	if (ret)
> > +		pr_warn("udc-core: couldn't find an available UDC or it's busy\n");
> >  	return ret;
> >  found:
> >  	ret = udc_bind_to_driver(udc, driver);
> > -- 
> > 2.17.1
> > 
> 
> Isn't this going to cause a lot more messages than is really needed?

I think this should not happen. here just for a gadget driver to find
an udc device by the same name. one driver only call this function once.
if it found, the udc device will bind this driver. otherwise, print this
warning.

I also searched for the caller of this function, For example:
gadget_dev_desc_UDC_store() and usb_composite_probe(), They also
failed silently without any warning messages for return error of
this function. 

> 
> And as you have a device, shouldn't this be dev_warn()?

Sorry, my comments has some mistake. I did not have a device when the
gadget driver failed to find an udc device by the same name. I will
fix it on patch v2.

> 
> thanks,
> 
> greg k-h

Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BD9206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Ogq3tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfJMSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:54:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43247 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfJMSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:54:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so17126427wrq.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqsXr9fhBmWkymaUtYPOa1KUp2T9gWdbbOi7v6RICyE=;
        b=e3Ogq3tDcHYRmDXvKY9LQuff9bout4EkuwMXlYAAcrsttguls8KMu8vsVoZEjVnMAH
         NhsyavnBvYbLZH/RA/+j3byv1NXTxcSVrkVJI720XNeW98d94CJtaS9v/PndhghijXx9
         7/skz27sxvHOnxS7ROVPAAFT+2AavDu73LsJ2CH4Gvm6cwKZ8MHfmZNz7LRD07hWFVy3
         R/RzY+8mSMtGJoZL8cN0g7licYApRQ+0CkbZRoy/a60aZJTedB6IBmYsbPuVUVyqA37D
         ANVUuj8MlOcylXGcw3G/tnJxDIMtdGcWMmbYsETqbQPa0qWBLmj92jrT3z3snrqMWJal
         I5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqsXr9fhBmWkymaUtYPOa1KUp2T9gWdbbOi7v6RICyE=;
        b=iY92XOFZIV8/9lVMlZlAvMp0LWOP3KGCUQTT4S+nJvCcrSVvAA2Lc4ZVB+IYAZdBxZ
         rnp6RwfkuPlRkzWV7+CEsC80ThkE2EY2HzW7bSk7Q+nz9XxF0SDmgwQxUK+uLDfK3Pqm
         Sj9Xg2HAdV1IhTVTnEbYEfq26LD1YePQW+h8D6HQ0W9ggWoqZpD59qbJfKc4o9OyiYpi
         PMcEOmbfbRqd3vHsjnkF94EJvhsM3sv5CXo9bF7Ie0/q7wv5gX9kvQ8nl1U6GknDpe28
         37LqIh64KkWHN+elF6L73ywEAqd2BrYJyZOYZH7u5aQO7g9aB8ByNTB7e3cD0WcKtcEA
         FmpA==
X-Gm-Message-State: APjAAAXbrW1MnH09z3WwctJ94kq2M2jD0lFZsT9lMAX2tv7SFgkjMkIk
        g9d6UJ+0feYRoGSlbcS79Yo=
X-Google-Smtp-Source: APXvYqwRgG0AqakseOajpuYCgvajUVizgTjQ2UAUWC3pGItKxEBHB8BMtahI2oGueApYcJ8lWqsolQ==
X-Received: by 2002:a5d:6787:: with SMTP id v7mr8237032wru.392.1570992874814;
        Sun, 13 Oct 2019 11:54:34 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id 90sm23340176wrr.1.2019.10.13.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 11:54:34 -0700 (PDT)
Date:   Sun, 13 Oct 2019 21:54:28 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: use DIV_ROUND_UP
 helper macro
Message-ID: <20191013185428.GA390@wambui>
Reply-To: alpine.DEB.2.21.1910132005330.2565@hadrien
References: <20191013180033.31882-1-wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910132005330.2565@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910132005330.2565@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 08:06:14PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 13 Oct 2019, Wambui Karuga wrote:
> 
> > Use the DIV_ROUND_UP macro to replace open-coded divisor calculation
> > to improve readability.
> > Issue found using coccinelle:
> > @@
> > expression n,d;
> > @@
> > (
> > - ((n + d - 1) / d)
> > + DIV_ROUND_UP(n,d)
> > |
> > - ((n + (d - 1)) / d)
> > + DIV_ROUND_UP(n,d)
> > )
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > index 87535a4c2e14..74312e8bb32e 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > @@ -4158,7 +4158,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
> >
> >  			/*  The value of ((usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B) */
> >  			/*  is getting the upper integer. */
> 
> It's a nice change.  Maybe the above comment could also be dropped, since
> the code is more understandable now.
> 
> julia
> 
Ok, I agree. Will update this.

wambui karuga

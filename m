Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE78C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E92089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGI/p+mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfDXR2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44022 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390141AbfDXR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so9700444pgu.10;
        Wed, 24 Apr 2019 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XOZE/Moh5Oad524HyWbDciU9ueFqigCfbKwzT9vWeSw=;
        b=XGI/p+mxXjrn2lepqt/3y0PJvrzTbX81CBL6TnpmVX6sjPskaV7jdKyncH8fI1W8tU
         dOlZTYWCZG/+FaKM/a7qFfy+NxHGQ0GmHUorwBBqNIcMcKWgs6vaLtdL+aGP4n22Aox2
         LgOB4DX30cpxK5jMkrC7koumLnlyzVTyV4fY0FI/bvMV4Ap0Sp8s90WFyTSI9vbM3oRt
         dMvfs6ifkdelUtDJk8tDyiZjCj7xFXPfa3ngmzDNNOboXRiiyR2IRUiTIRqAbh9fLzoN
         1WoS5RpPjNWRc4H4OdoR+q1zW55wcwhDnTAL1n/aLqyK3pMvox778xZabIw6lnLiz0j1
         LVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XOZE/Moh5Oad524HyWbDciU9ueFqigCfbKwzT9vWeSw=;
        b=AKNk7zYRJHEK9PQst7CU55nM/uI5vZeqI8+L2nO2JWC6kMyJDHnPhhhnmHA02xz5bK
         F7Eke55OYUxA3A3VNM30/fISM61pFCED1WYBUSfN6sJkxxP72W/u1Dc/ofVHC25XvPzY
         vocBVpkIkmkmqlLFoEzjTQ2dTwm3Kger9DFeKvrji0VqEoJHYZidgSvLJoAfmEofGfLz
         vVPbxWGlIYqmvtI+2aVreGV8zifrbp2EtNK9mUeLGax/cNwNp8Rc/LHEGk5BwP6gPFdd
         Nv+M4YPDt1ZsPWDj5XdOzj+dQcfsa/EdDKTxYU0MYA/su7expwLLj415XCqudYbjYbEU
         fcGQ==
X-Gm-Message-State: APjAAAXJiyNnljbrj07uRic6Cu5dF6tvM+qOvv2fI4nNFj1PKUoXHEFI
        +3Z1WkOMaG2yPXAijXDjAYw=
X-Google-Smtp-Source: APXvYqzuKaJO6QmqZOJ8APbvprfJirQYWExBCyedm1HY8DJGVycwN8GEefwmZovjhiHtfSUOyf/9NQ==
X-Received: by 2002:a65:6658:: with SMTP id z24mr2380626pgv.323.1556126894795;
        Wed, 24 Apr 2019 10:28:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20sm25674718pfn.131.2019.04.24.10.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:28:14 -0700 (PDT)
Date:   Wed, 24 Apr 2019 10:28:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: machzwd: Mark expected switch fall-through
Message-ID: <20190424172813.GA29860@roeck-us.net>
References: <20190410184905.GA24283@embeddedor>
 <20190410203556.GA18676@roeck-us.net>
 <707a1c55-c185-1227-0a65-136f3bf27617@embeddedor.com>
 <c2e13a6d-0701-414b-ff1d-70e358fc2786@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2e13a6d-0701-414b-ff1d-70e358fc2786@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:01:03PM -0500, Gustavo A. R. Silva wrote:
> Hi Guenter,
> 
> I wonder if you took this in you watchdog-next branch.
> 

It is in branch watchdog-next of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

waiting for Wim to pick it up.

Guenter

> Thanks
> --
> Gustavo
> 
> On 4/10/19 3:51 PM, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 4/10/19 3:35 PM, Guenter Roeck wrote:
> >> On Wed, Apr 10, 2019 at 01:49:05PM -0500, Gustavo A. R. Silva wrote:
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warnings:
> >>>
> >>> drivers/watchdog/machzwd.c: In function ‘zf_set_timer’:
> >>> ./arch/x86/include/asm/io.h:355:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>  #define outw outw
> >>> drivers/watchdog/machzwd.c:80:53: note: in expansion of macro ‘outw’
> >>>  #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
> >>>                                                      ^~~~
> >>> drivers/watchdog/machzwd.c:179:3: note: in expansion of macro ‘zf_writew’
> >>>    zf_writew(COUNTER_1, new);
> >>>    ^~~~~~~~~
> >>> drivers/watchdog/machzwd.c:180:2: note: here
> >>>   case WD2:
> >>>   ^~~~
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>
> >>> This patch is part of the ongoing efforts to enable
> >>> -Wimplicit-fallthrough.
> >>>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >>
> > 
> > Thank you, Guenter.
> > --
> > Gustavo
> > 
> >>> ---
> >>>  drivers/watchdog/machzwd.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
> >>> index 88d823d87a4b..108928dbc754 100644
> >>> --- a/drivers/watchdog/machzwd.c
> >>> +++ b/drivers/watchdog/machzwd.c
> >>> @@ -177,6 +177,7 @@ static inline void zf_set_timer(unsigned short new, unsigned char n)
> >>>  	switch (n) {
> >>>  	case WD1:
> >>>  		zf_writew(COUNTER_1, new);
> >>> +		/* fall through */
> >>>  	case WD2:
> >>>  		zf_writeb(COUNTER_2, new > 0xff ? 0xff : new);
> >>>  	default:
> >>> -- 
> >>> 2.21.0
> >>>

Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E8C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822852075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtiwMYst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDPUsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:48:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45302 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:48:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so10890553pgk.12;
        Tue, 16 Apr 2019 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPUQAgQ+R6PmJiarC6uQozwPmwGhpVf3N2CyetrS5X0=;
        b=HtiwMYstcKX7egS+8iz1zj+lxFEpEOcRu+tq0cLRJlurgMtvY+hkN+tHhOkBDx13fZ
         I/y5f7+XGPGcHDgFlirweCAuWfHZlHwCoKJlafqG/KExpQOSGqckh0G/b53i+P5MPPZZ
         ThEaNiCEE5WitBYXInmVpHxViKNH3h5Nv6+7I9hP7VE7Rw6ekfdPKQbqO32gO3/+ac16
         W+9ggHBoxeDqKcU8GBqaM4QhV37JZvxUuiCAZWFf40lNHpYvtjFCO4OG9vamyi14Sotw
         hZzqe56EOfqBqenAQHDya3G7M1Dxl31nFshPkdKEHD2e82AMnNowUcYK9MBLxIUOr/Fb
         ifIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPUQAgQ+R6PmJiarC6uQozwPmwGhpVf3N2CyetrS5X0=;
        b=E50W8QALul0DuUvSrewCF69QkkL3Ye3M3yoM2mZorifngw922oq6oTkjPauPbtWL64
         lQHiaUsdQLJ2xKpTqpGGdp9DJv2e1Xev8LG6fR3GQXfyDGDRa4UU8ltBUFTDP6FGA5zL
         4a5dUnyHzAjthoGvX2tIgWTrcV/jMyL5KauUqiNc53hFlzS/LIwQXGGvQzPZzmmxJU33
         EzDegF5O7HVMrqH6DkWkRZhIv+5wlb/PmmglVNDFdej9fKlqwtNqb0GN3kGR6makeza2
         TwCzqB/M+7xfT3vEs05SmDGQHUjPGBx3oPr4u0eId2syBykA4U94+LNJ5Q0eQrnRQ4Dl
         DqBA==
X-Gm-Message-State: APjAAAWLkmUrcALRBRUPTFXBqASyjFqVVS52vkMuPz8tTr32fMnzLF/R
        5YjVye7RxWtm834uRpJPp5csfqpi
X-Google-Smtp-Source: APXvYqz1bL7uIcfqj8he/AxkJWqYNkZe/yuNEqjxcsZZ3BXL3yBXjHWozHifgIFqeqY79BI3dxEQGA==
X-Received: by 2002:a63:f44:: with SMTP id 4mr74566124pgp.324.1555447695919;
        Tue, 16 Apr 2019 13:48:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm87234639pgn.4.2019.04.16.13.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:48:15 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:48:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416204814.GA26442@roeck-us.net>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416203431.GA20072@anatevka>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:34:31PM -0600, Jerry Hoemann wrote:
> On Tue, Apr 16, 2019 at 12:25:05PM +0200, Wolfram Sang wrote:
> > The core will print out details now.
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index ef30c7e9728d..db1bf6f546ae 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -311,8 +311,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
> >  		goto error_init_nmi_decoding;
> >  
> >  	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> > -	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> > -		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
> > +	watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);
> 
> I applied patches 1,2 & 6 in testing.
> 
> Note, that hpwdt is passing NULL as the third parameter to watchdog_init_timeout().
> 
> The second patch in this series is using "dev" as input to dev_err and dev_warn.
> 
> This results in the following in dmesg when trying to load hpwdt w/ an invalid soft_margin:
> 
> 
> [   80.848160] (NULL device *): driver supplied timeout (4294967295) out of range
> [   80.855429] (NULL device *): falling back to default timeout (30)
> 
Good find. Thanks a lot for testing!

We'll have to address this. Wolfram - it looks like we'll need
separate error message handling for situations where dev is NULL.
We may have to leave it up to the parent after all to display
a message in that case (since we do want to see the driver name).

> 
> if the call in hpwdt driver is changed to:
> 
> 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, &dev->dev))
> 
> 
> We see the message like we'd desire:
> 
> [ 2061.167100] hpwdt 0000:01:00.0: driver supplied timeout (4294967295) out of range
> [ 2061.174633] hpwdt 0000:01:00.0: falling back to default timeout (30)
> 
> 
> 
> watchdog_init_timeout() uses dev to "try to get the timeout_sec property"
> 
> I am not familiar with this part of the core and what effect having the hpwdt
> driver pass in dev to watchdog_init_timeout would have.  (I.e. is the
> change safe?)
> 
Yes, in general it is safe. watchdog_init_timeout() only uses dev to extract
a timeout value from devicetree (and now to display error messages).

> Guenter, can you help on this question?
> 
> Note, hpwdt isn't the only watch dog device that is passing NULL to
> watchdog_init_timeout.
> 
That is indeed a problem: the pointer will be NULL if there is no parent
device (such as in softdog.c). Otherwise it should never be NULL.

Thanks,
Guenter

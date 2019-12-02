Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAD2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5157D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf35EoFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLBRg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:36:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41874 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLBRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:36:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id e9so397189oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H8ecUYHrlgXWC+SSFS9i4n7p04mhH9a7a/Cpt3ffH28=;
        b=Sf35EoFbsWOdMEu192XWwbMrCaO0l/uAPDrg0e504xYEkn5xLLYrLt3jMickShAHVT
         DH64F4wFjbKE/pHolttk9q+0XZ1ijugRzTfZ3/f4K9rjac7NGmFer9Q+FTfGuNjkU3HP
         IaTS5BSN7OzgHuJqLPQN2pdu0+xePaLprFm4d6/+TiqiVRVl1/uJPbZ6lI+XPImy5A8c
         EkgbB7Xuni64tFTY5huQ1ZXswF/cZicGNmmEOfDfvWZfNsQ2cOhIKzwGyAHIKyzzj63o
         uh2LYyF1XgQ11C0i3Un4mMxh+u5Bkp46ljMqAlzxMnug3NcL5rzApYkTR2KsyNQN3WLV
         tCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H8ecUYHrlgXWC+SSFS9i4n7p04mhH9a7a/Cpt3ffH28=;
        b=cFItT4F9GgR1v88C/PFQeepdDma+zarVLuU/dBfi0t9o3UPPad5z8/OJU5gaDPG0tq
         NbjZToSjwso7RA4J94SvGe1mh2jEfLFmpMTsIOMfOHaZH7b8TfVe7b4S5ibmaY2tRmIn
         3AiaYV44aAXmD3W+mYW/SmoqOFJR3TI+5DR+LRgIFGnuwbEtDL+z94dMmrIC56vIYXQc
         GgGQ6Nj6RJLKzYkopouAJcubQwpoTV/miT2tnzTurrKR8/SCWCW2ilxvOpNVzlo64/Yy
         II/ZRnS56vKiTuwSN88yhccCkLtFbTw0dhkPnCx2sSO7CO7gkRbWm4R9VWlPargYROOJ
         Dvfg==
X-Gm-Message-State: APjAAAXunSHwuD6UNbmEcsW/NsJRdMLx7LSiWw871NDyje8YZZPCRYcD
        U0AIE6vUNWh8I/ZXmoBHJB0=
X-Google-Smtp-Source: APXvYqx7tXNNm+AI29xK9RC81iVgBoPBBGKztdz6XPDBAA1/IVCZuJ079W9XxpduM7rMKHViLKHPuw==
X-Received: by 2002:aca:1903:: with SMTP id l3mr184063oii.16.1575308183838;
        Mon, 02 Dec 2019 09:36:23 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 47sm11060995otu.37.2019.12.02.09.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 09:36:22 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:36:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Message-ID: <20191202173620.GA29323@roeck-us.net>
References: <20191202141836.9363-1-linux@roeck-us.net>
 <20191202165231.GA728202@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202165231.GA728202@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 05:52:31PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 02, 2019 at 06:18:36AM -0800, Guenter Roeck wrote:
> > The code doesn't compile due to incompatible pointer errors such as
> > 
> > drivers/staging/octeon/ethernet-tx.c:649:50: error:
> > 	passing argument 1 of 'cvmx_wqe_get_grp' from incompatible pointer type
> > 
> > This is due to mixing, for example, cvmx_wqe_t with 'struct cvmx_wqe'.
> > 
> > Unfortunately, one can not just revert the primary offending commit, as doing so
> > results in secondary errors. This is made worse by the fact that the "removed"
> > typedefs still exist and are used widely outside the staging directory,
> > making the entire set of "remove typedef" changes pointless and wrong.
> 
> Ugh, sorry about that.
> 
> > Reflect reality and mark the driver as BROKEN.
> 
> Should I just delete this thing?  No one seems to be using it and there
> is no move to get it out of staging at all.
> 
> Will anyone actually miss it?  It can always come back of someone
> does...
> 

All it does is causing trouble and misguided attempts to clean it up.
If anything, the whole thing goes into the wrong direction (declare a
complete set of dummy functions just to be able to build the driver
with COMPILE_TEST ? Seriously ?).

I second the motion to drop it. This has been in staging for 10 years.
Don't we have some kind of time limit for code in staging ? If not,
should we ? If anyone really needs it, that person or group should
really invest the time to get it out of staging for good.

Guenter

Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E472C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9D920828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbBYG0u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLJWsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:48:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34652 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLJWsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:48:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so600936pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toKM2TKe1TxNJ1VaQDO7o0YM+C3yJr2QelcOjh015Rs=;
        b=pbBYG0u1Bzy/q3jLJsNaX+L8CwYta1vgl3fEjO87Le/0PEWonsNYzt6cEeCGlEajq1
         bIl6/U+tcxSCkHrWcKyTLeXXalBIFGyG9w2sJhFs3OJ6KbT2D1U0iJGg6WQX7p62sdrn
         IaiR2v3HPq+C8uf2/lv40qFshPJmmHjgA7Yvv6gYUYhWLpcw4CCRE5LqyWDrQ+q5qYCj
         MEgtOjQRDvHbbbBJiUWh9hJ58p48ldv1XgALOkDasSuzGGxejVOWazsEJayfrUzvwmgJ
         i7nnd+dTecFfTmN26NzruoJQt1UXM08L1CxOsHzKENcOS6FGW/dCXq5fQ/BtIovotY8Y
         iFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=toKM2TKe1TxNJ1VaQDO7o0YM+C3yJr2QelcOjh015Rs=;
        b=nEtD5FgZgCDxS/FEeAvEKd9JFQQQUA2fruwMnfwLwqYNgTJRL0APRFY+xrtrMw3LFz
         DHYrCKzGIniC8G7TOEI8h1BX9eDV0DOJLqoaZvfc4rSQ73w8CSnatkUWOPm8MqBQv3d2
         0jhoUbqyfcVeBuomem3TF4mre/0+VNciqdAd1lSOXXKsrxmONWyPlDmz/QmOl6GY0Wgx
         kdnsaUj2QDDkGaIQ5gPMAsAV7PpVRlR9bloTxQXcoKNC1AndQhJ7QsmW4JmriMJ/33Jq
         YOg1Z9nrPutXNyx+vEQT3nAbeudEIIR3oAA3LzWv2j+7XxYXCiLxrhvRmJfM7nZ7A7ro
         h3vQ==
X-Gm-Message-State: APjAAAXoctxkNhakhNaPKyUjQHLZpBBKFIksbD0F6W9Q9F0xYmZnUQox
        UMw+k8ZYrs+GHStNMOYVH3g=
X-Google-Smtp-Source: APXvYqxi6tFJUHXKBXlv1vak8CiEOd7IldDFLoyZgDsTkXUY3scwhN8cMzSzOjmvU1EMyiERf+uqHw==
X-Received: by 2002:a63:3d4f:: with SMTP id k76mr564419pga.310.1576018085669;
        Tue, 10 Dec 2019 14:48:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm29746pgq.68.2019.12.10.14.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 14:48:04 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:48:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devel@driverdev.osuosl.org,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Paul Burton <paulburton@kernel.org>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Sandro Volery <sandro@volery.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Valery Ivanov <ivalery111@gmail.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20191210224803.GA3372@roeck-us.net>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
 <20191210120120.GA3779155@kroah.com>
 <20191210194659.GC18225@darkstar.musicnaut.iki.fi>
 <20191210201515.GA16912@roeck-us.net>
 <20191210214848.GA5834@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210214848.GA5834@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:48:49PM +0200, Aaro Koskinen wrote:
> On Tue, Dec 10, 2019 at 12:15:15PM -0800, Guenter Roeck wrote:
> > On Tue, Dec 10, 2019 at 09:46:59PM +0200, Aaro Koskinen wrote:
> > > On Tue, Dec 10, 2019 at 01:01:20PM +0100, Greg Kroah-Hartman wrote:
> > > > I have no idea :(
> > > 
> > > It's stated in the TODO file you are deleting (visible in your
> > > patch): "This driver is functional and supports Ethernet on
> > > OCTEON+/OCTEON2/OCTEON3 chips at least up to CN7030."
> > > 
> > > This includes e.g. some D-Link routers and Uniquiti EdgeRouters. You
> > > can check from /proc/cpuinfo if you are running on this MIPS SoC.
> > 
> > It also results in "mips:allmodconfig" build failures in mainline
> > and is for that reason being marked as BROKEN. Unfortunately,
> > misguided attempts to clean it up had the opposite effect.
> 
> This was because of stubs hack added by someone - people who do not run
> or care about the hardware can now break it for others with their
> silly x86 "compile test"s.
> 

Thast was the first breakage. The second was to replace typedefs with
structures without considering that those typedefs are still used
throughout the Cavium code, creating conflicts between "mystruct_t" and
"struct mystruct" in various API calls. It may well be that this
"improvement" was tested with x86_64:allmodconfig - if it was tested
in the first place. It was most definitely not tested with
cavium_octeon_defconfig, much less with real hardware.

Pretty much none of the changes made to the driver in the recent
past have improved it. On the contrary, it is getting worse. With no
one committed to get the driver out of staging, I don't think there
is a reasonable alternative to removing it. For my part I am for sure
not looking forward having to deal with it breaking over and over
again and having to spend time tracking down the breakage.

Guenter

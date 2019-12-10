Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7681C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48882073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llhypkAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLJUPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:15:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34938 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:15:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so7841213pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a23C88J7c4vvDVUHbth3se+rWS20dGukI7AqnM65nco=;
        b=llhypkAjXBMezhrv+X8Q+gI6d8VkNqoKlcbVvdvI9On4vUPUv1r+slLo8z/bVhZCO9
         xcgXnJuQKorteGeo/pibJPACwGP2FUf2gKSAQvCekuGSMMFOzXK3KPfUUGJAid5XrYbr
         yIJwahVO0Ize5dYpK7n62kNZNlUE3LHXrW2gwsDLGvkAKntWVLisYmQul+PetiTuX4RD
         bXEoMc3tRYxBKShqLs8q3JeVfg2Ku5KnyW+lDV5kB9aHOYh4Vb/J0Yj/PVmOt5PJe8Ee
         gX1yAlMAkWtX6gUN6jbr1CTR1NrVrD9hh3WiNFp2e1HV6gY9GwbshX3OFlL2XnLFwVPz
         S4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a23C88J7c4vvDVUHbth3se+rWS20dGukI7AqnM65nco=;
        b=Y1hdPk/oX3mE+c85tMLSmFJGtJoWoDSvenPyvr2OQ7lPjQtN4WmbqRlErM8GgeT4gx
         4wuErsKrSDddk8uvOADUMELgDFSW8FZjmOdfkzU0UMYMXdYX9hyUlMlDL6GCLY+VKPLQ
         KmIPNC+Umjsb39WKWOMBDXi8q6VEr0ERGEaKK3xmr5GLiOgHhrgpjTrVJzSN6fJ4vAqs
         5lLmFiC02dRKkstPH2yHPqtroL8ViuxdevTRXwL49ybQ0NyJ2TdUDQNBcfXsdpmZIkJJ
         79jSarPjp+cvfmeEdItvhOWxEbRdgaQ+2R6QmdBAQl92oKRbsJFOxXFhEKxn4bJOfOpR
         MTOw==
X-Gm-Message-State: APjAAAW5kaLzQ+CiwklOUAwWekt73FETrVXT0rJ8JrWJPEFyua4BZ86V
        kGa/WCRc0j1nGLtaXLm1+18=
X-Google-Smtp-Source: APXvYqyde2PpnPTK52R4kRUah6Xn6N9A9Bds8wqjeKADVQqfQY97SRK0znf6zNywQ2NTkGk1SXCm7w==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr37169532plp.217.1576008918269;
        Tue, 10 Dec 2019 12:15:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j22sm3478462pji.16.2019.12.10.12.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:15:16 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:15:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandro Volery <sandro@volery.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Florian Westphal <fw@strlen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paulburton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Valery Ivanov <ivalery111@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20191210201515.GA16912@roeck-us.net>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
 <20191210120120.GA3779155@kroah.com>
 <20191210194659.GC18225@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210194659.GC18225@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:46:59PM +0200, Aaro Koskinen wrote:
> On Tue, Dec 10, 2019 at 01:01:20PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 10, 2019 at 12:40:54PM +0100, Sandro Volery wrote:
> > > Doesn't octeon have drivers out of staging already?
> > > What is this module for?
> > 
> > I have no idea :(
> 
> It's stated in the TODO file you are deleting (visible in your
> patch): "This driver is functional and supports Ethernet on
> OCTEON+/OCTEON2/OCTEON3 chips at least up to CN7030."
> 
> This includes e.g. some D-Link routers and Uniquiti EdgeRouters. You
> can check from /proc/cpuinfo if you are running on this MIPS SoC.
> 

It also results in "mips:allmodconfig" build failures in mainline
and is for that reason being marked as BROKEN. Unfortunately,
misguided attempts to clean it up had the opposite effect.

Guenter

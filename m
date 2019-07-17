Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66A020880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q8tZgQ6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGQM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:26:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35276 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:26:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so17313675qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKZ3PPWFEXzcKJ2h50KgMAEoCEZWAlMCLSPlgytTa0U=;
        b=Q8tZgQ6ne2wtu8Y5dyZx2Dh+zE6bgW4dMvlxoeKXpUJKhA1FoV0KcTXKrU4OsFlOH4
         i5lgd3951e/igkkhMAKad7Rdptebm0BBjX7T0LzTgqFnBnPvAP5JywNOOyEBRIcXHScf
         kjPek6R0K4KQd0Ph2UPHwaVDI0tOpkylT+w61Wz8bfFV4gpE06h7cVmSS+sQn+gS5s4q
         PB6ORi+EHy/clfQxAnygZzL7kiGzJjOvDgPO3lwym0CLdfFkzPOO/xSVenYKArjV6XGr
         qLeloFO6ZloByVvDOZ62EoYQX/daD8Bj5kzb3IrLB4aP/bD5eseVpjtCTCDWPN231iVo
         cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKZ3PPWFEXzcKJ2h50KgMAEoCEZWAlMCLSPlgytTa0U=;
        b=VfM/xpppS8oQPTmFaFha4fnORAwsnKMEHf9PX2AMK7aNvPiItt5faxsCAjpZx/kkVR
         K2Lu38Rh3+mC/UMp4amZC2cw6mxI43dFd94/1SYQlPCfjTNVnkqSRXALa5bQvpIUUbN8
         PxPKOEDd2Se0/RoN5oUBWjnT5I7vMsO3qvERe/7ApWXJg4jpALO+nFKtztnIZPHgYWX4
         XJkfOaXeFBsI4JiZtn9sB2hu+q9lD1tvtNSokFrIXFxBy4L0VYwpYATm9A+rDfgep4Tk
         Mciv0aIrK1WXol/AVDsGVBgOVhC3SCqrKV632GyB4/4Y2VZGuXpvUlk/46cUOVVtWsXZ
         K5aw==
X-Gm-Message-State: APjAAAUOSLUhpkXDszXeFRY7vpZehoHnpOgeq2di1gDGhdzP+vR+scCf
        /4f7NUJ/xSHty9YkE8plZsyEYA==
X-Google-Smtp-Source: APXvYqwZBG7sz559LYm14ZgZaWNgptDbja7omCxLQue+lL9VAcSClk9Z0xTEGpcGpyPrll6J39/OOQ==
X-Received: by 2002:a05:620a:15a5:: with SMTP id f5mr25771788qkk.45.1563366359574;
        Wed, 17 Jul 2019 05:25:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y14sm10762015qkb.109.2019.07.17.05.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 05:25:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnj0Q-0003nG-3A; Wed, 17 Jul 2019 09:25:58 -0300
Date:   Wed, 17 Jul 2019 09:25:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717122558.GF12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> On 17.07.2019 00:45, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> > 
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1
> > Secure Microcontroller requires a special driver to handle its
> > specifics:
> >   - need to ensure a certain delay between spi transactions, or else
> >     the chip may miss some part of the next transaction;
> >   - if there is no spi activity for some time, it may go to sleep,
> >     and needs to be waken up before sending further commands;
> >   - access to vendor-specific registers.
> > 
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> > suspended bit and remove ifdef checks in cr50.h, push tpm.h
> > include into cr50.c]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >   drivers/char/tpm/Kconfig    |  16 ++
> >   drivers/char/tpm/Makefile   |   2 +
> >   drivers/char/tpm/cr50.c     |  33 +++
> >   drivers/char/tpm/cr50.h     |  15 ++
> >   drivers/char/tpm/cr50_spi.c | 450 ++++++++++++++++++++++++++++++++++++
> >   5 files changed, 516 insertions(+)
> >   create mode 100644 drivers/char/tpm/cr50.c
> >   create mode 100644 drivers/char/tpm/cr50.h
> >   create mode 100644 drivers/char/tpm/cr50_spi.c
> > 
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 88a3c06fc153..b7028bfa6f87 100644
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -114,6 +114,22 @@ config TCG_ATMEL
> >   	  will be accessible from within Linux.  To compile this driver
> >   	  as a module, choose M here; the module will be called tpm_atmel.
> > +config TCG_CR50
> > +	bool
> > +	---help---
> > +	  Common routines shared by drivers for Cr50-based devices.
> > +
> 
> Is it a common pattern to add config options that are not useful on their
> own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_SPI?
> Why can't you just use TCG_CR50_SPI for everything?

This is an internal kconfig symbol, it isn't seen by the user, which
is a pretty normal pattern.

But I don't think the help should be included (since it cannot be
seen), and I'm pretty sure it should be a tristate

But overall, it might be better to just double link the little helper:

obj-$(CONFIG_TCG_CR50_SPI) += cr50.o cr50_spi.o
obj-$(CONFIG_TCG_CR50_I2C) += cr50.o cr50_i2c.o

As we don't actually ever expect to load both modules into the same
system

Jason

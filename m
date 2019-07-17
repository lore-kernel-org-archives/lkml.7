Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AEDC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C012182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/7Z9+gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfGQQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:49:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGQQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:49:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so11115663pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=5Fl5Dlb5En2+Wq+o2LvoJPZA7FE64mKY2RfJ/AGSAjg=;
        b=M/7Z9+gDOEv7M8nlkeWZGNUlHiLiUkiZxwSc3n4jfdPNWM8nq23uOTzE9YrocVC6mA
         ZBT/EdbYeCiH/878aDGvzDeCSjfwdU+F4dPXbRJzJt20lFphSw1EcL5j1ZXjvx8gS26h
         0rbXKJHS3Sy2SUDezNgRx+/x694+ydI33ktK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=5Fl5Dlb5En2+Wq+o2LvoJPZA7FE64mKY2RfJ/AGSAjg=;
        b=B5vbp7smVv4deitJyZJ5qZ1PT6hBRQU9YTJy7+qu21i4UsWHWe2h+A68yQbv94vT4n
         y4+K8WimVsmMe+PdJMIoq/OLGIUN3SmD1lshcw/dkoDIsd0w0ZxZj8SM0vok6YD84q9o
         q0ZF82f1ycLUOF38wdgVAxBuliKTA5FhefjCgzCzBFxZsE7CetIkqgcSiCg/00RsWUUF
         Jkp9hqgbLkglFox/TuxuLg/oycBaItt2n5yNrDFP/n31FN8PKDhEFD++XU1fb6G0VbMn
         JIEWYc3tRAZV4zidQomem4Kt123W3+ABZhtFSowkfTI7vaPnE1x6LO3qoXPf65r9Qg6o
         WlVg==
X-Gm-Message-State: APjAAAXxnZSOyJ85mP6Te1hYJr2ncnPMaEKZWnLVZG8Oq44/ASMmGJs1
        xf81Z408k2mcU1ati/Ybo5sYuQ==
X-Google-Smtp-Source: APXvYqw4Ife04xsJ26z+6JtibYR39+gVPDdH9hC1m6zoSzlbBqMUpf4Yyn8uq1P4TAOm/LcO5jxK7g==
X-Received: by 2002:a63:b919:: with SMTP id z25mr41988841pge.201.1563382184041;
        Wed, 17 Jul 2019 09:49:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r1sm24176724pgv.70.2019.07.17.09.49.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:49:43 -0700 (PDT)
Message-ID: <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717122558.GF12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 09:49:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index 88a3c06fc153..b7028bfa6f87 100644
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -114,6 +114,22 @@ config TCG_ATMEL
> > >       will be accessible from within Linux.  To compile this driver
> > >       as a module, choose M here; the module will be called tpm_atmel.
> > > +config TCG_CR50
> > > +   bool
> > > +   ---help---
> > > +     Common routines shared by drivers for Cr50-based devices.
> > > +
> >=20
> > Is it a common pattern to add config options that are not useful on the=
ir
> > own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_S=
PI?
> > Why can't you just use TCG_CR50_SPI for everything?
>=20
> This is an internal kconfig symbol, it isn't seen by the user, which
> is a pretty normal pattern.
>=20
> But I don't think the help should be included (since it cannot be
> seen), and I'm pretty sure it should be a tristate

Good point. I'll fix it.

>=20
> But overall, it might be better to just double link the little helper:
>=20
> obj-$(CONFIG_TCG_CR50_SPI) +=3D cr50.o cr50_spi.o
> obj-$(CONFIG_TCG_CR50_I2C) +=3D cr50.o cr50_i2c.o
>=20
> As we don't actually ever expect to load both modules into the same
> system
>=20

Sometimes we have both drivers built-in. To maintain the tiny space
savings I'd prefer to just leave this as helpless and tristate.


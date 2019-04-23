Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64A520685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfDWPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:14:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52418 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:14:21 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43009260D5F;
        Tue, 23 Apr 2019 16:14:19 +0100 (BST)
Date:   Tue, 23 Apr 2019 17:14:16 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joao.pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 1/3] remap: Add I3C bus support
Message-ID: <20190423171416.47b2c9c4@collabora.com>
In-Reply-To: <13D59CF9CEBAF94592A12E8AE55501350A61C9A2@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
        <c38e3cb9e8524af58c995a9cf1f79ddba69b47b4.1555354268.git.vitor.soares@synopsys.com>
        <20190416153948.GF4834@sirena.org.uk>
        <13D59CF9CEBAF94592A12E8AE55501350A61C9A2@DE02WEMBXB.internal.synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 14:58:06 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Hi Mark,
> 
> From: Mark Brown <broonie@kernel.org>
> Date: Tue, Apr 16, 2019 at 16:39:48
> 
> > On Mon, Apr 15, 2019 at 09:19:39PM +0200, Vitor Soares wrote:
> >   
> > > +++ b/drivers/base/regmap/regmap-i3c.c
> > > @@ -0,0 +1,62 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.  
> > 
> > Please make the entire header C++ style so it looks more consistent.
> > Otherwise this looks good modulo   
> 
> I will change it next drop.
> 
> > Boris' comment; I'm fine with leaving
> > extra modes for later so long as they can be introduced without
> > disrupting existing users so the only question there would be if we
> > should name the init function in some way that's specific to the I/O
> > mode being used here.  
> 
> My concern is that booth modes (SDR/HDR) might be needed on the device.
> e.g. use SDR to configure the device and use HDR to send/receive large 
> data.

I'd say that we shouldn't use the regmap abstraction in this case or
have a driver-specific backend implementation for it. I guess the
common case is "regs are accessed in SDR mode", so let's keep the name
as it is now and we'll define devm_regmap_init_i3c_hdr() if we ever
need it. Please make it explicit in the kernel-doc that we're using SDR
transfers here.

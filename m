Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803DDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A2420863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCoyVpS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfI2G3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:29:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36666 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfI2G3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:29:18 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so29000210iof.3;
        Sat, 28 Sep 2019 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RDzM2OI8ZvEo8Fafv3HNsPBRly1dAxntip8HAHtNNA=;
        b=FCoyVpS3+z/N4O8wWgUaJKvTgVqsNnhsa6QaPGQ+zr2+py2vnR5LElNbGPiA6CWIhD
         f2LK4jsBAaIyTq3Y4Up1vBKi5J6nobnR+5z1rOFj4EqKRBVla4m788Jr7+Mq1GQkFFzc
         fIV2Bw5NLQTgD+DKcokiLvOpQAkmRebJdZaPh3sw8cu3llvMwZF3llRM4vquF+RGXZiQ
         bk8zK96weHsgNb08Wgfwrtt4q3lt5YDyRVAFuPN2NWzISRlpsehE5WI1VWwnaN1ZLle6
         Yts489lT39wohimuYRevSEOE7CCsdyP2Q5F+8/GxIOfOsWEIMNLsNIo+KX4KQCsF+vcY
         bp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RDzM2OI8ZvEo8Fafv3HNsPBRly1dAxntip8HAHtNNA=;
        b=VAcxcsEa8EMtaOZtGuux/KaDJL78u1wZkKmNSeIpzxtJ1aMmMQdpQoTjRslEw9m9gT
         0kEz4KqJd31PUDcgt5VhKl2qG0/fjx19ubrNXOBjSn0vwyMdON/RE8PEbtin7IJ9ONbM
         PahaknZxJ5M+9FonRCouizyCUb6ONpPm947LNl/UG2T8p5D9eZLq+nfnd3WE2Ua7WhhH
         a4aDlj6R7N+maU66DgK7J3n3e299khL9H8ELsw7WhudOu/uz/ccQ6bF2k/NVNe4huTRR
         U4T4qMsZlET+GzpmmF/Wv4LW5FHbiojPKuc+BZvQfg+8+PDkhrDMO2mVV00p1cqWMsGY
         P1Ng==
X-Gm-Message-State: APjAAAX0MHFLCoKFEdc0e6liI0+ZhYoP6ZqPb/nPfxXWfqXHj22Nx7zs
        7DiSd6YdrTyQtsvTZc5naM937eknnfofSj3E+gKT5Uy6RP8=
X-Google-Smtp-Source: APXvYqyxYVkx7iKbkP8a8b5DE0Gt+us8c5WTQMMn/tRHshxezZ09qJ6PaC7A3ZA7YsyFvIxs8e5x0brkSmjySNlcRrc=
X-Received: by 2002:a92:d148:: with SMTP id t8mr14498553ilg.287.1569738557374;
 Sat, 28 Sep 2019 23:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
 <DB8PR04MB6826763082AF84812426CC53F1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <DB8PR04MB682675054E3A5306F447E6FDF1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB682675054E3A5306F447E6FDF1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Sun, 29 Sep 2019 14:29:04 +0800
Message-ID: <CAL411-rPQiMN15-yTDTcNzhy9bvo_XnvYQFwKQTJ779MG8gBtQ@mail.gmail.com>
Subject: Re: [PATCH] usb: hub add filter for device with specific VID&PID
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > In fact, the system should respond the same way to any unrecognized
> > > device that doesn't support HNP, right?  There's nothing special about
> > > these VID/PID values.
> >
> > Yes, but I saw there are already some implementation in upstream kernel for this
> > purpose, just PID different: drivers/usb/core/otg_whitelist.h function
> > is_targeted()
> >
> > > > > And why those specific vid/pid values?  What do they refer to?
> > > >
> > > > For step 5, we got the VID / PID number from USB IF certified
> > > > lab(Allion.inc at Taiwang). Looks like this is a reserved ID pair
> > > > and will not be allocated to any vendor for their products. So it's
> > > > hence used for
> > > this case test (like saying: you should be able to pop a not-support
> > > message for this reserved VID&PID).
> > >
> > > Don't we do this already?
> >
> > Yes, but in function is_stargeted(), I found it's a little be different:
> > Current upstream:                     VID = 0x1a0a, PID = 0x0200
> > Info from USB-IF certified lab: VID = 0x1a0a, PID = 0x0201
> >
>
> Sorry that I mis-understood the logic of is_stargeted() and it's caller.
>
> So the proper way to resolve my problem is:
> 1. Select CONFIG_USB_OTG in .config
> 2. Add property 'tpl-support' to device tree
> 3. Customize whitelist_table[] according to my Target-Peripheral-List
> requirement.
>

Yan, this is the correct way, we (NXP i.MX Series) have followed this
way for USB EH certification
several years.

Peter

> Am I right? :)
>
> Regards,
> Ran

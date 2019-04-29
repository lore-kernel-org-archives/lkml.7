Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A242C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHPyhmdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfD2RMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:12:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33735 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2RMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:12:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so4531426plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUQwHR2VNeOE5MlCJ+FwXuCGuTGwhtdasJmtn1jXdiM=;
        b=RHPyhmdJuh4p9le7C8dnOEN+s/+kDEu7SpmvlvI4SYn8Wx81kzFxa/oxWR1hteJ5Dl
         OgDZ7UUSq4AcAcTrbT1g1ecqpA1ph7ueHeLKH8e3KvuIoYfHr3hwHNfZrfDwwOiwl8p9
         R29BMEjov8i+HamY04UYLVJfLDYgjroc3TxdDWUtHURJcAd2ymXMChRj6GrN8M8ENvFX
         WinMBAnsx/OzkDhZM2VhFw8LudtbHa41OLHMB8U/tzUszERAQRRYosfRyA95PXqiFi8Z
         FmebDEB/falILN7pKubBCOe0VN7vC4txcuSGuhj+IbXoQVvSL/9CwA9pq3BMLWvDTMV8
         MdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUQwHR2VNeOE5MlCJ+FwXuCGuTGwhtdasJmtn1jXdiM=;
        b=GVCm4WGevLHdPju9TTuZHDrl3xIksO0d/YjC7cp1kI2mxrH0fckQv/AqGTdAl/1opR
         haU8B+yjrs4CbfbklfE47q6eSwKuP8pXlALVE6LS6UsN0+7MI6ezLqp4VgLgNLSlgc3G
         xDS5DAqE5OHNOejmLbmI7yd4sFOaLHjR9fe2l+NiXeOXjYPrJBur90i12zYq5nK+zJH/
         MCoNV0vZKj2WIoVAHhx9Y/wDIJ4arc0iX3oMh70jOhvIqsJMI1qxLZN9tUIpeOHiE2U+
         6ofj1VUE+rDbj+cxEh/t73V8WZqj4GEyrVz55h9UzgLHbK84eV/D+kNPMZAA2sJ08Bnm
         FtsQ==
X-Gm-Message-State: APjAAAUVjR7woRDF1lNqAodQ24KZ5CeSWIAdJt27uvSgG54Oi3z/V5fC
        JAcAArFHBr09tDwdiZ/oFQ1YheNqFkWgDDGLet/x9g==
X-Google-Smtp-Source: APXvYqxq59dYK855wXF2UaGJJlas8QKc5gdt2Tmc79lygnKF06mh76NgaeqWYhNzCj+xE1WIeZANTXTtJj3hhk6vfL0=
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr62322314plm.3.1556557937999;
 Mon, 29 Apr 2019 10:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
In-Reply-To: <20190429165137.mwj4ehhwerunbef4@localhost>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 29 Apr 2019 10:12:06 -0700
Message-ID: <CAO=notwewAeeLz=LsOcSj=DakLGW0KjeDHALP5Nv2ckgkRqnFA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > >
> > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > Ack this version of the patchset since it changes when the soc/aspeed
> > > Makefile is followed.
> >
> > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > maintainers are free to take this.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I'm totally confused. This is the second "PATCH v2" of this patch that I came
> across, I already applied the first.

I think the issue here was that I added to the CC list another email
and so you may see the v2  without that mailing list, and a v2 with it
--

Does this require a v3?  I honestly didn't think so, but this was the
first time I had to add more people without needing other changes.

>
> Patrick: Follow up with incremental patch in case there's any difference.
> Meanwhile, please keep in mind that you're adding a lot of work for people when
> you respin patches without following up on the previous version. Thanks!

w.r.t this patch series.  I found an issue with v1, and released a v2
with the detail of what changed.  I thought that was the correct
approach.  I apologize for creating extra work, that's something
nobody needs.

>
>
> -Olof

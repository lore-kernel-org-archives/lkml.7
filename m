Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD0CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686D22419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3gchAZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfKTLzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:55:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728746AbfKTLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574250903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ/suR9lwab8Vmoit+8fApDfagM+XQzhiSMoLQs89Ks=;
        b=R3gchAZ4mjjf3pLWutObQwCzjHwgOuDb2q5SUPR1xdWCT3JOcVlVUIWsavgItXx0CraedU
        uGCvb4Gez4bE/RWEIr7JjV57Dl1AnBH8jgmRr9rDs/KFZRhsalfP/G2G9rKRz2i9u74AlW
        Y8BxE/4FTpzr3R+W9hD0POHV54zfIN0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-KROyP4iVN8yo-JYTPvQBZQ-1; Wed, 20 Nov 2019 06:54:59 -0500
Received: by mail-qv1-f72.google.com with SMTP id m43so16937931qvc.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXFyh8kBLvmSj4EaxcIf64KvYzB8eENY53AuUwLsMY8=;
        b=VE344bkhXajTjwy1HesoffG23XMtxqIafgd90g9jrfRGrIIPOp6JIbhBAtQNAPHGak
         0MOg9JoXlwhPd2gLJe9mH+xbpEMk0nnS22UtKk4ohEhiPLk/4fHH4j78np8BS9KkXyMv
         f1BQlTbMbnWTWT7DU9TqUHTWyMWwOs+XoI2Z1IDGiWcKcRW/AT33XPbFEd4M800oh957
         REf12hCDNnlrwPVi/ZiUjjF11biukxY/U7T2hVC2H3KOr74udgBm5NGMdRgR3EwCSBUF
         WZd2MsAPbEnZvrd5w+vEVAdIltJxtI121r3iH0fDkCo9YZSgShj9iVXydFSUfCl25Va1
         1Vhg==
X-Gm-Message-State: APjAAAVNCd/2adAecoB2aDmlRN31zZgatcyVT5BsPL6V2thMSNmHG7pq
        luKIJHJwXjsRd2zmkl7kbFSDaD05liYTgSXFJAdOWzHC150Xh2wNNH2WyJ4v+Zkc9cagG66MFJP
        DgCujRojyyjkyH+eqoXr2K6q1Pg1c30yHr8nokAkG
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147338qtc.254.1574250899268;
        Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgzPbhFAy1Wx/TLioNWRRw8v7Dky3juARvT+xkh08MnU9EQEHgjj6TnBsmHsTkQgM/Z6Vs1zzOXcqygfmJowM=
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147324qtc.254.1574250899096;
 Wed, 20 Nov 2019 03:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
In-Reply-To: <20191120115127.GD11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 12:54:48 +0100
Message-ID: <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: KROyP4iVN8yo-JYTPvQBZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for newer Windows the firmware uses bit  0x80 on 0x248 (Q0L2 being the
field name) on the bridge controller to turn of the device, on other
versions it uses the "older"? 0xb0 register and the P0LD field, which
is documented, where the former is not.

On Wed, Nov 20, 2019 at 12:51 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 01:22:16PM +0200, Mika Westerberg wrote:
> >             If (((OSYS <=3D 0x07D9) || ((OSYS =3D=3D 0x07DF) && (_REV =
=3D=3D
> >                 0x05))))
> >             {
>
> The OSYS comes from this (in DSDT):
>
>                 If (_OSI ("Windows 2009"))
>                 {
>                     OSYS =3D 0x07D9
>                 }
>
>                 If (_OSI ("Windows 2012"))
>                 {
>                     OSYS =3D 0x07DC
>                 }
>
>                 If (_OSI ("Windows 2013"))
>                 {
>                     OSYS =3D 0x07DD
>                 }
>
>                 If (_OSI ("Windows 2015"))
>                 {
>                     OSYS =3D 0x07DF
>                 }
>
> So I guess this particular check tries to identify Windows 7 and older,
> and Linux.
>
> >                 If ((PIOF =3D=3D Zero))
> >                 {
> >                     P0LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P0LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P0RM =3D One
> >                     P0AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D One))
> >                 {
> >                     P1LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P1LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P1RM =3D One
> >                     P1AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D 0x02))
> >                 {
> >                     P2LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P2LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P2RM =3D One
> >                     P2AP =3D 0x03
> >                 }
> >
> >                 If ((PBGE !=3D Zero))
> >                 {
> >                     If (SBDL (PIOF))
> >                     {
> >                         MBDL =3D GMXB (PIOF)
> >                         PDUB (PIOF, MBDL)
> >                     }
> >                 }
> >             }
> >             Else
> >             {
> >                 LKDS (PIOF)
> >             }
> >
> >             If ((DerefOf (SCLK [Zero]) !=3D Zero))
> >             {
> >                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
> >                 Sleep (0x10)
> >             }
> >
> >             GPPR (PIOF, Zero)
> >             If ((OSYS !=3D 0x07D9))
> >             {
> >                 DIWK (PIOF)
> >             }
> >
> >             \_SB.SGOV (0x01010004, Zero)
> >             Sleep (0x14)
> >             Return (Zero)
> >         }
>


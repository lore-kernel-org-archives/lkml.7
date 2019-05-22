Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417121473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNfDrv//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfEVTmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:42:00 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40421 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfEVTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:41:59 -0400
Received: by mail-yb1-f193.google.com with SMTP id g62so1321160ybg.7;
        Wed, 22 May 2019 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q19RztagPywupfj/J4DqX3LJhIyXp53CM3bbmnwAQI4=;
        b=UNfDrv//AipAlrKipQXskKoxdJ2WtyHM6zC+iXQvoSKDQ1xWXnw4KTXkT38SsmHf0v
         KIe58FwtZxyDiXkSfZ6M1RstrZLgPH2pQ8C7cPvGvGNym49DipYStwFJgW1yxQw9Thsx
         3qMvEXhUxNkLePzGsWh0whoKXODOhNRybDWn7sfS/Zydbv3kzTXg+AhDEfqLeagQBhoY
         gnR/j3HbggY7pTe+Ycz3AFsB4Dn3WV0jqtN3sjyrbZzdtDPUUStbBZMSL8O3NHW7Q1wK
         UYT8iWI8W15dz490WDuQErQYBf+B36yLyXTxFmeNfEjJFl3XgUAyx8MukKhh+Qw3BWa6
         deFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q19RztagPywupfj/J4DqX3LJhIyXp53CM3bbmnwAQI4=;
        b=Rz19czODH9iRHfF4M4ielDfNRshez/LeyWicCPvKWPO1bjgJK1x534SAKIUZDUPraT
         iADFH9XjoKn59HCAKvaEXPLIKUDcTHRWjOgFtRivfQJTqAOHQZtZkSDithOmKfDSRxjf
         +vsiYw2Xsssg/tlNrb17FJ+Hb4/I0uc6mEPNwVdJ70/4/ml6S6uPVi4JCP2lSr3aI6GW
         bLXtMTfHXWOIWnw538UJoAmsqHBeLUC0+zWM3SutDtVd5nKan57bP9tdzKCsS50tGSH3
         u3HSH8Oa/pnxyAKBTUEnm5kZQFlANkYudi1xqY1D2upH4Y2gjNhZa95ZVMnTbPKRuvyQ
         yYjg==
X-Gm-Message-State: APjAAAXdfVFzWG2b5tq57D/JmCekD9935ng6xAols4OMuFLLzSUG5IqK
        TBdPpMgDnHEgXEXVg2zTJ87WvbmBHG1nL+g1pZU=
X-Google-Smtp-Source: APXvYqw2xVvUgbCYG8yMU6wkqfSXTHCekPF2FBrZThkJBWJI1JX36gXbv5kknq16+qzBuCEjqhC/PD0it4+M3Z6X3Ac=
X-Received: by 2002:a25:138a:: with SMTP id 132mr41990542ybt.127.1558554117758;
 Wed, 22 May 2019 12:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 22 May 2019 21:41:46 +0200
Message-ID: <CAJiuCcdPXdG1ZcWypJZy_d04c2obEuqFZXna-voMmbK6Au84CA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 22 May 2019 at 21:27, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, May 21, 2019 at 11:11 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmai=
l.com> wrote:
> >
> > Hi,
> >
> > The Allwinner H6 has a Mali-T720 MP2 which should be supported by
> > the new panfrost driver. This series fix two issues and introduce the
> > dt-bindings but a simple benchmark show that it's still NOT WORKING.
> >
> > I'm pushing it in case someone want to continue the work.
> >
> > This has been tested with Mesa3D 19.1.0-RC2 and a GPU bitness patch[1].
> >
> > One patch is from Icenowy Zheng where I changed the order as required
> > by Rob Herring[2].
> >
> > Thanks,
> > Clement
> >
> > [1] https://gitlab.freedesktop.org/kszaq/mesa/tree/panfrost_64_32
> > [2] https://patchwork.kernel.org/patch/10699829/
> >
> >
> > [  345.204813] panfrost 1800000.gpu: mmu irq status=3D1
> > [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> > 0x0000000002400400
> > [  345.209617] Reason: TODO
> > [  345.209617] raw fault status: 0x800002C1
> > [  345.209617] decoded fault status: SLAVE FAULT
> > [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> > [  345.209617] access type 0x2: READ
> > [  345.209617] source id 0x8000
> > [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > status=3D0x8, head=3D0x2400400, tail=3D0x2400400, sched_job=3D000000009=
e204de9
> > [  346.055876] panfrost 1800000.gpu: mmu irq status=3D1
> > [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> > 0x0000000002C00A00
> > [  346.060680] Reason: TODO
> > [  346.060680] raw fault status: 0x810002C1
> > [  346.060680] decoded fault status: SLAVE FAULT
> > [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> > [  346.060680] access type 0x2: READ
> > [  346.060680] source id 0x8100
> > [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> > status=3D0x8, head=3D0x2c00a00, tail=3D0x2c00a00, sched_job=3D00000000b=
55a9a85
> > [  346.573913] panfrost 1800000.gpu: mmu irq status=3D1
> > [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> > 0x0000000002C00B80
> >
> > Change in v5:
> >  - Remove fix indent
> >
> > Changes in v4:
> >  - Add bus_clock probe
> >  - Fix sanity check in io-pgtable
> >  - Add vramp-delay
> >  - Merge all boards into one patch
> >  - Remove upstreamed Neil A. patch
> >
> > Change in v3 (Thanks to Maxime Ripard):
> >  - Reauthor Icenowy for her path
> >
> > Changes in v2 (Thanks to Maxime Ripard):
> >  - Drop GPU OPP Table
> >  - Add clocks and clock-names in required
> >
> > Cl=C3=A9ment P=C3=A9ron (5):
> >   drm: panfrost: add optional bus_clock
> >   iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
> >   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
> >   arm64: dts: allwinner: Add ARM Mali GPU node for H6
> >   arm64: dts: allwinner: Add mali GPU supply for H6 boards
> >
> > Icenowy Zheng (1):
> >   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
>
> I've applied patches 1 and 3 to drm-misc. I was going to do patch 4
> too, but it doesn't apply.

Thanks,

I have tried to applied on drm-misc/for-linux-next but it doesn't apply too=
.
It looks like commit d5ff1adb3809e2f74a3b57cea2e57c8e37d693c4 is
missing on drm-misc ?
https://github.com/torvalds/linux/commit/d5ff1adb3809e2f74a3b57cea2e57c8e37=
d693c4#diff-c3172f5d421d492ff91d7bb44dd44917

Cl=C3=A9ment

>
> Patch 2 can go in via the iommu tree and the rest via the allwinner tree.
>
> Rob

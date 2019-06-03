Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47594C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8DB23EEE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAN+/Qb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfFCR2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:28:04 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34558 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfFCR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:28:03 -0400
Received: by mail-yb1-f193.google.com with SMTP id x32so4322670ybh.1;
        Mon, 03 Jun 2019 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/CnmclOqeFitdxQUE9bLrTl+THj0klsLpLvs2FULiUc=;
        b=SAN+/Qb9AVqYn57ZhyRBvnABldr92BWgtJKUyDxZUVDegfg6Hg/wW2NTGAgFOnyE63
         dBdT9OM2aaDM6qQbtrdiPqk5pTS3O2IHLuGjFcdRja7a7i0/c34FEWldCJTns/IJpvML
         LM23y4Y5Aq2EIIUcvbR+MqqHW/tZb2ggEG5WnbMne3zHqowjYDxINP5TEoXckHWZzHwa
         JpOWMO78/dyuTFrkYsvQNXInVy8WqA6UHCjTZOT8K68WVsNdiGHozgliJY4ZTHfHdMni
         eq8JyMQ5/LtpsQeMS5Kn6VTelTQadx7VXG9B3JGK4unIGTZaycj9jjsTvfUEz89TGvAa
         2ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/CnmclOqeFitdxQUE9bLrTl+THj0klsLpLvs2FULiUc=;
        b=KhDm+fDDKNiEeAKrCI1rdcNCGK8Wgzwoobkrxi63htn5ta42cEQxEO8mrNQ3DmS5c1
         BggjAH4VoHJrGSaloSaC2BKVPuFwKa2NYjVu202TwXG2ABNS2BEkNnWMoBNNnrmNkgiP
         5jRYgUXuXgfL9B5s6YSwHj5jPWBbZxJtnM7fymaeY865FqWZWwf8dGb2zfmh/dTIDdG8
         eKeTYMPcx/fAWsyZtQ5bkYAWUqBj6Vbm/udlJWUGjJHqrDcP6l2jaLFKN940T7CQSJQc
         a1sNwk0q6VriQF25dqV6cY+mwicwtOAuupzPXwTkjxotTXXrlp49c11qCbUd7C9EUJKe
         oDng==
X-Gm-Message-State: APjAAAWIu2Xwz1Rom1N+arLBDOTMRB9md5ESXYmlIt09qAJl+sM6fYaM
        YbVzG+3jso6d+R5iNEqKV/m5tHz4Dp8YPoUsWOw=
X-Google-Smtp-Source: APXvYqwv36MV1EgjPM95jwDVnT/xOnPPHBe6w8IiRRT+qX6s8O/bgXKCVn5NKbfL9AQHj/f+E9bKbWM0yveHM2T4UZ4=
X-Received: by 2002:a25:ca8d:: with SMTP id a135mr9276509ybg.438.1559582882942;
 Mon, 03 Jun 2019 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 3 Jun 2019 19:27:51 +0200
Message-ID: <CAJiuCcchRZZ-Wwy3_fo_aq=GuCaCW8RHS8nBtB2br4n5Qtu-MA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Maxime, Joerg,

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
>
> Patch 2 can go in via the iommu tree and the rest via the allwinner tree.

Is this OK for you to pick up this series?

Thanks,
Cl=C3=A9ment

>
> Rob

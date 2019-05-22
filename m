Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB932C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5682075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554448;
	bh=hlAVIiOpRcQkmn1FUyVhG2T73UvpIg1zkjRYmBGZFbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bEt/WuCtW5JMtjRM/wTOu7II5w3bDCYzDkADPiCNS7FJXdgC/Z1L6qp8Efe8Y31bH
	 YWo+w+T9d9q9kh0fP46p+D4jLn0Kdi0CFDcGrO2XWYVU9jroyf8lOEwuSKGhn6K6YS
	 W8WsgzxgrXs32sSWvONU9H6rmDf6sgl0RwITQPzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfEVTr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731228AbfEVT1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:20 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5163217D9;
        Wed, 22 May 2019 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553240;
        bh=hlAVIiOpRcQkmn1FUyVhG2T73UvpIg1zkjRYmBGZFbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJ9rpfbd2rv6v3D4lAjk3XAx6LiuJ1QwweDrobD9sc2Rq9jjukvgLxtf9Z6bsyYvl
         h7svq0ygKqIntZoPr6aG5/rmJQzL4gL6dXYn/n/Kgb8bOsMZ2oq3/B6kedC79uwqyK
         z6dhugAon3gLUC97OTzeg0GfrOQs/ZoISnlsFDLg=
Received: by mail-qt1-f169.google.com with SMTP id i26so3809871qtr.10;
        Wed, 22 May 2019 12:27:19 -0700 (PDT)
X-Gm-Message-State: APjAAAVU/2A1WRw+JkuA+ygz+g9tfuhON6rfRTxfaNZbETtqXhEYT5D3
        wRTuXO/eoPm246JV1OBFHBfyv5nI1nNaDIy4Mw==
X-Google-Smtp-Source: APXvYqy+PeJM7o3ppEVTbfv/xeDCVQT0aKFYAppgCGRW5RshOFOrnfI1FkipG2N2RO8u2GCiHsgMEikYAzbvgjw3ptY=
X-Received: by 2002:ac8:7688:: with SMTP id g8mr48798907qtr.224.1558553239094;
 Wed, 22 May 2019 12:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 May 2019 14:27:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
Message-ID: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
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

On Tue, May 21, 2019 at 11:11 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com> wrote:
>
> Hi,
>
> The Allwinner H6 has a Mali-T720 MP2 which should be supported by
> the new panfrost driver. This series fix two issues and introduce the
> dt-bindings but a simple benchmark show that it's still NOT WORKING.
>
> I'm pushing it in case someone want to continue the work.
>
> This has been tested with Mesa3D 19.1.0-RC2 and a GPU bitness patch[1].
>
> One patch is from Icenowy Zheng where I changed the order as required
> by Rob Herring[2].
>
> Thanks,
> Clement
>
> [1] https://gitlab.freedesktop.org/kszaq/mesa/tree/panfrost_64_32
> [2] https://patchwork.kernel.org/patch/10699829/
>
>
> [  345.204813] panfrost 1800000.gpu: mmu irq status=3D1
> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002400400
> [  345.209617] Reason: TODO
> [  345.209617] raw fault status: 0x800002C1
> [  345.209617] decoded fault status: SLAVE FAULT
> [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> [  345.209617] access type 0x2: READ
> [  345.209617] source id 0x8000
> [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> status=3D0x8, head=3D0x2400400, tail=3D0x2400400, sched_job=3D000000009e2=
04de9
> [  346.055876] panfrost 1800000.gpu: mmu irq status=3D1
> [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002C00A00
> [  346.060680] Reason: TODO
> [  346.060680] raw fault status: 0x810002C1
> [  346.060680] decoded fault status: SLAVE FAULT
> [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> [  346.060680] access type 0x2: READ
> [  346.060680] source id 0x8100
> [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> status=3D0x8, head=3D0x2c00a00, tail=3D0x2c00a00, sched_job=3D00000000b55=
a9a85
> [  346.573913] panfrost 1800000.gpu: mmu irq status=3D1
> [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002C00B80
>
> Change in v5:
>  - Remove fix indent
>
> Changes in v4:
>  - Add bus_clock probe
>  - Fix sanity check in io-pgtable
>  - Add vramp-delay
>  - Merge all boards into one patch
>  - Remove upstreamed Neil A. patch
>
> Change in v3 (Thanks to Maxime Ripard):
>  - Reauthor Icenowy for her path
>
> Changes in v2 (Thanks to Maxime Ripard):
>  - Drop GPU OPP Table
>  - Add clocks and clock-names in required
>
> Cl=C3=A9ment P=C3=A9ron (5):
>   drm: panfrost: add optional bus_clock
>   iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
>   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
>   arm64: dts: allwinner: Add mali GPU supply for H6 boards
>
> Icenowy Zheng (1):
>   dt-bindings: gpu: add bus clock for Mali Midgard GPUs

I've applied patches 1 and 3 to drm-misc. I was going to do patch 4
too, but it doesn't apply.

Patch 2 can go in via the iommu tree and the rest via the allwinner tree.

Rob

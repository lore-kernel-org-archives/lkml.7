Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3491C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776BA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEC2jSav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfEOWF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 18:05:29 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38551 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:05:28 -0400
Received: by mail-yb1-f195.google.com with SMTP id a13so446627ybm.5;
        Wed, 15 May 2019 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CRLT4dWLqRM/ZZXMmXCwJjTergOTF43/E2BM9syTfec=;
        b=TEC2jSavzL2UXeNecfQHwh5fEdAYfPrVsB5TUZSIjXTlEy/XMjzap00vwXGrAXJNCu
         1rZH1zpLlX+fiSILnyzkYKogPili3LUPUqZlBHWgUNWRgGdUWxiahptHUH4op3nfP+Je
         cslfDPSVPO9iJzXT97wesUC05nqssX6QntLh5Er/na7dCAMgCryIi+tYdiYLR2RBxLbX
         0mfT0WyZ8IAcKFR95Z1yj+N7D8uv5d6D7yiyqgA7UbJtBUErfeKf3i9Jagu7tkTkbwMq
         7SDOvVvA3W58q45RihuofjyRCP+0lF8yn3qCA5SLkbuaJ0BMdREozcBo8hQnYSdYNbxk
         kJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CRLT4dWLqRM/ZZXMmXCwJjTergOTF43/E2BM9syTfec=;
        b=XrDTjeybR2xONUn9yvNcEwpuBCOegVAvxFuj2dLuhyFU4/4Hd8tEP73HyBM9xfa336
         mhBjUVuAbnvoQc7pgfwkUBAjHrnRJvEHbtyIuhbuXSuEo3axcT9vjHJTXYowvkysgnh+
         fbZW/ErPef315EnN+h7f91GeDf65W7XHYhtL2UpMibnD5zNzGUd51cA4YGxVKLqDGUHH
         l8doBd6fHDFh+L1gd52pTpeDswEgKFfZjgxsWUzdYVGoaxxY4LaZxQG4gUwUeX3GvnUX
         2a43ETS7H+r1pfLSs1WcQ9B93/TrZSRYuzGCuKoEpTPju3B8yhyFrR4Cw2OUAUU90f5V
         V6gQ==
X-Gm-Message-State: APjAAAXgj+1tRJiu1Eip0Dv8OtWpgRSkzG5sj3BVjee5M13AolVVY6Xj
        0Gxg7NFngKoJeh90At2cUENrUIYZeZk/LndS5mk=
X-Google-Smtp-Source: APXvYqxrAbiIbqW0nY/30IRpEN/mBAD3Cr2+703do+Kjwf4nMSeAa8lvtwfBa46a9dMgdGFQfwf/A6iw0Obgy4PWLfg=
X-Received: by 2002:a25:9b88:: with SMTP id v8mr21245291ybo.153.1557957927657;
 Wed, 15 May 2019 15:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190513151405.GW17751@phenom.ffwll.local>
 <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com> <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
 <CAJiuCccWa5UTML68JDQq6q8SyNZzVWwQWTOL=+84Bh4EMHGC3A@mail.gmail.com> <3c2c9094-69d4-bace-d5ee-c02b7f56ac82@arm.com>
In-Reply-To: <3c2c9094-69d4-bace-d5ee-c02b7f56ac82@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 16 May 2019 00:05:16 +0200
Message-ID: <CAJiuCcd=gCQJ4mxn3wNhHXveOhFLnYSEs+cnOMHcALPvd7bQZw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, 14 May 2019 at 23:57, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2019-05-14 10:22 pm, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > On Tue, 14 May 2019 at 17:17, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.com>=
 wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 13/05/2019 17:14, Daniel Vetter wrote:
> >>>> On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote=
:
> >>>>> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> >>>>> out-of-tree so this series only introduce the dt-bindings.
> >>>>
> >>>> We do have an in-tree midgard driver now (since 5.2). Does this stuf=
f work
> >>>> together with your dt changes here?
> >>>
> >>> No, but it should be easy to add.
> >> I will give it a try and let you know.
> > Added the bus_clock and a ramp delay to the gpu_vdd but the driver
> > fail at probe.
> >
> > [    3.052919] panfrost 1800000.gpu: clock rate =3D 432000000
> > [    3.058278] panfrost 1800000.gpu: bus_clock rate =3D 100000000
> > [    3.179772] panfrost 1800000.gpu: mali-t720 id 0x720 major 0x1
> > minor 0x1 status 0x0
> > [    3.187432] panfrost 1800000.gpu: features: 00000000,10309e40,
> > issues: 00000000,21054400
> > [    3.195531] panfrost 1800000.gpu: Features: L2:0x07110206
> > Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
> > JS:0x7
> > [    3.207178] panfrost 1800000.gpu: shader_present=3D0x3 l2_present=3D=
0x1
> > [    3.238257] panfrost 1800000.gpu: Fatal error during GPU init
> > [    3.244165] panfrost: probe of 1800000.gpu failed with error -12
> >
> > The ENOMEM is coming from "panfrost_mmu_init"
> > alloc_io_pgtable_ops(ARM_MALI_LPAE, &pfdev->mmu->pgtbl_cfg,
> >                                           pfdev);
> >
> > Which is due to a check in the pgtable alloc "cfg->ias !=3D 48"
> > arm-lpae io-pgtable: arm_mali_lpae_alloc_pgtable cfg->ias 33 cfg->oas 4=
0
> >
> > DRI stack is totally new for me, could you give me a little clue about
> > this issue ?
>
> Heh, this is probably the one bit which doesn't really count as "DRI stac=
k".
>
> That's merely a somewhat-conservative sanity check - I'm pretty sure it
> *should* be fine to change the test to "cfg->ias > 48" (io-pgtable
> itself ought to cope). You'll just get to be the first to actually test
> a non-48-bit configuration here :)

Thanks a lot, the probe seems fine now :)

I try to run glmark2 :
# glmark2-es2-drm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    glmark2 2017.07
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    OpenGL Information
    GL_VENDOR:     panfrost
    GL_RENDERER:   panfrost
    GL_VERSION:    OpenGL ES 2.0 Mesa 19.1.0-rc2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[build] use-vbo=3Dfalse:

But it seems that H6 is not so easy to add :(.

[  345.204813] panfrost 1800000.gpu: mmu irq status=3D1
[  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002400400
[  345.209617] Reason: TODO
[  345.209617] raw fault status: 0x800002C1
[  345.209617] decoded fault status: SLAVE FAULT
[  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  345.209617] access type 0x2: READ
[  345.209617] source id 0x8000
[  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
status=3D0x8, head=3D0x2400400, tail=3D0x2400400, sched_job=3D000000009e204=
de9
[  346.055876] panfrost 1800000.gpu: mmu irq status=3D1
[  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002C00A00
[  346.060680] Reason: TODO
[  346.060680] raw fault status: 0x810002C1
[  346.060680] decoded fault status: SLAVE FAULT
[  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  346.060680] access type 0x2: READ
[  346.060680] source id 0x8100
[  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
status=3D0x8, head=3D0x2c00a00, tail=3D0x2c00a00, sched_job=3D00000000b55a9=
a85
[  346.573913] panfrost 1800000.gpu: mmu irq status=3D1
[  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002C00B80
[  346.578707] Reason: TODO
[  346.578707] raw fault status: 0x800002C1
[  346.578707] decoded fault status: SLAVE FAULT
[  346.578707] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  346.578707] access type 0x2: READ
[  346.578707] source id 0x8000
[  347.073947] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
status=3D0x8, head=3D0x2c00b80, tail=3D0x2c00b80, sched_job=3D00000000cf6af=
8e8
[  347.104125] panfrost 1800000.gpu: mmu irq status=3D1
[  347.108930] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002800900
[  347.108930] Reason: TODO
[  347.108930] raw fault status: 0x810002C1
[  347.108930] decoded faultn thi status: SLAVE FAULT
[  347.108930] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  347.108930] access type 0x2: READ
[  347.108930] source id 0x8100
[  347.617950] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
status=3D0x8, head=3D0x2800900, tail=3D0x2800900, sched_job=3D000000009325f=
db7
[  347.629902] panfrost 1800000.gpu: mmu irq status=3D1
[  347.634696] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002800A80

Regards,
Clement

>
> Robin.

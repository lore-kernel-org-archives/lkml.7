Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEDDC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714BA216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OstiajoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEYTu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:50:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38887 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfEYTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:50:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so13079756wrs.5;
        Sat, 25 May 2019 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcYPCLZRiQ5K7DYB5WujiUGNLt4GcC2QMNo60dWqOik=;
        b=OstiajoXFzr8xn1GWXjVng2KUZPv1FpE26rnp+DZLjVAPoxD7Byqr11XQpCq8jTUzf
         Y1XDFCZ4Pu/99whHMyYu3EXOhEob5zAGVnJ2DS585qYBWvy6RTBDueIFeMMVp3CCFFB+
         6tDXPN8F1GdJDM42tpq66M+t/D3oe2j7klsnZkwmo47Qg+sUNZUcVgZAI1lbcEoMjLOF
         ds+diH1HvlA6W2geXXowspcUfv9Rd8vE1BBgGcJ9Xe6Vdv3ECO5LJI6BINSqAOtxbUHO
         m4+4X0BA6EjZV0FE3b3DL7jxfNuddAdQja7UZ/0o0KLsMMnOqtSYa20L5QXvRII02uHF
         AQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcYPCLZRiQ5K7DYB5WujiUGNLt4GcC2QMNo60dWqOik=;
        b=ZnyzjECUFxLVYxId4Oc4FV8jciSso/JUXbjSgY0Je3EFAfqE3iGuwBfCVGIOLu7kPO
         9Ri9cFqTiRF0SdUFp5XFO64YLP662QstohxmkeZ8cwx39BaJvAN+Gk/J8El2FwZS0XrV
         13GfnKB1g20r5GK5JYK+crB1q0/wlIxAMSNzKJomEN3lbB34GY/8ZRrXnjFNVdUyFqQB
         RRuysiH5jxzW6UtttwjryO5wFexk7VND9DjvrsveX3emyNCPkF7BlSDsLG67CChEAId8
         2W8f5OTKfs9y6vyG5c46Gbom6Z6VyRVczl82NejGEA1XzteCEASjfIa79fY37RZ96ziU
         lAaA==
X-Gm-Message-State: APjAAAVP5i6rt+Rqwfq/EKw/U1ZheYBWsT1IkxVrmprAgqT7iMAh91SI
        FFm9WkQhsKp/NcXOIfoL/9I=
X-Google-Smtp-Source: APXvYqz1Hc3st2m4yyaJ9QXusSb5WMHqrM7kgmyyrpaFPx9sCy5y1AsOTj+npZi0tXjPz1nzPZ0YgA==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr10319702wrn.127.1558813855045;
        Sat, 25 May 2019 12:50:55 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id t17sm3704510wmj.7.2019.05.25.12.50.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 12:50:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, robin.murphy@arm.com
Cc:     Rob Herring <rob.e.herring@gmail.com>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
Date:   Sat, 25 May 2019 21:50:51 +0200
Message-ID: <259803076.m90EgR4Zsz@jernej-laptop>
In-Reply-To: <e8618889-9b22-7f9f-7451-3c08a80a0f9b@arm.com>
References: <20190512174608.10083-1-peron.clem@gmail.com> <CAC=3edbn1yXih5vP0SwsDkqRB0j5q0c4FL0jhCq9DQ9Wt2-hAA@mail.gmail.com> <e8618889-9b22-7f9f-7451-3c08a80a0f9b@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne =C4=8Detrtek, 16. maj 2019 ob 13:19:06 CEST je Robin Murphy napisal(a):
> On 16/05/2019 00:22, Rob Herring wrote:
> > On Wed, May 15, 2019 at 5:06 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com>=20
wrote:
> >> Hi Robin,
> >>=20
> >> On Tue, 14 May 2019 at 23:57, Robin Murphy <robin.murphy@arm.com> wrot=
e:
> >>> On 2019-05-14 10:22 pm, Cl=C3=A9ment P=C3=A9ron wrote:
> >>>> Hi,
> >>>>=20
> >>>> On Tue, 14 May 2019 at 17:17, Cl=C3=A9ment P=C3=A9ron <peron.clem@gm=
ail.com>=20
wrote:
> >>>>> Hi,
> >>>>>=20
> >>>>> On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.c=
om>=20
wrote:
> >>>>>> Hi,
> >>>>>>=20
> >>>>>> On 13/05/2019 17:14, Daniel Vetter wrote:
> >>>>>>> On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com=20
wrote:
> >>>>>>>> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>>>>>>>=20
> >>>>>>>> Hi,
> >>>>>>>>=20
> >>>>>>>> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> >>>>>>>> out-of-tree so this series only introduce the dt-bindings.
> >>>>>>>=20
> >>>>>>> We do have an in-tree midgard driver now (since 5.2). Does this
> >>>>>>> stuff work
> >>>>>>> together with your dt changes here?
> >>>>>>=20
> >>>>>> No, but it should be easy to add.
> >>>>>=20
> >>>>> I will give it a try and let you know.
> >>>>=20
> >>>> Added the bus_clock and a ramp delay to the gpu_vdd but the driver
> >>>> fail at probe.
> >>>>=20
> >>>> [    3.052919] panfrost 1800000.gpu: clock rate =3D 432000000
> >>>> [    3.058278] panfrost 1800000.gpu: bus_clock rate =3D 100000000
> >>>> [    3.179772] panfrost 1800000.gpu: mali-t720 id 0x720 major 0x1
> >>>> minor 0x1 status 0x0
> >>>> [    3.187432] panfrost 1800000.gpu: features: 00000000,10309e40,
> >>>> issues: 00000000,21054400
> >>>> [    3.195531] panfrost 1800000.gpu: Features: L2:0x07110206
> >>>> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
> >>>> JS:0x7
> >>>> [    3.207178] panfrost 1800000.gpu: shader_present=3D0x3 l2_present=
=3D0x1
> >>>> [    3.238257] panfrost 1800000.gpu: Fatal error during GPU init
> >>>> [    3.244165] panfrost: probe of 1800000.gpu failed with error -12
> >>>>=20
> >>>> The ENOMEM is coming from "panfrost_mmu_init"
> >>>> alloc_io_pgtable_ops(ARM_MALI_LPAE, &pfdev->mmu->pgtbl_cfg,
> >>>>=20
> >>>>                                            pfdev);
> >>>>=20
> >>>> Which is due to a check in the pgtable alloc "cfg->ias !=3D 48"
> >>>> arm-lpae io-pgtable: arm_mali_lpae_alloc_pgtable cfg->ias 33 cfg->oas
> >>>> 40
> >>>>=20
> >>>> DRI stack is totally new for me, could you give me a little clue abo=
ut
> >>>> this issue ?
> >>>=20
> >>> Heh, this is probably the one bit which doesn't really count as "DRI
> >>> stack".
> >>>=20
> >>> That's merely a somewhat-conservative sanity check - I'm pretty sure =
it
> >>> *should* be fine to change the test to "cfg->ias > 48" (io-pgtable
> >>> itself ought to cope). You'll just get to be the first to actually te=
st
> >>> a non-48-bit configuration here :)
> >>=20
> >> Thanks a lot, the probe seems fine now :)
> >>=20
> >> I try to run glmark2 :
> >> # glmark2-es2-drm
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>=20
> >>      glmark2 2017.07
> >>=20
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>=20
> >>      OpenGL Information
> >>      GL_VENDOR:     panfrost
> >>      GL_RENDERER:   panfrost
> >>      GL_VERSION:    OpenGL ES 2.0 Mesa 19.1.0-rc2
> >>=20
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> [build] use-vbo=3Dfalse:
> >>=20
> >> But it seems that H6 is not so easy to add :(.
> >>=20
> >> [  345.204813] panfrost 1800000.gpu: mmu irq status=3D1
> >> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002400400
> >> [  345.209617] Reason: TODO
> >> [  345.209617] raw fault status: 0x800002C1
> >> [  345.209617] decoded fault status: SLAVE FAULT
> >> [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> >> [  345.209617] access type 0x2: READ
> >> [  345.209617] source id 0x8000
> >> [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> >> status=3D0x8, head=3D0x2400400, tail=3D0x2400400, sched_job=3D00000000=
9e204de9
> >> [  346.055876] panfrost 1800000.gpu: mmu irq status=3D1
> >> [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002C00A00
> >> [  346.060680] Reason: TODO
> >> [  346.060680] raw fault status: 0x810002C1
> >> [  346.060680] decoded fault status: SLAVE FAULT
> >> [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> >> [  346.060680] access type 0x2: READ
> >> [  346.060680] source id 0x8100
> >> [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> >> status=3D0x8, head=3D0x2c00a00, tail=3D0x2c00a00, sched_job=3D00000000=
b55a9a85
> >> [  346.573913] panfrost 1800000.gpu: mmu irq status=3D1
> >> [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002C00B80
> >> [  346.578707] Reason: TODO
> >> [  346.578707] raw fault status: 0x800002C1
> >> [  346.578707] decoded fault status: SLAVE FAULT
> >> [  346.578707] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> >> [  346.578707] access type 0x2: READ
> >> [  346.578707] source id 0x8000
> >> [  347.073947] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> >> status=3D0x8, head=3D0x2c00b80, tail=3D0x2c00b80, sched_job=3D00000000=
cf6af8e8
> >> [  347.104125] panfrost 1800000.gpu: mmu irq status=3D1
> >> [  347.108930] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002800900
> >> [  347.108930] Reason: TODO
> >> [  347.108930] raw fault status: 0x810002C1
> >> [  347.108930] decoded faultn thi status: SLAVE FAULT
> >> [  347.108930] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> >> [  347.108930] access type 0x2: READ
> >> [  347.108930] source id 0x8100
> >> [  347.617950] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> >> status=3D0x8, head=3D0x2800900, tail=3D0x2800900, sched_job=3D00000000=
9325fdb7
> >> [  347.629902] panfrost 1800000.gpu: mmu irq status=3D1
> >> [  347.634696] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002800A80
> >=20
> > Is this 32 or 64 bit userspace? I think 64-bit does not work with
> > T7xx. You might need this[1].
>=20
> [ Oooh... that makes T620 actually do stuff without falling over
> dereferencing VA 0 somewhere halfway through the job chain :D
>=20
> I shall continue to play... ]
>=20
> > You may also be the first to try T720,
> > so it could be something else.
>=20
> I was expecting to see a similar behaviour to my T620 (which I now
> assume was down to 64-bit job descriptors sort-of-but-not-quite working)
> but this does look a bit more fundamental - the fact that it's a level 1
> fault with VA =3D=3D head =3D=3D tail suggests to me that the MMU can't s=
ee the
> page tables at all to translate anything. I really hope that the H6 GPU
> integration doesn't suffer from the same DMA offset as the Allwinner
> display pipeline stuff, because that would be a real pain to support in
> io-pgtable.

DMA offset is present only on early SoCs with DE1. DE2 and DE3 (used on H6)=
=20
have no offset.

Best regards,
Jernej




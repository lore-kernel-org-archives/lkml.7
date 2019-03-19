Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7550C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A509520854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUtPNKeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCSEEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:04:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36361 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCSEEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:04:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id t206so14917354oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FxCVDx55J5+kHcmuGv45W+ZaMNUOkLZNHsAkDDnq18Y=;
        b=lUtPNKeKZSbonGnF8TWMGUP5R50nabnObsEyuWBm2wlpnICkYv1bxByYTQo1ni9g5L
         uT6pHpO4tfkpwVwJVzo5QW10t5sdhnz2fEPPoVZ47nhCWVgoHjKXiafM6Da/LajgJ6rv
         szrISKo2UA/FiqxWwFyMsx3vM7LIn+54RYES8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FxCVDx55J5+kHcmuGv45W+ZaMNUOkLZNHsAkDDnq18Y=;
        b=jMEGeLtHWuLGlotQbazYnKGQEYpN/1lrX5ItFLgNNaKCCVQSJIPX2P+CVMe/HpY71G
         zPhaVhYp90ldSp4Xq/pLCgU9EWEvotcCanvJlCfL+Z1d77IHTYpEFdb1Kpa3PVsEwmHB
         i69vxUhN0efB2VFQfBegf0W64da0XDxMqtODsk6A/rFBU5U4eiqMakuQgWckEtScM7gq
         UvHaA8JzXb/Ls+lvAi0eVdA2KVT07YWKRTbYgre/6RMJ30tTq2EV1qF4IKlu5YWZzqXI
         cOt1u4ZLWRDt3SgbyFrpu79i5GonSlaWNvHiz6SB0twrPmSYdz7l6x/uLu4O6ZAsl7lc
         kWbw==
X-Gm-Message-State: APjAAAWrHb/DS45J2mVHGOXYAWOK/l+bdaCVcrO+MAZXaN6xB9loh0sm
        M0TAEcsXO8lZqEtbWo6tuXJz6iuz/kU=
X-Google-Smtp-Source: APXvYqxR1NoQEYJhaSnuzEWvymWIHltZBq2KnJvY9CFBbjW0LAQ9KC8/d5Vt3+p9trSM5DEk7GH1JQ==
X-Received: by 2002:aca:45c4:: with SMTP id s187mr185490oia.20.1552968251480;
        Mon, 18 Mar 2019 21:04:11 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id a4sm4953197otc.21.2019.03.18.21.04.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 21:04:10 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 103so1120772otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 21:04:10 -0700 (PDT)
X-Received: by 2002:a05:6830:11c9:: with SMTP id v9mr257310otq.288.1552968250036;
 Mon, 18 Mar 2019 21:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.f011581516bfe7650c9d4c6054bb828e6227e309.1551964740.git-series.maxime.ripard@bootlin.com>
 <1d374e71ffcc396b71461ea916cac3d957f8d86c.1551964740.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AKXz5QmqnSEkChf8DqPkhEuUQg--q9dZKPmB1kBR1hzA@mail.gmail.com>
 <20190313153130.hnp5eybcgjm34i4n@flea> <CAAFQd5BeiGVvDcZTFVYg_Qbw1NxRcWFybW2FcDGE=ohFWHFbYA@mail.gmail.com>
 <20190318154700.4qks2qfxown2frgk@flea>
In-Reply-To: <20190318154700.4qks2qfxown2frgk@flea>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 19 Mar 2019 13:03:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D29vnxoX7Xd890_KYHdptL7NpMbhv1Jmbzibt1T4cx0g@mail.gmail.com>
Message-ID: <CAAFQd5D29vnxoX7Xd890_KYHdptL7NpMbhv1Jmbzibt1T4cx0g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:47 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Mar 14, 2019 at 01:13:33PM +0900, Tomasz Figa wrote:
> > On Thu, Mar 14, 2019 at 12:31 AM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi Tomasz,
> > >
> > > On Fri, Mar 08, 2019 at 03:12:18PM +0900, Tomasz Figa wrote:
> > > > > +.. _v4l2-mpeg-h264:
> > > > > +
> > > > > +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``
> > > > > +    Specifies the sequence parameter set (as extracted from the
> > > > > +    bitstream) for the associated H264 slice data. This includes=
 the
> > > > > +    necessary parameters for configuring a stateless hardware de=
coding
> > > > > +    pipeline for H264.  The bitstream parameters are defined acc=
ording
> > > > > +    to :ref:`h264`. Unless there's a specific comment, refer to =
the
> > > > > +    specification for the documentation of these fields, section=
 7.4.2.1.1
> > > > > +    "Sequence Parameter Set Data Semantics".
> > > >
> > > > I don't see this section being added by this patch. Where does it c=
ome from?
> > >
> > > This is referring to the the H264 spec itself, as I was trying to
> > > point out with the reference in that paragraph. How would you write
> > > this down to make it more obvious?
> > >
> >
> > Aha, somehow it didn't come to my mind when reading it. How about
> > something like below?
> >
> > Unless there is a specific comment, refer to the ITU-T Rec. H.264
> > specification, section "7.4.2.1.1 Sequence parameter set data semantics=
"
> > (as of the 04/2017 edition).
>
> The :ref:`h264` currently expands to "ITU H.264", which means in the
> documentation, in the case above, it ends up as
>
>  The bitstream parameters are defined according to ITU H.264. Unless
>  there=E2=80=99s a specific comment, refer to the specification for the
>  documentation of these fields, section 7.4.2.1.1 =E2=80=9CSequence Param=
eter
>  Set Data Semantics=E2=80=9D.
>
> I could change the reference to have "ITU-T Rec. H.264 Specification
> (04/2017 Edition)". Would that work for you?
>

Sounds good to me.

How about tweaking the text a bit too?

The bitstream parameters are defined according to ITU-T Rec. H.264
Specification (04/2017 Edition), section 7.4.2.1.1 =E2=80=9CSequence Parame=
ter
Set Data Semantics=E2=80=9D. For further documentation, refer to the above
specification, unless there is an explicit comment stating otherwise.

Best regards,
Tomasz

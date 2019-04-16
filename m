Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AE7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FM5V4Py8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfDPHYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:24:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40549 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfDPHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:24:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so16746634otp.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GfJbj3592HFAwS7sdfwgYwNJSeaElGORqUj9VQPS7Yc=;
        b=FM5V4Py8RkZJGeFFHn6B/aweYNJj0IZn6J4x5pKCTEqYobR2ZiIVwa7CGqqMPoLvQy
         FtRSkcnwY3aFDLVjJy/ByhOPFWptPIPutAc7gnB/bGJJOx/ifAppTL2QAupL/NsWIRSp
         X/b+VKIiAHHwFIJAYOIZmi45AJ+ZYUkjiwYaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GfJbj3592HFAwS7sdfwgYwNJSeaElGORqUj9VQPS7Yc=;
        b=kl7zd0P0lRauic7TryDMPkYu+/llYhtqy6rdFMFd/Vq2tl12FFlYPkEGBOXly8Vh+O
         UkxLTRUKViINrEQJ3YjLRVyPaYnEBePomYHx9ychEcViVxwlF8hCHPCY0XJEMIWfTBFt
         U8nLT1ex3TW3jmBdskE4twUH+lFYc7wdyIrdvqVJBsAohsWSpXvYXFDAYoi83AygPSyY
         ThjSY7cBtNFgq0LWr9kYcYyZPCgXXaqMzMVlts7y1ZIDtgAo1eZjQCx4uxiRftQ6ak9c
         ipde899FP5prLSLyJg8qqpkzOrbh2U9d4eZWQGN0tXpZqiQG4Dc3V3sV1kdoM4YTnkP5
         u/fQ==
X-Gm-Message-State: APjAAAVFfiXltDHPp2FNf0NiMT+1eGAL1YiKhCTAWSBgf7C6UFBaIH2a
        nm6b6Ip6i0sfZ7vfdeWQDooXR3Otfkc=
X-Google-Smtp-Source: APXvYqyNLJhh2tZEnaVExG2sWCxf74YH72CdrJxaVCmhTjm/bb2xpujxl8LiGnBYJ+shszEs45Tk2w==
X-Received: by 2002:a9d:6187:: with SMTP id g7mr49148720otk.2.1555399489203;
        Tue, 16 Apr 2019 00:24:49 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id q9sm20359305oti.78.2019.04.16.00.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 00:24:49 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id o74so16761988ota.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:24:48 -0700 (PDT)
X-Received: by 2002:a9d:57c2:: with SMTP id q2mr48272947oti.313.1555399021608;
 Tue, 16 Apr 2019 00:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
 <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
 <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
 <20190405151552.biesirbs35uivk7d@flea> <05078223a4098c96f6260f77e9ef2a01b966daa6.camel@collabora.com>
 <20190411155749.crdpidehjxa6edya@flea>
In-Reply-To: <20190411155749.crdpidehjxa6edya@flea>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 16 Apr 2019 16:16:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cz-N-7YdwVbtF9yX3LgDtG0yqD0sw6w9r47_m086=b-A@mail.gmail.com>
Message-ID: <CAAFQd5Cz-N-7YdwVbtF9yX3LgDtG0yqD0sw6w9r47_m086=b-A@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:57 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Fri, Apr 05, 2019 at 12:27:48PM -0400, Nicolas Dufresne wrote:
> > Le vendredi 05 avril 2019 =C3=A0 17:15 +0200, Maxime Ripard a =C3=A9cri=
t :
> > > Hi Nicolas,
> > >
> > > On Thu, Apr 04, 2019 at 11:41:13AM -0400, Nicolas Dufresne wrote:
> > > > > > > +    * - __u16
> > > > > > > +      - ``pic_width_in_mbs_minus1``
> > > > > > > +      -
> > > > > > > +    * - __u16
> > > > > > > +      - ``pic_height_in_map_units_minus1``
> > > > > > > +      -
> > > > > >
> > > > > > We recently had some reflection with Alex that this is redundan=
t with
> > > > > > the width and height in the OUTPUT format. It may also apply to=
 some
> > > > > > other fields in these structs. I feel like they should be remov=
ed and
> > > > > > passed via corresponding generic V4L2 properties - format, sele=
ction,
> > > > > > etc.
> > > > > >
> > > > > > The same problem is also present in the MPEG2 controls. In fact=
, there
> > > > > > was a patch already which used some fields from the controls to
> > > > > > calculate the destination buffer strides, rather than bytesperl=
ine in
> > > > > > the format.
> > > > > >
> > > > > > Since we're in staging, it could be done with a follow-up patch=
, though.
> > > > >
> > > > > Just my two cents. I played with some codecs a while back. IIRC s=
ome
> > > > > specify a "codec" size in addition to the actual picture size, li=
ke
> > > > > when the encoder does padding to fit the requirements of the code=
c
> > > > > (spec). Is this needed anywhere?
> > > >
> > > > With state-less encoders, the headers, which contains the crop
> > > > information is created by userspace and for state less decoder, the
> > > > headers that contains this information is parsed by userspace. So I
> > > > believe that in theory, the accelerator does not strictly need to b=
e
> > > > aware of the cropped dimensions.
> > > >
> > > > Another thing, is that there is not guarantied matches between e.g.
> > > > depth of the chrome/luma and the final image buffers. Some hardware=
 may
> > > > have bandwidth limitation or internal converter and could possibly
> > > > decode 10bit data into 8bit buffers.
> > > >
> > > > A third reason why I would not try and encode this header informati=
on
> > > > is that there can be multiple PPS/SPS at the same time, and I think
> > > > it's confusing if the relevant information to differentiate them is
> > > > removed.
> > >
> > > Sorry if that sounds a bit dumb, but it's not really clear to me if
> > > you're arguing for the removal of the data as Tomasz suggests, or if
> > > you want to keep them.
> > >
> > > The first paragrah seems to advocate for the former, but the two
> > > others for the latter.
> >
> > I think the data should stay. As I said, there can be multiple SPS/PPS,
> > while there is only one format. That being said, how does SPS/PPS
> > activation works ? How do you tell the driver about all the SPS/PPS and
> > which one is being activated ?
>
> The current way of dealing with this is that the _SLICE_PARAMS control
> actually takes an array of SPS's. And same thing for PPS.
>
> There's no difference between activated and deactivated ones
> though. What is the use case for this?

Uhm, there is only one format, but so there is only one active
SPS/PPS, isn't it?

An alternative would be to just make the OUTPUT format a function of
the currently set controls, so that it would always match the active
PPS/SPS, without the ability for the application to change it.

I just want to avoid the case when the OUTPUT format can be set
randomly to something different than in the stream and also drivers
reading randomly the format-related information sometimes from the
controls and sometimes from the format state.

Best regards,
Tomasz

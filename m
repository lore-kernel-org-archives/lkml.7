Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96276C73C7F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4720651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IXgXXgvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfGJIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:24:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44050 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfGJIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:24:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so1316197edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nVtz/RtjwCEYdQFLJCW6G4ORFWnvHXCMUmZJUUl1vhA=;
        b=IXgXXgvXPtimF3q16gy1j+I8+arnl9Bg8UFUc7zPylYDNgUcqEsKezdXlSkr8TinyM
         RP3PPF87dV6otolRQcTPjk7kghAfb6pWq1K46lzseOnIq4tZl7XjeLRTMmGa5VQ/E/I2
         w9tPkxOIQyi2ZWBT0spXNJI/M92dIJI5K3O34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nVtz/RtjwCEYdQFLJCW6G4ORFWnvHXCMUmZJUUl1vhA=;
        b=AOitdTJKzz8r/FCYQ7OFMYA0Z+y2LDkhqS7GK4Nd3Gd5EFw8WP8BAOEA8zbA+wLEzT
         gVRaaWRfQcgWn6tLJuRPxt1FjgCs5k60B9s1PKyt0UKpVL0p0heURnW5MP8A/0Wfg8mC
         2gVEtI7DZl27XnzRgBMNPYMhkiEDbC8657J7CfhncHA50tcy778BOg39IYmZQmXOdH4a
         7+BW4U7WymMnZSWI52SIpqLSo5AfZTmpGuNVopHyNfVgOUeA4lY/xnhIkMgD3dZ0i3v/
         sBZTiRSKFe3dAy1mLDEtHMGDMffLtHp4Y6utHwFwb2v2Dfb9M5BixZjpA1zQDl9NkszO
         Op4Q==
X-Gm-Message-State: APjAAAVKotxCAZwfWvkaTIMMlbh2iQYF6NmppioG1NAOD/m6Wo1shZLb
        Qqrywq4kuqj9xGtcw5B8IWltij8EsWXQ5Q==
X-Google-Smtp-Source: APXvYqz+8s7vb+fM6RkeSrinxagD0OcWpzQo+svTQh9jVzOsJSqhf8D49oQXLrUNxvljgD4yXnx6ng==
X-Received: by 2002:a50:a5b7:: with SMTP id a52mr30385886edc.237.1562747046716;
        Wed, 10 Jul 2019 01:24:06 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id v8sm499874edy.14.2019.07.10.01.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 01:24:04 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id s3so1273636wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:24:04 -0700 (PDT)
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr4020308wmk.10.1562747044241;
 Wed, 10 Jul 2019 01:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190603112835.19661-1-hverkuil-cisco@xs4all.nl>
 <20190603112835.19661-2-hverkuil-cisco@xs4all.nl> <CAAFQd5Aa-PQEakeg3sC_EDYdKy15hHx09Qmk6Jik4COeBe3xVA@mail.gmail.com>
 <02da6340-3174-c03b-ffad-cc9a0a58afab@xs4all.nl>
In-Reply-To: <02da6340-3174-c03b-ffad-cc9a0a58afab@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 10 Jul 2019 17:23:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A4+o9MZL8_TTdKOYa04O87GEi81PU2Kipa_Seeg98oMA@mail.gmail.com>
Message-ID: <CAAFQd5A4+o9MZL8_TTdKOYa04O87GEi81PU2Kipa_Seeg98oMA@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 5:09 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wro=
te:
>
> On 7/3/19 6:58 AM, Tomasz Figa wrote:
> > Hi Hans,
> >
> > On Mon, Jun 3, 2019 at 8:28 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> =
wrote:
> >>
> >> From: Tomasz Figa <tfiga@chromium.org>
> >>
> >> Due to complexity of the video decoding process, the V4L2 drivers of
> >> stateful decoder hardware require specific sequences of V4L2 API calls
> >> to be followed. These include capability enumeration, initialization,
> >> decoding, seek, pause, dynamic resolution change, drain and end of
> >> stream.
> >>
> >> Specifics of the above have been discussed during Media Workshops at
> >> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> >> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> >> originated at those events was later implemented by the drivers we alr=
eady
> >> have merged in mainline, such as s5p-mfc or coda.
> >>
> >> The only thing missing was the real specification included as a part o=
f
> >> Linux Media documentation. Fix it now and document the decoder part of
> >> the Codec API.
> >>
> >> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >> ---
> >>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1084 ++++++++++++++++=
+
> >>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    8 +-
> >>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
> >>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
> >>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   41 +-
> >>  5 files changed, 1132 insertions(+), 16 deletions(-)
> >>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> >>
> >
> > Thanks a lot for helping with remaining changes.
> >
> > Just one thing inline our team member found recently.
> >
> > [snip]
> >> +Capture setup
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> > [snip]
> >> +4.  **Optional.** Set the ``CAPTURE`` format via :c:func:`VIDIOC_S_FM=
T` on the
> >> +    ``CAPTURE`` queue. The client may choose a different format than
> >> +    selected/suggested by the decoder in :c:func:`VIDIOC_G_FMT`.
> >> +
> >> +    * **Required fields:**
> >> +
> >> +      ``type``
> >> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> >> +
> >> +      ``pixelformat``
> >> +          a raw pixel format.
> >
> > The client should be able to set the width and height as well. It's a
> > quite frequent case, especially in DMA-buf import mode, that the
> > buffers are actually bigger (e.g. more alignment) than what we could
> > get from the decoder by default. For sane hardware platforms it's
> > reasonable to expect that such bigger buffers could be handled as
> > well, as long as we update the width and height here.
>
> I've added this:
>
>      ``width``, ``height``
>          frame buffer resolution of the decoded stream; typically unchang=
ed from
>          what was returned with :c:func:`VIDIOC_G_FMT`, but it may be dif=
ferent
>          if the hardware supports composition and/or scaling.
>
> Is that what you were looking for?
>

Not sure if composition is a requirement here, but I guess it depends
on how we define composition. Most of the hardware today at least
support arbitrary strides (+/- some alignment), but still write the
pixels at (0,0)x(w,h).

In fact, there would be already some composition happening, even
without arbitrary strides, because G_FMT would return values aligned
in some way, but only the visible rectangle would contain meaningful
pixel data.

Best regards,
Tomasz

Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCEBC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A027421726
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="Wo0JoL3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfFJP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:57:50 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40419 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389447AbfFJP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:57:50 -0400
Received: by mail-ua1-f65.google.com with SMTP id s4so3220220uad.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=aRAWyVb7T/pu55YIusBAX8P46//GPGyU/Kan5m7eqCo=;
        b=Wo0JoL3ONHGWQdF0PGrZJ5QKkIu6siHwVXdNEK+PZjNp/QmRYrb1ZqI/qXctBPSg3T
         ka0oTBpnVpmWvlYSre9bVgaVvYg/7Uuw1yVGJh3rTineRd+jxVjpNyM5qbb9iYgFFnAg
         YQrJAecw5BTnb2ghfaxRCTnaY958vISiKT6yH9V7Xtelfylgl92rfPTRZIb3z7lFdKyj
         YVkSfe5Hhd0+Wzd9oSWVMdfOOn40wvp55ik037pd3Nt+km0se1//3xDSxnsaEcOGMelY
         juYByA4rwB4mzGS9LC40iBwu59cHE53UEXJUePp0L27Vh18sf6J2rsHIt0fRhbbHv8mw
         xEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=aRAWyVb7T/pu55YIusBAX8P46//GPGyU/Kan5m7eqCo=;
        b=S26VsjcJRtbuHhc+nM1qXNMpbyFqMLHy2RzCZr26kwHQRZ9vNZTDxnlEn+CxqsWNt0
         TJZcH/qvTu5b9e7kE+hC5ySMpR5zv9YP4REpELOh8e48ePb5ffl2K4msvKdtmjhDzMaH
         rDYbPo/lBl33AhBFeetpc3hK0VGY9k6IpvI9ZHIGm3LRAa7st8FHfBz/lRtah/+1Pysp
         QMEie0/wKXu1RQwWsQmHmdvWnzhbd+5vdS/A78zDpkZ9HACgNgP9Kn+0I7MJEvmiBf7a
         x9zKMdxedfBac6fj5FgFESsV5iRT6BmElVWpbg3lbJCUyxxyV0JcNm9Ux4BePwSlcPIE
         QBWQ==
X-Gm-Message-State: APjAAAXec0dVwjYHrLY/izv5TuvOsPf8xD6Rxp10K1zQ5u9eUuqYHpYb
        UvGDv2rwlmBuuKFh92P5qPaM2Q==
X-Google-Smtp-Source: APXvYqwLQDesqUmKTmojJdikYYaptNzhKaUFR4puTmpiUQbDKjarHEaYT5uxBnbG3vEEECo8t7UuBw==
X-Received: by 2002:ab0:6619:: with SMTP id r25mr11398562uam.33.1560182269131;
        Mon, 10 Jun 2019 08:57:49 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id q77sm2952584vke.13.2019.06.10.08.57.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 08:57:47 -0700 (PDT)
Message-ID: <e40174b9a3d813389dc9529598541e4849067387.camel@ndufresne.ca>
Subject: Re: [PATCHv4 0/2] Document memory-to-memory video codec interfaces
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Pawel Osciak <posciak@chromium.org>
Date:   Mon, 10 Jun 2019 11:57:45 -0400
In-Reply-To: <20190603112835.19661-1-hverkuil-cisco@xs4all.nl>
References: <20190603112835.19661-1-hverkuil-cisco@xs4all.nl>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-nGMRhe68cITpEahwQfZ0"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nGMRhe68cITpEahwQfZ0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 03 juin 2019 =C3=A0 13:28 +0200, Hans Verkuil a =C3=A9crit :
> Since Thomasz was very busy with other things, I've taken over this
> patch series. This v4 includes his draft changes and additional changes
> from me.
>=20
> This series attempts to add the documentation of what was discussed
> during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
> later Embedded Linux Conference Europe 2014 in D=C3=BCsseldorf and then
> eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
> video team (but mostly in a cosmetic way or making the document more
> precise), during the several years of Chrome OS using the APIs in
> production.
>=20
> Note that most, if not all, of the API is already implemented in
> existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
> this series is just to formalize what we already have.
>=20
> Thanks everyone for the huge amount of useful comments to previous
> versions of this series. Much of the credits should go to Pawel Osciak
> too, for writing most of the original text of the initial RFC.
>=20
> This v4 incorporates all known comments (let me know if I missed
> something!) and should be complete for the decoder.
>=20
> For the encoder there are two remaining TODOs for the API:
>=20
> 1) Setting the frame rate so bitrate control can make sense, since
>    they need to know this information.
>=20
>    Suggested solution: require support for ENUM_FRAMEINTERVALS for the
>    coded pixelformats and S_PARM(OUTPUT). Open question: some drivers
>    (mediatek, hva, coda) require S_PARM(OUTPUT), some (venus) allow both
>    S_PARM(CAPTURE) and S_PARM(OUTPUT). I am inclined to allow both since
>    this is not a CAPTURE vs OUTPUT thing, it is global to both queues.

Is ENUM_FRAMEINTERVALS really required ? This will be a hint to the
encoder, so that the encoder round to it's internal precision does not
seem very important.

>=20
> 2) Interactions between OUTPUT and CAPTURE formats.
>=20
>    The main problem is what to do if the capture sizeimage is too small
>    for the OUTPUT resolution when streaming starts.
>=20
>    Proposal: width and height of S_FMT(OUTPUT) are used to
>    calculate a minimum sizeimage (app may request more). This is
>    driver-specific.
>=20
>    V4L2_FMT_FLAG_FIXED_RESOLUTION is always set for codec formats
>    for the encoder (i.e. we don't support mid-stream resolution
>    changes for now) and V4L2_EVENT_SOURCE_CHANGE is not
>    supported. See https://patchwork.linuxtv.org/patch/56478/ for
>    the patch adding this flag.
>=20
>    Of course, if we start to support mid-stream resolution
>    changes (or other changes that require a source change event),
>    then this flag should be dropped by the encoder driver and
>    documentation on how to handle the source change event should
>    be documented in the encoder spec. I prefer to postpone this
>    until we have an encoder than can actually do mid-stream
>    resolution changes.

For H264, mid-stream changes would make sense for the case we'd like
the statefull encoder to emit multiple PPS at start, so then the switch
would simply change the PPS index. The problem seems to be how do we
expose "multiple" resolution in our interface ? As there is currently
no solution to this, I would not see much use for having this supported
at the moment.

>=20
>    If sizeimage of the OUTPUT is too small for the CAPTURE
>    resolution and V4L2_EVENT_SOURCE_CHANGE is not supported,
>    then the second STREAMON (either CAPTURE or OUTPUT) will
>    return -ENOMEM since there is not enough memory to do the
>    encode.
>=20
>    If V4L2_FMT_FLAG_FIXED_RESOLUTION is set (i.e. that should
>    be the case for all current encoders), then any bitrate controls
>    will be limited in range to what the current state (CAPTURE and
>    OUTPUT formats and frame rate) supports.
>=20
> Comments regarding these two encoder proposals are welcome!
>=20
> Regards,
>=20
> 	Hans
>=20
> Changes since v3:
>=20
> - Lots of stylistic fixes and fixing typos/grammar/etc.
>=20
> Decoder:
>=20
> - width/height for S_FMT(OUTPUT):
>=20
>   Expects that the output width and height is always a valid
>   resolution (i.e. never 0x0), and G/S/TRY_FMT and REQBUFS will use that
>   instead of returning an error. Note that this resolution is a placehold=
er
>   until the actual resolution is parsed from the stream.
>=20
> - Dropped step 3 (Query the minimum number of buffers required for the CA=
PTURE
>   queue via VIDIOC_G_CTRL().) in the Capture Setup section. It seems to b=
e
>   a left-over from earlier versions. The same information is also in Step=
 10,
>   so no need to have this in two places.
>=20
> - Added step 5 in the Capture Setup section: set COMPOSE rectangle if nee=
ded.
>=20
> - VIDIO_DECODER_CMD: document EBUSY return while draining the queue.
>=20
> Encoder:
>=20
> - width/height for S_FMT(CAPTURE): The width/height for the CAPTURE forma=
t
>   are marked as read-only and are based on the encoders current state suc=
h
>   as the OUTPUT format.
>=20
> - Drop TGT_COMPOSE support in the encoder: there are currently
>   no encoders that can do composing/scaling.
>=20
> - Document corner cases in the Drain sequence
>=20
> - Document error handling.
>=20
> - VIDIO_ENCODER_CMD: document EBUSY return while draining the queue.
>=20
> Changes since v2:
> (https://lore.kernel.org/patchwork/cover/1002474/)
> Decoder:
>  - Specified that the initial source change event is signaled
>    regardless of whether the client-set format matches the
>    stream format.
>  - Dropped V4L2_CID_MIN_BUFFERS_FOR_OUTPUT since it's meaningless
>    for the bitstream input buffers of decoders.
>  - Explicitly stated that VIDIOC_REQBUFS is not allowed on CAPTURE
>    if the stream information is not available.
>  - Described decode error handling.
>  - Mentioned that timestamps can be observed after a seek to
>    determine whether the CAPTURE buffers originated from before
>    or after the seek.
>  - Explicitly stated that after a pair of V4L2_DEC_CMD_STOP and
>    V4L2_DEC_CMD_START, the decoder is not reset and preserves
>    all the state.
>=20
> Encoder:
>  - Specified that width and height of CAPTURE format are ignored
>    and always zero.
>  - Explicitly noted the common use case for the CROP target with
>    macroblock-unaligned video resolutions.
>  - Added a reference to Request API.
>  - Dropped V4L2_CID_MIN_BUFFERS_FOR_CAPTURE since it's meaningless
>    for the bitstream output buffers of encoders.
>  - Explicitly stated that after a pair of V4L2_ENC_CMD_STOP and
>    V4L2_ENC_CMD_START, the encoder is not reset and preserves
>    all the state.
>=20
> General:
>  - Dropped format enumeration from "Initialization", since it's already
>    a part of "Querying capabilities".
>  - Many spelling, grammar, stylistic, etc. changes.
>  - Changed the style of note blocks.
>  - Rebased onto Hans' documentation cleanup series.
>    (https://patchwork.kernel.org/cover/10775407/
>     https://patchwork.kernel.org/patch/10776737/)
>  - Moved the interfaces under the "Video Memory-To-Memory Interface"
>    section.
>=20
> For changes since v1 see the v2:
> https://lore.kernel.org/patchwork/cover/1002474/
>=20
> For changes since RFC see the v1:
> https://patchwork.kernel.org/cover/10542207/
>=20
> Tomasz Figa (2):
>   media: docs-rst: Document memory-to-memory video decoder interface
>   media: docs-rst: Document memory-to-memory video encoder interface
>=20
>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1084 +++++++++++++++++
>  Documentation/media/uapi/v4l/dev-encoder.rst  |  608 +++++++++
>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    9 +-
>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   10 +
>  Documentation/media/uapi/v4l/v4l2.rst         |   12 +-
>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   41 +-
>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |   51 +-
>  7 files changed, 1779 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
>=20

--=-nGMRhe68cITpEahwQfZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXP59+QAKCRBxUwItrAao
HMpzAJ9i+5QrRORHUeV85CGN2nvRVqO/0QCgwmNQtt7qX04cHquHnxGx2vrhF6U=
=ngKe
-----END PGP SIGNATURE-----

--=-nGMRhe68cITpEahwQfZ0--


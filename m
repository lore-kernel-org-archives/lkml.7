Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3697C20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QefLO8g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDIK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:28:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40548 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfDIK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:28:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id 3so13091777oir.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYTuoLYFJqANn1Vm2k0gRmGZwBX9er5JKzWBC2GAxrY=;
        b=QefLO8g5+P26iA7b7fmNguGD2S+2frIoWz0IdSGaT8jb/P6Lk6wAT0BNQdoGkCDLtt
         YCYWAwaUCxy4G6b2MOS6MU8bZNRwvWI0o07R0ayIBCUuwP0j06EI2FoKC3CX37Vx44KG
         Orr80cHIy2p493y4OmtaquoFLRrbgsYwS1+54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYTuoLYFJqANn1Vm2k0gRmGZwBX9er5JKzWBC2GAxrY=;
        b=sTh9qLuvQhGqePBAU4LRf7tEnO15OQq9uvK8GeD+UpWo5H21DC08FyZCKwljPBCdDh
         DCVjueH5DsKfEL10ov+DwWgoa47K/wK0qZIr59nACbaaN1ipJU57caa6/Z1Ygk56Kq70
         0+Iv9etRYeVho5Ugw7qI6QxKqowxfjr5h99neX399OawAodr1V8Uuo7ttf5IPTrG9ppH
         djDGHI756rTKK/VhWvN9tBi4CMOZ4RLS+P8X4aITLyMVj9mecvlUFy54lYlxvfl4/XIp
         neZcHRlkrLe2F3SJGCMvdkiarab8+QQPJZaRBXABGJOoVrHU/qOa067B4SOjcYVTvA7E
         VQrw==
X-Gm-Message-State: APjAAAVhJ+9mJVzXlb0Ba7K5Rl4UGrxdSboZ2i5VQx9gtIfeIAFD1P+u
        Hh4MQe0EJxbDmYRPfXqzQbAbtJEJB0o=
X-Google-Smtp-Source: APXvYqzBWA151qHrt9TuWQIgsfyaufAC7tO4DpLnlJeyyagUZgqJ9CfqREOYxiIF25VA/yzQAo+PZQ==
X-Received: by 2002:aca:b4c6:: with SMTP id d189mr20022983oif.83.1554805702848;
        Tue, 09 Apr 2019 03:28:22 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id m206sm12631726oif.50.2019.04.09.03.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:28:21 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id c16so15064143otn.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:28:21 -0700 (PDT)
X-Received: by 2002:a9d:57c2:: with SMTP id q2mr22414256oti.313.1554805700679;
 Tue, 09 Apr 2019 03:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-2-tfiga@chromium.org>
 <1554461965.3060.5.camel@pengutronix.de> <8f05866a-1244-5e85-9b37-409526970779@xs4all.nl>
In-Reply-To: <8f05866a-1244-5e85-9b37-409526970779@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 19:28:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bit7E4iQLxOZo=Qd-CK1tcKL-eV-+fozhV3di44taDvQ@mail.gmail.com>
Message-ID: <CAAFQd5Bit7E4iQLxOZo=Qd-CK1tcKL-eV-+fozhV3di44taDvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 8:21 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/5/19 12:59 PM, Philipp Zabel wrote:
> > On Thu, 2019-01-24 at 19:04 +0900, Tomasz Figa wrote:
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
> >> ---
> >>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1076 ++++++++++++++++=
+
> >>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    5 +
> >>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
> >>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
> >>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
> >>  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
> >>  6 files changed, 1135 insertions(+), 15 deletions(-)
> >>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> >>
> >> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentat=
ion/media/uapi/v4l/dev-decoder.rst
> >> new file mode 100644
> >> index 000000000000..b7db2352ad41
> >> --- /dev/null
> >> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> >> @@ -0,0 +1,1076 @@
> >> +.. -*- coding: utf-8; mode: rst -*-
> >> +
> >> +.. _decoder:
> >> +
> >> +*************************************************
> >> +Memory-to-memory Stateful Video Decoder Interface
> >> +*************************************************
> >> +
> > [...]
> >> +
> >> +Drain
> >> +=3D=3D=3D=3D=3D
> >> +
> > [...]
> >> +
> >> +3. Once all the ``OUTPUT`` buffers queued before the ``V4L2_DEC_CMD_S=
TOP`` call
> >> +   are dequeued and the last ``CAPTURE`` buffer is dequeued, the deco=
der is
> >> +   stopped and it will accept, but not process, any newly queued ``OU=
TPUT``
> >> +   buffers until the client issues any of the following operations:
> >> +
> > [...]
> >> +
> >> +.. note::
> >> +
> >> +   Once the drain sequence is initiated, the client needs to drive it=
 to
> >> +   completion, as described by the steps above, unless it aborts the =
process by
> >> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``C=
APTURE``
> >> +   queues.  The client is not allowed to issue ``V4L2_DEC_CMD_START``=
 or
> >> +   ``V4L2_DEC_CMD_STOP`` again while the drain sequence is in progres=
s and they
> >> +   will fail with -EBUSY error code if attempted.
> >
> > Should the V4L2_DEC_CMD_STOP documentation in
> > Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst:
> >
> >   * - ``V4L2_DEC_CMD_STOP``
> >     - 1
> >     - Stop the decoder. When the decoder is already stopped, this
> >       command does nothing.
> >
> > be updated to mention that for mem2mem decoders this not only does
> > nothing, but returns an -EBUSY error return value?
>
> Yes. Basically in this case the STOP is still in progress, so returning
> EBUSY makes sense and should be documented.
>

Done. Also for the encoder.

> >
> > Also, if V4L2_DEC_CMD_STOP_IMMEDIATELY is set, should the decoder drop
> > all pending buffers and signal EOS immediately? Should this be mentione=
d
> > here?
>
> Hmm, the decoder spec says that flags should be set to 0, and current cod=
ec
> drivers explicitly disallow a non-0 flags value.
>
> I'm not sure if there is a practical use-case for V4L2_DEC_CMD_STOP_IMMED=
IATELY
> in the context of a decoder. If you want to stop immediately, then just c=
all
> streamoff on the OUTPUT queue.
>

Agreed.

> >
> >> +   Although mandatory, the availability of decoder commands may be qu=
eried
> >> +   using :c:func:`VIDIOC_TRY_DECODER_CMD`.
> >
> > Do the TRY_DECODER_CMD also return -EBUSY during the draining phase?
>
> No.

Ack.

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
> >
> > regards
> > Philipp
> >
>

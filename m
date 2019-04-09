Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CC821473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TbobGleR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDIJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:47:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37167 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:47:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so13011205oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ONojt7DSJuXLOIn+w7xwUHVbI9Qr9/WFumFlFOuNW+A=;
        b=TbobGleRXLfIriPfQ79rXtq4pabgN2t01OdGZBWutzdoIuq7XEsf0LS2ctUKtey730
         h/Z2CBH/6K/9bDtmkgqMHrCH3djuPVD7uLgl3jwxczZfjrYTkueGDxpqJ4xu/V6L1gDi
         TqKEUw5Oa7L8Izof6YXTW+pQHJ9d3wZdm/E0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ONojt7DSJuXLOIn+w7xwUHVbI9Qr9/WFumFlFOuNW+A=;
        b=Cj6Ykq1nVAg4BRX/KeQQXci1963sKqown5UuGrBd+XkuFe782sQzp0oAdApb5DOhqP
         olE23CV6pchMCBUrp65yhGyUnkDk4WlLN3PUix6MrbBtY7OF0RBKG4Fw1VWe0tp1+dYm
         +klpYDdUQYHiFndR48ihXn18j2JF3dIheUgUuZMJPX0G/oXaknotXfgPeGfOO9wMmB9H
         Es1cx2uBHDGos9TlJ6RgUelws0AP+vigXgOf/2ds06/zU0dfUQoSmgEe6TSRvkdey6y5
         8WeNmaLB+BW+QZ5ArFq7UbMKRu6JKzpgruUiTTgwbFDml2NDUnMOmUz7J5/KEjvwlWpj
         RLTg==
X-Gm-Message-State: APjAAAUSCSzQOnHvtvx6T+guGJt3/g90HX1uonO+fiibqpNxdz6x1OXO
        HO0ntd/Xd9nbDIvYIwTFdtVZ1PhZcGs=
X-Google-Smtp-Source: APXvYqyojW/LDv6xrXZGGXk+QLtAvMDfvHBxzLe6ta0oHANEVK4cRmKnXYyOnefm+nz447lkD4r9pw==
X-Received: by 2002:aca:3056:: with SMTP id w83mr18185650oiw.78.1554803263276;
        Tue, 09 Apr 2019 02:47:43 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id h8sm12532641oti.64.2019.04.09.02.47.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:47:42 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id e5so13042432oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:47:41 -0700 (PDT)
X-Received: by 2002:aca:4b03:: with SMTP id y3mr18864793oia.21.1554803261513;
 Tue, 09 Apr 2019 02:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-2-tfiga@chromium.org>
 <cf0fc2fc-72c6-dbca-68f7-a349879a3a14@xs4all.nl> <CAAFQd5AORjMjHdavdr3zM13BnyFnKnEb-0aKNjvwbB_xJEnxgQ@mail.gmail.com>
 <9b7c1385-d482-6e92-2222-2daa835dbc91@xs4all.nl> <CAAFQd5DwjLt8UeDohzrMausaLGnOStvrmp5p7frYbG1hbGjx3Q@mail.gmail.com>
 <CAAFQd5BPJv3cbJOWrziEjz_yE32DhfZv9vb-pG1Ltx-KS2=PQg@mail.gmail.com>
 <3ea3bf5bf9904ce877142c41f595207752172d27.camel@ndufresne.ca>
 <CAAFQd5C_OD=bvAxG0B_G+T6bnWddPHuiVZApj_8_+4xpMjH9+g@mail.gmail.com>
 <c145fbf21301d03bdfdd8bf6613f0f68576e66be.camel@ndufresne.ca> <CAAFQd5D4AP+xj_EkcsB84UqxCLBBEGComqGaMCm2zHSMnpqOKw@mail.gmail.com>
In-Reply-To: <CAAFQd5D4AP+xj_EkcsB84UqxCLBBEGComqGaMCm2zHSMnpqOKw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 18:47:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AfmoUNbd5qwNmj+X80T-B49M-kUCLzGSOirg3o5WPPzA@mail.gmail.com>
Message-ID: <CAAFQd5AfmoUNbd5qwNmj+X80T-B49M-kUCLzGSOirg3o5WPPzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
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

On Wed, Feb 6, 2019 at 2:35 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Wed, Jan 30, 2019 at 1:02 PM Nicolas Dufresne <nicolas@ndufresne.ca> w=
rote:
> >
> > Le vendredi 25 janvier 2019 =C3=A0 12:27 +0900, Tomasz Figa a =C3=A9cri=
t :
> > > On Fri, Jan 25, 2019 at 4:55 AM Nicolas Dufresne <nicolas@ndufresne.c=
a> wrote:
> > > > Le jeudi 24 janvier 2019 =C3=A0 18:06 +0900, Tomasz Figa a =C3=A9cr=
it :
> > > > > > Actually I just realized the last point might not even be achie=
vable
> > > > > > for some of the decoders (s5p-mfc, mtk-vcodec), as they don't r=
eport
> > > > > > which frame originates from which bitstream buffer and the driv=
er just
> > > > > > picks the most recently consumed OUTPUT buffer to copy the time=
stamp
> > > > > > from. (s5p-mfc actually "forgets" to set the timestamp in some =
cases
> > > > > > too...)
> > > > > >
> > > > > > I need to think a bit more about this.
> > > > >
> > > > > Actually I misread the code. Both s5p-mfc and mtk-vcodec seem to
> > > > > correctly match the buffers.
> > > >
> > > > Ok good, since otherwise it would have been a regression in MFC dri=
ver.
> > > > This timestamp passing thing could in theory be made optional thoug=
h,
> > > > it lives under some COPY_TIMESTAMP kind of flag. What that means th=
ough
> > > > is that a driver without such a capability would need to signal dro=
pped
> > > > frames using some other mean.
> > > >
> > > > In userspace, the main use is to match the produced frame against a
> > > > userspace specific list of frames. At least this seems to be the ca=
se
> > > > in Gst and Chromium, since the userspace list contains a superset o=
f
> > > > the metadata found in the v4l2_buffer.
> > > >
> > > > Now, using the produced timestamp, userspace can deduce frame that =
the
> > > > driver should have produced but didn't (could be a deadline case co=
dec,
> > > > or simply the frames where corrupted). It's quite normal for a code=
c to
> > > > just keep parsing until it finally find something it can decode.
> > > >
> > > > That's at least one way to do it, but there is other possible
> > > > mechanism. The sequence number could be used, or even producing buf=
fers
> > > > with the ERROR flag set. What matters is just to give userspace a w=
ay
> > > > to clear these frames, which would simply grow userspace memory usa=
ge
> > > > over time.
> > >
> > > Is it just me or we were missing some consistent error handling then?
> > >
> > > I feel like the drivers should definitely return the bitstream buffer=
s
> > > with the ERROR flag, if there is a decode failure of data in the
> > > buffer. Still, that could become more complicated if there is more
> > > than 1 frame in that piece of bitstream, but only 1 frame is corrupte=
d
> > > (or whatever).
> >
> > I agree, but it might be more difficult then it looks (even FFMPEG does
> > not do that). I believe the code that is processing the bitstream in
> > stateful codecs is mostly unrelated from the code actually doing the
> > decoding. So what might happen is that the decoding part will never
> > actually allocate a buffer for the skipped / corrupted part of the
> > bitstream. Also, the notion of a skipped frame is not always evident in
> > when parsing H264 or HEVC NALs. There is still a full page of text just
> > to explain how to detect that start of a new frame.
>
> Right. I don't think we can guarantee that we can always correlate the
> errors with exact buffers and so I phrased the paragraph about errors
> in v3 in a bit more conservative way:
>
> See the snapshot hosted by Hans (thanks!):
> https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-decoder.html#decod=
ing
>
> >
> > Yet, it would be interesting to study the firmwares we have and see
> > what they provide that would help making decode errors more explicit.
> >
>
> Agreed.
>
> > >
> > > Another case is when the bitstream, even if corrupted, is still enoug=
h
> > > to produce some output. My intuition tells me that such CAPTURE buffe=
r
> > > should be then returned with the ERROR flag. That wouldn't still be
> > > enough for any more sophisticated userspace error concealment, but
> > > could still let the userspace know to perhaps drop the frame.
> >
> > You mean if a frame was concealed (typically the frame was decoded from
> > a closed by reference instead of the expected reference). That is
> > something signalled by FFPEG. We should document this possibility. I
> > actually have something implemented in GStreamer. Basically if we have
> > the ERROR flag with a payload size smaller then expected, I drop the
> > frame and produce a drop event message, while if I have a frame with
> > ERROR flag but of the right payload size, I assume it is corrupted, and
> > simply flag it as corrupted, leaving to the application the decision to
> > display it or not. This is a case that used to happen with some UVC
> > cameras (though some have been fixed, and the UVC camera should drop
> > smaller payload size buffers now).
>
> I think it's a behavior that makes the most sense indeed.
>
> Technically one could also consider the case of 0 < bytesused <
> sizeimage, which could mean that only a part of the frame is in the
> buffer. An application could try to blend it with previous frame using
> some concealing algorithms. I haven't seen an app that could do such
> thing, though.

Actually some interesting thought on this. I don't think the existing
drivers would return any CAPTURE buffers on errors right now, but just
return the OUTPUT buffer that failed to be decoded. Should we change
this so that always one CAPTURE buffer with the ERROR flag is
returned, to signal the application that a frame was potentially
dropped?

Best regards,
Tomasz

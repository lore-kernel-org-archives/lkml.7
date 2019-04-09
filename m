Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A9C282DE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FD621473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z01F5ih9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDIKAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:00:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43371 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDIKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:00:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so13014108oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cme9y15RBVs+D6PIJELCcpr6/0n0fysoUeBaEk7YhAo=;
        b=Z01F5ih9F3zCQqah06ebIyJYLJroGIVizBsB8YdOw8FPgiIDCRqV/jE5q0uak0Ibe/
         77i375Z+SHnQ99fZ3XRPvYiemWXOc2MtqCIkRWXmzMvYXt5laPlpoLnAWaiM1agQhHOC
         ABRXScu5TTjDJo/tDf7I0VKCNVyTjTfLQ3BCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cme9y15RBVs+D6PIJELCcpr6/0n0fysoUeBaEk7YhAo=;
        b=Io6tqer8oYM5NbScT8fQ5DwWwOGT9sb3HpD4BgK+kgfMFAgc3rrxTDID5Bxg7tIqte
         JVmJwn6uqgTe2l+2HCzuXrE/IKSZ94JKSLjq3N3Oa1augd0iqscCE3Nl0A2czXSeWoKV
         j5YDsB1EwSc4D8Tm3TmbbnwGh8+oWjHO6ZHARqreIscdi+zZlfbdsvIMfBH3YFxOUSdK
         Krzt/J3T6XBZs3a2RImwHHCDPe7LEWY3lhfwb9+fo7om6U5gtJe8Ov80ZLJxcQ8c2wj6
         wqKwPHzMpcfRns63p1VV8O9FjpsNwfQ0ignbDh26a+1tFqSmGetBTnLhQEGOx4toXQvV
         P0xA==
X-Gm-Message-State: APjAAAXRYnk9FIKxk38YDVMbbs4OkmHxjhXQhH5d4qLQRfqFrl/cxmSn
        BcYJxKNg42k8UK5vh91/id+liayuulA=
X-Google-Smtp-Source: APXvYqwofQXtwus/pXxzqd+eUb7OzUlpUXHlmfyRmiOdWhILCIonLWofGLiJq6TRTpS9jaRsR0Q63w==
X-Received: by 2002:aca:fccd:: with SMTP id a196mr18013823oii.132.1554804001745;
        Tue, 09 Apr 2019 03:00:01 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id a198sm13215256oib.19.2019.04.09.03.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:00:00 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id k21so15019628otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:00:00 -0700 (PDT)
X-Received: by 2002:a9d:6206:: with SMTP id g6mr22995965otj.7.1554803999930;
 Tue, 09 Apr 2019 02:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <CAAFQd5Cm1zyPzJnixwNmWzxn2zh=63YrA+ZzH-arW-VZ_x-Awg@mail.gmail.com>
 <28069a44-b188-6b89-2687-542fa762c00e@linaro.org> <CAAFQd5BevOV2r1tqmGPnVtdwirGMWU=ZJU85HjfnH-qMyQiyEg@mail.gmail.com>
 <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
 <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com>
 <e8a90694c306fde24928a569b7bcb231b86ec73b.camel@ndufresne.ca>
 <CAAFQd5DFfQRd1VoN7itVXnWGKW_WBKU-sm6vo5CdgjkzjEEkFg@mail.gmail.com>
 <57419418d377f32d0e6978f4e4171c0da7357cbb.camel@ndufresne.ca>
 <1548938556.4585.1.camel@pengutronix.de> <CAAFQd5Aih7cWu-cfwBvNdwhHHYEaMF0SFebrYfdNXD9qKu8fxw@mail.gmail.com>
 <1f8485785a21c0b0e071a3a766ed2cbc727e47f6.camel@ndufresne.ca>
 <CAAFQd5CPKm1ES8c9Lab63Lr8ZfWRckHmJ99SVRYi6Hpe7hzy+g@mail.gmail.com>
 <f1e9dc99-4fcb-dee1-4279-ac0cf1d1fd6e@xs4all.nl> <CAAFQd5B+bt3SV_WRw1=2agZk=Q+Enbkv=nXCrbXX=+MNpeSpCg@mail.gmail.com>
 <cb8cda5d-e714-6019-4a76-3853ea49c4a6@xs4all.nl> <CAAFQd5BZhhX6Cjj7GhbaY_G7ERksyKne6hxKFCuTJoOnamoQ=A@mail.gmail.com>
In-Reply-To: <CAAFQd5BZhhX6Cjj7GhbaY_G7ERksyKne6hxKFCuTJoOnamoQ=A@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 18:59:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ar9c91G66oFMYGj59n+_NScB_QyZB2yF_y+=Y_64pWqA@mail.gmail.com>
Message-ID: <CAAFQd5Ar9c91G66oFMYGj59n+_NScB_QyZB2yF_y+=Y_64pWqA@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 4:33 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, Feb 5, 2019 at 7:35 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 2/5/19 10:31 AM, Tomasz Figa wrote:
> > > On Tue, Feb 5, 2019 at 6:00 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> > >>
> > >> On 2/5/19 7:26 AM, Tomasz Figa wrote:
> > >>> On Fri, Feb 1, 2019 at 12:18 AM Nicolas Dufresne <nicolas@ndufresne=
.ca> wrote:
> > >>>>
> > >>>> Le jeudi 31 janvier 2019 =C3=A0 22:34 +0900, Tomasz Figa a =C3=A9c=
rit :
> > >>>>> On Thu, Jan 31, 2019 at 9:42 PM Philipp Zabel <p.zabel@pengutroni=
x.de> wrote:
> > >>>>>> Hi Nicolas,
> > >>>>>>
> > >>>>>> On Wed, 2019-01-30 at 10:32 -0500, Nicolas Dufresne wrote:
> > >>>>>>> Le mercredi 30 janvier 2019 =C3=A0 15:17 +0900, Tomasz Figa a =
=C3=A9crit :
> > >>>>>>>>> I don't remember saying that, maybe I meant to say there migh=
t be a
> > >>>>>>>>> workaround ?
> > >>>>>>>>>
> > >>>>>>>>> For the fact, here we queue the headers (or first frame):
> > >>>>>>>>>
> > >>>>>>>>> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blo=
b/master/sys/v4l2/gstv4l2videodec.c#L624
> > >>>>>>>>>
> > >>>>>>>>> Then few line below this helper does G_FMT internally:
> > >>>>>>>>>
> > >>>>>>>>> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blo=
b/master/sys/v4l2/gstv4l2videodec.c#L634
> > >>>>>>>>> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blo=
b/master/sys/v4l2/gstv4l2object.c#L3907
> > >>>>>>>>>
> > >>>>>>>>> And just plainly fails if G_FMT returns an error of any type.=
 This was
> > >>>>>>>>> how Kamil designed it initially for MFC driver. There was no =
other
> > >>>>>>>>> alternative back then (no EAGAIN yet either).
> > >>>>>>>>
> > >>>>>>>> Hmm, was that ffmpeg then?
> > >>>>>>>>
> > >>>>>>>> So would it just set the OUTPUT width and height to 0? Does it=
 mean
> > >>>>>>>> that gstreamer doesn't work with coda and mtk-vcodec, which do=
n't have
> > >>>>>>>> such wait in their g_fmt implementations?
> > >>>>>>>
> > >>>>>>> I don't know for MTK, I don't have the hardware and didn't inte=
grate
> > >>>>>>> their vendor pixel format. For the CODA, I know it works, if th=
ere is
> > >>>>>>> no wait in the G_FMT, then I suppose we are being really lucky =
with the
> > >>>>>>> timing (it would be that the drivers process the SPS/PPS synchr=
onously,
> > >>>>>>> and a simple lock in the G_FMT call is enough to wait). Adding =
Philipp
> > >>>>>>> in CC, he could explain how this works, I know they use GStream=
er in
> > >>>>>>> production, and he would have fixed GStreamer already if that w=
as
> > >>>>>>> causing important issue.
> > >>>>>>
> > >>>>>> CODA predates the width/height=3D0 rule on the coded/OUTPUT queu=
e.
> > >>>>>> It currently behaves more like a traditional mem2mem device.
> > >>>>>
> > >>>>> The rule in the latest spec is that if width/height is 0 then CAP=
TURE
> > >>>>> format is determined only after the stream is parsed. Otherwise i=
t's
> > >>>>> instantly deduced from the OUTPUT resolution.
> > >>>>>
> > >>>>>> When width/height is set via S_FMT(OUT) or output crop selection=
, the
> > >>>>>> driver will believe it and set the same (rounded up to macrobloc=
k
> > >>>>>> alignment) on the capture queue without ever having seen the SPS=
.
> > >>>>>
> > >>>>> That's why I asked whether gstreamer sets width and height of OUT=
PUT
> > >>>>> to non-zero values. If so, there is no regression, as the specs m=
imic
> > >>>>> the coda behavior.
> > >>>>
> > >>>> I see, with Philipp's answer it explains why it works. Note that
> > >>>> GStreamer sets the display size on the OUTPUT format (in fact we p=
ass
> > >>>> as much information as we have, because a) it's generic code and b=
) it
> > >>>> will be needed someday when we enable pre-allocation (REQBUFS befo=
re
> > >>>> SPS/PPS is passed, to avoid the setup delay introduce by allocatio=
n,
> > >>>> mostly seen with CMA base decoder). In any case, the driver report=
ed
> > >>>> display size should always be ignored in GStreamer, the only
> > >>>> information we look at is the G_SELECTION for the case the x/y or =
the
> > >>>> cropping rectangle is non-zero.
> > >>>>
> > >>>> Note this can only work if the capture queue is not affected by th=
e
> > >>>> coded size, or if the round-up made by the driver is bigger or equ=
al to
> > >>>> that coded size. I believe CODA falls into the first category, sin=
ce
> > >>>> the decoding happens in a separate set of buffers and are then de-=
tiled
> > >>>> into the capture buffers (if understood correctly).
> > >>>
> > >>> Sounds like it would work only if coded size is equal to the visibl=
e
> > >>> size (that GStreamer sets) rounded up to full macroblocks. Non-zero=
 x
> > >>> or y in the crop could be problematic too.
> > >>>
> > >>> Hans, what's your view on this? Should we require G_FMT(CAPTURE) to
> > >>> wait until a format becomes available or the OUTPUT queue runs out =
of
> > >>
> > >> You mean CAPTURE queue? If not, then I don't understand that part.
> > >
> > > No, I exactly meant the OUTPUT queue. The behavior of s5p-mfc in case
> > > of the format not being detected yet is to waits for any pending
> > > bitstream buffers to be processed by the decoder before returning an
> > > error.
> > >
> > > See https://elixir.bootlin.com/linux/v5.0-rc5/source/drivers/media/pl=
atform/s5p-mfc/s5p_mfc_dec.c#L329
> >
> > It blocks?! That shouldn't happen. Totally against the spec.
> >
>
> Yeah and that's what this patch tries to implement in venus as well
> and is seemingly required for compatibility with gstreamer...
>
> > > .
> > >
> > >>
> > >>> buffers?
> > >>
> > >> First see my comment here regarding G_FMT returning an error:
> > >>
> > >> https://www.spinics.net/lists/linux-media/msg146505.html
> > >>
> > >> In my view that is a bad idea.
> > >
> > > I don't like it either, but it seemed to be the most consistent and
> > > compatible behavior, but I'm not sure anymore.
> > >
> > >>
> > >> What G_FMT should return between the time a resolution change was
> > >> detected and the CAPTURE queue being drained (i.e. the old or the ne=
w
> > >> resolution?) is something I am not sure about.
> > >
> > > Note that we're talking here about the initial stream information
> > > detection, when the driver doesn't have any information needed to
> > > determine the CAPTURE format yet.
> >
> > IMHO the driver should just start off with some default format, it
> > really doesn't matter what that is.
> >
>
> I guess that's fine indeed.
>
> > This initial situation is really just a Seek operation: you have a form=
at,
> > you seek to a new position and when you find the resolution of the
> > first frame in the bitstream it triggers a SOURCE_CHANGE event. Actuall=
y,
> > to be really consistent with the Seek: you only need to trigger this ev=
ent
> > if 1) the new resolution is different from the current format, or 2) th=
e
> > capture queue is empty. 2) will never happen during a normal Seek, so
> > that's a little bit special to this initial situation.
>
> Having the error returned allowed the applications to handle the
> initial parsing without the event, though. It could have waited for
> all the OUTPUT buffers to be dequeued and then call G_FMT to check if
> that was enough data to obtain the format.
>

Actually, I'm not sure whether triggering the event only if the
resolution changed is a good idea. It makes the application have no
idea when it can actually start preparing the CAPTURE queue. Any
thoughts?

Should it just try to allocate instantly and then reallocate? That
would be a waste of time, though, especially since allocations are not
cheap.

Best regards,
Tomasz

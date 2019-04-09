Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE45C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585C92084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="k81wGRg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDIQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:31:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38025 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDIQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:31:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so20544692qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bSh6wUujSEQsjrtxyLCFN+SuhP+hPl0Z3xHWJLaIQtc=;
        b=k81wGRg0LDs6Vi8sH27yt4Ex2JdZ3do1PedYwBfN0BIK1t5H+pJDFLJ0jUgyna4Xxw
         oo7J6muyPwgs5h5o3pJnwWS2N9mwQNnzNn47XqjQ6UFa68ehAoOrPJbYRgmWAWao1QWb
         WAp9J8Se2rvqKYs6FZ0pixIhme9/ItfqFWPQEex4hjcjs+USIELzAjbRCmNZLMgG+mYc
         rznin/9km8zS1JVuJzUAPU2d/Fm3npR24WfvSsekcCm3xX8PRar6SlS+P1sr4+c7k29i
         uo1M2VGvbUQGGVeNiqaFvQ8/bxsAz1Gpv14sxslmK5BiK6Q1paPA5nXUkMAx56q3xEdn
         aERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bSh6wUujSEQsjrtxyLCFN+SuhP+hPl0Z3xHWJLaIQtc=;
        b=gna4Bgn7BanfRsEWx8B2luuJKJbANih1NCdu+gl51+yAF9fsZTfwh45lPnT10LhASe
         QD3RPuKUPV7uYbbl4F9ze15UOKp5NoA8J7c6ZILproLcH4YURcM88TxT/F7ro7C3pipL
         xTfZhx1BV0LbvSHKxr0iqPeAkSLvjWs3iaa9PNgy66FbGymN2mE2ncFsPDqN5wCgA13y
         xZH7U5mYVtpaSdGD5z9EP/XHkPXWTB78at0HdUnMyCHZMA+W9SFPOHQFrrhkZvFjQPw6
         1FsQIUZE+KV+vrjQdW6PXUfxVPiNvKZNaezvhezsQoqTaqYLcwJE6z2G+4njQdtMF5Ho
         r5GQ==
X-Gm-Message-State: APjAAAXY7pq1k1g1Msw00PZopw+HfP+3dBvKmRm3b5TZO+zV6N+T6uD7
        B6x23BpIRZb27wTHvhF/YXLmVg==
X-Google-Smtp-Source: APXvYqw5AKCc89AMdZgrRw4kkKxh7tx3D4gbh8VUSlzsFWiCneCp4MDaK/0Cz87KRDoYArWPRtknRw==
X-Received: by 2002:ac8:4544:: with SMTP id z4mr30892581qtn.298.1554827461665;
        Tue, 09 Apr 2019 09:31:01 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id x2sm16850899qkj.59.2019.04.09.09.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:31:00 -0700 (PDT)
Message-ID: <7773688904e78fb1a467d4afa5988e2f0648b54f.camel@ndufresne.ca>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Date:   Tue, 09 Apr 2019 12:30:58 -0400
In-Reply-To: <CAAFQd5Ar9c91G66oFMYGj59n+_NScB_QyZB2yF_y+=Y_64pWqA@mail.gmail.com>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
         <20190117162008.25217-11-stanimir.varbanov@linaro.org>
         <CAAFQd5Cm1zyPzJnixwNmWzxn2zh=63YrA+ZzH-arW-VZ_x-Awg@mail.gmail.com>
         <28069a44-b188-6b89-2687-542fa762c00e@linaro.org>
         <CAAFQd5BevOV2r1tqmGPnVtdwirGMWU=ZJU85HjfnH-qMyQiyEg@mail.gmail.com>
         <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
         <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com>
         <e8a90694c306fde24928a569b7bcb231b86ec73b.camel@ndufresne.ca>
         <CAAFQd5DFfQRd1VoN7itVXnWGKW_WBKU-sm6vo5CdgjkzjEEkFg@mail.gmail.com>
         <57419418d377f32d0e6978f4e4171c0da7357cbb.camel@ndufresne.ca>
         <1548938556.4585.1.camel@pengutronix.de>
         <CAAFQd5Aih7cWu-cfwBvNdwhHHYEaMF0SFebrYfdNXD9qKu8fxw@mail.gmail.com>
         <1f8485785a21c0b0e071a3a766ed2cbc727e47f6.camel@ndufresne.ca>
         <CAAFQd5CPKm1ES8c9Lab63Lr8ZfWRckHmJ99SVRYi6Hpe7hzy+g@mail.gmail.com>
         <f1e9dc99-4fcb-dee1-4279-ac0cf1d1fd6e@xs4all.nl>
         <CAAFQd5B+bt3SV_WRw1=2agZk=Q+Enbkv=nXCrbXX=+MNpeSpCg@mail.gmail.com>
         <cb8cda5d-e714-6019-4a76-3853ea49c4a6@xs4all.nl>
         <CAAFQd5BZhhX6Cjj7GhbaY_G7ERksyKne6hxKFCuTJoOnamoQ=A@mail.gmail.com>
         <CAAFQd5Ar9c91G66oFMYGj59n+_NScB_QyZB2yF_y+=Y_64pWqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 09 avril 2019 à 18:59 +0900, Tomasz Figa a écrit :
> On Thu, Feb 7, 2019 at 4:33 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > On Tue, Feb 5, 2019 at 7:35 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > On 2/5/19 10:31 AM, Tomasz Figa wrote:
> > > > On Tue, Feb 5, 2019 at 6:00 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > > > On 2/5/19 7:26 AM, Tomasz Figa wrote:
> > > > > > On Fri, Feb 1, 2019 at 12:18 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > > > > > > Le jeudi 31 janvier 2019 à 22:34 +0900, Tomasz Figa a écrit :
> > > > > > > > On Thu, Jan 31, 2019 at 9:42 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > > > > > > > Hi Nicolas,
> > > > > > > > > 
> > > > > > > > > On Wed, 2019-01-30 at 10:32 -0500, Nicolas Dufresne wrote:
> > > > > > > > > > Le mercredi 30 janvier 2019 à 15:17 +0900, Tomasz Figa a écrit :
> > > > > > > > > > > > I don't remember saying that, maybe I meant to say there might be a
> > > > > > > > > > > > workaround ?
> > > > > > > > > > > > 
> > > > > > > > > > > > For the fact, here we queue the headers (or first frame):
> > > > > > > > > > > > 
> > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys/v4l2/gstv4l2videodec.c#L624
> > > > > > > > > > > > 
> > > > > > > > > > > > Then few line below this helper does G_FMT internally:
> > > > > > > > > > > > 
> > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys/v4l2/gstv4l2videodec.c#L634
> > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys/v4l2/gstv4l2object.c#L3907
> > > > > > > > > > > > 
> > > > > > > > > > > > And just plainly fails if G_FMT returns an error of any type. This was
> > > > > > > > > > > > how Kamil designed it initially for MFC driver. There was no other
> > > > > > > > > > > > alternative back then (no EAGAIN yet either).
> > > > > > > > > > > 
> > > > > > > > > > > Hmm, was that ffmpeg then?
> > > > > > > > > > > 
> > > > > > > > > > > So would it just set the OUTPUT width and height to 0? Does it mean
> > > > > > > > > > > that gstreamer doesn't work with coda and mtk-vcodec, which don't have
> > > > > > > > > > > such wait in their g_fmt implementations?
> > > > > > > > > > 
> > > > > > > > > > I don't know for MTK, I don't have the hardware and didn't integrate
> > > > > > > > > > their vendor pixel format. For the CODA, I know it works, if there is
> > > > > > > > > > no wait in the G_FMT, then I suppose we are being really lucky with the
> > > > > > > > > > timing (it would be that the drivers process the SPS/PPS synchronously,
> > > > > > > > > > and a simple lock in the G_FMT call is enough to wait). Adding Philipp
> > > > > > > > > > in CC, he could explain how this works, I know they use GStreamer in
> > > > > > > > > > production, and he would have fixed GStreamer already if that was
> > > > > > > > > > causing important issue.
> > > > > > > > > 
> > > > > > > > > CODA predates the width/height=0 rule on the coded/OUTPUT queue.
> > > > > > > > > It currently behaves more like a traditional mem2mem device.
> > > > > > > > 
> > > > > > > > The rule in the latest spec is that if width/height is 0 then CAPTURE
> > > > > > > > format is determined only after the stream is parsed. Otherwise it's
> > > > > > > > instantly deduced from the OUTPUT resolution.
> > > > > > > > 
> > > > > > > > > When width/height is set via S_FMT(OUT) or output crop selection, the
> > > > > > > > > driver will believe it and set the same (rounded up to macroblock
> > > > > > > > > alignment) on the capture queue without ever having seen the SPS.
> > > > > > > > 
> > > > > > > > That's why I asked whether gstreamer sets width and height of OUTPUT
> > > > > > > > to non-zero values. If so, there is no regression, as the specs mimic
> > > > > > > > the coda behavior.
> > > > > > > 
> > > > > > > I see, with Philipp's answer it explains why it works. Note that
> > > > > > > GStreamer sets the display size on the OUTPUT format (in fact we pass
> > > > > > > as much information as we have, because a) it's generic code and b) it
> > > > > > > will be needed someday when we enable pre-allocation (REQBUFS before
> > > > > > > SPS/PPS is passed, to avoid the setup delay introduce by allocation,
> > > > > > > mostly seen with CMA base decoder). In any case, the driver reported
> > > > > > > display size should always be ignored in GStreamer, the only
> > > > > > > information we look at is the G_SELECTION for the case the x/y or the
> > > > > > > cropping rectangle is non-zero.
> > > > > > > 
> > > > > > > Note this can only work if the capture queue is not affected by the
> > > > > > > coded size, or if the round-up made by the driver is bigger or equal to
> > > > > > > that coded size. I believe CODA falls into the first category, since
> > > > > > > the decoding happens in a separate set of buffers and are then de-tiled
> > > > > > > into the capture buffers (if understood correctly).
> > > > > > 
> > > > > > Sounds like it would work only if coded size is equal to the visible
> > > > > > size (that GStreamer sets) rounded up to full macroblocks. Non-zero x
> > > > > > or y in the crop could be problematic too.
> > > > > > 
> > > > > > Hans, what's your view on this? Should we require G_FMT(CAPTURE) to
> > > > > > wait until a format becomes available or the OUTPUT queue runs out of
> > > > > 
> > > > > You mean CAPTURE queue? If not, then I don't understand that part.
> > > > 
> > > > No, I exactly meant the OUTPUT queue. The behavior of s5p-mfc in case
> > > > of the format not being detected yet is to waits for any pending
> > > > bitstream buffers to be processed by the decoder before returning an
> > > > error.
> > > > 
> > > > See https://elixir.bootlin.com/linux/v5.0-rc5/source/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c#L329
> > > 
> > > It blocks?! That shouldn't happen. Totally against the spec.
> > > 
> > 
> > Yeah and that's what this patch tries to implement in venus as well
> > and is seemingly required for compatibility with gstreamer...
> > 
> > > > .
> > > > 
> > > > > > buffers?
> > > > > 
> > > > > First see my comment here regarding G_FMT returning an error:
> > > > > 
> > > > > https://www.spinics.net/lists/linux-media/msg146505.html
> > > > > 
> > > > > In my view that is a bad idea.
> > > > 
> > > > I don't like it either, but it seemed to be the most consistent and
> > > > compatible behavior, but I'm not sure anymore.
> > > > 
> > > > > What G_FMT should return between the time a resolution change was
> > > > > detected and the CAPTURE queue being drained (i.e. the old or the new
> > > > > resolution?) is something I am not sure about.
> > > > 
> > > > Note that we're talking here about the initial stream information
> > > > detection, when the driver doesn't have any information needed to
> > > > determine the CAPTURE format yet.
> > > 
> > > IMHO the driver should just start off with some default format, it
> > > really doesn't matter what that is.
> > > 
> > 
> > I guess that's fine indeed.
> > 
> > > This initial situation is really just a Seek operation: you have a format,
> > > you seek to a new position and when you find the resolution of the
> > > first frame in the bitstream it triggers a SOURCE_CHANGE event. Actually,
> > > to be really consistent with the Seek: you only need to trigger this event
> > > if 1) the new resolution is different from the current format, or 2) the
> > > capture queue is empty. 2) will never happen during a normal Seek, so
> > > that's a little bit special to this initial situation.
> > 
> > Having the error returned allowed the applications to handle the
> > initial parsing without the event, though. It could have waited for
> > all the OUTPUT buffers to be dequeued and then call G_FMT to check if
> > that was enough data to obtain the format.
> > 
> 
> Actually, I'm not sure whether triggering the event only if the
> resolution changed is a good idea. It makes the application have no
> idea when it can actually start preparing the CAPTURE queue. Any
> thoughts?

Oh, I was assuming with the new event we'd get the event the first time
the decoder have a sync (e.g. for H.264 a set of PPS/SPS is activated)
and later on, each time the capture format need to change.

I don't expect the current method implemented in GStreamer to work with
random initial frames. Right now it only works if you have a parser to
handle the sync and hide it from the decoder. But simpler userspace
should be able to just frame the data and let the decoder find the sync
(it's stateful after all).

> 
> Should it just try to allocate instantly and then reallocate? That
> would be a waste of time, though, especially since allocations are not
> cheap.

For compatibility with GStreamer, and simply to allow pre-allocation
for application that knows) it would be nice to let userspace do that.
That being to just allocate base on whatever information was set on
OUTPUT queue (like CODA does). But newer userspace should not have to
do that. They should be able to wait for a sync.

> 
> Best regards,
> Tomasz


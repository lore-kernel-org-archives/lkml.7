Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66DC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24E7272AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLQwRznF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFCHa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:30:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44515 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfFCHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:30:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so25501483edm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo/05+9hcZwW8SjdLMg/XD5HT/ASZ+Wu485ITiG25q4=;
        b=QLQwRznFSB/E5WI16dNZSQ5jie0R77DHJ6JJlOD0tT30W++++l6AdGqNNSygq0F3ex
         hushvXYIIt7EpVLKqh6tIfIeeBRMU5bwbs5/asealweqDQ6LVVB+ixq6t30Y8v/vNunv
         /PuCgQE1eHrAPfVhm8Ug+s7AR6hwxlF8W3hck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo/05+9hcZwW8SjdLMg/XD5HT/ASZ+Wu485ITiG25q4=;
        b=q6Uqqvyef8PcKyGdGalWnlvL8MO++hS/1g2f8p0KuJ2Zohi+c2j1Z++6Tz2yWqi9y8
         4AJcRFdH5Tc0JK/5/JJvtn5VcRv0ftFS1FIXe4dU//a32r6AWg3H6rnpZjBYkrgfM4QE
         g/2aR6ekNopmDzowkB5U/O+kJrnv2Jjj8k6lUJKIQunQvnHNcn1steVE3OCP+DCIJjhQ
         iO4pqZxh5POYTXNq0YOcZ3azxgrZJns9rlFS2xbgC+TVlRw+Jg6bsNS/2SsCHM5ecbbp
         UK3EafsbFBAvtzogeu8Sv0p09f6Yz4fJYgvVovco9OQ2I+ye6FIW1uqxv9/ZGcwxe6P1
         vqBw==
X-Gm-Message-State: APjAAAVSFUKW7XdBWW/MxKABPinJL0SX3PxGSEQWWTf/4S1XUFO9lJmv
        R7PwKEdfF92WAIe9n5DOUfW7iLuv8D7LsA==
X-Google-Smtp-Source: APXvYqwWkenu6Rom8QnbXExeBCmJqyWiSj54yFvkmnxB+0+/yAV6t7MqNbJy+4EwJb+wPnvwvUyymg==
X-Received: by 2002:a50:b147:: with SMTP id l7mr6197730edd.65.1559547053695;
        Mon, 03 Jun 2019 00:30:53 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id z26sm2350804edr.5.2019.06.03.00.30.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 00:30:52 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id m3so10852014wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:30:52 -0700 (PDT)
X-Received: by 2002:a5d:568c:: with SMTP id f12mr15245783wrv.77.1559547052239;
 Mon, 03 Jun 2019 00:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
 <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org> <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
 <c56930e0-be6f-2ade-fcea-8ee0ff6247ec@linaro.org> <CAAFQd5CNGsnqjpLsWSTf=8r+hSfyOgD8SU-tn5EbHCCuuSgH6A@mail.gmail.com>
 <01b6683f-9378-e6f2-501f-e2213e6c690d@xs4all.nl> <CAAFQd5Dw-1A2gXuC54Z7808L6Vm9mjPpE7Kbj-TZC18_k_FgVA@mail.gmail.com>
 <a9b11ba0-adca-f974-67a5-a0fe54689bba@xs4all.nl> <CAAFQd5CMpQ4ODyeBPnOv4w9ktqPsiqJtSkpRhAx+XgQ=Lz9crQ@mail.gmail.com>
 <ee62fdb0-d8fa-0695-9088-5aaef48e485f@linaro.org> <0cf25512-97b3-f46a-c266-508368e261d8@xs4all.nl>
In-Reply-To: <0cf25512-97b3-f46a-c266-508368e261d8@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 3 Jun 2019 16:30:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AWSEyAyVVJ21C554cbLRE9tRfCM=iwwJMbmKNKS7NJ2g@mail.gmail.com>
Message-ID: <CAAFQd5AWSEyAyVVJ21C554cbLRE9tRfCM=iwwJMbmKNKS7NJ2g@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 4:26 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 5/31/19 10:01 AM, Stanimir Varbanov wrote:
> > Hi,
> >
> > On 5/27/19 11:18 AM, Tomasz Figa wrote:
> >> On Mon, May 27, 2019 at 4:39 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>
> >>> On 5/27/19 5:51 AM, Tomasz Figa wrote:
> >>>> On Tue, May 21, 2019 at 9:27 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>>>
> >>>>> On 5/21/19 11:09 AM, Tomasz Figa wrote:
> >>>>>> Hi Stan,
> >>>>>>
> >>>>>> On Mon, May 20, 2019 at 11:47 PM Stanimir Varbanov
> >>>>>> <stanimir.varbanov@linaro.org> wrote:
> >>>>>>>
> >>>>>>> Hi Tomasz,
> >>>>>>>
> >>>>>>> On 4/24/19 3:39 PM, Tomasz Figa wrote:
> >>>>>>>> On Wed, Apr 24, 2019 at 9:15 PM Stanimir Varbanov
> >>>>>>>> <stanimir.varbanov@linaro.org> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Hans,
> >>>>>>>>>
> >>>>>>>>> On 2/15/19 3:44 PM, Hans Verkuil wrote:
> >>>>>>>>>> Hi Stanimir,
> >>>>>>>>>>
> >>>>>>>>>> I never paid much attention to this patch series since others were busy
> >>>>>>>>>> discussing it and I had a lot of other things on my plate, but then I heard
> >>>>>>>>>> that this patch made G_FMT blocking.
> >>>>>>>>>
> >>>>>>>>> OK, another option could be to block REQBUF(CAPTURE) until event from hw
> >>>>>>>>> is received that the stream is parsed and the resolution is correctly
> >>>>>>>>> set by application. Just to note that I'd think to this like a temporal
> >>>>>>>>> solution until gstreamer implements v4l events.
> >>>>>>>>>
> >>>>>>>>> Is that looks good to you?
> >>>>>>>>
> >>>>>>>> Hmm, I thought we concluded that gstreamer sets the width and height
> >>>>>>>> in OUTPUT queue before querying the CAPTURE queue and so making the
> >>>>>>>> driver calculate the CAPTURE format based on what's set on OUTPUT
> >>>>>>>> would work fine. Did I miss something?
> >>>>>>>
> >>>>>>> Nobody is miss something.
> >>>>>>>
> >>>>>>> First some background about how Venus implements stateful codec API.
> >>>>>>>
> >>>>>>> The Venus firmware can generate two events "sufficient" and
> >>>>>>> "insufficient" buffer requirements (this includes decoder output buffer
> >>>>>>> size and internal/scratch buffer sizes). Presently I always set minimum
> >>>>>>> possible decoder resolution no matter what the user said, and by that
> >>>>>>> way I'm sure that "insufficient" event will always be triggered by the
> >>>>>>> firmware (the other reason to take this path is because this is the
> >>>>>>> least-common-divider for all supported Venus hw/fw versions thus common
> >>>>>>> code in the driver). The reconfiguration (during codec Initialization
> >>>>>>> sequence) is made from STREAMON(CAPTURE) context. Now, to make that
> >>>>>>> re-configuration happen I need to wait for "insufficient" event from
> >>>>>>> firmware in order to know the real coded resolution.
> >>>>>>>
> >>>>>>> In the case of gstreamer where v4l2_events support is missing I have to
> >>>>>>> block (wait for firmware event) REQBUF(CAPTURE) (vb2::queue_setup) or
> >>>>>>> STREAMON(CAPTURE) (vb2::start_streaming).
> >>>>>>>
> >>>>>>> I tried to set the coded resolution to the firmware as-is it set by
> >>>>>>> gstreamer but then I cannot receive the "sufficient" event for VP8 and
> >>>>>>> VP9 codecs. So I return back to the solution with minimum resolution above.
> >>>>>>>
> >>>>>>> I'm open for suggestions.
> >>>>>>
> >>>>>> I think you could still keep setting the minimum size and wait for the
> >>>>>> "insufficient" event. At the same time, you could speculatively
> >>>>>> advertise the expected "sufficient" size on the CAPTURE queue before
> >>>>>> the hardware signals those. Even if you mispredict them, you'll get
> >>>>>> the event, update the CAPTURE resolution and send the source change
> >>>>>> event to the application, which would then give you the correct
> >>>>>> buffers. Would that work for you?
> >>>>>
> >>>>> As I understand it this still would require event support, which gstreamer
> >>>>> doesn't have.
> >>>>
> >>>> I don't think it matches what I remember from the earlier discussion.
> >>>> As long as Gstreamer sets the visible resolution (from the container
> >>>> AFAIR) on OUTPUT, the driver would adjust it to something that is
> >>>> expected to be the right framebuffer resolution and so Gstreamer would
> >>>> be able to continue. Of course if the expected value doesn't match, it
> >>>> wouldn't work, but it's the same as currently for Coda AFAICT.
> >>>>
> >>>>>
> >>>>> I think it is OK to have REQBUFS sleep in this case. However, I would only
> >>>>
> >>>> Why REQBUFS? While that could possibly allow us to allocate the right
> >>>> buffers, Gstreamer wouldn't be able to know the right format, because
> >>>> it would query it before REQBUFS, wouldn't it?
> >>>
> >>> Oops, you are right. It's got to be in G_FMT(CAPTURE), but *only* if
> >>> nobody subscribed to the SOURCE_CHANGE event.
> >>>
> >>>>
> >>>> For this reason, s5p-mfc makes G_FMT(CAPTURE) blocking and if we
> >>>> decide to forcefully keep the compatibility, even with in drivers, we
> >>>> should probably do the same here.
> >>>>
> >>>>> enable this behavior if the application didn't subscribe to the SOURCE_CHANGE
> >>>>> event. That's easy enough to check in the driver. And that means that if the
> >>>>> application is well written, then the driver will behave in a completely
> >>>>> standard way that the compliance test can check.
> >>>>
> >>>> I guess one could have some helpers for this. They would listen to the
> >>>> source change events internally and block / wake-up appropriate ioctls
> >>>> whenever necessary.
> >>>
> >>> I really do not want this for new drivers. gstreamer should be fixed.
> >>> A blocking G_FMT is just plain bad. Only those drivers that do this, can
> >>> still block if nobody subscribed to EVENT_SOURCE_CHANGE.
> >>
> >> Yeah and that's why I just suggested to mimic coda, which doesn't
> >> block, but apparently gstreamer still works with it.
> >
> > Unfortunately in Venus case that is not an easy task (as I tried to
> > explain why above).
> >
> > To have an unified and common code for all different SoCs and
> > firmware/hardware versions I decided to set the minimum supported
> > resolution for the decoder (no matter what the user said) and trigger
> > the reconfiguration event always. Something more, I need the event also
> > to retrieve the minimum capture buffers
> > (V4L2_CID_MIN_BUFFERS_FOR_CAPTURE) and sizes for capture and
> > internal/scratch buffers as well, thus I really need to wait for that
> > event.
> >
> > So, just to confirm - you are fine with blocking G_FMT (not REQBUF) when
> > the user doesn't subscribe for v4l2 events?
>
> 'Fine' is too strong a word :-)
>
> But I think this is a reasonable compromise.
>
> Document carefully why you are doing this, since it is purely for backwards
> compatibility reasons. And perhaps at some point in the future the workaround
> might be removed again.

Thanks Hans. I don't have objections either.

Best regards,
Tomasz

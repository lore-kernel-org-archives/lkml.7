Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D6C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF3216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRgF3QOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfEUJKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:10:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfEUJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:10:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so28355757edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSdPOItR/QwQaJqAWDzyHjSOY0FhX0Q6RByw0iZfWqY=;
        b=LRgF3QOdZRfOdkdcevF4kHXKpLVf+DmgnDacDANvUI/gJ05zyHF+rFhWral3BX2t5a
         AJ+s8NZT0eJHefNlxPmxnDRpDW3x3YNDwEXIYtO228pxHr+jNhr45VMKgvEdUUF0YW8k
         t3rsUQityMohQJFpsxx9FCJ4P2P235mLpB1no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSdPOItR/QwQaJqAWDzyHjSOY0FhX0Q6RByw0iZfWqY=;
        b=nzdaCP6DYnqo+gSiIWN4evM15v9GBJcRy3PDt2XWcjQ6vM0OK7g6kZZeg0vA3qUyBo
         aZMZiWLR1h/9HC0gJpfUM6wv4JYgyzJvXOvAB35zbX7F1CBesECv0+E2PYw6X/uqnnsZ
         1c4osa1OrCNjxMuvSdoe0CRcKPTSRcTOnU2Ni7dqXPl7/EHMg9Fd+k3MAdeSDvesMHvZ
         h4mkGLQmDNKAz/lOpC2vZgZBJyyOsXzuzP2Gy/goaT6RErl0sGjMkFfFKV9gR5vfjpJu
         auM1eZwP+WuUc7nCViPN2d4dRJqkUVKN4UWKy302JtVX6pEjj0Rzjwn1oTOVqJK7TVqP
         9RIw==
X-Gm-Message-State: APjAAAU/dm6WcKB2cyhWTjwVEj7kcO407TNf+Y5EsqfvmL4IcWVJ+7qw
        m9cO/LL+Lu32IceCz5P1bZkxkcdEyUs//x+N
X-Google-Smtp-Source: APXvYqzyM2+evbT5zDcn90m3mCtX83pfhDORxAQ5KNJl89ORXJ1cmJXtHaQISRqGD56KpPqm9wGxdA==
X-Received: by 2002:a17:906:7cd2:: with SMTP id h18mr27069746ejp.267.1558429799438;
        Tue, 21 May 2019 02:09:59 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id y20sm3434194ejb.40.2019.05.21.02.09.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 02:09:58 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id f10so2249080wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:09:58 -0700 (PDT)
X-Received: by 2002:a5d:5048:: with SMTP id h8mr681332wrt.177.1558429797759;
 Tue, 21 May 2019 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
 <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org> <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
 <c56930e0-be6f-2ade-fcea-8ee0ff6247ec@linaro.org>
In-Reply-To: <c56930e0-be6f-2ade-fcea-8ee0ff6247ec@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 21 May 2019 18:09:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CNGsnqjpLsWSTf=8r+hSfyOgD8SU-tn5EbHCCuuSgH6A@mail.gmail.com>
Message-ID: <CAAFQd5CNGsnqjpLsWSTf=8r+hSfyOgD8SU-tn5EbHCCuuSgH6A@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
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

Hi Stan,

On Mon, May 20, 2019 at 11:47 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 4/24/19 3:39 PM, Tomasz Figa wrote:
> > On Wed, Apr 24, 2019 at 9:15 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Hans,
> >>
> >> On 2/15/19 3:44 PM, Hans Verkuil wrote:
> >>> Hi Stanimir,
> >>>
> >>> I never paid much attention to this patch series since others were busy
> >>> discussing it and I had a lot of other things on my plate, but then I heard
> >>> that this patch made G_FMT blocking.
> >>
> >> OK, another option could be to block REQBUF(CAPTURE) until event from hw
> >> is received that the stream is parsed and the resolution is correctly
> >> set by application. Just to note that I'd think to this like a temporal
> >> solution until gstreamer implements v4l events.
> >>
> >> Is that looks good to you?
> >
> > Hmm, I thought we concluded that gstreamer sets the width and height
> > in OUTPUT queue before querying the CAPTURE queue and so making the
> > driver calculate the CAPTURE format based on what's set on OUTPUT
> > would work fine. Did I miss something?
>
> Nobody is miss something.
>
> First some background about how Venus implements stateful codec API.
>
> The Venus firmware can generate two events "sufficient" and
> "insufficient" buffer requirements (this includes decoder output buffer
> size and internal/scratch buffer sizes). Presently I always set minimum
> possible decoder resolution no matter what the user said, and by that
> way I'm sure that "insufficient" event will always be triggered by the
> firmware (the other reason to take this path is because this is the
> least-common-divider for all supported Venus hw/fw versions thus common
> code in the driver). The reconfiguration (during codec Initialization
> sequence) is made from STREAMON(CAPTURE) context. Now, to make that
> re-configuration happen I need to wait for "insufficient" event from
> firmware in order to know the real coded resolution.
>
> In the case of gstreamer where v4l2_events support is missing I have to
> block (wait for firmware event) REQBUF(CAPTURE) (vb2::queue_setup) or
> STREAMON(CAPTURE) (vb2::start_streaming).
>
> I tried to set the coded resolution to the firmware as-is it set by
> gstreamer but then I cannot receive the "sufficient" event for VP8 and
> VP9 codecs. So I return back to the solution with minimum resolution above.
>
> I'm open for suggestions.

I think you could still keep setting the minimum size and wait for the
"insufficient" event. At the same time, you could speculatively
advertise the expected "sufficient" size on the CAPTURE queue before
the hardware signals those. Even if you mispredict them, you'll get
the event, update the CAPTURE resolution and send the source change
event to the application, which would then give you the correct
buffers. Would that work for you?

Best regards,
Tomasz

Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D6C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2547B20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RT3D5TSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfEPIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:54:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36923 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEPIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:54:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id h19so2359756ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbBv8/kgFCXtJw8fNPqWr98/z/AOw8cQoQFcWTbdFDw=;
        b=RT3D5TSX65Lv0cB5LSWKWOBzSHwwZBbkz1W3Nborb8ZOHEq3YjDOpVimC6o2ukErZU
         fFIDcvHxLfuvQtL80a+PvQYANT8q1f0FEdv5Fd9Mj8vRiLJOoJoJpiq/X4ilax9A9DgK
         HjKmDdfp4CRl4u9+XCaytxQcs274uw8qEOEno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbBv8/kgFCXtJw8fNPqWr98/z/AOw8cQoQFcWTbdFDw=;
        b=WV7JVo0/+KrhlX+jFFuxYB5ZiDoboKpYmjr6ivS6zux/rviMqUIqNh/uFZp6OLMklT
         IMxq3k5FQDUT64/NUGwI8Lwfo5U3cgRFOxLXe5ArD6M5f15n6Sbd+I14XWkEAzB0QMfP
         bnVudOcxzz2hbplZQ0luv8B3n0gc6F+p7oP+Mc67LCuwhBVxnYt7veFAcEs06nl4OORB
         aVZibv7hz8W5QsM7yV8nIECgdpC9mPsCkP2w1m9vZl8kwsYE4SIjutMbrt2OBzj5vc17
         AT4NG1wKkCK4OI5R6lGOvX8ePhrTWgFdi+GnlSqidcDcjn6L2/BkvwpUFkr/xPPukekk
         qdbA==
X-Gm-Message-State: APjAAAVGFpV6TCSWl3w8IMh05Q3S55fLtHcjXBOfp2n97zHlF9ihz/oX
        ZAKXx6CDCtzoVQL/yC5js5B3ajqcRb3YWmWa
X-Google-Smtp-Source: APXvYqy/WRWMUQRojnccnVZ3QKn+JYHjoXwQ7Fmh7ElyPwDjTQHxgokPipTqUrVMRkV7FfUYEvxb7A==
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr2483068ljj.27.1557996847671;
        Thu, 16 May 2019 01:54:07 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p71sm207796ljb.18.2019.05.16.01.54.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:54:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h19so2359715ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:54:07 -0700 (PDT)
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr24756953ljb.102.1557996499095;
 Thu, 16 May 2019 01:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <20190430193412.4291fca8@litschi.hi.pengutronix.de> <20190514081204.GA132745@chromium.org>
 <20190516103715.283face8@litschi.hi.pengutronix.de>
In-Reply-To: <20190516103715.283face8@litschi.hi.pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 16 May 2019 17:48:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BNvip1SGA21_C+ogB276jog2CupkKV3TZ_FUO90y0c=Q@mail.gmail.com>
Message-ID: <CAAFQd5BNvip1SGA21_C+ogB276jog2CupkKV3TZ_FUO90y0c=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:37 PM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> On Tue, 14 May 2019 17:12:04 +0900, Tomasz Figa wrote:
> > Hi Michael,
> >
> > On Tue, Apr 30, 2019 at 07:34:12PM +0200, Michael Tretter wrote:
> > > On Thu, 24 Jan 2019 19:04:19 +0900, Tomasz Figa wrote:
> >
> > [snip]
> >
> > > > +State machine
> > > > +=============
> > > > +
> > > > +.. kernel-render:: DOT
> > > > +   :alt: DOT digraph of encoder state machine
> > > > +   :caption: Encoder state machine
> > > > +
> > > > +   digraph encoder_state_machine {
> > > > +       node [shape = doublecircle, label="Encoding"] Encoding;
> > > > +
> > > > +       node [shape = circle, label="Initialization"] Initialization;
> > > > +       node [shape = circle, label="Stopped"] Stopped;
> > > > +       node [shape = circle, label="Drain"] Drain;
> > > > +       node [shape = circle, label="Reset"] Reset;
> > > > +
> > > > +       node [shape = point]; qi
> > > > +       qi -> Initialization [ label = "open()" ];
> > > > +
> > > > +       Initialization -> Encoding [ label = "Both queues streaming" ];
> > > > +
> > > > +       Encoding -> Drain [ label = "V4L2_DEC_CMD_STOP" ];
> > > > +       Encoding -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
> > > > +       Encoding -> Stopped [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
> > > > +       Encoding -> Encoding;
> > > > +
> > > > +       Drain -> Stopped [ label = "All CAPTURE\nbuffers dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> > >
> > > Shouldn't this be
> > >
> > >     Drain -> Stopped [ label = "All OUTPUT\nbuffers dequeued\nor\nVIDIOC_STREAMOFF(OUTPUT)" ];
> > >
> > > ? While draining, the encoder continues encoding until all source
> > > buffers, i.e., buffers in the OUTPUT queue, are encoded or STREAMOFF
> > > happens on the OUTPUT queue. At the same time, the client continues to
> > > queue and dequeue buffers on the CAPTURE queue and there might be
> > > buffers queued on the CAPTURE queue even if the driver returned the
> > > buffer with the FLAG_LAST set and returns -EPIPE on further DQBUF
> > > requests.
> > >
> >
> > The STREAMOFF should be on OUTPUT indeed, because that immediately
> > removes any OUTPUT buffers from the queue, so there is nothing to be
> > encoded to wait for anymore.
> >
> > The "All OUTPUT buffers dequeued" part is correct, though. The last

I just realized that I made a typo here, sorry. It obviously should be
"All CAPTURE buffers dequeued", as per the existing spec draft and
rest of the sentence. Fortunately you seem to have figured that out.
:)

> > OUTPUT buffer in the flush sequence is considered encoded after the
> > application dequeues the corresponding CAPTURE buffer is dequeued and
> > that buffer is marked with the V4L2_BUF_FLAG_LAST flag.
>
> I understand. As the application continues to queue and dequeue buffers
> on the CAPTURE queue until it received the last CAPTURE buffer and cannot
> dequeue further CAPTURE buffers, "All CAPTURE buffers dequeued" is
> correct. Thanks for the clarification.
>
> Michael
>
> >
> > Best regards,
> > Tomasz
> >

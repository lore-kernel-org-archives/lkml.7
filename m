Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B50C76193
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F13C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/yeuiND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfG2U4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:56:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbfG2U4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:56:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so20025795pgu.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=Iq6W5b285KrUDE+rxE5CdrYmcMCWWImQEwlR0dFM2bE=;
        b=f/yeuiNDbPrjXuT+RnwPpAsP/eViKYRpJZVzyM+Kngqn9apFLepG8/tWmQ0UEm/NAf
         aRlMlR3PHw4Ccfb/+nqMIrd66PNnGAsuRmhYTNOUgj/5ouxZgyKD7rOzPrSI4jrivIR9
         sylL9kP0Oeu/CdzSZLM/BgzeeJdOUPJyexvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=Iq6W5b285KrUDE+rxE5CdrYmcMCWWImQEwlR0dFM2bE=;
        b=oM/YTr5xDcbbUSwLBBBBrMRJtvHKPqB2dkBYWBo4VnJ77YXhtZzr0DBj+PMjLOsWcd
         Y0fchNeBC/RW9cwdTEuC4yl5Yy266TSUFkM5bni4zw5Vgc5l5ALJC2ZVcXquD7REzsau
         CiQfFaxCDSLGr59qs3hRTd/rjlAeasrtVBnNZ/z7cLa+nX0X8sDr5SirGiIg6r8EPXW8
         qvmw01ZFiZYlcSyGJfp/SK05wSuDziiu1AQ5+4A33vZMyigjsAJ6dR9yovy+8AyiQYSS
         0VhoOT3PZiXMN6vWdFZnlHFzMrSwWShmCQtOqqGLwCLQ4A/5M6oCbnj+uzKZ1X/hzQSt
         Z3Nw==
X-Gm-Message-State: APjAAAU9CmC4pK0Gp9iRyWYhRrZMR6WQIbWgEAWN7yoMw+j1RrYfLPe5
        bLtxSW6RNEUxpogbFY/jTzicP2KQX4U=
X-Google-Smtp-Source: APXvYqxqNY1XzBr6zHWT88SCXbqLK4lnF+uhJjvBY48N+vni0IQclaJTI8ui1Q2aOdFllxYi8GjHOg==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr104332462pgc.139.1564433774298;
        Mon, 29 Jul 2019 13:56:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o24sm121273158pfp.135.2019.07.29.13.56.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 13:56:13 -0700 (PDT)
Message-ID: <5d3f5d6d.1c69fb81.4c1e2.5be6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190729190139.GH18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <20190722215340.3071-2-ilina@codeaurora.org> <5d3769df.1c69fb81.55d03.aa33@mx.google.com> <20190724145251.GB18620@codeaurora.org> <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com> <20190724203610.GE18620@codeaurora.org> <CAD=FV=UYj55m99EcQXmkYhs257A46x8DaarE0DC-GRF_3dY3-Q@mail.gmail.com> <20190725151851.GG18620@codeaurora.org> <CAD=FV=X2ENqt5+vdUoRnLTRbedj_sFdQD3Me-yYEW0fDOdBCvg@mail.gmail.com> <20190729190139.GH18620@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Doug Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the interrupt handler
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, mkshah@codeaurora.org
User-Agent: alot/0.8.1
Date:   Mon, 29 Jul 2019 13:56:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-07-29 12:01:39)
> On Thu, Jul 25 2019 at 09:44 -0600, Doug Anderson wrote:
> >On Thu, Jul 25, 2019 at 8:18 AM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Wed, Jul 24 2019 at 17:28 -0600, Doug Anderson wrote:
> >> >
> >> >Jumping in without reading all the context, but I saw this fly by and
> >> >it seemed odd.  If I'm way off base then please ignore...
> >> >
> >> >Can you give more details?  Why are these drivers in atomic contexts?
> >> >If they are in atomic contexts because they are running in the context
> >> >of an interrupt then your next patch in the series isn't so correct.
> >> >
> >> >Also: when people submit requests in atomic context are they always
> >> >submitting an asynchronous request?  In that case we could
> >> >(presumably) just use a spinlock to protect the queue of async
> >> >requests and a mutex for everything else?
> >> Yes, drivers only make async requests in interrupt contexts.
> >
> >So correct me if I'm off base, but you're saying that drivers make
> >requests in interrupt contexts even after your whole series and that's
> >why you're using spinlocks instead of mutexes.  ...but then in patch
> >#3 in your series you say:
> >
> >> Switch over from using _irqsave/_irqrestore variants since we no longer
> >> race with a lock from the interrupt handler.
> >
> >Those seem like contradictions.  What happens if someone is holding
> >the lock, then an interrupt fires, then the interrupt routine wants to
> >do an async request.  Boom, right?
> >
> The interrupt routine is handled by the driver and only completes the
> waiting object (for sync requests). No other requests can be made from
> our interrupt handler.

The question is more if an interrupt handler for some consumer driver
can call into this code and make an async request. Is that possible? If
so, the concern is that the driver's interrupt handler can run and try
to grab the lock on a CPU that already holds the lock in a non-irq
disabled context. This would lead to a deadlock while the CPU servicing
the interrupt waits for the lock held by another task that's been
interrupted.

>=20
> >> They cannot
> >> use the sync variants. The async and sync variants are streamlined into
> >> the same code path. Hence the use of spinlocks instead of mutexes
> >> through the critical path.
> >
> >I will perhaps defer to Stephen who was the one thinking that a mutex
> >would be a big win here.  ...but if a mutex truly is a big win then it
> >doesn't seem like it'd be that hard to have a linked list (protected
> >by a spinlock) and then some type of async worker that:
> >
> >1. Grab the spinlock, pops one element off the linked list, release the =
spinlock
> >2. Grab the mutex, send the one element, release the mutex
> This would be a problem when the request is made from an irq handler. We
> want to keep things simple and quick.
>=20

Is the problem that you want to use RPMh code from deep within the idle
thread? As part of some sort of CPU idle driver for qcom platforms? The
way this discussion is going it sounds like nothing is standing in the
way of a design that use a kthread to pump messages off a queue of
messages that is protected by a spinlock. The kthread would be woken up
by the sync or async write to continue to pump messages out until the
queue is empty.


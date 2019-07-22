Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5178C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE63021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6+P34LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfGVXlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:41:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39484 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbfGVXlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:41:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so30935775oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67APUiaG7UxLheSEbISe3Tn27sJMteMTbqoURFT1XoA=;
        b=I6+P34LY0f5vyF9B+uy9PslT5WKLMItEvyXbe9YYr7nQoBjnek11aXKjq7SPMA8aRd
         hyG8LG4WpMge8Tx0dLJfxmylKxyG+PshphEzX4/SNFn+UiPfLCmbbTzSfnaLKmEK3X6o
         nLDC1oobEibs7sSL7paxJNGewRGuYDZMnnE6xUdPhoL/vrYc+vJu2xEdQBm18Nkx29Fm
         ht0hSU6pkxIrySCddzxSXCWY0BIRx3hV0pf2pxFVj1MIorBQidxVRfXS/UlhCbpv2EL2
         hb4orOES+rjszSEk4H3kqsZb2RWkSk/lOJNRKIOtvJAiA5hHKAjCHGyjKDlgZbVLq7g2
         ZS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67APUiaG7UxLheSEbISe3Tn27sJMteMTbqoURFT1XoA=;
        b=JsAo0AzFwXNo6P1xd7ryTAWCI2M8p+/XdCJN6BtONW81817saOv477e6LwTV3EAigK
         GVaQ8qYnasGNI4j/VTL4gZclB0DtnD3KebaZt4bCgaDBR03B//u9KIGcDa2gH+62Pikm
         OTiMmHqUtb2gK0ILH1+nzGtns45UDFiicIeGIQJEvhzwARm1dUeU6hqptntUbr0KtRtR
         zN1sYEwH9/lYLPMqsb0+h103lLvy0++AUlOikEdd/+MFB5+Rk7ryPzheDxttU4BbWBw8
         fM/BlkVcYK9l4EFPU9DdjlV3vK7tezxYPC7ZoyACZFIkm8cNrX/sB4GpzL0KwO1TVlhc
         isnA==
X-Gm-Message-State: APjAAAXo5dNYb3NArjKQ7szztXd1IRtcgSaQJhw84WDkbCov4BxAxxBb
        E2i7zcvHQmlTKVm9Ywwr1bPGAQWyKxVDoF112iG3ng==
X-Google-Smtp-Source: APXvYqweTW5Fc5Q2uLGP2UuxiXAJzAEvzTAMLQvVQSyfXU+IfRr+1wvAwdupCvUaVh9HkQ+orIyi2efK9LWcbPQ3KJw=
X-Received: by 2002:a05:6808:90a:: with SMTP id w10mr34680176oih.43.1563838889831;
 Mon, 22 Jul 2019 16:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org> <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
 <20190722233501.GA19594@bogus>
In-Reply-To: <20190722233501.GA19594@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 22 Jul 2019 16:40:53 -0700
Message-ID: <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> > On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > >
> > > Hey Saravana,
> > >
> > > https://patchwork.kernel.org/patch/10850815/
> > > There was already a discussion ^^ on how bandwidth bindings were to be
> > > named.
> >
> > Yes, I'm aware of that series. That series is trying to define a BW
> > mapping for an existing frequency OPP table. This patch is NOT about
> > adding a mapping to an existing table. This patch is about adding the
> > notion of BW OPP tables where BW is the "key" instead of "frequency".
> >
> > So let's not mixed up these two series.
>
> Maybe different reasons, but in the end we'd end up with 2 bandwidth
> properties. We need to sort out how they'd overlap/coexist.

Oh, I totally agree! My point is that the other mapping isn't the
right approach because it doesn't handle a whole swath of use cases.
The one I'm proposing can act as a super set of the other (as in, can
handle that use case too).

> The same comment in that series about defining a standard unit suffix
> also applies to this one.

I thought I read that whole series and I don't remember reading about
the unit suffix. But I'll take a closer look. I've chosen to keep the
DT units at least as "high of a resolution" as what the APIs accept
today. The APIs take KB/s. So I make sure DT can capture KB/s
differences. If we all agree that KB/s is "too accurate" then I think
we should change everything to MB/s.

-Saravana

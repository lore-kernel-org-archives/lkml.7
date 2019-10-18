Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF3CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BA72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMqSU3dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443229AbfJRTEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:04:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37723 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439950AbfJRTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:04:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so7093472wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVifxkwV57lbFaLMZ62E2MymQicYvTWMQCIWoJEOxVE=;
        b=xMqSU3dYbjRNXrK2X8mJ/bin+9yX01nMLFcUnxVFLpfdUixET5kIQRIzXkvV2uxO9O
         kpcRo/hk2WxPWy9wV9qo1Xxdk8WgRtI3qM6Co2dH7dwh7RuwKxOX4ylleKdUsIrwTPp1
         yIdT4fnHrv46kuyNWpEGCexOMl0Bcb46+XkOIBw+wWBVdUJXZGYiRex6IgkeP8mxLdpk
         6MJloWgTsrbwbR5GfCnNlabZWhh/e7ZU6zshSRdF4ukvYZ16k9884bM+9+9yFTXgtwXm
         WRk00HZkwETc9wrc6kFfJTbyt9EtQcId79EXlIFf+PwgBt/p+I68WUV9xOTFzSQR/YQA
         34sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVifxkwV57lbFaLMZ62E2MymQicYvTWMQCIWoJEOxVE=;
        b=PWHqnq2V61Ma2xdlDkCm+uOwYHuJhByi5ElL4uRUawdsZktb4d/OI9dONy7RYlwGnN
         wV0Js10GJLl0Dw85IHBtZtfwIOEQtkcAnyCdt90XpoyaFg8vT4/q4qgaMbxeLy3Q8Z33
         54oWhinybhTn5hc4smmZ277wS2YHitotQ2tEQbOlkRQJVuwd+iYDgq5L3uQDLunXArVD
         LBbNMbq3iOXqeG9Sz1DX3MxI87wyqkAMAYXpilCvikhNxP3MZN4c/9aAhS41lQcOB7Pj
         RDPT1WhI6cYOeo7VuD7gXF/v2c5lEeFJ28MRIDdJeVs55QuU3/n+ytJZR+csGdIC9n3S
         MByw==
X-Gm-Message-State: APjAAAWGkk5nsPOj4WFouOp2L3WCI9ND/GieHGr9WUEU9fgAF3rOA/ZV
        TuXktS/XIgA/8dcU0k/nkUlFO5e1TPkIUohHeQfCcA==
X-Google-Smtp-Source: APXvYqwa7ITNvRtiSOdskk4SkYRranN4eQE7juVdF/IwYGcYFc5PbwoFNc53WWVl4wD8gsZPH/JeOwOuUVc3Uwax8DY=
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr8328661wma.173.1571425476242;
 Fri, 18 Oct 2019 12:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191009173742.GA2682@arm.com> <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com> <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com> <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com> <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
 <20191018185723.GA27993@arm.com>
In-Reply-To: <20191018185723.GA27993@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 12:04:25 -0700
Message-ID: <CALAqxLVeo6=CHabFZv7qMkNw+h_5xez+aF7CuBT=37Dz-=s5eg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F. Davis" <afd@ti.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:57 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
> On Fri, Oct 18, 2019 at 11:49:22AM -0700, John Stultz wrote:
> > On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
> > > With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as follows :-
> > >
> > > [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved_areas+0xec/0x22c
> >
> > Is the value 0x60000000 you're using something you just guessed at? It
> > seems like the warning here is saying the pfn calculated from the base
> > address isn't valid.
> It is a valid memory region we use to allocate framebuffers.

Hrm. I guess I'd suggest digging to figure out why the kernel doesn't
see it as such.

Does this only happen with my patches applied? I'm sort of assuming
can you trip this even without them, but maybe I'm wrong?

thanks
-john

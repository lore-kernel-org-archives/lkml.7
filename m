Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7FCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8064F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C87WZN4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbfJRSth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:49:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37678 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJRSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:49:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so7316989wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHwrkkqK+v7ttT3hkVnbsvrpjAbQK2fYZ6a+Ri81jgQ=;
        b=C87WZN4lrYok7x6kNxv0f0V7ppeKpanyF4cDM/PfsE+M+YjE0iuSVN+/VcRd49e7LA
         YE5LPYMob7fMxbLpv+EoYWVR0inRsUItRnCdIt397m1VUWWqVVjuM4LV2vX49cSP8Rxm
         nUTrkPsAeE8JTzCJsyWV6DVzjCCsDRC94wvzybXU4QMjBBeSSVm9lJuPPzt6o+PjrX9T
         AlKObj5riecOiesJDhAZOw4aUgNmajjyk/183XTLhsiNsq8rtaBDNHJV94i/IMp5FIBY
         yVPl40u3fOh1qcLW0geb+swIlPmpweHyjqV4geYV557h3Xhlc+u4ylm2rQACxFKbjwlx
         q4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHwrkkqK+v7ttT3hkVnbsvrpjAbQK2fYZ6a+Ri81jgQ=;
        b=ZBZ5TfRgFpw5RCy2G173+s22kdKS4EiSWke0KglsLoNYsp0/S3EEs41c8PU6d8x/96
         +dmDJdzQTjyP7VjpAcb8pQdFLnKQNodz/ePMERcPyxAa7OT2CyRCIh0XZVimqoROQy+K
         QQ7jtGhv5dHAZWGh1Y05deXlOepUVWlUVrKBbz8szVyfMk6h2fyKONFwqG01By++7arW
         wZNps+hG3wLfmW4r0QcSQulMXWS24ShWWqe1JGPLbGxc6H/alLoQqp8B9+JwrMh5m8Ck
         UQ72vMRkegISteRmN+0PMhA1glcBAoi3FpWjbU5NPYHBpfBN0oc/bouOIDEzBy5FTfxO
         XkKg==
X-Gm-Message-State: APjAAAU207f87pP59sW6t/bTdYZO2NWGNqdbbhswSQ286mYGOjP3luOV
        uxOvOCTCCEWa2RehbUd4fCle5LM2OwGFWcmI9YgQkQ==
X-Google-Smtp-Source: APXvYqzEAUVJXB6Gp+u1CbtLAoa/ziEMiFEWlTCerkSuIf0yRZwzZiVqQ9e0pvTxq8U6NBXXT02BZ5WPL3KU1SkqmaQ=
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr8710623wrt.36.1571424573429;
 Fri, 18 Oct 2019 11:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com> <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com> <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com> <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain> <20191018184123.GA10634@arm.com>
In-Reply-To: <20191018184123.GA10634@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 11:49:22 -0700
Message-ID: <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
> On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> > On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > > On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> > > > On 10/17/19 3:14 PM, John Stultz wrote:
> > > > > But if the objection stands, do you have a proposal for an alternative
> > > > > way to enumerate a subset of CMA heaps?
> > > > >
> > > > When in staging ION had to reach into the CMA framework as the other
> > > > direction would not be allowed, so cma_for_each_area() was added. If
> > > > DMA-BUF heaps is not in staging then we can do the opposite, and have
> > > > the CMA framework register heaps itself using our framework. That way
> > > > the CMA system could decide what areas to export or not (maybe based on
> > > > a DT property or similar).
> > >
> > > Ok. Though the CMA core doesn't have much sense of DT details either,
> > > so it would probably have to be done in the reserved_mem logic, which
> > > doesn't feel right to me.
> > >
> > > I'd probably guess we should have some sort of dt binding to describe
> > > a dmabuf cma heap and from that node link to a CMA node via a
> > > memory-region phandle. Along with maybe the default heap as well? Not
> > > eager to get into another binding review cycle, and I'm not sure what
> > > non-DT systems will do yet, but I'll take a shot at it and iterate.
> > >
> > > > The end result is the same so we can make this change later (it has to
> > > > come after DMA-BUF heaps is in anyway).
> > >
> > > Well, I'm hesitant to merge code that exposes all the CMA heaps and
> > > then add patches that becomes more selective, should anyone depend on
> > > the initial behavior. :/
> >
> > How about only auto-adding the system default CMA region (cma->name ==
> > "reserved")?
> >
> > And/or the CMA auto-add could be behind a config option? It seems a
> > shame to further delay this, and the CMA heap itself really is useful.
> >
> A bit of a detour, comming back to the issue why the following node
> was not getting detected by the dma-buf heaps framework.
>
>         reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
>
>                 display_reserved: framebuffer@60000000 {
>                         compatible = "shared-dma-pool";
>                         linux,cma-default;
>                         reusable; <<<<<<<<<<<<-----------This was missing in our
> earlier node
>                         reg = <0 0x60000000 0 0x08000000>;
>                 };

Right. It has to be a CMA region for us to expose it from the cma heap.


> With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as follows :-
>
> [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved_areas+0xec/0x22c

Is the value 0x60000000 you're using something you just guessed at? It
seems like the warning here is saying the pfn calculated from the base
address isn't valid.

thanks
-john

Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52151C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0021873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOQcbBOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfGXIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:09:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39379 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:09:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so44577357qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Lpd+hOfQ/hSysjd4WRfKNMZK+VOhGnP5t1TFXShC7M=;
        b=VOQcbBOVW81gEk6UYdrISLr70kaZw7smJ93fG1k88v2CiADBQEGhOjdDrUVccAJ53f
         iis1zZNkYW8Ssai/XzSxFDoA/0X7+Xtv8H1HSftMVx+JHagoHr3iqjwcnloS+UJgjYdn
         vay/OWRz4LA3IZIIEnhiINZfTnCvMW358OdlNW0G0+UcvmfM3NY4LS3/RAbYpyi720/6
         /I0JoRE9RTyoGAKJa3jmDAuPx/4YAOfqSsOYNMNtYNyhXqIR0HG6vt0XrzuFptZWqyTY
         HIb5bqcET3ZOyf+wJldrySHQcJOIxg4PPRWsNHswPosnAir5E6PMWMzbq0Jr7gLCAK4P
         /LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Lpd+hOfQ/hSysjd4WRfKNMZK+VOhGnP5t1TFXShC7M=;
        b=TLyW8yCbL8plylQ6qO1s1CA+S+n92fxSlk8fZXZ7vwiCzNzJOhw0nYQkAGCgnHhYqm
         foNYspcWHBXqOpuW0rctr7Cj31x/gMV3UPLwGTzabj2PL2FVjHcNquo6TSdtiTVN3kW9
         DRe452oUMAXQLyz7SQdeHBA29OFO+hlCseFjY5ErkxUfAp8bInUXA6F8jfLvnNAJ8BpS
         oi/RiMt4HCNqGid8VkI+b3irkB8VaTUIPrQCGdREYphblBJWmiaY5CkfjVqh1FQdD37B
         tS53qiCRSp5A530k1AmV3P8sOvnKNYsmeOn1tbbYJyHYAusUyaU9oyqBk4W1X/Q9QdxU
         3jZw==
X-Gm-Message-State: APjAAAXQ+zzlaL+d/hwE7TXFR3zLcO10FUs4dlCE/AYJLUHQDsxS3i+g
        6393H7Dcr3x39U5sUj/mHLdjp3m/GsbuC2G+Ecvkiw==
X-Google-Smtp-Source: APXvYqwhaR/vZAZ4Pspx2z7Xquj9JBXVTtZ3bp2S/aQJ83tPbQMPL0PZne0WPPs+ZPh0DWRYluwOZumHkN+9N+cgrXA=
X-Received: by 2002:a0c:d003:: with SMTP id u3mr59212119qvg.112.1563955745710;
 Wed, 24 Jul 2019 01:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org> <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com> <20190724065958.GC16225@infradead.org>
In-Reply-To: <20190724065958.GC16225@infradead.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Jul 2019 10:08:54 +0200
Message-ID: <CA+M3ks6yPTV4i=wEu41bHqMsn_VkYUj=y9BXGmgDgovnT9ESfA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 24 juil. 2019 =C3=A0 09:00, Christoph Hellwig <hch@infradead.org> a=
 =C3=A9crit :
>
> On Mon, Jul 22, 2019 at 10:04:06PM -0700, John Stultz wrote:
> > Apologies, I'm not sure I'm understanding your suggestion here.
> > dma_alloc_contiguous() does have some interesting optimizations
> > (avoiding allocating single page from cma), though its focus on
> > default area vs specific device area doesn't quite match up the usage
> > model for dma heaps.  Instead of allocating memory for a single
> > device, we want to be able to allow userland, for a given usage mode,
> > to be able to allocate a dmabuf from a specific heap of memory which
> > will satisfy the usage mode for that buffer pipeline (across multiple
> > devices).
> >
> > Now, indeed, the system and cma heaps in this patchset are a bit
> > simple/trivial (though useful with my devices that require contiguous
> > buffers for the display driver), but more complex ION heaps have
> > traditionally stayed out of tree in vendor code, in many cases making
> > incompatible tweaks to the ION core dmabuf exporter logic.
>
> So what would the more complicated heaps be?
>
> > That's why
> > dmabuf heaps is trying to destage ION in a way that allows heaps to
> > implement their exporter logic themselves, so we can start pulling
> > those more complicated heaps out of their vendor hidey-holes and get
> > some proper upstream review.
> >
> > But I suspect I just am confused as to what your suggesting. Maybe
> > could you expand a bit? Apologies for being a bit dense.
>
> My suggestion is to merge the system and CMA heaps.  CMA (at least
> the system-wide CMA area) is really just an optimization to get
> large contigous regions more easily.  We should make use of it as
> transparent as possible, just like we do in the DMA code.

CMA has made possible to get large regions of memories and to give some
priority on device allocating pages on it. I don't think that possible
with system
heap so I suggest to keep CMA heap if we want to be able to port a maximum
of applications on dma-buf-heap.

Benjamin

Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB14C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB92190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCIkimKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfGYOrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:47:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43727 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbfGYOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:47:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so10929178qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpauZog8AJ0JP+jM70fncJTKaBzMsaQ9j0djN38srWU=;
        b=pCIkimKBBofK2niPxQMPIL9oHxljTwswpTmsaxh50VBjjkBbyvgmRXJbRQpo1kJ2Qs
         lYIInkn3OZFH5TqZbEoY4M3KTunf8bZ8GXSveSRJX05tGUmoRmVpex5DGoxKP0JMenRW
         fUnYIw+JZTP4ygsXVOc33k2DdcVOvVvQMoWcvSiAehbWRnO7m9bH+fbwpLApwYROvBWy
         DKvzMA0GRpwcqr7EbI3fXGHn5sdej8kz4a5eDRkAN94n6INYGjQwbNYhNQ3UB6U4cb7O
         0BB/KYzB8tJT7HQs/Bo0pwr5oraUY2mY424OblaPNXFBLz5yHKy49xkkQI6414z5w/Q6
         SOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpauZog8AJ0JP+jM70fncJTKaBzMsaQ9j0djN38srWU=;
        b=SBqnhq+iEipE49iCAXHSTtHtzK5rrf9YTSy8Umbi7nWYoQ+6XCFGik24+hgU63xCSn
         PGCQ/wTps/FKc+UE0gKE9hmJHWkNG6dtlVtJyaKwo4PbaNuGrQqMVnv/YqtXoRmpNzAe
         j8+hPxVCP66fNuU/tfng348k5P56puHez6x3Ww3wVvLIaOG4pM5cW7psMOPPPGVXfxaf
         /x8r31YT4HzcfxFqeo9VNvKoRbYPpZ0aKy3r0hZmZexkbiHjursfa+kLMU0uTZ2G075e
         5ZCkoXmJvhUR2cVzWbvIIK6x9jS1DcOctbhhOElLpGwxywr2a3U6y24rNiYRp/Wx5Pe7
         7nrw==
X-Gm-Message-State: APjAAAVrh7yr5JyBNVryhB1eTHYhjE5AEE9BKPgRloZmmDPBIHWaQi9v
        bv2PF9c2ZhX46tCgJGKBrBW20VObbUUaXA6t1VhJ7w==
X-Google-Smtp-Source: APXvYqwYX0b7/7Ql7NtzQjoaUIjjAeW642gLL+8VwcDRegxmXLgSOZ+3DpSyImxBEakEMyXESY2enVT+PzPCjvFI0MQ=
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr57362371qki.219.1564066028230;
 Thu, 25 Jul 2019 07:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org> <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org> <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
 <20190725125206.GE20286@infradead.org> <CA+M3ks52ADKVCw_pZP9=LSNt+vhiEFyrtB-Jm2x=p62kSV7qVA@mail.gmail.com>
 <20190725143335.GB21894@infradead.org>
In-Reply-To: <20190725143335.GB21894@infradead.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 16:46:55 +0200
Message-ID: <CA+M3ks5s7GKdgUA1J3WDuRCdmQJkQ2t_CzqknAd5+S9FVynnfg@mail.gmail.com>
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

Le jeu. 25 juil. 2019 =C3=A0 16:33, Christoph Hellwig <hch@infradead.org> a=
 =C3=A9crit :
>
> On Thu, Jul 25, 2019 at 03:20:11PM +0200, Benjamin Gaignard wrote:
> > > But that just means we need a flag that memory needs to be contiguous=
,
> > > which totally makes sense at the API level.  But CMA is not the only
> > > source of contigous memory, so we should not conflate the two.
> >
> > We have one file descriptor per heap to be able to add access control
> > on each heap.
> > That wasn't possible with ION because the heap was selected given the
> > flags in ioctl
> > structure and we can't do access control based on that. If we put flag
> > to select the
> > allocation mechanism (system, CMA, other) in ioctl we come back to ION =
status.
> > For me one allocation mechanism =3D one heap.
>
> Well, I agree with your split for different fundamentally different
> allocators.  But the point is that CMA (at least the system cma area)
> fundamentally isn't a different allocator.  The per-device CMA area
> still are kinda the same, but you can just have one fd for each
> per-device CMA area to make your life simple.

Form my point of view default cma area is a specific allocator because
it could migrate page to give them in priority to contigous allocation. It =
is
also one of the last region where system page are going to be allocated.
I don't think that system allocator does have the same features, either we
would have use it rather develop CMA years ago ;-). In short CMA had
solved lot of problems on our side so it had to have it own heap.

Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD7C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8F20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRR2Xad8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJGV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:27:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:27:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so16920060wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8WHnqHPGHetk5a2zp8iHSZwK2TQo9c5ejvOe0oNFMg=;
        b=iRR2Xad8P3jKRgIZbf0Ci7pHA2GsQ8Uph1o2h1yDvXlqByGUCl3ouzt69oBBHaQcet
         Ed0hPQp9MY970Sc3pOnKr/alZnEVJSA8MLiQkKeIMr48eZVSlFD7HRkgig1Kpws+52GR
         jfenwn7/lHlrE739CljIHkwj3XvwIrF2Ai15YwLZ6f+MAk+2iCWGQAVKK5WjnM72Rlx2
         oNxO/+4FZ6QbvJExJpbivel7NWWrgv9fxxRy+aqZFC3UIB+bjmrUhj9OVZK74NlsmMgg
         kH/xOQD9Jcrqv46vFnJ3Ku5x1+GWbTdH/wDR6qmVuVnzS8MTGx3VFCp0MqbmBEGTEpJC
         /Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8WHnqHPGHetk5a2zp8iHSZwK2TQo9c5ejvOe0oNFMg=;
        b=a0JsTi/Hs1nxjPoZEhbNUVQSbEKKWz++9Lgtha6M3sJqMqPfgc0753gctQT8jWTMza
         joTf2AOjioaeIKcTKycQ8i1H5W8BKR45Zy2vZx0AIe+LkmlPBTDxg/eD7ZJhZrnT0Uh8
         L9Zq0WdUHgPiNXBS4Rfxt5uFX5Pn8M2C9falOZiEgO+W53MzQSp5oL+2AZFhmfmgj5k5
         4f4c3pqPjdFbVzv2JPq4Anubyibq/j8euZ01Cw1Xzk+27Q4Qj7i35kF8MlwjF9Rcj/Ze
         2iisG3fUdmG2eAETnaLBtmDzgCpxg7MTY2t3sbFpQa6x0bqiBKcJD1yysV/qanjk5i9C
         Lo/w==
X-Gm-Message-State: APjAAAVxi40zj44LEcMvXhkpAkXgdCclOyca+1FwowsClObn/Ev3Kg2l
        y9Ae6J70+/qNjzcoTDxOj6ZTuvC6vwxFldBzyd6bsg==
X-Google-Smtp-Source: APXvYqyOYxJmSNS/HbH+PJUrgfD/Y/yCZlDImNd5GT/+xSfVS9D2D2PyIq3Xm1+PVkS3xMEmRiURpxxALcERacqIaqI=
X-Received: by 2002:adf:fc07:: with SMTP id i7mr9284755wrr.50.1570483631796;
 Mon, 07 Oct 2019 14:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211830.42838-1-john.stultz@linaro.org>
 <20191007211830.42838-2-john.stultz@linaro.org> <ad064efe-4d86-3b81-ace2-152e90c72e94@infradead.org>
In-Reply-To: <ad064efe-4d86-3b81-ace2-152e90c72e94@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 7 Oct 2019 14:27:00 -0700
Message-ID: <CALAqxLV_ioD3ZnOQXP3YfixdC+zr=Bht4jkdLGHKViX_8smztA@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] dma-buf: Add dma-buf heaps framework
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:21 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/7/19 2:18 PM, John Stultz wrote:
> > diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> > index a23b6752d11a..6e9c7c4d7447 100644
> > --- a/drivers/dma-buf/Kconfig
> > +++ b/drivers/dma-buf/Kconfig
> > @@ -44,4 +44,13 @@ config DMABUF_SELFTESTS
> >       default n
> >       depends on DMA_SHARED_BUFFER
> >
> > +menuconfig DMABUF_HEAPS
> > +     bool "DMA-BUF Userland Memory Heaps"
> > +     select DMA_SHARED_BUFFER
> > +     help
> > +       Choose this option to enable the DMA-BUF userland memory heaps,
>
>                                                                    heaps.
>
> > +       this options creates per heap chardevs in /dev/dma_heap/ which
>
>           This
>
> > +       allows userspace to use to allocate dma-bufs that can be shared
>
> ??                         to allocate & use

I think the "to use" was just extraneous. I'll drop it.

Thanks for catching these. I'll fix them up and respin v11 later this week.

thanks
-john
